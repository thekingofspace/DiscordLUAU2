local module = {}
local task = require("@lune/task")

export type Connection = {
    Callback: (...any) -> (),
    IsConnected: boolean,
    Disconnect: (self: Connection) -> (),
}

export type Signal = {
    Connect: (self: Signal, Callback: (...any) -> ()) -> Connection,
    ConnectAsync: (self: Signal, Callback: (...any) -> ()) -> Connection,
    Wait: (self: Signal, timeout: number?) -> ...any,
    Fire: (self: Signal, ...any) -> (),
}

function module:CreateSignal()
    local self = {}
    local SyncConnections = {}
    local AsyncConnections = {}
    local WaitingThreads = {}
    self.Constructor = nil
    self.WasConnected = false

    function self:Connect(Callback: (...any) -> ())
        assert(typeof(Callback) == "function", "Callback must be a function")

        local Connection = {
            Callback = Callback,
            IsConnected = true,
        }

        function Connection:Disconnect()
            self.IsConnected = false
        end

        table.insert(SyncConnections, Connection)
        self.WasConnected = true
        return Connection
    end

    function self:ConnectAsync(Callback: (...any) -> ())
        assert(typeof(Callback) == "function", "Callback must be a function")

        local Connection = {
            Callback = Callback,
            IsConnected = true,
        }

        function Connection:Disconnect()
            self.IsConnected = false
        end

        table.insert(AsyncConnections, Connection)
        self.WasConnected = true
        return Connection
    end

    function self:AddConstructor(Callback: (...any) -> ...any)
        self.Constructor = Callback
    end

    function self:Wait(timeout: number?)
        local thread = coroutine.running()
        local fired = false
        local result = nil
        local timeoutTask = nil
        self.WasConnected = true

        local function continue(...)
            if fired then return end
            fired = true
            result = table.pack(...)
            if timeoutTask then
                task.cancel(timeoutTask)
            end
            coroutine.resume(thread)
        end

        table.insert(WaitingThreads, continue)

        if timeout and timeout > 0 then
            timeoutTask = task.delay(timeout, function()
                if fired then return end
                fired = true
                for i, waiter in ipairs(WaitingThreads) do
                    if waiter == continue then
                        table.remove(WaitingThreads, i)
                        break
                    end
                end
                coroutine.resume(thread)
            end)
        end

        coroutine.yield()

        if result then
            return table.unpack(result, 1, result.n)
        end

        return nil
    end

    function self:Fire(...)
        local args = table.pack(...)

        if self.Constructor then
            args = table.pack(self.Constructor(table.unpack(args, 1, args.n)))
        end

        for _, connection in ipairs(AsyncConnections) do
            if connection.IsConnected then
                task.spawn(connection.Callback, table.unpack(args, 1, args.n))
            end
        end

        if #WaitingThreads > 0 then
            local toResume = table.clone(WaitingThreads)
            table.clear(WaitingThreads)
            task.spawn(function()
                for _, resumeFn in ipairs(toResume) do
                    resumeFn(table.unpack(args, 1, args.n))
                end
            end)
        end

        for _, connection in ipairs(SyncConnections) do
            if connection.IsConnected then
                connection.Callback(table.unpack(args, 1, args.n))
            end
        end

        if #AsyncConnections == 0 and #SyncConnections == 0 then
            self.WasConnected = false
        end
    end

    return self
end

function module:CreateReadOnlySignal(realSignal)
    assert(realSignal and typeof(realSignal.Connect) == "function", "Expected a signal object")

    local public = {}

    function public:Connect(...)
        return realSignal:Connect(...)
    end

    function public:ConnectAsync(...)
        return realSignal:ConnectAsync(...)
    end

    function public:Wait(timeout)
        return realSignal:Wait(timeout)
    end

    return public
end

return module

const { execSync } = require('child_process');

execSync(`"./.lune-bin/lune.exe" run "Main.luau"`, { stdio: 'inherit' });

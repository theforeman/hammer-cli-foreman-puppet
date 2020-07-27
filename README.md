[WIP] hammer_cli_foreman_puppet
=========================================

This [Hammer CLI](https://github.com/theforeman/hammer-cli) plugin contains
set of commands for puppet.
Configuration
-------------

Configuration is expected to be placed in one of hammer's configuration directories for plugins:
- `/etc/hammer/cli.modules.d/`
- `~/.hammer/cli.modules.d/`
- `./.config/cli.modules.d/` (config dir in CWD)

If you install `hammer_cli_foreman_puppet` from source you'll have to copy the config file manually
from `config/foreman_puppet.yml`.

License
-------

This project is licensed under the GPLv3+.
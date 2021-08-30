# Hammer CLI Foreman Puppet

This Hammer CLI plugin contains a set of commands for [foreman_puppet](https://github.com/theforeman/foreman_puppet), a plugin that adds Puppet functionality to Foreman.

## Compatibility

This is the list of which version of Foreman Puppet and Foreman are needed for which version of this plugin.

|foreman        |foreman_puppet|hammer-cli-puppet |   Notes                                                 |
|---------------|--------------|----------------- |---------------------------                              |
| >= 3.0        | ~> 1.0       |  >= 0.0.3        |  Required                                               |
| <= 2.5        | ~> 0.1       |     -            |  Not supported (functionality is in [hammer-cli-foreman](https://github.com/theforeman/hammer-cli-foreman)) |

## Installation

    $ gem install hammer_cli_foreman_puppet

    $ mkdir -p ~/.hammer/cli.modules.d/

    $ cat <<EOQ > ~/.hammer/cli.modules.d/foreman_puppet.yml
    :foreman_puppet:
      :enable_module: true
    EOQ

## Problems

Please feel free to open a [new Github issue](https://github.com/theforeman/hammer-cli-foreman-puppet/issues/new) if you encounter any bugs/issues using this plugin.

## More info

See our [Hammer CLI installation and configuration instuctions](
https://github.com/theforeman/hammer-cli/blob/master/doc/installation.md#installation).

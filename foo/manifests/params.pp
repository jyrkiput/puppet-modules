# Class: foo::params
#
# Sets internal variables and defaults for foo module
# This class is automatically loaded in all the classes that use the values set here 
#
class foo::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')

# Full hostname of foo server
    $server = $foo_server ? {
        ''      => "foo",
        default => "${foo_server}",
    }


## DEFAULTS FOR MONITOR CLASS
# These are settings that influence the (optional) foo::monitor class
# You can define these variables or leave the defaults

    # How the monitor server refers to the monitor target 
    $monitor_target = $foo_monitor_target ? {
        ''      => "$fqdn",
        default => "$foo_monitor_target",
    }

    # BaseUrl to access this host
    $monitor_baseurl = $foo_monitor_baseurl ? {
        ''      => "http://${fqdn}",
        default => "${foo_monitor_baseurl}",
    }

    # Pattern to look for in the URL defined in foo::monitor class
    $monitor_url_pattern = $foo_monitor_url_pattern ? {
        ''      => "OK",
        default => "${foo_monitor_url_pattern}",
    }

    # If foo port monitoring is enabled 
    $monitor_port_enable = $foo_monitor_port ? {
        ''      => $monitor_port ? {
           ''      => true,
           default => $monitor_port,
        }
        default => $foo_monitor_port,
    }

    # If foo url monitoring is enabled 
    $monitor_url_enable = $foo_monitor_url ? {
        ''      => $monitor_url ? {
           ''      => true,
           default => $monitor_url,
        }
        default => $foo_monitor_url,
    }

    # If foo process monitoring is enabled 
    $monitor_process_enable = $foo_monitor_process ? {
        ''      => $monitor_process ? {
           ''      => true,
           default => $monitor_process,
        }
        default => $foo_monitor_process,
    }

    # If foo plugin monitoring is enabled 
    $monitor_plugin_enable = $foo_monitor_plugin ? {
        ''      => $monitor_plugin ? {
           ''      => true,
           default => $monitor_plugin,
        }
        default => $foo_monitor_plugin,
    }

## DEFAULTS FOR BACKUP CLASS
# These are settings that influence the (optional) foo::backup class
# You can define these variables or leave the defaults

    # How the backup server refers to the backup target 
    $backup_target = $foo_backup_target ? {
        ''      => "$fqdn",
        default => "$foo_backup_target",
    }

    # Frequency of backups
    $backup_frequency = $foo_backup_frequency ? {
        ''      => "daily",
        default => "$foo_backup_frequency",
    }

    # If foo data have to be backed up
    $backup_data_enable = $foo_backup_data ? {
        ''      => $backup_data ? {
           ''      => true,
           default => $backup_data,
        }
        default => $foo_backup_data,
    }

    # If foo logs have to be backed up
    $backup_log_enable = $foo_backup_log ? {
        ''      => $backup_log ? {
           ''      => true,
           default => $backup_log,
        }
        default => $foo_backup_log,
    }


## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        solaris => "CSWfoo",
        default => "foo",
    }

    $servicename = $operatingsystem ? {
        default => "foo",
    }

    $processname = $operatingsystem ? {
        default => "food",
    }

    $hasstatus = $operatingsystem ? {
        default => true,
    }

    $configfile = $operatingsystem ? {
        freebsd => "/usr/local/etc/foo/foo.conf",
        default => "/etc/foo/foo.conf",
    }

    $configfile_mode = $operatingsystem ? {
        default => "644",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

    $configdir = $operatingsystem ? {
        freebsd => "/usr/local/etc/foo/",
        default => "/etc/foo",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/food",
        ubuntu  => "/etc/default/food",
        default => "/etc/sysconfig/food",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default => "/var/run/food.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/foo",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/foo",
    }


## FILE SERVING SOURCE
# Sets the correct source for static files
# In order to provide files from different sources without modifying the module
# you can override the default source path setting the variable $base_source
# Ex: $base_source="puppet://ip.of.fileserver" or $base_source="puppet://$servername/myprojectmodule"
# What follows automatically manages the new source standard (with /modules/) from 0.25 

    case $base_source {
        '': {
            $general_base_source = $puppetversion ? {
                /(^0.25)/ => "puppet:///modules",
                /(^0.)/   => "puppet:///",
                default   => "puppet:///modules",
            }
        }
        default: { $general_base_source=$base_source }
    }

}
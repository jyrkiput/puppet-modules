# Define puppi::rollback
#
# This define creates a file with a rollback command that can be used locally.
#
# Usage:
# puppi::rollback { "Retrieve files":
#     command  => "get_file.sh",
#     argument => "/remote/dir/file",
#     priority => "10",
#     user     => "root",
#     project  => "spysite",
# }
#
define puppi::rollback (
    $command,
    $arguments,
    $priority="50",
    $user="root",
    $project,
    $enable = 'true' ) {

    require puppi::params

    # Autoinclude the puppi class
    include puppi

    $ensure = $enable ? {
        "false" => "absent",
        "no"    => "absent",
        "true"  => "present",
        "yes"   => "present",
    }

    file { "${puppi::params::projectsdir}/$project/rollback/${priority}-${name}":
        mode    => "750",
        owner   => "${puppi::params::configfile_owner}",
        group   => "${puppi::params::configfile_group}",
        ensure  => "${ensure}",
        require => Class["puppi"],
        content => "su - ${user} -c \"export project=${project} && ${puppi::params::scriptsdir}/${command} ${arguments}\"\n",
        tag     => 'puppi_rollback',
    }

}


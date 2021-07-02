class profiles::python::python(
  String                                $version                     = 'system',
  Enum['absent', 'present', 'latest']   $ensure                      = 'present',
  Enum['absent', 'present', 'latest']   $pip                         = 'latest',
  Enum['absent', 'present', 'latest']   $dev                         = 'absent',
  Enum['absent', 'present', 'latest']   $virtualenv                  = 'absent',
  Enum['absent', 'present', 'latest']   $gunicorn                    = 'absent',
  Boolean                               $manage_gunicorn             = true,
  Boolean                               $manage_python_package       = true,
  Boolean                               $manage_pip_package          = true,
  Boolean                               $manage_virtualenv_package   = true,
  Boolean                               $manage_scl                  = true,
  Boolean                               $use_epel                    = false,
  Optional[String]                      $gunicorn_package_name       = undef,
  Optional[String]                      $valid_versions              = undef,
  Optional[Enum['pip', 'scl', 'rhscl']] $provider                    = '',
  Hash                                  $python_pips                 = {},
  Hash                                  $python_virtualenvs          = {},
  Hash                                  $python_pyvenvs              = {},
  Hash                                  $python_requirements         = {},
  Hash                                  $python_dotfiles             = {},
  Optional[String]                      $rhscl_use_public_repository = undef,
  Optional[String]                      $anaconda_installer_url      = undef,
  Optional[String]                      $anaconda_install_path       = undef,
  Optional[Pattern[/[0-7]{1,4}/]]       $umask                       = undef,
){

  case $facts['os']['name'] {
    'RedHat', 'CentOS':  {
        class { 'python':
          version                     => $version,
          ensure                      => $ensure,
          pip                         => $pip,
          dev                         => $dev,
          virtualenv                  => $virtualenv,
        }
    }
    /^(Debian|Ubuntu)$/:  {
        class { 'python':
          version                     => $version,
          ensure                      => $ensure,
          pip                         => $pip,
          dev                         => $dev,
          virtualenv                  => $virtualenv,
          gunicorn                    => $gunicorn,
          manage_gunicorn             => $manage_gunicorn,
          manage_python_package       => $manage_python_package,
          manage_pip_package          => $manage_pip_package,
          manage_virtualenv_package   => $manage_virtualenv_package,
          manage_scl                  => $manage_scl,
          use_epel                    => $use_epel,
          gunicorn_package_name       => $gunicorn_package_name,
          valid_versions              => $valid_versions,
          provider                    => $provider,
          python_pips                 => $python_pips,
          python_virtualenvs          => $python_virtualenvs,
          python_pyvenvs              => $python_pyvenvs,
          python_requirements         => $python_requirements,
          python_dotfiles             => $python_dotfiles,
          rhscl_use_public_repository => $rhscl_use_public_repository,
          anaconda_installer_url      => $anaconda_installer_url,
          anaconda_install_path       => $anaconda_install_path,
          umask                       => $umask,
        }
    }
    default:  {
        notify { 'some_title':
          message  => 'OS is not CentOs/Ubuntu/Debian'
        }include role::generic 
    }
  }
}

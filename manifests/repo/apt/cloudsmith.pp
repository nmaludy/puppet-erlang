# erlang cloudsmith apt repo
class erlang::repo::apt::cloudsmith (
  String $ensure      = $erlang::repo::apt::ensure,
  String $location    = 'https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/deb/debian',
  # trusty, xenial, bionic, etc
  String $release     = downcase($facts['os']['distro']['codename']),
  String $repos       = 'main',
  String $key         = 'A16A42516F6A691BC1FF5621E495BB49CC4BBE5B',
  String $key_source  = 'https://dl.cloudsmith.io/public/rabbitmq/rabbitmq-erlang/gpg.E495BB49CC4BBE5B.key',
  Optional[Variant[Numeric, String]] $pin = $erlang::package_apt_pin,
) inherits erlang {
  apt::source { 'erlang-cloudsmith':
    ensure   => $ensure,
    location => $location,
    release  => $release,
    repos    => $repos,
    key      => {
      'id'     => $key,
      'source' => $key_source,
    },
  }

  if $pin {
    apt::pin { 'erlang':
      packages => '*',
      priority => $pin,
      origin   => inline_template('<%= require \'uri\'; URI(@location).host %>'),
    }
  }
}

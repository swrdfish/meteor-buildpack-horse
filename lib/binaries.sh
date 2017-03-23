needs_resolution() {
  local semver=$1
  if ! [[ "$semver" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    return 0
  else
    return 1
  fi
}

install_nodejs() {
  local version=${1:-6.x}
  local dir="$2"

  if needs_resolution "$version"; then
    echo "Resolving node version $version via semver.io..."
    local version=$(curl --silent --get --retry 5 --retry-max-time 15 --data-urlencode "range=${version}" https://semver.herokuapp.com/node/resolve)
  fi

  echo "Downloading and installing node $version..."
  local download_url="https://s3pository.heroku.com/node/v$version/node-v$version-$os-$cpu.tar.gz"
  local code=$(curl "$download_url" --silent --fail --retry 5 --retry-max-time 15 -o /tmp/node.tar.gz --write-out "%{http_code}")
  if [ "$code" != "200" ]; then
    echo "Unable to download node $version; does it exist?" && false
  fi
  tar xzf /tmp/node.tar.gz -C /tmp
  rm -rf $dir/*
  mv /tmp/node-v$version-$os-$cpu/* $dir
  chmod +x $dir/bin/*
}

install_meteor() {
  local version=${1:-6.x}
  local dir="$2"

  echo "Downloading and installing Meteor $version..."
  local download_url="https://install.meteor.com/?release=$version"
  local code=$(curl "$download_url" --silent --fail --retry 5 --retry-max-time 15 -o /tmp/install_meteor.sh --write-out "%{http_code}")
  if [ "$code" != "200" ]; then
    echo "Unable to download Meteor $version; does it exist?" && false
  fi
  chmod +x /tmp/install_meteor.sh
  HOME="$dir" bash /tmp/install_meteor.sh
  chmod +x "$dir"/.meteor/meteor
}

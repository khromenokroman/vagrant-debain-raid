Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"

  config.vm.provider :virtualbox

  config.vm.disk :disk, size: "1GB", name: "hdd1"
  config.vm.disk :disk, size: "1GB", name: "hdd2"
  config.vm.disk :disk, size: "1GB", name: "hdd3"
  config.vm.disk :disk, size: "1GB", name: "hdd4"
  config.vm.provision "shell", path: "provision.sh"
end

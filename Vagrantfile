$script_ubuntu = <<-SCRIPT
echo Running apt update...
sudo apt update
echo Installing Ubuntu Desktop...
sudo apt install -y ubuntu-desktop
echo Installing VirtualBox Guest Additions
sudo apt install -y virtualbox-guest-additions-iso
echo Complete...
SCRIPT

$script_fedora = <<-SCRIPT
echo Installing Gnome Desktop...
sudo dnf group install -y "Fedora Workstation"
echo Set GUI as default
sudo systemctl set-default graphical.target
echo Complete...
SCRIPT

Vagrant.configure("2") do |config|
  # Create boxes
  boxes = [
    { :script => $script_ubuntu, :box => "ubuntu/focal64", :v_name => "ubuntu-focal64-desktop-workstation" },
    { :script => $script_fedora, :box => "generic/fedora34", :v_name => "fedora-34-desktop-workstation" }
  ]
  boxes.each do |opts|
    config.vm.define opts[:v_name] do |config|
        config.vm.provider "virtualbox" do |v|
            v.name = opts[:v_name]
            v.gui = true
            v.cpus = 4
            v.memory = 8192
            v.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
            v.customize ["modifyvm", :id, "--accelerate3d", "on"]
            end  
        config.vm.box = opts[:box]
        config.vm.provision "shell", inline: opts[:script]
        config.vm.provision :reload    
    end
  end
end

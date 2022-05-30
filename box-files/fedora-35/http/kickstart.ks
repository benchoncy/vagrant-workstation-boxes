text
reboot --eject
lang en_GB.UTF-8
keyboard us
timezone Europe/Dublin
rootpw --plaintext vagrant
user --name=vagrant --password=vagrant --plaintext

# Set up drive
zerombr
clearpart --all --initlabel
part swap --recommended
part / --grow

selinux --permissive
network --bootproto=dhcp --device=eth0
bootloader --timeout=1 --location=mbr

url --url=https://dl.fedoraproject.org/pub/fedora/linux/releases/35/Everything/x86_64/os/

%packages
@Fedora Workstation
%end

%post
# Enable ssh service
systemctl enable sshd.service

# Enable root login and password auth
sed -i -e "s/.*PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
sed -i -e "s/.*PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config

# Enable desktop by default
systemctl set-default graphical.target
%end
username = "nurasyl"
password = ""
hostname = "curking.com"
synced_folder = "/project"

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.box_version = "1802.01"
  config.vm.communicator = "ssh"
  config.vm.hostname = hostname
  config.vm.synced_folder ".", "#{synced_folder}", type: "virtualbox"
  config.vm.network "forwarded_port", guest: 3000, host: 8080

  if ARGV[0] == "ssh"
    config.ssh.username = username
  end
  config.ssh.shell = "bash"
  config.vm.provision "shell", privileged: true, inline: <<-SHELL
    username=#{username}
    password=#{password}
    if [ $(grep -c '^$username' /etc/passwd) == "0" ]; then
	  adduser -m -g wheel -s /bin/bash $username
	  passwd --delete $username
      cp -rf /home/vagrant/.ssh /home/$username/.ssh
      chown -R $username:wheel /home/$username
	  chown -R $username:wheel #{synced_folder}
	  echo User "$username" created!
    else
      echo User "$username" already created!
    fi
  SHELL
end

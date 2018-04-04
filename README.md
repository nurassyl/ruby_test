**Project name:** Curking (Currency king)

------------

- **Vagrant:** v2.0.3
	- Virtualbox: v5.2.8
	- **Box:** centos/7 v1802.01
- **Visual Studio Code:** v1.27.1
	- VS Code Plugins:
		- EditorConfig v0.12.1
		- ruby v0.17.0
- **Git:** v2.16.2

------------

- **OS:** CentOS Linux v7.4.1708 x64
	- ```cat /etc/*-release```

	- ```cat /proc/verssion```

------------

### Install system dependencies
```
sudo yum install vim git gpg openssh
```

------------

### Install frameworks
Install NodeJS
```
# sudo yum install gcc-c++ make
# or: sudo yum groupinstall 'Development Tools'
curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash - &&\
sudo yum -y install nodejs
```
Install PostgreSQL
```
sudo yum install https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm &&\
sudo yum install postgresql96 yum install postgresql96-server postgresql-devel &&\
sudo /usr/pgsql-9.6/bin/postgresql96-setup initdb &&\
sudo systemctl enable postgresql-9.6 &&\
sudo systemctl start postgresql-9.6
```
Install Ruby & Ruby on Rails
```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB &&\
\curl -sSL https://get.rvm.io | bash -s stable &&\
source ~/.profile &&\
rvm install 2.4 &&\
gem install bundler:1.16.1 rails:5.1.6 --no-ri --no-rdoc
```
Install gems
```
PROJECT_DIR=/project &&\
sudo chown -R nurasyl:wheel $PROJECT_DIR &&\
cd $PROJECT_DIR/app &&\
bundle install
```
Migrate
```
rake db:migrate
```
Run HTTP server
```
# Host port: 8080
# Guest port: 3000
RAILS_ENV=development bin/rails server -b 127.0.0.1
```

------------

```
sudo su postgres
psql
\password <new password>

SHOW is_superuser;
CREATE USER nurasyl WITH PASSWORD '12345';
ALTER ROLE nurasyl SET client_encoding TO 'UTF8';
ALTER ROLE nurasyl SET default_transaction_isolation TO 'READ UNCOMMITTED';
ALTER ROLE nurasyl SET TimeZone TO 'UTC';
CREATE DATABASE curking;
CREATE DATABASE curking_test;
CREATE DATABASE curking_dev;
GRANT ALL PRIVILEGES ON DATABASE curking, curking_test, curking_dev TO nurasyl;

SHOW config_file;
\q

# Find "pg_hba.conf" file
sudo fing / -type f -name 'pg_hba.conf' | grep 'pg_hba.conf'
# View "pg_hba.conf" file
sudo vim /var/lib/pgsql/9.6/data/pg_hba.conf

# Change auth method
sudo bash -c 'echo -e "host curking nurasyl localhost password\nhost curking_dev nurasyl localhost password\nhost curking_test nurasyl localhost password\n$(cat /var/lib/pgsql/9.6/data/pg_hba.conf)" > /var/lib/pgsql/9.6/data/pg_hba.conf' &&\
sudo service postgresql-9.6 restart

# Log into the PostgreSQL server
psql -h localhost -U nurasyl -d curking -p 5432 -W
```

------------

### Vagrant
- **Plugins**
```
vagrant plugin install vagrant-vbguest
# vagrant plugin uninstall vagrant-vbguest # Uninstall
```
- **Machine**
	- Status
	```
	vagrant status
	```
	- Install/Reinstall
	```
	./vg.install.sh
	```
	- Start
	```
	vagrant up
	```
	- Restart
	```
	vagrant reload
	```
	- Stop
	```
	vagrant halt
	```
	- Reload provision
	```
	vagrant reload --provision
	```
	- Destroy
	```
	./vg.destroy.sh
	```
- **SSH Client**
Private key path: ./.vagrant/machines/default/virtualbox/private_key
	- SSH info
	```
	vagrant ssh-config
	```
	- Login
	```
	vagrant ssh
	```
	- Exit
	```
	exit
	```

------------

### Shell
- as ROOT
```
sudo -s
```
- Exit
```
exit
```

------------

Get prices
```
rails runner tasks/get_prices.rb
```
Kill process
```
kill -9 <PID>
```

------------

Markdown edited [here](https://pandao.github.io/editor.md/en.html "here")

------------

**Author:** [Nurasyl Aldan](https://github.com/nurassyl) <nurassyl.aldan@gmail.com>

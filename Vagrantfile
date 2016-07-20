# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	
	config.vm.box = "ubuntu1404"

	#config.vm.network "forwarded_port", guest: 8080, host: 8080
	config.vm.network "private_network", ip: "192.168.50.4"


	config.ssh.forward_agent = true

	config.vm.synced_folder "build", '/build'
	
	config.vm.provider "virtualbox" do |vb|
	#   vb.gui = true
		vb.customize ["modifyvm", :id, "--memory", "2048"]
	end

	config.vm.provision "chef_solo" do |chef|
		chef.cookbooks_path = ["./chef/cookbooks","./chef/dna_cookbooks"]
		chef.roles_path = "./chef/roles"
		chef.data_bags_path = "./chef/data_bags"

		chef.add_recipe 'mysql::client'
		chef.add_recipe 'mysql::server'
		chef.add_recipe 'java'
		chef.add_recipe 'ant::install_package'

		pw = "test"
		chef.json = {
			java: {
				jdk_version: '7',
				remove_deprecated_packages: true,
				accept_oracle_download_terms: true,
				set_default: true,
				connect_timeout: 1200
			},
			:mysql => {
				:server_root_password => 'test',
				:server_debian_password => 'test',
				:server_repl_password => 'test'
			}
		}
	end

	require 'fileutils'
	build_dir = 'build'
	# Remove existing cached artifacts.
	#Dir.glob(File.join(build_dir, '*.war')).each do |f|
	#	FileUtils.rm(f)
	#end
	
	# Cache new copies.
	#Dir.glob(File.join('..', '**', 'target', '*.war')).each do |f|
	#	FileUtils.cp(f, 'build')
	#end
	
	config.vm.provision :shell, :path => "provision.sh"

	# puts "Deploying any/all built .war files.""
	# config.vm.provision 'shell', inline: 'cp /build/*.war /var/lib/tomcat7/webapps'
		
	# puts "Setting MySQL to start automatically at boot, and (re)starting the daemon."
	config.vm.provision 'shell', inline: 'update-rc.d mysql defaults'
	config.vm.provision 'shell', inline: 'service mysql restart'

	# puts "The VM network interfaces are configured as follows..."
	config.vm.provision 'shell', inline: 'ifconfig'
	

end

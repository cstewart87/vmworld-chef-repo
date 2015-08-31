VMworld 2015 Chef Workshop Repo
========

The repository will be used for the VMworld 2015 Chef Workshop.  If you're unable to attend, or fell asleep during a portion of the workshop, feel free to clone this repository and follow along with this README.


# Lab 1 - Chef Introduction

## Download Workshop Repo

Includes pre-configured items to help with limited time during workshop making it easier to follow along.

### If Git is already installed

1. Clone this repo to your local machine

		$ git clone https://github.com/vmwaredevops/vmworld-chef-repo.git

### If Git is not installed

1. Download latest copy of repo from this link: [https://github.com/vmwaredevops/vmworld-chef-repo/archive/master.zip](https://github.com/vmwaredevops/vmworld-chef-repo/archive/master.zip)
2. Unzip somewhere on local machine

## Chef Development Kit Installation

### From VMworld USB

1. Double-click Chef DK Installer
	* OSX - ./Chef/chefdk-0.6.2-1.dmg
	* Windows - ./Chef/chefdk-0.6.2-1.msi

### From Web

1. Go to [https://downloads.chef.io/chef-dk/](https://downloads.chef.io/chef-dk/)
2. Select necessary package to download (latest as of writing is v0.7.0):
	* OSX - [https://opscode-omnibus-packages.s3.amazonaws.com/mac_os_x/10.8/x86_64/chefdk-0.7.0-1.dmg](https://opscode-omnibus-packages.s3.amazonaws.com/mac_os_x/10.8/x86_64/chefdk-0.7.0-1.dmg)
	* Windows - [https://opscode-omnibus-packages.s3.amazonaws.com/windows/2008r2/x86_64/chefdk-0.7.0-1.msi](https://opscode-omnibus-packages.s3.amazonaws.com/windows/2008r2/x86_64/chefdk-0.7.0-1.msi)
3. Run downloaded installer
4. Verify installation was successful

		$ chef --version
		Chef Development Kit Version: 0.7.0
		chef-client version: 12.4.1
		berks version: 3.2.4
		kitchen version: 1.4.2

## Hosted Chef Signup

1. Go to [https://manage.chef.io/signup/](https://manage.chef.io/signup/)
2. Fill out signup form
3. Click __Create New Organization__
![Create Chef Organization](./img/chef-manage-create-org.png?raw=true "Create Chef Org")
4. Enter "Full Name" and "Short Name" for your organization.  NOTE: Full Name can be whatever you want, but Short Name must be unique (across all hosted Chef orgs)
![Enter Org Info](./img/chef-manage-org-details.png?raw=true "Organization Details")
5. Navigate to the __Administration__ panel and select __Users__ from the left menu.  Select your user, then click "Reset Key" from that Actions menu
![Reset Key](./img/chef-manage-reset-key.png?raw=true "Reset Key")
6. Click "Reset Key" download your user pem
![Download User Pem](./img/chef-manage-download-user-pem.png?raw=true "Download User Pem")
7. Add downloaded user pem to `/vmworld-chef-repo/.chef/[username].pem`
8. Copy `./vmworld-chef-repo/.chef/knife.rb.example` to `./vmworld-chef-repo/.chef/knife.rb` and replace the following items (we'll replace the others later:
	* INSERT_CHEF_USERNAME
	* INSERT_CHEF_ORG_SHORTNAME
9. Run `knife client list` from within your `/vmworld-chef-repo/` directory to verify access to your Chef server. 


# Lab 2 - vCloud Air + Chef

1. Install knife-vcair plugin

		$ chef exec gem install knife-vcair

2. Ensure `./vmworld-chef-repo/.chef/knife.rb` is up-to-date with vCloud Air configurations

		current_dir = File.dirname(__FILE__)
		log_level                :info
		log_location             STDOUT
		node_name				 mychefuser
		client_key               "#{current_dir}/mychefuser.pem"
		chef_server_url          "https://api.opscode.com/organizations/mycheforg"
		cookbook_path            ["#{current_dir}/../cookbooks"]

		# vCloud Air OnDemand Settings
		knife[:vcair_api_host] = "us-california-1-3.vchs.vmware.com"
		knife[:vcair_username] = "VCAIR USERNAME FROM SLIDES"
		knife[:vcair_password] = "VCAIR PASSWORD FROM SLIDES"
		knife[:vcair_org]      = "f305cc3c-57ee-40ad-bca0-16a7d5d2a1f9"
		knife[:vcair_vdc]      = "ChefVDC1"
		knife[:vcair_api_path] = '/api/compute/api'

3. Upload cookbook to the Chef Server - be sure you're in /vmworld-chef-repo/ directory

		$ knife cookbook upload hello_vmworld

4. Create and bootstrap vCloud Air VM

		knife vcair server create --ssh-password vmworld2015 --image "CentOS64-64BIT" --node-name YOURNAME-chef-node --customization-script bootstrap/install-linux-vcair-example.sh --run-list 'recipe[hello_vmworld::default]' --ssh-gateway root@107.189.120.118 --fog-version 1.33.0 --vcair-net chef-routed-network --no-host-key-verify

# Troubleshooting

### winrm gem Conflicts

If you see something along these lines:

```
/opt/chefdk/embedded/lib/ruby/site_ruby/2.1.0/rubygems/specification.rb:2104:in `raise_if_conflicts': Unable to activate winrm-s-0.3.1, because winrm-1.2.0 conflicts with winrm (~> 1.3.0) (Gem::ConflictError)
	from /opt/chefdk/embedded/lib/ruby/site_ruby/2.1.0/rubygems/specification.rb:1282:in `activate'
	from /opt/chefdk/embedded/lib/ruby/site_ruby/2.1.0/rubygems/specification.rb:1316:in `block in activate_dependencies'
	from /opt/chefdk/embedded/lib/ruby/site_ruby/2.1.0/rubygems/specification.rb:1302:in `each'
	from /opt/chefdk/embedded/lib/ruby/site_ruby/2.1.0/rubygems/specification.rb:1302:in `activate_dependencies'
	from /opt/chefdk/embedded/lib/ruby/site_ruby/2.1.0/rubygems/specification.rb:1284:in `activate'
	from /opt/chefdk/embedded/lib/ruby/site_ruby/2.1.0/rubygems/core_ext/kernel_require.rb:117:in `require'
```

Try running `chef exec gem uninstall winrm -v 1.2.0`

# References

* [Learn Chef](https://learn.chef.io/index.html)
* ESXi
	* [knife-esx](https://github.com/maintux/knife-esx)
* Fusion and Workstation
	* [Vagrant + VMware](https://www.vagrantup.com/vmware)
	* [Vagrant + Chef Client](http://docs.vagrantup.com/v2/provisioning/chef_client.html)
	* [Vagrant + Chef Solo](http://docs.vagrantup.com/v2/provisioning/chef_solo.html)
	* [Vagrant + Chef Zero](http://docs.vagrantup.com/v2/provisioning/chef_zero.html)
	* [Vagrant + Chef Apply](http://docs.vagrantup.com/v2/provisioning/chef_apply.html)
	* [kitchen-vagrant](https://github.com/test-kitchen/kitchen-vagrant)
* vCloud Air
	* [knife-vcair](https://github.com/chef-partners/knife-vcair)
	* [kitchen-vcair](https://github.com/vulk/kitchen-vcair)
* vSphere
	* [chef-provisioning-vsphere](https://github.com/CenturyLinkCloud/chef-provisioning-vsphere)
	* [knife-vsphere](https://github.com/ezrapagel/knife-vsphere)
* VMware Integrated OpenStack
	* [knife-openstack](https://github.com/chef/knife-openstack)
	* [kitchen-openstack](https://github.com/test-kitchen/kitchen-openstack) 	

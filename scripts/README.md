# Pre-requisites

There are a few items that need to be pre-configured in order to provide necessary networking configurations for remote access to provisioned VMs.

* Allocate Public IP
* Setup jumphost and use for SSH gateway
* Install [vca-cli](https://github.com/vmware/vca-cli) tool
* Configure network (NAT/Firewall) settings for SSH and internet access (currently using vca-cli tool)
* Use [vcair-network-setup script](./scripts/vcair-network-setup.sh) to setup necessary NAT rules
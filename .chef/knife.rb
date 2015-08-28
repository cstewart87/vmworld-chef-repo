current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name				 ENV['CHEF_USER']
client_key               "#{current_dir}/#{ENV['CHEF_USER']}.pem"
validation_client_name   "#{ENV['CHEF_ORG']}-validator"
validation_key           "#{current_dir}/#{ENV['CHEF_ORG']}-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/#{ENV['CHEF_ORG']}"
cookbook_path            ["#{current_dir}/../cookbooks"]

# vCloud Air OnDemand Settings
knife[:vcair_api_host] = "us-california-1-3.vchs.vmware.com"
knife[:vcair_username] = ENV['VCAIR_USERNAME']
knife[:vcair_password] = ENV['VCAIR_PASSWORD']
knife[:vcair_org]      = ENV['VCAIR_HOST']
knife[:vcair_vdc]      = ENV['VCAIR_VDC']
knife[:vcair_api_path] = '/api/compute/api'

require 'yaml'

rules = [
	{"type"=>"SNAT", "original_ip"=>"192.168.109.0/24", 'original_port' => 'any', 'translated_ip' => "107.189.120.118", 'translated_port' => 'any', 'protocol' => 'any'},
	{"type"=>"DNAT", "original_ip"=>"107.189.120.118", 'original_port' => 22, 'translated_ip' => "192.168.109.2", 'translated_port' => 22, 'protocol' => 'tcp'}
]

(3..120).each do |n|
	port = 8000 + n
	rules << {"type"=>"DNAT", "original_ip"=>"107.189.120.118", 'original_port' => port, 'translated_ip' => "192.168.109.#{n}", 'translated_port' => 80, 'protocol' => 'tcp'}
	rules << {"type"=>"DNAT", "original_ip"=>"107.189.120.118", 'original_port' => "#{n}22", 'translated_ip' => "192.168.109.#{n}", 'translated_port' => 22, 'protocol' => 'tcp'}
end

::File.open('./scripts/vcair_chef_nat.yaml', 'w') {|f| f.write(rules.to_yaml) }
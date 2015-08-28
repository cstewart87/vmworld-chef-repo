#/bin/bash
vca login $VCAIR_USERNAME --host $VCAIR_HOST --password $VCAIR_PASSWORD --instance $VCAIR_INSTANCE
vca vdc use --vdc $VCAIR_VDC
vca firewall disable
vca nat add --type DNAT --original-ip $VCAIR_GATEWAY_IP --original-port 22 --translated-ip 192.168.109.2 --translated-port 22 --protocol tcp
vca nat add --type DNAT --original-ip $VCAIR_GATEWAY_IP --original-port 8003 --translated-ip 192.168.109.3 --translated-port 80 --protocol tcp
vca nat add --type DNAT --original-ip $VCAIR_GATEWAY_IP --original-port 8004 --translated-ip 192.168.109.4 --translated-port 80 --protocol tcp
vca nat add --type DNAT --original-ip $VCAIR_GATEWAY_IP --original-port 8005 --translated-ip 192.168.109.5 --translated-port 80 --protocol tcp
vca nat add --type DNAT --original-ip $VCAIR_GATEWAY_IP --original-port 8006 --translated-ip 192.168.109.6 --translated-port 80 --protocol tcp
vca nat add --type DNAT --original-ip $VCAIR_GATEWAY_IP --original-port 8007 --translated-ip 192.168.109.7 --translated-port 80 --protocol tcp
vca nat add --type SNAT --original-ip 192.168.109.0/24 --translated-ip $VCAIR_GATEWAY_IP

# Troubleshooting
# vca org info
# vca status
# vca vdc
# vca status
# vca gateway
# vca nat
# vca vm
# vca nat delete -a # clear nat rules

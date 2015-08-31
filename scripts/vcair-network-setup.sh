#/bin/bash
vca login $VCAIR_USERNAME --host $VCAIR_HOST --password $VCAIR_PASSWORD --instance $VCAIR_INSTANCE
vca vdc use --vdc $VCAIR_VDC
vca firewall disable
vca nat add --file ./vcair_chef_nat.yaml

# Troubleshooting
# vca org info
# vca status
# vca vdc
# vca status
# vca gateway
# vca nat
# vca vm
# vca nat delete -a # clear nat rules

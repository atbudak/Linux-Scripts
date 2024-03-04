#! /bin/bash

registry="registry.overtech.com.tr/overtech/overpay:"
os_registry="172.30.1.1:5000/overpay/overpay_"

### created image list
declare -a OverpayRegistryArray

OverpayRegistryArray=(controllers_master services_master daemons_financialdocument_master gateways_gib_master \
gateways_integration_master gateways_pfterminal_master gateways_pfreporting_master management_master \
reseller_master sales_master gateways_supervisor_master)

for tag in ${OverpayRegistryArray[@]}; do
	echo $tag
	docker pull ${registry}${tag}
	docker tag ${registry}${tag} ${os_registry}${tag}
	docker push ${os_registry}${tag}
	echo "${os_registry}${tag} was pushed"
done

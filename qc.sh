#!/usr/bin/env bash

GREEN=`tput setaf 2`
RESET=`tput sgr0`

# Set Project
PROJECT=$(gcloud config get-value project)

echo -e "\n${GREEN}01 Project name matches DD"
echo "--------------------------------------------------------------------------------------------------------${RESET}"

gcloud config list --format 'value(core.project)'

echo -e "\n${GREEN}02 Check for default network firewall rules & routes"
echo "-------------------------------------------------------------------------------------------------------- ${RESET}"

gcloud compute firewall-rules list --filter="network~'default'" --format="json(
                name,
                network
            )"

gcloud compute routes list --filter="network~'default'"


echo -e "\n${GREEN}03 Networks"
echo "--------------------------------------------------------------------------------------------------------${RESET}"

gcloud compute networks list

echo -e "\n${GREEN}04 Subnetworks"
echo "--------------------------------------------------------------------------------------------------------${RESET}"

gcloud compute networks subnets list

echo -e "\n${GREEN}05 Peerings"
echo "--------------------------------------------------------------------------------------------------------${RESET}"
gcloud compute networks peerings list


echo -e "\n${GREEN}06 Firewall Rules"
echo "--------------------------------------------------------------------------------------------------------${RESET}"
gcloud compute firewall-rules list --format="table(
                name,
                network,
                direction,
                sourceRanges.list():label=SRC,
                destinationRanges.list():label=DEST,
                allowed[].map().firewall_rule().list():label=ALLOW,
                sourceTags.list():label=SRC_TAGS,
                targetTags.list():label=TARGET_TAGS
            )"

echo -e "\n${GREEN}07 VPN tunnels"
echo "--------------------------------------------------------------------------------------------------------${RESET}"
gcloud compute vpn-tunnels list

echo -e "\n${GREEN}08 Certificates"
echo "--------------------------------------------------------------------------------------------------------${RESET}"
gcloud compute ssl-certificates list

echo -e "\n${GREEN}09 LoadBalancers"
echo "--------------------------------------------------------------------------------------------------------${RESET}"
gcloud compute backend-services list

echo -e "\n${GREEN}10 IP address list"
echo "--------------------------------------------------------------------------------------------------------${RESET}"
gcloud compute addresses list

echo -e "\n${GREEN}11 Instances Group list"
echo "--------------------------------------------------------------------------------------------------------${RESET}"
gcloud compute instance-groups list

echo -e "\n${GREEN}12 Instances templates list"
echo "--------------------------------------------------------------------------------------------------------${RESET}"
gcloud compute instance-templates list

echo -e "\n${GREEN}13 Instances list"
echo "--------------------------------------------------------------------------------------------------------${RESET}"
gcloud compute instances list

echo -e "\n${GREEN}14 Kubernetes Clusters"
echo "--------------------------------------------------------------------------------------------------------${RESET}"
gcloud gcloud container clusters list

echo -e "\n${GREEN}15 Cloud SQL instances list"
echo "--------------------------------------------------------------------------------------------------------${RESET}"
gcloud sql instances list

echo -e "\n${GREEN}16 List Roles IAMs"
echo "--------------------------------------------------------------------------------------------------------${RESET}"
gcloud projects get-iam-policy $PROJECT

echo -e "\n${GREEN}17 List Service Accounts"
echo "--------------------------------------------------------------------------------------------------------${RESET}"
for item in $(gcloud projects get-iam-policy $PROJECT |grep serviceAccount|cut -f2 -d':'); do echo "$item";gcloud iam service-accounts keys list --iam-account "$item";done

#echo -e "\n${GREEN}18 Cloud DNS"
#echo "--------------------------------------------------------------------------------------------------------${RESET}"
#gcloud dns managed-zones list




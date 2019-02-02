#!/bin/bash
# Tag each AMI with the source AMI's creation date.

source_ami_creation_date=$(aws ec2 describe-images --image-ids $SOURCE_AMI --query 'Images[0].CreationDate' --output text)

for build in $(jq -r '.builds[] | (.artifact_id)' artifacts.json); do
	# Each line looks like: us-west-1:ami-12345678
	region=$(cut -d : -f 1)
	ami=$(cut -d : -f 2)
	echo "Tagging $ami in $region with tag: SourceAMICreationDate=$source_ami_creation_date ..."
	aws ec2 create-tags --tags Key=SourceAMICreationDate,Value=$source_ami_creation_date --resources $ami --region $region
done

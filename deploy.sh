#!/usr/bin/env bash

set -e

aws s3 cp .build/account-package.zip s3://reiddhughes-custom-resource-packages-v1-us-east-1/account-package.zip
REGISTRATION_TOKEN=$(aws cloudformation register-type --type RESOURCE --type-name 'REIDDHUGHES::Demo::Account' --schema-handler-package s3://reiddhughes-custom-resource-packages-v1-us-east-1/account-package.zip --query 'RegistrationToken' --output text)
echo "Registration token is: $REGISTRATION_TOKEN"

echo "Waiting for registration to complete."
aws cloudformation wait type-registration-complete --registration-token $REGISTRATION_TOKEN
echo "Registration is complete."

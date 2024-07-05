#!/usr/bin/env bash
set -euo pipefail

# Wait for DynamoDB Local to be ready
sleep 5 #Dirty hack. There could be another way to poll the dynamo db server 

# Create DynamoDB table
aws dynamodb create-table --cli-input-json file://subaccount-api/app/create-table-posttrade-subaccount.json --endpoint-url http://localhost:8000 > /dev/null

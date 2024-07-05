#!/bin/bash

DYNAMODB_ENDPOINT="http://localhost:8000"

# Start DynamoDB Local in the background
java -jar DynamoDBLocal.jar -inMemory -sharedDb &

# Wait for DynamoDB Local to start
until curl -s $DYNAMODB_ENDPOINT; do
    echo "Waiting for DynamoDB Local to start..."
    sleep 1
done

# Create the table
aws dynamodb create-table \
    --table-name Posttrade_SubAccount \
    --attribute-definitions AttributeName=FirmId,AttributeType=S AttributeName=Code,AttributeType=S \
    --key-schema AttributeName=FirmId,KeyType=HASH AttributeName=Code,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --endpoint-url $DYNAMODB_ENDPOINT \
    --region us-west-2

# Keep the container running
tail -f /dev/null

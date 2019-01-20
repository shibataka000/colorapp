#!/bin/bash

export AWS_ACCOUNT="370106426606"
export AWS_PROFILE="default"
export AWS_REGION="us-east-1"
export AWS_DEFAULT_REGION="$AWS_REGION"

export MESH_NAME="default"
export SERVICES_DOMAIN="default.svc.cluster.local"
export COLOR_GATEWAY_IMAGE_NAME="colorgateway"
export COLOR_TELLER_IMAGE_NAME="colorteller"

export COLOR_GATEWAY_IMAGE="${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/${COLOR_GATEWAY_IMAGE_NAME}"
export COLOR_TELLER_IMAGE="${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/${COLOR_TELLER_IMAGE_NAME}"
export ENVOY_IMAGE="111345817488.dkr.ecr.us-west-2.amazonaws.com/aws-appmesh-envoy:v1.8.0.2-beta"

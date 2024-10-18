#!/bin/bash

echo "Deploying website to Google Cloud Storage..."

# Build the Hugo site
cd website
hugo --minify

# Sync with Google Cloud Storage bucket
gsutil -m rsync -d -r public gs://your-bucket-name

echo "Deployment complete!"

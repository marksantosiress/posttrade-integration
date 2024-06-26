# Posttrade Integration Project

This project integrates multiple posttrade componenets, including a frontend application (MFE), a backend BFF service, and an NGINX reverse proxy to handle CORS and URL rewriting. The project uses Docker and Docker Compose to build and run the services locally.

## Prerequisites

Before you begin, ensure you have the following installed on your machine:

- Docker
- Docker Compose
- Make
- authenticate

## Setup

1. Clone the repository

   ```sh
   git clone git@github.com:marksantosiress/posttrade-integration.git
   cd posttrade-integration

1. Initialize submodules

   ```sh
   git submodule update --init --recursive

## Developing and Updating Submodules

The safest way to develop and update submodules is to navigate to each submodule's directory and perform git operations as you would in a standalone repository. This ensures that you can work on each submodule independently and with full control over your git workflow.

1. Update each submodule to the latest commit on the main branch

   ```sh
   git submodule foreach 'git checkout main && git pull origin main'

1. Add and commit the updated submodule references

   ```sh
   git add .
   git commit -m "Update submodules to latest commits"
   git commit -m "Update submodules to latest commits"

## Building and Running the project

1. Install dependencies

   ```sh
   make install

1. Build the project

   ```sh
   make build

1. Run the project

   ```sh
   make start

   Go to: http://localhost

1. Stop the project

   ```sh
   make stop
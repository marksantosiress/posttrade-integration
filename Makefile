# Use some sensible default shell settings
SHELL := /bin/bash
.ONESHELL:
.SILENT:

RED := '\033[1;31m'
CYAN := '\033[0;36m'
NC := '\033[0m'

ifdef OS
    export USER_ID=0
    export GROUP_ID=0
else
    export USER_ID=$(shell id -u)
    export GROUP_ID=$(shell id -g)
endif

.PHONY: frontend_install
frontend_install:
	echo -e --- $(CYAN)Installing frontend dependencies ...$(NC)
	@docker-compose run --rm mfe-node yarn install

.PHONY: frontend_build
frontend_build:
	echo -e --- $(CYAN)Building the frontend project ...$(NC)
	@docker-compose run --rm mfe-node yarn webpack --config /app/webpack.isolated.cjs

.PHONY: bff_build
bff_build:
	echo -e --- $(CYAN)Building the BFF project ...$(NC)
	docker-compose build bff

.PHONY: subaccount_api_build
subaccount_api_build:
	echo -e --- $(CYAN)Building the Sub Account Api project ...$(NC)
	docker-compose build subaccount-api

.PHONY: frontend_run_local
frontend_run_local:
	echo -e --- $(CYAN)Running frontend locally ...$(NC)
	@docker-compose up -d mfe-node

.PHONY: bff_run_local
bff_run_local:
	echo -e --- $(CYAN)Running BFF locally ...$(NC)
	@docker-compose up -d bff

.PHONY: subaccount_api_run_local
subaccount_api_run_local:
	echo -e --- $(CYAN)Running Sub Account Api locally ...$(NC)
	@docker-compose up -d subaccount-api

.PHONY: dynamodb_run_local
dynamodb_run_local:
	echo -e --- $(CYAN)Running DynamoDB locally ...$(NC)
	@docker-compose up -d dynamodb && ./dynamodb_table_setup.sh

.PHONY: nginx_run_local
nginx_run_local:
	echo -e --- $(CYAN)Running NGINX reverse proxy locally ...$(NC)
	@docker-compose up -d nginx

.PHONY: install
install: frontend_install
	echo -e --- $(CYAN)Installing project dependencies ...$(NC)

.PHONY: build
build: frontend_build bff_build subaccount_api_build
	echo -e --- $(CYAN)Building all projects ...$(NC)

.PHONY: start
start: dynamodb_run_local bff_run_local subaccount_api_run_local nginx_run_local
	echo -e --- $(CYAN)Running all services locally ...$(NC)

.PHONY: stop
stop:
	echo -e --- $(CYAN)Stopping all running containers ...$(NC)
	@docker-compose down --remove-orphans
	@docker ps -q --filter "name=posttrade-integration" | xargs -r docker stop
	@docker ps -a -q --filter "name=posttrade-integration" | xargs -r docker rm

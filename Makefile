#!/usr/bin/make

#----------- Make Environment ----------------------
SHELL=/bin/bash

COMPOSE_CONFIG=-f docker-compose.yml

.DEFAULT_GOAL := help

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \033[92m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo "\n  Allowed for overriding next properties:\n\n\
	    PULL_TAG - Tag for pulling images before building own\n\
	              ('latest' by default)\n\
	    PUBLISH_TAGS - Tags list for building and pushing into remote registry\n\
	                   (delimiter - single space, 'latest' by default)\n\n\
	  Usage example:\n\
	    make PULL_TAG='v1.2.3' PUBLISH_TAGS='latest v1.2.3 test-tag' php56-push"

---------------: ## ------[ ACTIONS ]---------
#Actions --------------------------------------------------
check: ## Check your configuration
	docker compose $(COMPOSE_CONFIG) config
up: ## Start all containers (in background)
	docker compose $(COMPOSE_CONFIG) up -d
down: ## Stop all started for development containers
	docker compose $(COMPOSE_CONFIG) down
restart: ## Restart all started for development containers
	docker compose $(COMPOSE_CONFIG) restart

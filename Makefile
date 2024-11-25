SHELL := /bin/bash

-include .env

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Build the project’s smart contracts.
	forge build

clean: ## Remove the build artifacts and cache directories.
	forge clean
	
tests: ## Run the project’s tests.
	forge test

coverage: ## Displays which parts of your code are covered by tests. 
	forge coverage

coverage-report: ## Create a coverge report of the code that is uncovered by tests.
	forge coverage --report debug > coverage.report

format: ## Format Solidity source files.
	forge fmt

# Makefile for a simple Rails app

# Variables
APP_NAME = simple-chat-rails
RAILS_ENV = development

# Default target
all: setup

# Setup the application
setup: install setup_db

# Install gems
install:
	bundle install

# Setup the database
setup_db:
	bin/rails db:setup RAILS_ENV=$(RAILS_ENV)

migrate:
	bin/rails db:migrate RAILS_ENV=$(RAILS_ENV)

# Start the Rails server
run: install
	bin/rails server

# Run tests
test:
	bin/rails test

# Clean up
clean:
	bin/rails db:drop RAILS_ENV=$(RAILS_ENV)
	bin/rails db:create RAILS_ENV=$(RAILS_ENV)
	bin/rails db:migrate RAILS_ENV=$(RAILS_ENV)

.PHONY: all setup install_gems setup_db start test clean
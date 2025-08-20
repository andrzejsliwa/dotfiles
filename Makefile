.PHONY: all

default: install link
clean: unlink uninstall

install: ## install all software
	@bin/install

uninstall: ## uninstall all software
	@bin/uninstall

link: ## link all stows
	@bin/link

unlink: ## unlink all stows
	@bin/unlink

update: ## update the sources
	./update_sources.sh

define print_help
	grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(1) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36mmake %-20s\033[0m%s\n", $$1, $$2}'
endef

help:
	@printf "\033[36mHelp: \033[0m\n"
	@$(foreach file, $(MAKEFILE_LIST), $(call print_help, $(file));)


# Short names for the Web and Desktop application commands. The package.json
# scripts they call stay the source of truth; docs/development.md documents both.
.DEFAULT_GOAL := help
.PHONY: help build clean start web desktop dev-web dev-desktop

PNPM ?= pnpm
ARGS ?=

# Local Web startup uses the installed Homebrew Node and project-local state.
LOCAL_NODE_BIN ?= /opt/homebrew/opt/node/bin
LOCAL_DSH_HOME ?= $(CURDIR)/.cache/office-dev-home

help:
	@echo "make start        start the local Web app with project-local settings and sessions"
	@echo "make build        pnpm run build           complete repository build"
	@echo "make clean        pnpm run clean           remove build outputs and safe deleted-package residue"
	@echo "make web          pnpm run start:web       serve the built Web artifacts from source"
	@echo "make desktop      pnpm run start:desktop   launch the built Desktop artifacts"
	@echo "make dev-web      pnpm run dev:web         build, serve, and rebuild Web on source edits"
	@echo "make dev-desktop  pnpm run dev:desktop     build, then launch Desktop"
	@echo "ARGS='--no-open --port 3081' forwards options to the launched application;"
	@echo "the Web commands accept dsh web flags, the Desktop launcher accepts none."

build:
	$(PNPM) run build

clean:
	$(PNPM) run clean

start:
	env PATH="$(LOCAL_NODE_BIN):$$PATH" DSH_HOME="$(LOCAL_DSH_HOME)" "$(CURDIR)/node_modules/.bin/pnpm" run start:web $(ARGS)

web:
	$(PNPM) run start:web $(ARGS)

desktop:
	$(PNPM) run start:desktop $(ARGS)

dev-web:
	$(PNPM) run dev:web $(ARGS)

dev-desktop:
	$(PNPM) run dev:desktop $(ARGS)

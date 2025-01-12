# Variables
DESTDIR ?=

WWWROOT ?= /var/www/html
WWWPREFIX ?= /morniteaque.org

OUTPUT_DIR ?= out

# Private variables
sts = ps-pwa
all: $(addprefix build-pwa/,$(sts))

# Build
build: $(addprefix build-pwa/,$(sts))

# Build frontend
$(addprefix build-pwa/,$(sts)):
	mkdir -p $(OUTPUT_DIR)
	hugo --baseURL=/
	tar czvf $(OUTPUT_DIR)/$(subst build-pwa/,,$@).tar.gz -C public .

# Install
install: $(addprefix install-pwa/,$(sts))

# Install frontend
$(addprefix install-pwa/,$(sts)):
	mkdir -p $(DESTDIR)$(WWWROOT)$(WWWPREFIX)
	cp -rf public/* $(DESTDIR)$(WWWROOT)$(WWWPREFIX)

# Uninstall
uninstall: $(addprefix uninstall-pwa/,$(sts))

# Uninstall frontend
$(addprefix uninstall-pwa/,$(sts)):
	rm -rf $(DESTDIR)$(WWWROOT)$(WWWPREFIX)

# Run
run:
	hugo server --baseURL=/ --appendPort=false

# Develop
dev:
	hugo server -D --baseURL=/ --appendPort=false

# Clean
clean:
	rm -rf out public resources static/assets

# Dependencies
depend:
	npm i
	find node_modules/@patternfly/patternfly/ -name "*.css" -type f -delete
	rm -rf static/assets
	mkdir -p static
	cp -r node_modules/@patternfly/patternfly/assets static

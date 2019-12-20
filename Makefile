
# Makefile for mfa

VERSION ?= 0.0.0

build:

test:

archive:

release:

build-prerequisites:
	mkdir -p bin dist

test-prerequisites:

### BUILD ###################################################################

build-mfa: build-prerequisites
	go build -ldflags "-X main.version=${VERSION} -X main.commit=$$(git rev-parse --short HEAD 2>/dev/null || echo \"none\")" -o bin/$(OUTPUT_DIR)mfa cli/main.go
build-mfa-linux_amd64: build-prerequisites
	$(MAKE) GOOS=linux GOARCH=amd64 OUTPUT_DIR=linux_amd64/ build
build-mfa-darwin_amd64: build-prerequisites
	$(MAKE) GOOS=darwin GOARCH=amd64 OUTPUT_DIR=darwin_amd64/ build
build-mfa-windows_amd64: build-prerequisites
	$(MAKE) GOOS=windows GOARCH=amd64 OUTPUT_DIR=windows_amd64/ build

build-linux_amd64: build-mfa-linux_amd64
build-darwin_amd64: build-mfa-darwin_amd64
build-windows_amd64: build-mfa-windows_amd64

build: build-mfa
build-all: build-linux_amd64 build-darwin_amd64 build-windows_amd64

### ARCHIVE #################################################################

archive-mfa-linux_amd64: build-mfa-linux_amd64
	tar czf dist/mfa-${VERSION}-linux_amd64.tar.gz -C bin/linux_amd64/ .
archive-mfa-darwin_amd64: build-mfa-darwin_amd64
	tar czf dist/mfa-${VERSION}-darwin_amd64.tar.gz -C bin/darwin_amd64/ .
archive-mfa-windows_amd64: build-mfa-windows_amd64
	tar czf dist/mfa-${VERSION}-windows_amd64.tar.gz -C bin/windows_amd64/ .

archive-linux_amd64: archive-mfa-linux_amd64
archive-darwin_amd64: archive-mfa-darwin_amd64
archive-windows_amd64: archive-mfa-windows_amd64

archive: archive-linux_amd64 archive-darwin_amd64 archive-windows_amd64

release: archive
	sha1sum dist/*.tar.gz > dist/mfa-${VERSION}.shasums

### TEST ####################################################################

test-mfa:
	ginkgo
test-mfa-watch:
	ginkgo watch
test: test-mfa
.PHONY: test-mfa
.PHONY: test

clean:
	rm -r bin/* dist/*

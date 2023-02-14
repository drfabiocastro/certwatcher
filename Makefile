BINARY=certwatcher

all: build

build:
	go build -o cmd/certwatcher/$(BINARY) cmd/certwatcher/main.go
clean:
	@go clean
	@rm -f cmd/certwatcher/$(BINARY)

run:
	cmd/certwatcher/$(BINARY)

.PHONY: all build clean run

install:
	@echo "[INFO] Cloning certwatcher templates repository into ~/.certwatcher-templates"
	# Cloning the certwatcher-templates repository
	@if [ ! -d "$(HOME)/.certwatcher-templates" ]; then \
		echo "[INFO] Cloning the certwatcher-templates repository into $(HOME)/.certwatcher-templates"; \
		git clone https://github.com/drfabiocastro/certwatcher-templates.git $(HOME)/.certwatcher-templates; \
	else \
		echo "[INFO] certwatcher-templates repository already exists in $(HOME)/.certwatcher-templates"; \
	fi
	@echo "[INFO] Moving the binary to /usr/bin/certwatcher"
	@if [ -f "/usr/bin/certwatcher" ]; then \
		read -p "[WARN] A binary already exists at /usr/bin/certwatcher. Do you want to delete it? (y/n) " answer; \
		sudo rm -f "/usr/bin/certwatcher"; \
	fi
	@cp cmd/certwatcher/certwatcher /usr/bin/certwatcher
	@echo "[INFO] Creating hidden directory .certwatcher-templates at the user home directory"
	@mkdir -p ~/.certwatcher-templates
	@echo "[INFO] Certwatcher binary successfully installed at /usr/bin/certwatcher."
	@echo "[INFO] Templates successfully cloned."
	@echo "[INFO] You can now run the certwatcher"

update:
	@echo "[INFO] Updating certwatcher templates repository"
	@cd $(HOME)/.certwatcher-templates && git pull origin master
	@echo "[INFO] Templates updated."
	@read -p "Do you want to update the certwatcher binary? (y/n) " answer;
	if [ "$$answer" == "y" ]; then
		echo "[INFO] Updating certwatcher binary";
		cd cmd/certwatcher && make install;
		echo "[INFO] Certwatcher binary updated.";
	else
		echo "[INFO] Not updating certwatcher binary.";
	fi
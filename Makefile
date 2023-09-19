.PHONY: help
help: 
	@echo "Supported commands"
	@echo "1. make drop-packets"

.PHONY: drop-packets
drop-packets: drop-packets-generate drop-packets-build

drop-packets-generate: 
	go generate ./...

drop-packets-build:
	go build -o ./cmd/drop_packets/drop-4040-packets ./cmd/drop_packets/...

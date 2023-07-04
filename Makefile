
deps:
	(cd themes/congo && npm install)

ship:
	echo "Ship!"

s: server

server:
	npm run dev

.PHONY: deps ship s server

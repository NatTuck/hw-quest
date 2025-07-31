
server: deps
	hugo server

deps:
	(cd themes/blowfish && npm install)
	npm install -g @tailwindcss/cli@4.1.7
	tailwindcss -c ./themes/blowfish/tailwind.config.js \
		-i ./themes/blowfish/assets/css/main.css \
		-o ./assets/css/compiled/main.css --jit

ship:
	hugo
	rsync -avz --delete public/ nat@gargoyle:/home/nat/www/homework.quest

s: server

clean:
	rm -rf public resources

.PHONY: deps ship s server

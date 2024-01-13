
server: deps
	hugo server

deps:
	(cd themes/congo && npm install)

ship:
	hugo
	rsync -avz --delete public/ nat@homework.quest:/home/nat/www/homework.quest

s: server

clean:
	rm -rf public resources

.PHONY: deps ship s server

name=rtgnx/bitlbee


build: Dockerfile
	docker build -t $(name) .

fresh: Dockerfile
	docker build --no-cache -t $(name) .

run:
	docker run -d -p 6667 $(name)

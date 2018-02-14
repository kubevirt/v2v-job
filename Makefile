build:
	docker build -t quay.io/fabiand/v2v .

run:
	bash bin/job data/example-srcs/

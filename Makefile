run:
	bash -ex bin/job /var/tmp/dst disk ~/tmp/test-src/disk.raw

container-build:
	make -C images

container-run: container-build
	docker run \
		-v /home/fabiand/tmp/test-src:/v2v-src \
		-v /var/tmp:/var/tmp \
		-v /dev/kvm:/dev/kvm \
		--tmpfs /v2v-dst \
		--cap-add ALL --privileged \
		--rm -it quay.io/fabiand/v2v-job \
		/v2v-dst disk /v2v-src/disk.raw 

job-run:
	kubectl apply -f manifests/job.yaml

QUAY_ORG=kubevirt

run:
	bash -ex bin/job /var/tmp/dst disk ~/tmp/test-src/disk.raw

container-build: images/v2v-job/Dockerfile
	docker build -t quay.io/${QUAY_ORG}/v2v-job -f images/v2v-job/Dockerfile .

container-run: container-build
	docker run \
		-v /dev/kvm:/dev/kvm \
		--tmpfs /v2v-dst \
		--cap-add ALL --privileged \
		--rm -it quay.io/${QUAY_ORG}/v2v-job \
		/v2v-dst disk example

job-run:
	sed 's#value:.*#value: "disk example"#' manifests/v2v-job.yaml \
	| kubectl apply -f -

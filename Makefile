build:
	docker build --no-cache --tag netdata-smol:latest .

stop:
	-docker stop netdata-smol && docker rm netdata-smol

run: stop
	docker run --name=netdata-smol \
		-p 19999:19999 \
		-v netdatalib:/var/lib/netdata \
		-v netdatacache:/var/cache/netdata \
		-v /etc/passwd:/host/etc/passwd:ro \
		-v /etc/group:/host/etc/group:ro \
		-v /proc:/host/proc:ro \
		-v /sys:/host/sys:ro \
		-v /etc/os-release:/host/etc/os-release:ro \
		--restart unless-stopped \
		--cap-add SYS_PTRACE \
		--security-opt apparmor=unconfined \
		netdata-smol:latest \
		/opt/netdata/bin/netdata -D

shell: stop
	docker run \
		-p 19999:19999 \
		-it \
		-v netdatalib:/var/lib/netdata \
		-v netdatacache:/var/cache/netdata \
		-v /etc/passwd:/host/etc/passwd:ro \
		-v /etc/group:/host/etc/group:ro \
		-v /proc:/host/proc:ro \
		-v /sys:/host/sys:ro \
		-v /etc/os-release:/host/etc/os-release:ro \
		--restart unless-stopped \
		--cap-add SYS_PTRACE \
		--security-opt apparmor=unconfined \
		--name netdata-smol \
		netdata-smol:latest \
		/bin/sh


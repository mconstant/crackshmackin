release:
	docker build --no-cache -t xmconstantx/crackshmackin .
	docker push xmconstantx/crackshmackin

out_like_a_bandit:
	docker run -v "$(shell pwd)"/crackshmackin:/crackshmackin/data -it --rm xmconstantx/crackshmackin

.PHONY: init

init:
	git submodule update --init --recursive
	git submodule foreach 'git restore --staged . 2>/dev/null; git checkout . 2>/dev/null; true'
	git config merge.ours.driver true
	git update-index --assume-unchanged ./btop/btop.conf

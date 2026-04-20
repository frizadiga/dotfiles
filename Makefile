.PHONY: init

init:
	git config merge.ours.driver true
	git update-index --assume-unchanged ./btop/btop.conf

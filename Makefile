.PHONY: lint ci

lint:
	./check-contents-list.sh
	./check-object-names.sh

ci: lint

.PHONY: lint ci

lint:
	./check-contents-list.sh
	./check-object-names.sh
	./check-convention-index.sh

ci: lint

.PHONY: all
all: quality

.PHONY: quality
quality:
	poetry run pre-commit run --all-files

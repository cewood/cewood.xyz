DOCS_FILES = $(shell find content/ -name \*.md -print)


.dockerimage: Dockerfile
	docker \
	  build \
	  -f Dockerfile \
	  -t linter \
	  .
	touch $@

.PHONY: docker-do-%
docker-do-%: .dockerimage
	docker \
	  run \
	  --rm \
	  -it \
	  --name linter \
	  -v ${PWD}:/workdir \
	  -w /workdir \
	  ${DOCKER_RUN_OPTS} \
	  linter:latest \
	  make $* $(if ${ARGS},ARGS=${ARGS})


.PHONY: server
server:
	hugo \
	  server \
	  -D \
	  -w \
	  --bind 0.0.0.0

.PHONY: server-docker
server-docker:
	make docker-do-server DOCKER_RUN_OPTS="-p 1313:1313"


.PHONY: linter-alex
linter-alex:
	alex $(or ${ARGS},${DOCS_FILES})

.PHONY: linter-alex-docker
linter-alex-docker: docker-do-linter-alex


.PHONY: linter-mdspell
linter-mdspell:
	mdspell --en-us --ignore-numbers --ignore-acronyms --report $(or ${ARGS},${DOCS_FILES})

.PHONY: linter-mdspell-docker
linter-mdspell-docker: docker-do-linter-mdspell


.PHONY: linter-proselint
linter-proselint:
	proselint $(or ${ARGS},${DOCS_FILES})

.PHONY: linter-proselint-docker
linter-proselint-docker: docker-do-proselint


.PHONY: linter-retext-mapbox-standard
linter-retext-mapbox-standard:
	retext-mapbox-standard $(or ${ARGS},${DOCS_FILES})

.PHONY: linter-retext-mapbox-standard-docker
linter-retext-mapbox-standard-docker: docker-do-retext-mapbox-standard


.PHONY: linter-write-good
linter-write-good:
	write-good $(or ${ARGS},${DOCS_FILES})

.PHONY: linter-write-good-docker
linter-write-good-docker: docker-do-write-good


.PHONY: lint
lint:
	make linter-alex || true
	make linter-mdspell || true
	make linter-proselint || true
	make linter-retext-mapbox-standard || true
	make linter-write-good || true

.PHONY: lint-docker
lint-docker: docker-do-lint

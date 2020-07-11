FROM alpine:3.8 AS alpine
FROM klakegg/hugo:0.73.0-alpine AS hugo



FROM alpine AS docs-linter

RUN apk add --no-cache \
  make \
  nodejs \
  npm \
  python3

RUN pip3 \
    install \
    --disable-pip-version-check \
    proselint \
  && npm \
    install \
    --global \
    alex \
    markdown-spellcheck \
    retext-mapbox-standard \
    write-good

COPY --from=hugo /usr/lib/hugo/hugo /bin/hugo

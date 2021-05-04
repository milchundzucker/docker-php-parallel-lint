FROM php:alpine as builder

RUN set -xe
RUN apk add --no-cache curl
RUN curl -o parallel-lint.phar -fsSL $(curl -s https://api.github.com/repos/php-parallel-lint/PHP-Parallel-Lint/releases/latest | grep 'browser_' | cut -d'"' -f4 | grep -v ".phar.asc")
RUN chmod +x parallel-lint.phar
RUN mv parallel-lint.phar /usr/local/bin/parallel-lint
RUN parallel-lint --version

FROM php:alpine
LABEL maintainer="jens.kohl@milchundzucker.de"

COPY --from=builder /usr/local/bin/parallel-lint /usr/local/bin/parallel-lint

VOLUME [ "/app" ]
ENTRYPOINT [ "/usr/local/bin/parallel-lint"]
CMD [ "--version" ]

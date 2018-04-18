# Docker Image: milchundzucker/php-parallel-lint
[![Docker Stars](https://img.shields.io/docker/stars/milchundzucker/php-parallel-lint.svg)](https://hub.docker.com/r/milchundzucker/php-parallel-lint/) [![Docker Pulls](https://img.shields.io/docker/pulls/milchundzucker/php-parallel-lint.svg)](https://hub.docker.com/r/milchundzucker/php-parallel-lint/) [![Docker Automated buil](https://img.shields.io/docker/automated/milchundzucker/php-parallel-lint.svg)](https://hub.docker.com/r/milchundzucker/php-parallel-lint/)

This is one of our docker images we use to build our software with GitLab CI (_Jenkins TBA_). We use it in a multi-stage
docker build to copy over the latest `parallel-lint` PHAR into our `milchundzucker/php-essentials` docker images.
Although you can use this image from your command line (but beware it's build with the latest PHP version from
`php:alpine` docker image).

## How to use this image

### Within your Dockerfile

```dockerfile
FROM your-base-image

COPY --from=milchundzucker/php-parallel-lint:latest /usr/local/bin/parallel-lint /usr/local/bin/parallel-lint

# RUN /usr/local/bin/parallel-lint --version
```

### From your command line

To use the linter from your command line, you need to mount your project directory into the container and then run the
linter on the directory inside the container (i.e. `/app`). You should also be aware that the `--exclude` param of the
linter expects the whole path (`/app`-prefix, for example `/app/vendor`).

```
# docker run -it --rm -v $(pwd):/app milchundzucker/php-parallel-lint:latest --version
# docker run -it --rm -v $(pwd):/app milchundzucker/php-parallel-lint:latest --help
# docker run -it --rm -v $(pwd):/app milchundzucker/php-parallel-lint:latest --exclude /app/vendor /app
```

## How to debug the image

In case you want to debug this image you've to overwrite the entrypoint to get an interactive shell.

```
# docker run -it --rm -v $(pwd):/app --entrypoint=sh milchundzucker/php-parallel-lint:latest
/ apk add --update bash && bash
bash-4.3# parallel-lint --version
```
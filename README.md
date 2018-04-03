# OVH docs-dev-env

Easy to deploy developer environment, for writing/testing guides & documentations for docs.ovh.com

## With Docker

### Prerequisite

- [Docker](https://docs.docker.com/install/) installed

### Steps

First, build the docker image
```sh
git clone https://github.com/ovh/docs-developer-env.git
cd docs-developer-env
docker build -t ovh-docs-dev-env .
```

Second, run docker container
```sh
# get the ovh docs repository
git clone https://github.com/ovh/docs.git
cd docs
# run the container and mount volume "pages" (change the port to suit your needs, here XXXXX)
# the port 8080 is the exposed one, so don't change it
docker run --rm -v $(pwd)/pages:/src/docs/pages -d --name ovh-docs-dev-env -p XXXXX:8080 ovh-docs-dev-env
```

__Note__ : the pelican build, started in __debug mode__, takes __1 or 2 minutes__ to complete. 

Check the logs.
```sh
docker logs -f ovh-docs-dev-env
```

When the build is complete, go to http://localhost:XXXXX/fr/ and check your works.

Third, stop the container
```sh
docker stop ovh-docs-dev-env
```
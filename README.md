# OVH Docs : Developer environment 

Easy to deploy developer environment, for writing/testing guides & documentations for docs.ovh.com

## With Docker

### Prerequisite

- [Docker](https://docs.docker.com/install/) installed

### Build script

Show help

```sh
./build.sh -h

> build.sh [-h] [-f folder] [-p port] build and start docs.ovh.com in a docker container
>
> where:
>    -h  show this help
>    -f  set the docs repo path to build (default: current directory)
>    -p  set the exposed docker port (default: 8080)

```

Start the build

```sh
./build.sh -f /path/to/docs
```

Next, go to http:///localhost:8080/fr/

### Steps (Manual)

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

## Without Docker

Use this method only if docker is not an option or for local development

1. First, checkout the following repositories

```shell
git clone https://github.com/ovh/docs-developer-env.git
git clone https://github.com/ovh/docs-rendering.git
```

2. Then, you'll need to prepare and install the dependencies

```shell
cd docs-rendering
python3 -m venv venv3  			# create a virtualenv
. venv3/bin/activate  			# enter the virtualenv
pip install -r requirements.txt	# install dependencies
mkdir output  					# prepare the destination directory
```

**Option 1: full documentation**

```shell
cd .. && git clone https://github.com/ovh/docs.git; cd -
ln -sf ../docs/pages .  		# prepare the source directory
```

**Option 2: local guide edition**

```shell
cp -r ../docs-developer-env/stub/ pages	# copy a minimal set of file to get you started
```

3. Finally, without changing of directory

```shell
../docs-developer-env/src/entrypoint.sh  # start pelican and the web-server
```

and navigate to `http://localhost:8080/`

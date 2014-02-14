# Docker Registry

This Docker image contains a Docker registry you can use to run your own, private repository in your organization. Please see this [blog post][blog-post] for details.

In the default configuration (local), the registry container uses a local directory in the file system for storing images. This directory is configured to use a seperate volume `/docker-registry-storage` which can be mapped by the `docker run -v` parameter -- see `Makefile` target `start-registry`. In order to correctly run parallel work threads, the configuration file `config.yml` contains a `secret_key`. 

In case you like to customize the Docker image, please clone the corresponding [GitHub Repository][github-repo] and follow the instructions below. There is also a Vagrant file included in case you're on a system not directly supported by Docker.


## Customization

This Docker registry image is prepared for customizing the storage backend, the `secret_key`, and the flavor to run:

* In order to change the storage backend, edit the file config template `config.yml.template`. For S3 there are already the necessary keys which only need to be filled. Then run 
  `make -B config.yml registry`
* In case you like to change the secret key, edit the same template as above and replace `@@SEC_KEY@@` with your key of choice. You can keep the file unchanged, then the command above will use *openssl* to create a random key.
* If you choose to run a different flavor, e.g., because you changed the storage backend, you can use overwrite the enviroment variable `FLAVOR` to select the desired flavor. See below.

## Running

By default, the registry can be started in flavor `local` by running
  `make start-registry`
In order to select a different flavor use
  `FLAVOR=<your flavor> make -e start-registry`
To stop the registry, run
  `make stop-registry`
To clean all artifacts including the locally stored images run
  `make clean`

[blog-post]: blog
[github-repo]: https://github.com/lukaspustina/docker-repository


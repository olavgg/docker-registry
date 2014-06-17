# Docker Registry

This Docker image contains a Docker registry you can use to run your own, private repository in your organization.

In the default configuration (local), the registry container uses a local directory in the file system to store images. This directory is configured to use a separate volume `/docker-registry-storage` which can be mapped by the `docker run -v` parameter.

In case you would like to customize the Docker image, please clone the corresponding [GitHub Repository][github-repo].

## Running

Run from Docker Index -- You can also add --rm if you just want to try this image

    docker run --name docker-registry -it -p 5000:5000 \
        -v <absolute path to storage>:/docker-registry-storage olavgg/docker-registry

[github-repo]: https://github.com/olavgg/docker-registry


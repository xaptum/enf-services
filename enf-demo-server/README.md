# enf-demo-server[-noenf]

These are Docker images that run a simple TCP server, for
illustrating the difference between being on the ENF overlay
and listening directly on the Internet.

# Usage

## Building

To build a specific image, run `make build-<image name>`.
To build all available images, run `make build` (or just `make`).

To push the image to Xaptum's public Docker Hub, run `make push-<image name>`.

To save an image as a tarball, run `make save-<image name>`.
To save all available images, run `make save`.

An image can be run locally via `make run-<image name>`.
To access a shell in that container, run `make shell-<image name>`.

To stop the container, run `make stop-<image name>`.

## Connecting to the ENF

Images that connect to the ENF expect the following files to be available
in a volume attached at `/data/enf0`:
- enf0.crt.pem
- enf0.key.pem

## Images

The following Docker images are built:
- `enf-demo-server`
  - Runs a TCP server, via the ENF, that sends static text responses after connection
- `enf-demo-server-noenf`
  - Same as `enf-demo-server`, but doesn't connect to the ENF

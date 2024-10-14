# Jonathan's Development Container

I work in a number of environments. Keeping a stable set of tools across these
environments for a consistent build experience is challenging. I created this
set of containers to manage that and provide all the tools that I regularly use
across systems, platforms, etc.

## Usage

This repo provides 2 scripts: `start-container.sh` and `attach-to-container.sh`.
The start script will stand up the container and mount a bunch of different
directories so that it feels roughly like the system it's starting on in terms
of access, etc. The attach script will call the start script if the container
isn't started and then attach to the running container. NOTE: The attach script
does not halt the container when you exit the container's shell - stopping must
be done manually.

For example, to start the user container, run `./start-container.sh user`. These
scripts also allow passing through arguments to the docker commands - eg:
`./start-container user --workdir /tmp`.

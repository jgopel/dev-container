# Jonathan's Development Container

I work in a number of environments. Keeping a stable set of tools across these
environments for a consistent build experience is challenging. I created this 
container to manage that and provide all the tools that I regularly use across
systems, platforms, etc.

## Running

From the git root:

```
docker run --rm --interactive --tty --entrypoint bash $(docker build -q .)
```
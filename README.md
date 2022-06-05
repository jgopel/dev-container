# Jonathan's Development Container

I work in a number of environments. Keeping a stable set of tools across these
environments for a consistent build experience is challenging. I created this
container to manage that and provide all the tools that I regularly use across
systems, platforms, etc.

## Running

From the git root:

```
docker run --rm --interactive --tty --entrypoint bash --hostname dev-container $(docker build -q .)
```

To mount a local directory the `--volume` command can be used as such:
`--volume path/to/host/dir:path/to/container/dir`. Typically something like
`--volume ~:/home/jonathan/` makes sense.

## Performance

When running the container on a Windows host, it is important to map scratch
directories from inside a WSL instance to get direct access to a native(ish)
Linux filesystem. Windows directories are NTFS format and have different update
requirements, so failure to do this will cause IO issues severe enough to
significantly slow compilation.
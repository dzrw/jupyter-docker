# jupyter notebook

This repository contains the recipe for running a local Jupyter notebook with ContinuumIO's Anaconda for Python 3 distribution pre-loaded.

## Installation

```Bash
$ git clone ....
$ make install
```

## Running the Server

```Bash
$ make

... <snip> ...
[I 02:15:13.477 NotebookApp] Writing notebook server cookie secret to /root/.local/share/jupyter/runtime/notebook_cookie_secret
[W 02:15:13.495 NotebookApp] WARNING: The notebook server is listening on all IP addresses and not using encryption. This is not recommended.
[I 02:15:13.502 NotebookApp] Serving notebooks from local directory: /opt/notebooks
[I 02:15:13.502 NotebookApp] 0 active kernels
[I 02:15:13.502 NotebookApp] The Jupyter Notebook is running at: http://[all ip addresses on your system]:8888/?token=ce53fd5ba0cce853de8dd671f5a126b4545bc532faf0e1d6
[I 02:15:13.502 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 02:15:13.503 NotebookApp]

    Copy/paste this URL into your browser when you connect for the first time,
	    to login with a token:
		        http://localhost:8888/?token=ce53fd5ba0cce853de8dd671f5a126b4545bc532faf0e1d6

... <snip> ...
```

Copy the login URL to your favorite browser.

## Tips

### Fork this repository

If you want to save any of your notebooks in version control, then you should fork this repository.

### Getting your notebooks out of the container

Any notebook that you save will be stored in the `notebooks` directory.

If you've followed the first tip ("fork this repo"), then you should be able to commit your notebooks directly to version control after stopping the server.


## Getting your local data sets in and out of this container

When you run `make`, the `notebooks` directory will be mounted inside the container at `/opt/notebooks`.  Use this path to import and export data to and from the container.  My convention is to create a directory for each notebook containing `inputs` and `outputs` subfolders.  That might work for you.

If you've followed the first tip ("fork this repo"), then you should be able to commit your datasets directly to version control after stopping the server.

### Use other people's notebooks to get started

- [Learn Python 3 with Jupyter](https://gist.github.com/kenjyco/69eeb503125035f21a9d)
- [Pandas](https://dev.socrata.com/blog/2016/02/01/pandas-and-jupyter-notebook.html)
- [More Pandas](https://bitbucket.org/hrojas/learn-pandas)

You get the idea.  Put em in the `notebooks` directory.


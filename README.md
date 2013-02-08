# walrus

Command-line toolset for running a CraftBukkit server

## why?

As a big fan of Minecraft, especially playing multiplayer with my friends, I quickly found it difficult to manage a Craftbukkit server instance on my home server. I turned to Screen, Cron, and Bash scripts.

## project state

The project is in a working state. Everything should work except for overviewer.

## how to use walrus

To use walrus to run your craftbukkit server, download and unarchive the zip file . Since `walrus` is a command-line tool, I'm going to assume you have an intermediate knowledge of the terminal.

### configuration

First, go into the `config` directory and copy `walrus.template.yml` to `walrus.yml`. This is `walrus`'s configuration file. you'll need to set a couple things in this file.

1. set the user that will be running the `walrus` scripts
2. choose whether or not you want `walrus` to auto-update to the newest craftbukkit.jar on each startup.
3. unfortunately the scheduled backups don't work quite yet.
4. set the minimum amount of RAM you want CraftBukkit to use
5. set the maximum amount of RAM you want CraftBukkit to use

### starting up

To start walrus, go to the `src` directory and run `./start.sh`. On first start-up, walrus goes out and downloads the latest CraftBukkit jar so you don't have to. `start.sh` fires off a detached `screen` session and runs the CraftBukkit server inside there. If you'd like to attach to it and give the server commands, run `screen -d -r minecraft`. To detach from the `screen` session, press `ctrl + a` then `d`.

### shutting down

When you're ready to shutdown the CraftBukkit server, run `./close-nicely.sh` which is located in the `src` directory.

## overviewer

I have [minecraft-overviewer](http://github.com/overviewer/Minecraft-Overviewer) in a submodule of this project because it's a really really cool project and I think it should be included with every craftbukkit server!

## help

I'd love to get others involved in making a nice set of command-line tools. Make your own fork of `walrus` and submit your code with a pull-request.

### getting started

To contribute to `walrus`, fork this repository and then:

1. `cp config/walrus.template.yml config/walrus.yml`
2. `git submodule update --init`
3. `cd overviewer/; python setup.py build`

## questions


If you have a question about anything related to `walrus`, or if I've made a mistake somewhere, please feel free to contact me via email or submit an [issue](https://github.com/komidore64/walrus/issues).

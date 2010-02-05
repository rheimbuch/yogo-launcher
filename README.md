Yogo Launcher
==============

This is the base for packaging Yogo as a distributable end-user app.

To get started:

1. `gem install thor bundler`
2. `gem bundle`
3. `rake`

Currently the basic thor tasks are working and you can create a
"complete" yogo install using:

    thor yogo:install:create /path/to/my/yogo-install

Which will create "yogo-install" at the specified path:

    /yogo-install/
        yogo/       # The yogo rails app
        persvr/     # A persevere instance

To run yogo:

    thor yogo:install:start /path/to/my/yogo-install

Now browse to: http://localhost:3000

Other stuff
--------------

### What version of the yogo rails app is being bundled?
If you simply run `rake` or `rake yogo_app`, then the **master branch** will
be checked out from the yogo git repo (http://git@github.com:yogo/yogo.git).

If you want to checkout a specific branch, tag, or commit, instead of running `rake`,
you should run:

    thor yogo:build:complete resource/yogo_app -b your-branch -t package

This will checkout and the 'your-branch' branch of yogo into 
`resource/yogo_app` and make it suitable for packaging with the launcher. The `-t package`
option indicates that we won't be using this checkout for local development, and the 
resulting checkout in `resource/yogo_app` will be a _shallow_ clone of the git repository.
Don't try to do any development in it.

Please note! If you decide to checkout some other branch/tag/commit, be aware that you will
need the patch found in this [commit](http://github.com/yogo/yogo/commit/b22801c503d800a7e44cd55b0d91a338312a697f).
If your version of yogo does not contain this change, it will not run properly.

### Could I use this to checkout the yogo project for development?
Sure. Simply use `-t development`, or omit the `-t` option altogether:

    thor yogo:build:complete path/to/dev/yogo

This will checkout and configure the yogo master branch at the path you specify.
See `thor help yogo:build:complete` for more info on the options you can use, 
and `thor list yogo:build` for the sub-tasks that compose the `yogo:build:complete` 
uber-task.


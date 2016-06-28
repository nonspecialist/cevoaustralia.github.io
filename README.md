# Cevo Website
Jekyll website for cevo.com.au

* The theme used here is http://elbe.blahlab.com/

# How to develop

You need to have:
* a working Ruby environment
* this repository checked out

The site is developed as a set of static resources, and assembled into the resultant website through the use of [Jekyll][f0caf124]

## How to install dependencies

The depenencies of the build have been included in a `Gemfile`, use `bundler` to

```
$ bundle install
```

If you are running in an rbenv you will need to run `rehash` for your commands to be exported to your shell
```
$ rbenv rehash
```

## How to serve the site locally

To run the server with the correct URL's and base paths, you will need to serve the content from

```
$ jekyll serve
```

## How to build the site
```
$ jekyll build
# => The current folder will be generated into ./_site

$ jekyll build --watch
# => The current folder will be generated into ./_site,
#    watched for changes, and regenerated automatically.
```


[f0caf124]: https://jekyllrb.com/ "Jekyll"

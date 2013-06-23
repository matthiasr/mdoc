# man page redirector

This is a special-case link shortener for manual pages. It was written by [Constantine A. Murenin](http://mdoc.su/), this is a slightly extended port to Heroku and Bazooka.

## Why?

Because I need to look up manpages a lot, wanted to practice porting to Heroku and Bazooka (especially classic `configure && make && make install` apps) and why not?

## What next?

* do not require section numbers for OS X
** or at least give some error message
* figure out a way around nginx' case-insensitive matching on OS X

## Deploying

### Heroku

    heroku create $name --buildpack https://github.com/ddollar/heroku-buildpack-multi
    heroku config:set CANONICAL_NAME=$name.heroku.com
    git push heroku master

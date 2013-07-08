# man page redirector

This is a special-case link shortener for manual pages. It was written by [Constantine A. Murenin](http://mdoc.su/), this is a slightly extended port to [Heroku](https://www.heroku.com/) and [Bazooka](http://gotocon.com/dl/goto-zurich-2013/slides/AlexanderSimmerl_and_MattProud_BuildingAnInHouseHeroku.pdf). It is running [on Heroku](http://mdoc.herokuapp.com/).

## Why?

Because I need to look up manpages a lot, wanted to practice porting to Heroku and Bazooka (especially classic `configure && make && make install` apps) and why not?

## What next?

* do not require section numbers for OS X
** or at least give some error message
* figure out a way around nginx' case-insensitive matching on OS X

## Deploying

### Heroku

    heroku create $name --buildpack https://github.com/ddollar/heroku-buildpack-multi
    heroku config:set CANONICAL_NAME=$name.herokuapp.com
    git push heroku master

### Bazooka

For a general description of Bazooka, see [here](http://gotocon.com/dl/goto-zurich-2013/slides/AlexanderSimmerl_and_MattProud_BuildingAnInHouseHeroku.pdf). Set `CANONICAL_NAME` to the `host:port` of your load balancer or proxy.

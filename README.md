PageSpeed
======

Description
-----------

PageSpeed is a simple gem which ports Google Page Speed's scores to your
command line.

[![Build Status](https://secure.travis-ci.org/albertbellonch/page_speed.png)](http://travis-ci.org/albertbellonch/page_speed)

Installation
------------

Simply install the gem:

    gem install page_speed

Usage
-----

You have to get your API key first through [here](http://code.google.com/intl/en-EN/apis/pagespeedonline/v1/getting_started.html), then set it to the gem:

    page_speed -k YOUR_KEY

After that, just execute page_speed against any website you can imagine:

    page_speed URL

Example
-------

If we test it against itnig.net:

    > page_speed itnig.net

    Google Page Speed for itnig.net: 94 (Desktop) / 88 (Mobile)

If we test it against a non-valid URL:

    > page_speed cucamonga

    There has been an error. Please check your URL.

Documentation
-------------

* [Google Page Speed](http://pagespeed.googlelabs.com)
* [Google Page Speed API](http://code.google.com/intl/en-EN/apis/pagespeedonline/)

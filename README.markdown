# Artigo


## What is Artigo?
Artigo (Portuguese for Article) is a blog engine written in [Ruby](http://ruby-lang.org) running on the [Rails](http://rubyonrails.org) web platform.


To read more about setting up and configuring Artigo please read the [wiki](wiki)


## Installation
It's recommended that you install Artigo by cloning it in mercurial.

    $ git clone http://github.com/codeimpossible/Artigo.git


Once you have this on your local machine just run the first time config and the unit tests to ensure everything is setup correctly.

    $ bundle install
 
    # ... bundler will now go and download all the gems needed

    $ rake artigo:first_time

    # ... snip you'll see some database migration stuff here

    $ rake test

    # ... everything should pass, now you're ready to configure your install of Artigo

## Configuration
Artigo configuration is stored in two files within the /config directory: database.yml and artigo.yml. All the database settings are stored in the, you guessed it, database.yml and any blog specific settings are stored in the artigo.yml.
#!/bin/bash
echo -e "*** Bootstrapping TravisCI ***"
bundle install
bundle exec rake artigo:travis

echo -e "*** Running Tests ***"
bundle exec rake test
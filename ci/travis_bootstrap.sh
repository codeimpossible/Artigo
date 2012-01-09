#!/bin/bash
echo -e "*** Bootstrapping TravisCI ***"
bundle exec rake artigo:travis

echo -e "*** Running Tests ***"
bundle exec rake test
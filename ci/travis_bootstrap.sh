#!/bin/bash

if [ "$DB" = "mysql" ]; then
  echo -e "*** Bootstrapping TravisCI MYSQL ***"
  mysql -e 'create database artigo_test;'
fi

if [ "$DB" = "postgres" ]; then
  echo -e "*** Bootstrapping TravisCI POSTGRESQL ***"
  psql -c 'create database artigo_test;' -U postgres
fi

echo -e "*** Bootstrapping TravisCI ***"
bundle exec rake artigo:travis

echo -e "*** Running Tests ***"
bundle exec rake test

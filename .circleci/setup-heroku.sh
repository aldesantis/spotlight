#!/bin/bash
git remote add heroku-staging git@heroku.com:b911-spotlight-staging.git
git remote add heroku-production git@heroku.com:b911-spotlight-prod.git

cat >> ~/.ssh/config << EOF
  VerifyHostKeyDNS yes
  StrictHostKeyChecking no
EOF

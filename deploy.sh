#!/bin/bash

hugo
cd public
aws s3 sync --acl public-read . s3://thewellarchitectedguideto.com/
aws cloudfront create-invalidation --distribution-id E3NI5N6G31OPR5 --paths "/*"
cd ../

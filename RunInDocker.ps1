#JEKYLL_ENV=development make it crash,
set-location $PSScriptRoot
docker run --volume="$PWD":/srv/jekyll  `
-it -p 127.0.0.1:5000:5000 -e JEKYLL_ENV=docker jekyll/jekyll:latest `
jekyll s --port 5000 --config _config.yml,_config.dev.yml --force_polling --incremental --trace
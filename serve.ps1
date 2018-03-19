#JEKYLL_ENV=development make it crash,
set-location $PSScriptRoot -Verbose
write-verbose (get-variable pwd | Ft -AutoSize -wrap | out-string)
docker run --volume="$PWD":/srv/jekyll  `
-it -p 127.0.0.1:4000:4000 -e JEKYLL_ENV=production jekyll/jekyll:latest `
jekyll s --port 4000 --config _config.yml,_config.dev.yml --force_polling --incremental --trace
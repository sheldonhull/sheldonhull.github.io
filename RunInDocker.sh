#!/bin/bash
docker run --rm --volume=$(pwd):/srv/jekyll -it -p 4000:4000 jekyll/jekyll jekyll s --config _config.yml,_config.dev.yml
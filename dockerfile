FROM jekyll/jekyll:latest

RUN apk add --update imagemagick
ADD Gemfile .
RUN bundle install

#ENTRYPOINT [ "bundle", "exec", "jekyll" ]

CMD [ "--help" ]

ENV JEKYLL_ENV docker

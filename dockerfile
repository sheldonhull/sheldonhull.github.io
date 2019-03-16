FROM jekyll/builder:latest

# Adds a C compiler and make, and the headers for ruby
RUN apk --update add alpine-sdk ruby-dev

# Add extra: jekyll-responsive_images, which requires imagemagick-dev
RUN apk --update add imagemagick
#RUN gem install --no-document --verbose 'jekyll-picture-tag' , git: 'https://github.com/robwierzbowski/jekyll-picture-tag/'
# gem 'jekyll-picture-tag' #, git: 'https://github.com/robwierzbowski/jekyll-picture-tag/'

ADD Gemfile .
RUN gem install bundler && bundle install --system
#RUN bundle install --system
ENTRYPOINT [ "bundle", "exec", "jekyll" ]
CMD [ "--help" ]
ENV JEKYLL_ENV docker

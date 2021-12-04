FROM ruby:2.7.2-alpine3.13

# Env vars
ENV GEM_HOME=/gems \
    RAILS_ENV=production

# Add user
RUN addgroup -g 3554 -S rails \
 && adduser -u 3554 -S -G rails rails

# Create code and gems directory
RUN mkdir /code /gems \
 && chown rails:rails /code /gems
WORKDIR /code

# Dependencies
RUN apk add --no-cache --update \
    dumb-init \
    build-base \
    tzdata \
    postgresql-dev

# Install gems
ADD Gemfile* .ruby-version /code/
RUN chown -R rails:rails /code
USER rails
RUN gem install bundler && bundle install

# Add code
USER root
ADD . /code/
RUN chown -R rails:rails /code
USER rails

# Stop with SIGINT
STOPSIGNAL int

# Entry point
# Note: Use dumb-init in order to fulfil our PID 1 responsibilities,
# see https://github.com/Yelp/dumb-init
ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD ["/bin/sh", "docker-start.sh"]

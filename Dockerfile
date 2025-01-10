### Build Image ###

FROM ruby:3.1.6-alpine3.19 AS builder
ENV GEM_HOME=/gems RAILS_ENV=production

# Build dependencies
RUN apk add --no-cache --update \
    build-base \
    tzdata \
    postgresql-dev

# Install gems
ADD Gemfile* .ruby-version /code/
RUN cd /code && gem install bundler && bundle install


### Runtime Image ###

FROM ruby:3.1.6-alpine3.19
ENV GEM_HOME=/gems RAILS_ENV=production

# Add user
RUN addgroup -g 3554 -S rails \
 && adduser -u 3554 -S -G rails rails

# Create code and gems directory
RUN mkdir /code /gems \
 && chown rails:rails /code /gems
WORKDIR /code

# Runtime dependencies
RUN apk add --no-cache --update \
    dumb-init \
    tzdata \
    libpq

# Copy gems from build container
COPY --from=builder /gems/ /gems/
RUN chown -R rails:rails /gems

# Add code
ADD . /code/
RUN chown -R rails:rails /code
USER rails

# Precompiling assets for production without requiring secret key
RUN SECRET_KEY_BASE=dummy bin/rails assets:precompile

# Stop with SIGINT
STOPSIGNAL int

# Entry point
# Note: Use dumb-init in order to fulfil our PID 1 responsibilities,
# see https://github.com/Yelp/dumb-init
ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD ["/bin/sh", "docker-start.sh"]

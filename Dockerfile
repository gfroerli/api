FROM ruby:2.5.0
MAINTAINER Danilo Bargen <mail@dbrgn.ch>

# Env vars
ENV GEM_HOME=/gems \
    RAILS_ENV=production

# Dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
        apt-get install -y --install-recommends netcat

# Add users
RUN useradd -m -U rails

# Create code and gems directory
RUN mkdir /code /gems \
    && chown rails:rails /code /gems
WORKDIR /code

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

# Entry point
CMD ["/bin/bash", "docker-start.sh"]

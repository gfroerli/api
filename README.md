# Coredump Water Sensor API

This project provides an API for querying sensor data of our
photon water sensors located in the particle cloud.

## Requirements

* Ruby 2.3
* Rails 5

## Setup

(Note: If you don't want to manually set up the entire dev environment, skip
down to the Docker section!)

Install [rbenv](https://github.com/rbenv/rbenv) and
[ruby-build](https://github.com/rbenv/ruby-build). On ArchLinux you can install
them from the AUR:

 * https://aur.archlinux.org/packages/rbenv/
 * https://aur.archlinux.org/packages/ruby-build/

To activate rbenv you need to add

    eval "$(rbenv init -)"

To your shell init file (`.bashrc`/`.zshrc`).

Prepare the ruby environment

    git clone git@github.com:coredump-ch/water-sensor-api.git
    rbenv install
    gem install bundler

### Prepare the database

#### ArchLinux

    pacman -S postgresql
    sudo su - postgres -c "initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data'"
    createuser -U postgres --createdb $USERNAME

### Run the setup script

    bin/setup

## Dev Server

    bin/rails server

## Quality

    bin/check

## Tasks

You can query the particle cloud and update the APIs sensor data by running
the following task

    rake particle:update

## API Endpoints

Base path is `/api/`.

- `/sensors` (full CRUD)
- `/measurements` (full CRUD)
- `/sponsors` (full CRUD)

## Docker

You can run the entire setup with docker compose:

    docker-compose build
    docker-compose up -d

Now the server is running on `http://localhost:3000/`.

If you're using *docker-machine* the server is running inside your virtual
machine which has a different IP:

    docker-machine ip default


# Coredump Water Sensor API

This project provides an API for querying sensor data of our LoRaWAN based
water temperature sensors.  Checkout https://gfrör.li for an application using
the API

## Requirements

* Ruby 2.5
* Rails 5

## Installation

    bin/setup

## Run

    bin/run

## Tests

    bin/check

## API Endpoints

Base path is `/api/`.

- `/sensors` (full CRUD)
- `/measurements` (full CRUD)
- `/sponsors` (full CRUD)

### Authentication

The API uses token based authentication. A sample request looks like this:

    curl 'http://localhost:3000/api/measurements' -H "Authorization: Bearer 0123456789ABCDEF" -v

## Docker

You can run the entire setup with docker compose:

    docker-compose build
    docker-compose up -d

Now the server is running on `http://localhost:3000/`.

If you're using *docker-machine* the server is running inside your virtual
machine which has a different IP:

    docker-machine ip default

## ArchLinux

(Note: If you don't want to manually set up the entire dev environment, use the
Docker instructions above!)

Install [rbenv](https://github.com/rbenv/rbenv) and
[ruby-build](https://github.com/rbenv/ruby-build). On ArchLinux you can install
them from the AUR:

 * https://aur.archlinux.org/packages/rbenv/
 * https://aur.archlinux.org/packages/ruby-build/

To activate rbenv you need to add

    eval "$(rbenv init -)"

To your shell init file (`.bashrc`/`.zshrc`).

### Prepare the ruby environment

    git clone git@github.com:gfroerli/gfroerli-api.git
    cd gfroerli-api
    rbenv install
    gem install bundler

### Prepare the database

    pacman -S postgresql
    sudo su - postgres -c "initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data'"
    createuser -U postgres --createdb $USERNAME


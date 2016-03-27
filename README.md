# Coredump Water Sensor API

This project provides an API for querying sensor data of our
photon water sensors located in the particle cloud.

## Requirements

* Ruby 2.3
* Rails 5

## Setup

Prepare the ruby environment

    git clone git@github.com:coredump-ch/water-sensor-api.git
    rbenv install
    gem install bundler

Run the setup script

    bin/setup

## Dev Server

    bin/rails server

## Tests

    bin/rails test

## Tasks

You can query the particle cloud and update the APIs sensor data by running
the following task

    rake particle:update


# Coredump Water Sensor API

This project provides an API for querying sensor data of our LoRaWAN based
water temperature sensors. Check out https://gfrör.li for an application using
the API.

## API Endpoints

### Authentication

The API uses token based authentication. A sample request looks like this:

    curl 'http://localhost:3000/api/measurements' -H "Authorization: Bearer 0123456789ABCDEF" -v

All "index" and "show" resources are accessible with a public API key, while
writing to the API is permitted only for consumers who provide a private API key.

### CRUD Endpoints

The following endpoints are RESTful and allow full CRUD operations.

- `/api/sensors`
- `/api/measurements`
- `/api/sponsors`

You can post a measurement to the api the following way (use the private api key of ApiConsumer):

    curl -X POST 'http://localhost:3000/api/measurements' \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer 0123456789ABCDEF" \
        -d '{"sensor_id": 1, "temperature": 20.7, "custom_attributes": {"foo": "bar"}}'

### Application Endpoints

The following endpoints are optimized for mobile applications and return
read-only aggregated data.

**Sensors**

Endpoint: `/api/mobile_app/sensors`

JSON array element fields:

| Field | Type | Description |
| --- | --- | --- |
| id | int | Sensor ID |
| device_name | string | Sensor name |
| caption | string | Caption describing the sensor |
| created_at | uint | Unix timestamp (seconds) |
| sponsor_id | uint? | Associated sponsor ID |
| latitude | number | Latitude (WGS84) |
| longitude | number | Longitude (WGS84) |
| latest_temperature | number? | Latest temperature measurement |
| latest_measurement_at | number? | Unix timestamp (seconds) |

**Sensor Details**

Endpoint: `/api/mobile_app/sensors/<sensor-id>`

JSON fields:

| Field | Type | Description |
| --- | --- | --- |
| id | int | Sensor ID |
| device_name | string | Sensor name |
| caption | string | Caption describing the sensor |
| created_at | uint | Unix timestamp (seconds) |
| sponsor_id | uint? | Associated sponsor ID |
| latitude | number | Latitude (WGS84) |
| longitude | number | Longitude (WGS84) |
| latest_temperature | number? | Latest temperature measurement |
| latest_measurement_at | number? | Unix timestamp (seconds) |
| average_temperature | number? | Average temperature (all-time) |
| minimum_temperature | number? | Lowest temperature (all-time) |
| maximum_temperature | number? | Highest temperature (all-time) |

**Sponsor**

Endpoint: `/api/mobile_app/sensors/<sensor-id>/sponsor`

JSON fields:

| Field | Type | Description |
| --- | --- | --- |
| id | int | Sponsor ID |
| name | string | Sponsor name |
| description | string? | Sponsor description |
| logo_url | string? | Logo URL (PNG) |

**Sensor Daily Temperatures**

Endpoint: `/api/mobile_app/sensors/<sensor-id>/daily_temperatures`

JSON array element fields:

| Field | Type | Description |
| --- | --- | --- |
| aggregation_date | string | ISO date (e.g. "2021-02-25") |
| minimum_temperature | number | Lowest daily temperature |
| maximum_temperature | number | Highest daily temperature |
| average_temperature | number | Average daily temperature (arithmetic mean) |

Query parameters:

| Param | Description | Default |
| --- | --- | --- |
| from | Start date in ISO format (e.g. "2021-02-25") | 1989-04-07 |
| to | End date in ISO format (e.g. "2021-02-25") | now |
| limit | Max number of elements returned | 10 |

**Sensor Hourly Temperatures**

Endpoint: `/api/mobile_app/sensors/<sensor-id>/hourly_temperatures`

JSON array element fields:

| Field | Type | Description |
| --- | --- | --- |
| aggregation_date | string | ISO date (e.g. "2021-02-25") |
| aggregation_hour | int | Hour of day (0-23) |
| minimum_temperature | number | Lowest daily temperature |
| maximum_temperature | number | Highest daily temperature |
| average_temperature | number | Average daily temperature (arithmetic mean) |

Query parameters:

| Param | Description | Default |
| --- | --- | --- |
| from | Start date in ISO format (e.g. "2021-02-25") | 1989-04-07 |
| to | End date in ISO format (e.g. "2021-02-25") | now |
| limit | Max number of elements returned | 10 |

## Development

### Requirements

* Ruby 3.3
* Rails 7.2

### Installation

    bin/setup

### Run

    bin/run

### Tests

    bin/check

### API Consumers

To create an API consumer, run the following query on the database:

    INSERT INTO api_consumers(public_api_key, private_api_key, caption, contact_email, created_at, updated_at)
    VALUES('PUBLIC', 'PRIVATE', 'Test API Consumer', 'consumer@example.com', NOW(), NOW());

### Docker

You can run the entire setup with docker compose:

    docker-compose build
    docker-compose up -d

Now the server is running on `http://localhost:3000/`.

If you're using *docker-machine* the server is running inside your virtual
machine which has a different IP:

    docker-machine ip default

To connect to the PostgreSQL database:

    docker-compose exec db psql -U api watertemp_api

### ArchLinux

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

#### Prepare the ruby environment

    git clone git@github.com:gfroerli/gfroerli-api.git
    cd gfroerli-api
    rbenv install
    gem install bundler

#### Prepare the database

    pacman -S postgresql
    sudo su - postgres -c "initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data'"
    createuser -U postgres --createdb $USERNAME

## License

    Copyright (C) 2016-2024 Gfrörli Developers
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.
    
    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

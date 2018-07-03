# API Endpoints


## Sponsors

Resource: `/sponsors/`


### GET

Return a sponsor or a list of sponsors.

**Auth**

Public token.

**Fields**

| Field       | Type      | Null |
| ----------- | --------- | ---- |
| id          | integer   | n    |
| url         | string    | n    |
| name        | string    | n    |
| description | string    | y    |
| active      | integer   | n    |
| created_at  | string    | n    |
| updated_at  | string    | n    |
| sensor_ids  | integer[] | n    |

**Examples**

List:

    $ http GET :3000/api/sponsors/ Authorization:'Bearer public'

Detail:

    $ http GET :3000/api/sponsors/3/ Authorization:'Bearer public'


### POST

Create a new sponsor.

**Auth**

Private token.

**Fields**

| Field       | Type    | Null | Optional |
| ----------- | ------- | ---- | -------- |
| name        | string  | n    | n        |
| description | string  | y    | y        |
| active      | integer | n    | y (true) |

**Examples**

Minimal:

    $ http POST :3000/api/sponsors/ Authorization:'Bearer private' \
        name='Stadt Rapperswil'

Complete:

    $ http POST :3000/api/sponsors/ Authorization:'Bearer private' \
        name='Stadt Rapperswil' description='Die charmante Stadt am Zürichsee' \
        active=true


### DELETE

Delete a sponsor.

**Auth**

Private token.

**Examples**

    $ http DELETE :3000/api/sponsors/3/ Authorization:'Bearer private'


## Sponsor Images

Resource: `/sponsor_images/`


### GET

Return a sponsor image. (Listing all sponsor images is not supported.)


### POST

Create a new sponsor image.

**Auth**

Private token.

**Fields**

| Field         | Type    | Null | Optional |
| ------------- | ------- | ---- | -------- |
| sponsor_id    | integer | n    | n        |
| content_type  | string  | n    | n        |
| file_contents | binary  | n    | n        |

**Examples**

Minimal:

    $ http POST :3000/api/sponsors/ Authorization:'Bearer private' \
        name='Stadt Rapperswil'

Complete:

    $ http POST :3000/api/sponsors/ Authorization:'Bearer private' \
        name='Stadt Rapperswil' description='Die charmante Stadt am Zürichsee' \
        active=true


## Sensors

Resource: `/sensors/`


### POST

Create a new sensor.

**Auth**

Private token.

**Fields**

| Field       | Type    | Null | Optional |
| ----------- | ------- | ---- | -------- |
| device_name | string  | n    | n        |
| caption     | string  | n    | y ("")   |
| sponsor_id  | integer | y    | y        |
| latitude    | float   | y    | y        |
| longitude   | float   | y    | y        |

Example request (minimal):

    $ http POST :3000/api/sensors/ Authorization:'Bearer private' \
        device_name='Sensor 3'

Example request (complete):

    $ http POST :3000/api/sensors/ Authorization:'Bearer private' \
        device_name='Sensor 3' caption='A great sensor' \
        sponsor_id=4 latitude=47.222207 longitude=8.815783


### DELETE

Delete a sensor.

**Auth**

Private token.

**Examples**

    $ http DELETE :3000/api/sensors/3/ Authorization:'Bearer private'

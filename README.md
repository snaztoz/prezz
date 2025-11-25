# Prezz

Prezz is an online employee attendance system. It's a monolithic app implemented using Ruby on Rails framework.

## Features

* Multi-tenancy capabilities.
* Group-based user management; work shifts are assigned to groups.
* Timezone-aware shifts.
* Bulk user import (via CSV).
* Attendance with location & picture upload. **TODO**
* Attendance corrections via group leader approval. **TODO**
* Attendance reportings. **TODO**

### Nerdy Features

* Implemented in monolithic Rails.
* Ease of development & deployment due to Solid stacks (Solid Queue, Solid Cache and Solid Cable). No external dependencies are needed (other than the database).
* Extensive test suites (currently containing 100+ test cases).

## Required Ruby Version

ruby-3.4.2

## System Dependencies

* A database engine compatible with Rails. The current configured default is SQLite.

## Configuration

## Database Creation

## Database Initialization

## Run Tests

Run:

```
bin/rails t
```

## Services

### Job Queue

## Deployment

## Licensing & Commercial Use

This project is licensed under the AGPL-3.0 License for open-source and non-commercial use.

If you would like to use this software in a commercial or private/closed-source setting, please contact me at hafidhmn@gmail.com to obtain a commercial license.

## Author

Developed by [Hafidh Muqsithanova S](https://hafidhmn.com/)

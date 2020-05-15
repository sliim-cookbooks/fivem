fivem Cookbook
================

Configure FiveM server.

[![Cookbook Version](https://img.shields.io/cookbook/v/fivem.svg)](https://supermarket.chef.io/cookbooks/fivem) [![Build Status](https://travis-ci.org/sliim-cookbooks/fivem.svg?branch=master)](https://travis-ci.org/sliim-cookbooks/fivem) 

Requirements
------------

#### Cookbooks
- [git](https://supermarket.chef.io/cookbooks/git)
- [mariadb](https://supermarket.chef.io/cookbooks/mariadb)

#### Platforms
The following platforms and versions are tested and supported using Opscode's test-kitchen.
- `Debian 10`

Attributes
----------
#### fivem::default

General FiveM server setup

| Key                  | Type   | Description                                            |
| -----------          | ----   | -----------------------------------------              |
| `[fivem][prefix]`    | String | Prefix install directory (default: `/opt`)             |
| `[fivem][version]`   | String | FiveM version/build to install (default: `2431-[...]`) |
| `[fivem][endpoints]` | Hash   | Server endpoints                                       |
| `[fivem][resources]` | Array  | Resources to start                                     |
| `[fivem][config]`    | Hash   | Server configuration                                   |

| Key                                | Type   | Description                                                                      |
| ---------------------------------- | ------ | -------------------------------------------------------------------------------- |
| `[fivem][server_data][repository]` | String | Server data repository (default: `https://github.com/citizenfx/cfx-server-data`) |
| `[fivem][server_data][reference]`  | String | Server data reference (default: `master`)                                        |

#### fivem::mariadb

Mariadb server & client configuration

| Key                                  | Type   | Description                                        |
| ------------------------------------ | ------ | -------------------------------------------------- |
| `[fivem][mariadb][version]`          | String | MariaDB version (default: `10.3`)                  |
| `[fivem][mariadb][server][host]`     | String | MariaDB server bind address (default: `127.0.0.1`) |
| `[fivem][mariadb][server][port]`     | String | MariaDB server bind port (default: `3306`)         |
| `[fivem][mariadb][server][password]` | String | MariaDB server root password (default: `mypass`)   |

#### fivem::mysql_async
| Key                                | Type   | Description                                                                        |
| ---------------------------------- | ------ | ---------------------------------------------------------------------------------- |
| `[fivem][mysql_async][repository]` | String | mysql_async repository (default: `https://github.com/brouznouf/fivem-mysql-async`) |
| `[fivem][mysql_async][reference]`  | String | mysql_async reference (default: `v2.1.1`)                                          |

#### fivem::vrp
| Key                        | Type   | Description                                                     |
| -------------------------- | ------ | --------------------------------------------------------------- |
| `[fivem][vrp][repository]` | String | vRP repository (default: `https://github.com/ImagicTheCat/vRP`) |
| `[fivem][vrp][reference]`  | String | vRP reference (default: `master`)                               |

#### fivem::vrp_basic_mission
| Key                           | Type   | Description                                                                   |
| ----------------------------- | ------ | ----------------------------------------------------------------------------- |
| `[fivem][vrp_bm][repository]` | String | vRP repository (default: `https://github.com/ImagicTheCat/vRP-basic-mission`) |
| `[fivem][vrp_bm][reference]`  | String | vRP reference (default: `master`)                                             |

Usage
-----
#### fivem::default
Include `fivem` in your node's `run_list` to setup a FiveM server:
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[fivem]"
  ]
}
```

#### fivem::mariadb_server
Include `fivem::mariadb_server` in your node's `run_list` to install a MariaDB server:
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[fivem::mariadb_server]"
  ]
}
```

#### fivem::mysql_async
Include `fivem::mysql_async` in your node's `run_list` to install mysql_async resource:
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[fivem::mysql_async]"
  ]
}
```

#### fivem::es
Include `fivem::es` in your node's `run_list` to install essentialmode resources:
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[fivem::es]"
  ]
}
```

#### fivem::vrp
Include `fivem::vrp` in your node's `run_list` to install vRP resources:
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[fivem::vrp]"
  ]
}
```

#### fivem::vrp_basic_mission
Include `fivem::vrp_basic_mission` in your node's `run_list` to install vRP basic_mission resource:
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[fivem::vrp_basic_mission]"
  ]
}
```

Testing
-------
See [TESTING.md](TESTING.md)

Contributing
------------
See [CONTRIBUTING.md](CONTRIBUTING.md)

License and Authors
-------------------
Authors: Sliim <sliim@mailoo.org> 

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

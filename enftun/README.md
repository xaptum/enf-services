# enftun

This image runs the [enftun](https://github.com/xaptum/enftun)
service for connecting to the Xaptum ENF.
It can be used as a base image to build services that require
access to the ENF.

## Usage

Follow the instructions in the [enf-services
README](https://github.com/xaptum/enf-services) to configure the
Docker host and create credentials for this container.

### In Dockerfile

To use this as a base image, add to your Dockerfile:
```
FROM xaptum:enftun
```

### Test Shell

To run this image in a local container:
- Create a subdirectory named `enf0`
    ```
    mkdir enf0
    ```
- Provision the credentials using the following command by or by
following the instructions in [enf-services
README](https://github.com/xaptum/enf-services)
    ```
    make keys user=<USERNAME> address=<ADDRESS>
    ```

- run:
    ```
    make shell
    ```

This will run the container and start the `bash` shell.

## License

Copyright 2020 Xaptum, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not
use this work except in compliance with the License. You may obtain a copy of
the License from the LICENSE.txt file or at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
License for the specific language governing permissions and limitations under
the License.

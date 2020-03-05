### Usage

Bring the logging system up with `docker-compose -f docker-compose.yml up` from the project root. This will start 3 containers:

- `mongo`: MongoDB instance (Graylog metadata)
- `elasticsearch`: Elasticsearch node (Graylog primary storage)
- `graylog`: Graylog server

To connect to the `graylog` Docker network from another compose project, just add a reference to it (Docker prefixes network names with their root project directory):

```yml
networks:
  DIRT2_Logging_graylog:
    driver: bridge
```

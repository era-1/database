FROM postgis/postgis

ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_USER=postgres
ENV POSTGRES_DB=postgres

COPY docker-entrypoint-initdb.d/* /docker-entrypoint-initdb.d/

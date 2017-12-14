FROM postgres
ADD init.sql /docker-entrypoint-initdb.d/
ADD tinyData.sql /docker-entrypoint-initdb.d/
EXPOSE 5432

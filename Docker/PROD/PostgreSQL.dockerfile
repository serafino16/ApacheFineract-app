
FROM postgres:latest


ENV POSTGRES_USER=produser
ENV POSTGRES_PASSWORD=prodpassword
ENV POSTGRES_DB=proddb


EXPOSE 5432


CMD ["postgres"]

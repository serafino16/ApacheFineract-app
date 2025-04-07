


FROM postgres:latest


ENV POSTGRES_USER=devuser
ENV POSTGRES_PASSWORD=devpassword
ENV POSTGRES_DB=devdb


EXPOSE 5432


CMD ["postgres", "-c", "log_statement=all", "-c", "log_duration=on"]

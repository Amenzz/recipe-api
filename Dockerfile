FROM python:3.9-alpine3.13
LABEL maintainer="myrecipeapi.com"
ENV PYTHONBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
Copy ./requirements.dev.txt /tmp/requirements.dev.txt 
#  copys requirement file to the docker image
COPY ./app /app
#  
WORKDIR /app
#  the working directory where all the commands will be run
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true"];\
    then /py/bin/pip install -r /tmp/requirements.dev.txt ;\
    fi && \
    rm -rf /tmp && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user
# this runs a command on the alpine image that we are using
ENV PATH="/py/bin:$PATH"
USER django-user

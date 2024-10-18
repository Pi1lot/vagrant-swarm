# Use an official Python runtime as a parent image
FROM python:3.8

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

ENTRYPOINT django-model-master/modele/manage.py runserver 0.0.0.0:8000
# Set the working directory
# Install dependencies
COPY django-model-master.zip /app/

RUN apt update && apt install unzip
RUN unzip django-model-master.zip
RUN pip install django
RUN django-model-master/modele/manage.py makemigrations
RUN django-model-master/modele/manage.py migrate

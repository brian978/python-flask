# Base image
FROM python:3.6.4-slim-stretch

# installing virtualenv
RUN pip install virtualenv

# Creating the app folder
RUN mkdir -p /var/app_docker_env

# Creating the virtualenv that will allow the docker container to run
RUN cd /var/app_docker_env && virtualenv venv
RUN apt-get update && apt-get install -y build-essential && /var/app_docker_env/venv/bin/pip install uwsgi
RUN /var/app_docker_env/venv/bin/pip install flask

# Creating privileges
RUN useradd www-py
RUN usermod www-py -d /var/app_docker_env
RUN chown www-py:www-py /var/app_docker_env -R

# Expose process
CMD ["python3"]
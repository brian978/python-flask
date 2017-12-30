# Base image
FROM python:3.6.4-slim-stretch

# installing virtualenv
RUN pip install virtualenv

# Creating the app folder
RUN mkdir -p /var/app_default

# Demo Application Files 
COPY app/app.py /var/app_default/app.py

# Creating the virtualenv
RUN cd /var/app_default && virtualenv venv
RUN apt-get update && apt-get install -y build-essential && /var/app_default/venv/bin/pip install uwsgi
RUN /var/app_default/venv/bin/pip install flask

# Creating privileges
RUN useradd www-py
RUN usermod www-py -d /var/app_default
RUN chown www-py:www-py /var/app_default -R

# Expose process
CMD ["python3"]
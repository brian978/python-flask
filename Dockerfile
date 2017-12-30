# Base image
FROM python:3.6.4-slim-stretch

# installing virtualenv
RUN pip install virtualenv

# Creating the app folder
RUN mkdir -p /var/app

# Demo Application Files 
COPY app/app.py /var/app/app.py

# Creating the virtualenv
RUN cd /var/app && virtualenv venv
RUN apt-get update && apt-get install -y build-essential && /var/app/venv/bin/pip install uwsgi
RUN /var/app/venv/bin/pip install flask

# Creating privileges
RUN useradd www-py
RUN usermod www-py -d /var/app
RUN chown www-py:www-py /var/app -R

# Expose process
CMD ["python3"]
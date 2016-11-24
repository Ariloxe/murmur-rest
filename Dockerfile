FROM ubuntu:14.04

EXPOSE 5000

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y build-essential mumble-server supervisor

# Build Python app
RUN apt-get install -y python python-pip python-zeroc-ice
ADD requirements.txt /opt/requirements.txt
RUN cd /opt && pip install -r requirements.txt

# Add config files.
ADD ./etc/mumble-server.ini /etc/mumble-server.ini
ADD ./etc/supervisord.conf /etc/supervisord.conf

# Add app.
ADD . /opt

WORKDIR /opt
RUN mv settings.py.example settings.py

CMD ["/usr/bin/supervisord"]

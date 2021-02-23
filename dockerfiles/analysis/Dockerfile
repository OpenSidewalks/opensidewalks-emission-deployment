# python 3
FROM emission/e-mission-server.dev.server-only:2.9.1

# Reimplementation of clone_server.sh
WORKDIR /usr/src/app

RUN git clone $SERVER_REPO
WORKDIR /usr/src/app/e-mission-server
# Get a specific commit so that versioning is pinned. 
# This one is from the "ceo_ebike_project" branch, the one used in the
# e-mission-docker repo for whatever reason.
# RUN git fetch origin $SERVER_BRANCH
# RUN git checkout -f $SERVER_BRANCH
RUN git fetch origin ceo_ebike_project
RUN git checkout -f 9d1f098

# Replaces miniconda-based workflow full of nonfunctional `source` commands
# TODO: use a requirements.txt file
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install arrow==0.13.1 \
    attrdict==2.0.1 \
    cheroot==8.4.2 \
    future==0.18.0 \
    geojson==2.4.1 \
    google-auth==1.20.1 \
    jsonpickle==1.4.1 \
    numpy==1.19.1 \
    pandas==1.1.0 \
    pip==20.2.2 \
    python-dateutil==2.8.1 \
    pytz==2020.1 \
    requests==2.24.0 \
    scikit-learn==0.23.2 \
    scipy==1.5.2 \
    utm==0.5.0 \
    jwcrypto==0.7 \
    pyfcm==1.4.7 \
    pygeocoder==1.2.5 \
    pymongo==3.11.0 \
    pykov==0.1

RUN cp /index.html webapp/www/index.html

RUN sed -i -e "s|run.host=server_host|run(reloader=True,host=server_host|g" emission/net/api/cfc_webapp.py

# Reimplementation of part of the start_server.sh script
RUN sed -i -e "s|HASHED|ASCENDING|" emission/core/get_database.py
RUN sed -i -e "/GEOSPHERE/d" emission/core/get_database.py
RUN pip3 install devcron

# crontab runs intake every hour
COPY crontab /usr/src/app/crontab
COPY start_cron.sh /usr/src/app/start_cron.sh

CMD ["/bin/bash", "/usr/src/app/start_cron.sh"]

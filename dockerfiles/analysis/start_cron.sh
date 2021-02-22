#set database URL using environment variable
#in the webapp, this is set in start_script
#but we don't call start_script here since we don't want to start the server
#but we still need to connect to the database
if [ -z ${DB_HOST} ] ; then
    local_host=`hostname -i`
    sed "s_localhost_${local_host}_" conf/storage/db.conf.sample > conf/storage/db.conf
else
    sed "s_localhost_${DB_HOST}_" conf/storage/db.conf.sample > conf/storage/db.conf
fi

# launch the cronjob
echo "Launch the cronjob"
# while true; do sleep 30; done;
devcron ../crontab >> /var/log/cron.console.stdinout 2>&1

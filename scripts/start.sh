#!/bin/bash
echo "---Ensuring UID: 99 matches user---"
usermod -u 99 browser
echo "---Ensuring GID: 100 matches user---"
groupmod -g 100 browser > /dev/null 2>&1 ||:
usermod -g 100 browser
echo "---Setting umask to 000---"
umask 000



echo "---Taking ownership of data...---"
chown -R root:100 /opt/scripts
chmod -R 750 /opt/scripts
chown -R 99:100 /browser

echo "---Starting...---"
term_handler() {
	kill -SIGTERM "$killpid"
	wait "$killpid" -f 2>/dev/null
	exit 143;
}

rm -rf /var/run/pulse /var/lib/pulse /root/.config/pulse

trap 'kill ${!}; term_handler' SIGTERM
su browser -c "/opt/scripts/start-server.sh" &
killpid="$!"
while true
do
	wait $killpid
	exit 0;
done
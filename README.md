
## Audio
docker exec 2302c89b96b3371c4d3d7977f3b91006c34644b569da5a77c94a970e9be5c7fd bash -c "sudo kill \$(pgrep -f '/opt/scripts/server -audio-port 10000 -port 8081')"
docker exec 2302c89b96b3371c4d3d7977f3b91006c34644b569da5a77c94a970e9be5c7fd bash -c  "/opt/scripts/server -audio-port 10000 -port 8081 &"

Start in container: /opt/scripts/server -audio-port 10000 -port 8081 &


#!/bin/bash
​
if [[ -z "${RCON_PASSWORD}" ]]; then
    echo "Error: No rcon password set"
    exit 1
fi
​
if [[ -z "${MAP_NAME}" ]]; then
    echo "Error: No map name set"
    exit 1
fi
​
# Update Game
./steamcmd.sh +login anonymous +force_install_dir ./l4d2 +app_update 222860 +quit
​
# Server Config
cat > l4d2/left4dead2/cfg/server.cfg <<EOF
hostname "${HOSTNAME}"
sv_region ${REGION}
rcon_password "${RCON_PASSWORD}"
sv_logecho 1
sm_cvar mp_gamemode versus
sv_gametypes "versus"
mp_gamemode "versus"

EOF

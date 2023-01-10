#!/bin/bash

if [[ -z "${RCON_PASSWORD}" ]]; then
    echo "Error: No rcon password set"
    exit 1
fi

if [[ -z "${MAP_NAME}" ]]; then
    echo "Error: No map name set"
    exit 1
fi

if [[ -z "${STEAMGROUP}" ]]; then
    echo "Error: no steam group"
    exit 1
fi

#####

if [[ -z "${GAMETYPES}" ]]; then
    GAMETYPES="coop,realism,survival,versus,teamversus,scavenge,teamscavenge"
fi

#####

# get our public ip
public_ip=$( curl api.ipify.org )

# set up ban lists
ln -s /l4d2-cfg/banned_ip.cfg l4d2/left4dead2/cfg/banned_ip.cfg
ln -s /l4d2-cfg/banned_user.cfg l4d2/left4dead2/cfg/banned_user.cfg

# Update Game
./steamcmd.sh +login anonymous +force_install_dir ./l4d2 +app_update 222860 +quit


# Server Config
cat > l4d2/left4dead2/cfg/server.cfg <<EOF
hostname "${HOSTNAME}"
rcon_password "${RCON_PASSWORD}"

sv_steamgroup ${STEAMGROUP}

sv_region ${REGION}
sv_logecho 1
sm_cvar mp_gamemode versus
sv_gametypes "${GAMETYPES}"
mp_gamemode "${GAMETYPES}"

sv_lan 0
sv_cheats 0
sv_consistency 1
sv_maxcmdrate 101
sv_maxrate 30000

exec banned_user.cfg  //loads banned users' ids
exec banned_ip.cfg      //loads banned users' ips
//writeip          // Save the ban list to banned_ip.cfg.
//writeid          // Wrties a list of permanently-banned user IDs to banned_user.cfg.


EOF

# Start Game
cd l4d2 && ./srcds_run -console -usercon -game left4dead2  -port "$PORT" +net_public_adr ${public_ip} -ip ${public_ip} +maxplayers "$PLAYERS" +sv_gametypes "VERSUS" +map "${MAP_NAME}" versus

FROM amazonlinux:2

RUN yum -y install curl wget tar bzip2 gzip unzip python3 binutils bc jq tmux glibc.i686 libstdc++ libstdc++.i686 shadow-utils util-linux file nmap-ncat iproute SDL2.i686 SDL2.x86_64 && \
    yum -y update --security

RUN useradd louis

WORKDIR /home/louis
USER louis

RUN wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz && tar -xzf steamcmd_linux.tar.gz && \
    rm steamcmd_linux.tar.gz && ./steamcmd.sh +quit

RUN mkdir -p .steam/sdk32/ && ln -s ~/linux32/steamclient.so ~/.steam/sdk32/steamclient.so && \
    mkdir -p .steam/sdk64/ && ln -s ~/linux64/steamclient.so ~/.steam/sdk64/steamclient.so

RUN ./steamcmd.sh +login anonymous +force_install_dir ./l4d2 +app_update 222860 +quit

# install metamod
#RUN cd l4d2/left4dead2/addons && \
#    wget https://github.com/alliedmodders/metamod-source/archive/4bdc2182b6c3b37c2628acea8fbca63c280cb28b.zip && \
#    unzip 4bdc2182b6c3b37c2628acea8fbca63c280cb28b.zip && \
#    rm -f 4bdc2182b6c3b37c2628acea8fbca63c280cb28b.zip && \
#    mv metamod-source-4bdc2182b6c3b37c2628acea8fbca63c280cb28b metamod-source


# install sourcemod
#RUN cd l4d2/left4dead2/addons && \
#    wget https://github.com/alliedmodders/sourcemod/archive/58f0ca475887dc697890431ec08a5e09ad1d7314.zip && \
#    unzip 58f0ca475887dc697890431ec08a5e09ad1d7314.zip && \
#    rm -f 58f0ca475887dc697890431ec08a5e09ad1d7314.zip && \
#    mv sourcemod-58f0ca475887dc697890431ec08a5e09ad1d7314 sourcemod

EXPOSE 27015/tcp
EXPOSE 27015/udp
EXPOSE 27016/tcp
EXPOSE 27016/udp

ENV PORT=27015 \
    PLAYERS=8 \
    REGION=255

ADD motd.txt l4d2/left4dead2
ADD host.txt l4d2/left4dead2
ADD entrypoint.sh entrypoint.sh


ENTRYPOINT bash ./entrypoint.sh

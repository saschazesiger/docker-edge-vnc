FROM j4n11s/base-vnc

LABEL org.opencontainers.image.authors="janis@js0.ch"
LABEL org.opencontainers.image.source="https://github.com/saschazesiger/"

ENV URL=https://browser.lol/redirect-url-to

COPY /scripts /opt/scripts

RUN apt-get update && \
	apt-get -y install --no-install-recommends fonts-takao fonts-arphic-uming libgtk-3-0 libgconf-2-4 libnss3 fonts-liberation libasound2 libcurl3-gnutls libcurl3-nss libcurl4 libgbm1 libnspr4 libnss3 libu2f-udev xdg-utils



RUN EDGE_BUILD=$(curl -q https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-dev/ | grep href | grep .deb | sed 's/.*href="//g'  | cut -d '"' -f1 | sort --version-sort | tail -1) &&\
	wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-dev/$EDGE_BUILD -O /tmp/chrome.deb
RUN dpkg -i /tmp/chrome.deb || apt-get install -yf
RUN rm /tmp/chrome.deb

#Server Start
CMD ["bash", "/opt/scripts/start.sh"]

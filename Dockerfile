FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
  git curl


RUN curl https://winswitch.org/gpg.asc | apt-key add -
RUN echo "deb http://winswitch.org/ xenial main" > /etc/apt/sources.list.d/winswitch.list
RUN apt-get install -y software-properties-common
RUN add-apt-repository universe
RUN apt-get update
RUN apt-get install -y xpra

RUN apt-get install -y xserver-xorg-input-void
RUN apt-get install -y xserver-xorg-video-dummy
RUN apt-get install -y pulseaudio
RUN apt-get install -y wget
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get update && apt-get install -y google-chrome-stable
RUN apt-get install -y dbus dbus-x11
RUN apt-get install -y x11-apps
RUN apt-get install -y xterm
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
RUN echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list
RUN apt-get update && apt-get install -y spotify-client

ENV DISPLAY=:0
ENV XPRA_KEYBOARD_SYNC=yes

WORKDIR /opt
RUN git clone https://github.com/novnc/websockify.git

WORKDIR /app
COPY app/entrypoint.sh .

ENTRYPOINT [ "/app/entrypoint.sh" ]

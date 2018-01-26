FROM ubuntu:16.04
RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list \
  && apt-get update && apt-get install -y \
  language-pack-ja-base \
  language-pack-ja \
  ibus-mozc \
  fonts-ipafont-gothic \
  fonts-ipafont-mincho \
  curl \
  git \
  sudo \
  wget \
  unzip \
  vim \
  apt-utils \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && alias curl='curl --noproxy localhost,127.0.0.1' \
 && update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja
ENV LC_ALL C.UTF-8
COPY .ssh /.ssh
COPY git.sh /git.sh
RUN /git.sh

RUN apt-get update && apt-get install -y \
  npm \
 && npm install -g npm@4

# Installing NodeJS
RUN apt-get install -y build-essential \
  && curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - \
  && apt-get install -y nodejs
  # ln: failed to create symbolic link '/usr/bin/node': File exists  
  #&& ln -s /usr/bin/nodejs /usr/bin/node

# Installing Watchman
RUN git clone https://github.com/facebook/watchman.git
WORKDIR watchman
RUN apt-get update && apt-get install -y \
  python-dev \
  automake \
  autoconf \
  && git checkout v4.5.0 \
  && ./autogen.sh \
  && ./configure \
  && make \
  && make install

# Installing Flow
# Flow is a static type checker for JavaScript. To install it, paste the following in the terminal:
RUN npm install -g flow-bin

ENV USER enxajt
RUN useradd -m -g sudo -s /bin/zsh $USER && echo "$USER:$USER" | chpasswd
USER $USER

RUN mkdir /home/$USER/src
WORKDIR /home/$USER/src
RUN git clone https://github.com/CanonicalLtd/react-native -b ubuntu
USER root
RUN npm install -g sinopia

RUN wget https://dl.google.com/dl/android/studio/ide-zips/2.3.3.0/android-studio-ide-162.4069837-linux.zip \
 && unzip android-studio-ide-162.4069837-linux.zip \
 && mv android-studio /usr/local/

RUN npm install -g create-react-native-app

RUN apt-get update && apt-get install -y \
  qemu-kvm \
  libvirt-bin \
  ubuntu-vm-builder \
  bridge-utils \
  virt-viewer
#RUN apt-get update && apt-get install -y \
#  ia32-libs-multiarch
#RUN adduser $USER kvm && adduser $USER libvirtd
RUN adduser $USER libvirtd

USER $USER
RUN create-react-native-app AwesomeProject
CMD ["/bin/bash"]

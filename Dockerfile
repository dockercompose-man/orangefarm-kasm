FROM kasmweb/core-ubuntu-focal:1.12.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########
### Install Ansible
#COPY ./src/ubuntu/install/ansible $INST_SCRIPTS/ansible/
#RUN bash $INST_SCRIPTS/ansible/install_ansible.sh  && rm -rf $INST_SCRIPTS/ansible/

# Install Google Chrome
#COPY ./src/ubuntu/install/chrome $INST_SCRIPTS/chrome/
#RUN bash $INST_SCRIPTS/chrome/install_chrome.sh  && rm -rf $INST_SCRIPTS/chrome/

# Install Chromium
COPY ./src/ubuntu/install/chromium $INST_SCRIPTS/chromium/
RUN if [ "$(uname -m)" = "aarch64" ]; then bash $INST_SCRIPTS/chromium/install_chromium.sh; fi && rm -rf $INST_SCRIPTS/>
# Install Firefox
#COPY ./src/ubuntu/install/firefox/ $INST_SCRIPTS/firefox/
#COPY ./src/ubuntu/install/firefox/firefox.desktop $HOME/Desktop/
#RUN bash $INST_SCRIPTS/firefox/install_firefox.sh && rm -rf $INST_SCRIPTS/firefox/

# Install VLC
RUN apt-get update && apt-get install -y vlc

### Install TorBrowser
#COPY ./src/ubuntu/install/torbrowser $INST_SCRIPTS/torbrowser/
#RUN bash $INST_SCRIPTS/torbrowser/install_torbrowser.sh  && rm -rf $INST_SCRIPTS/torbrowser/

### Install Thunderbird
COPY ./src/ubuntu/install/thunderbird $INST_SCRIPTS/thunderbird/
RUN bash $INST_SCRIPTS/thunderbird/install_thunderbird.sh  && rm -rf $INST_SCRIPTS/thunderbird/

### Install Visual Studio Code
COPY ./src/ubuntu/install/vs_code $INST_SCRIPTS/vs_code/
RUN bash $INST_SCRIPTS/vs_code/install_vs_code.sh  && rm -rf $INST_SCRIPTS/vs_code/

### Install NextCloud
COPY ./src/ubuntu/install/nextcloud $INST_SCRIPTS/nextcloud/
RUN bash $INST_SCRIPTS/nextcloud/install_nextcloud.sh  && rm -rf $INST_SCRIPTS/nextcloud/

### Install GIMP
COPY ./src/ubuntu/install/gimp $INST_SCRIPTS/gimp/
RUN bash $INST_SCRIPTS/gimp/install_gimp.sh  && rm -rf $INST_SCRIPTS/gimp/

### Install Only Office
#COPY ./src/ubuntu/install/only_office $INST_SCRIPTS/only_office/
#RUN bash $INST_SCRIPTS/only_office/install_only_office.sh  && rm -rf $INST_SCRIPTS/only_office/

### Install Libre Office
COPY ./src/ubuntu/install/libre_office $INST_SCRIPTS/libre_office/
RUN bash $INST_SCRIPTS/libre_office/install_libre_office.sh  && rm -rf $INST_SCRIPTS/libre_office/

### Install VMWare Horizons
#COPY ./src/ubuntu/install/horizon $INST_SCRIPTS/zoom/
#RUN bash $INST_SCRIPTS/horizon/install_horizons.sh  && rm -rf $INST_SCRIPTS/horizon/

### Install Zoom
COPY ./src/ubuntu/install/zoom $INST_SCRIPTS/zoom/
RUN bash $INST_SCRIPTS/zoom/install_zoom.sh  && rm -rf $INST_SCRIPTS/zoom/

### Install Teams
COPY ./src/ubuntu/install/teams $INST_SCRIPTS/teams/
RUN bash $INST_SCRIPTS/teams/install_teams.sh  && rm -rf $INST_SCRIPTS/teams/

### Install Tools-Deluxe
#COPY ./src/ubuntu/install/tools $INST_SCRIPTS/teams/
#RUN bash $INST_SCRIPTS/tools/install_tools_deluxe.sh  && rm -rf $INST_SCRIPTS/tools/


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000

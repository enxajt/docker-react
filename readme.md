# docker run
xhost +local:root; \
docker run -it \
 -e DISPLAY=$DISPLAY \
 -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
 -v /home/enxajt/docker-react/shared:/home/enxajt/shared:rw \
 react-android-studio \
 /bin/bash

# Android Studio
/usr/local/android-studio/bin/studio.sh
# KVM

# create-react-native-app
cd AwesomeProject
sudo npm start
Expo xde on Galago
Expo on iPh

# import react-native project to EXP
npm install -g exp
exp init [dir]
copy from react-native project
# see in phone
exp start --send-to enxajt@gmail.com
# notify on EXPO
curl -iv -H 'accept: application/json' -H 'accept-encoding: gzip, deflate' -H 'content-type: application/json' -d '[{"to":"ExponentPushToken[QNVoo2Bemz2IjAWEU4FBkT]", "body":"wut up", "badge": 1, "data":{"a":"b"}}]' https://exp.host/--/api/v2/push/send

# organize Dockerfile
# docker build

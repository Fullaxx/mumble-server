#!/bin/bash

# REQUIRES: --cap-add=NET_ADMIN
# sed -e 's/MURMUR_USE_CAPABILITIES=0/MURMUR_USE_CAPABILITIES=1/' -i /etc/default/mumble-server
# DOES NOT SEEM TO WORK CORRECTLY

sed -e 's@database=/var/lib/mumble-server/mumble-server.sqlite@database=/data/mumble-server.sqlite@' -i /etc/mumble-server.ini
sed -e 's@logfile=/var/log/mumble-server/mumble-server.log@logfile=/data/mumble-server.log@' -i /etc/mumble-server.ini

# If you leave this field blank, Murmur will force itself into foreground mode which logs to the console.
# sed -e 's@logfile=/var/log/mumble-server/mumble-server.log@logfile=@' -i /etc/mumble-server.ini

if [ -n "${WELCOMETEXT}" ]; then
  sed -e "s@Welcome to this server running <b>Murmur</b>.<br />Enjoy your stay\!@${WELCOMETEXT}@" -i /etc/mumble-server.ini
fi

if [ -n "${PASSWORD}" ]; then
  sed -e "s/^serverpassword=$/serverpassword=${PASSWORD}/" -i /etc/mumble-server.ini
fi

if [ -n "${BANDWIDTH}" ]; then
  sed -e "s/^bandwidth=72000$/bandwidth=${BANDWIDTH}/" -i /etc/mumble-server.ini
fi

if [ -n "${TIMEOUT}" ]; then
  sed -e "s/^;timeout=30$/timeout=${TIMEOUT}/" -i /etc/mumble-server.ini
fi

if [ -n "${USERS}" ]; then
  sed -e "s/^users=100$/users=${USERS}/" -i /etc/mumble-server.ini
fi

if [ -n "${USERSPERCHANNEL}" ]; then
  sed -e "s/^;usersperchannel=0$/usersperchannel=${USERSPERCHANNEL}/" -i /etc/mumble-server.ini
fi

if [ "${ALLOWPING}" == "false" ]; then
  sed -e "s/^allowping=true$/allowping=false/" -i /etc/mumble-server.ini
fi

if [ -n "${OPUSTHRESHOLD}" ]; then
  sed -e "s/^;opusthreshold=100$/opusthreshold=${OPUSTHRESHOLD}/" -i /etc/mumble-server.ini
fi

if [ -n "${CHANNELNESTINGLIMIT}" ]; then
  sed -e "s/^;channelnestinglimit=10$/channelnestinglimit=${CHANNELNESTINGLIMIT}/" -i /etc/mumble-server.ini
fi

if [ -n "${CHANNELCOUNTLIMIT}" ]; then
  sed -e "s/^;channelcountlimit=1000$/channelcountlimit=${CHANNELCOUNTLIMIT}/" -i /etc/mumble-server.ini
fi

if [ "${CERTREQUIRED}" == "true" ]; then
  sed -e "s/^;certrequired=False$/certrequired=true/" -i /etc/mumble-server.ini
fi

if [ "${SENDVERSION}" == "false" ]; then
  sed -e "s/^;sendversion=True$/sendversion=false/" -i /etc/mumble-server.ini
fi

if [ -n "${SUGGESTVERSION}" ]; then
  sed -e "s/^;suggestVersion=$/suggestVersion=${SUGGESTVERSION}/" -i /etc/mumble-server.ini
fi

if [ -n "${SUGGESTPOSITIONAL}" ]; then
  sed -e "s/^;suggestPositional=$/suggestPositional=${SUGGESTPOSITIONAL}/" -i /etc/mumble-server.ini
fi

if [ -n "${SUGGESTPUSHTOTALK}" ]; then
  sed -e "s/^;suggestPushToTalk=$/suggestPushToTalk=${SUGGESTPUSHTOTALK}/" -i /etc/mumble-server.ini
fi

# We force foreground mode to ensure that murmurd has a chance to close its database properly
# docker logs mumble will show logs
chown -R mumble-server.mumble-server /data
exec /usr/sbin/murmurd -fg -ini /etc/mumble-server.ini

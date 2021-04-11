# ------------------------------------------------------------------------------
# Pull base image
FROM debian:bullseye-slim
MAINTAINER Brett Kuskie <fullaxx@gmail.com>

# ------------------------------------------------------------------------------
# Set environment variables
ENV DEBIAN_FRONTEND noninteractive

# ------------------------------------------------------------------------------
# Install mumble-server and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends mumble-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# Install startup script
COPY app.sh /app/

# ------------------------------------------------------------------------------
# Identify Volumes
VOLUME /data

# ------------------------------------------------------------------------------
# Expose ports
EXPOSE 64738/tcp 64738/udp

# ------------------------------------------------------------------------------
# Define runtime command
CMD ["/app/app.sh"]

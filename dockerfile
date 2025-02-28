# Use Ubuntu 18.04 as base image (14.04 is outdated)
FROM ubuntu:18.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    curl && \
    apt-get clean

# Add the RethinkDB repository
RUN echo "deb http://download.rethinkdb.com/repository/ubuntu-bionic bionic main" | tee /etc/apt/sources.list.d/rethinkdb.list && \
    wget -qO- https://download.rethinkdb.com/repository/raw/pubkey.gpg | apt-key add -

# Install RethinkDB
RUN apt-get update && apt-get install -y rethinkdb && apt-get clean

# Expose ports for RethinkDB
EXPOSE 8080 28015 29015

# Run RethinkDB
CMD ["rethinkdb", "--bind", "all"]

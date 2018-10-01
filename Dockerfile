FROM ubuntu:16.04

LABEL Author="Sam Chen"

ENV REFRESHED_AT=2018-10-01 \
    LANG=en_US.UTF-8 \
    HOME=/opt/build \
    PHOENIX_VERSION=1.3.4

WORKDIR /opt/build

RUN \
  apt-get update -y && \
  apt-get install -y curl vim git wget locales && \
  locale-gen en_US.UTF-8 && \
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
  dpkg -i erlang-solutions_1.0_all.deb && \
  rm erlang-solutions_1.0_all.deb && \
  apt-get update -y && \
  apt-get install -y erlang elixir

RUN mix local.rebar --force && \
  mix local.hex --force

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new-$PHOENIX_VERSION.ez

CMD ["/bin/bash"]

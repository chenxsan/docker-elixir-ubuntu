FROM ubuntu:16.04

LABEL Author="Sam Chen"

ENV REFRESHED_AT=2018-10-01 \
    LANG=en_US.UTF-8 \
    HOME=/opt/build \
    TERM=xterm

WORKDIR /opt/build

RUN \
  apt-get update -y && \
  apt-get install -y git wget locales && \
  locale-gen en_US.UTF-8 && \
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
  dpkg -i erlang-solutions_1.0_all.deb && \
  rm erlang-solutions_1.0_all.deb && \
  apt-get update -y && \
  apt-get install -y erlang elixir

# Install local Elixir hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

CMD ["/bin/bash"]


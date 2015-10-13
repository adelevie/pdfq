FROM hone/mruby-cli
ENV SHELL /bin/bash
RUN apt-get update && apt-get install -y --no-install-recommends cmake

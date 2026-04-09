FROM geodynamics/aspect:v3.0.0

# root user is not allowed in binder
ARG NB_USER=jovyan
ARG NB_UID=1100
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

USER root

RUN adduser --disabled-password \
    --gecos "Default user" \
    ${NB_USER}
 
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*
    
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
RUN python3 -m pip install --no-cache-dir notebook jupyterlab
USER ${NB_USER}

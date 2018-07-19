FROM registry.access.redhat.com/rhel7

ARG USER
ARG PASS

ENV SUMMARY="Base image which allows using of source-to-image."	\
    DESCRIPTION="The s2i-core image provides any images layered on top of it \
with all the tools needed to use source-to-image functionality while keeping \
the image size as small as possible."

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="s2i-rhel7-base" \
      io.openshift.s2i.scripts-url=image:///usr/libexec/s2i \
      io.s2i.scripts-url=image:///usr/libexec/s2i \
      com.redhat.component="rhel7-base" \
      name="bucharestgold/rhel7-base" \
      version="1"

ENV \
    # Path to be used in other layers to place s2i scripts into
    STI_SCRIPTS_PATH=/usr/libexec/s2i \
    APP_ROOT=/opt/app-root \
    # The $HOME is not set by default, but some applications needs this variable
    HOME=/opt/app-root/src

# This is the list of basic dependencies that all language container image can
# consume.
# Also setup the 'openshift' user that is used for the build execution and for the
# application runtime execution.
RUN subscription-manager register --username=${USER} --password=${PASS} --auto-attach && \ 
  INSTALL_PKGS="rh-git29 \
  gcc-c++ \
  make" && \
  subscription-manager repos --enable rhel-7-server-extras-rpms && \
  subscription-manager repos --enable rhel-server-rhscl-7-rpms && \
  yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
  rpm -V $INSTALL_PKGS && \
  yum clean all -y && \
  rm -rf /var/cache/yum && \
  subscription-manager unregister

COPY bin/ /usr/bin/

ENV CONTAINER_SCRIPTS_PATH=/usr/share/container-scripts/git \
    ENABLED_COLLECTIONS=rh-git29

# When bash is started non-interactively, to run a shell script, for example it
# looks for this variable and source the content of this file. This will enable
# the SCL for all scripts without need to do 'scl enable'.
ENV BASH_ENV=${CONTAINER_SCRIPTS_PATH}/scl_enable \
    ENV=${CONTAINER_SCRIPTS_PATH}/scl_enable \
    PROMPT_COMMAND=". ${CONTAINER_SCRIPTS_PATH}/scl_enable"

ADD root /

# Directory with the sources is set as the working directory so all STI scripts
# can execute relative to this path.
WORKDIR ${HOME}

ENTRYPOINT ["container-entrypoint"]

RUN useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin \
      -c "Default Application User" default && \
  chown -R 1001:0 ${APP_ROOT}


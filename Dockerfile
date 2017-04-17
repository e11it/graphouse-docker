FROM debian:jessie
ENV DEBIAN_FRONTEND noninteractive

ARG repo_ch="deb http://repo.yandex.ru/clickhouse/trusty stable main"
ARG repo_ch_key="E0C56BD4"
ARG ch_version=\*

ARG repo_java="deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main"
ARG repo_java_src="deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main"
ARG repo_java_key="EEA14886"


ADD run.sh /usr/local/bin/run.sh
RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    mkdir -p /etc/apt/sources.list.d && \
    echo $repo_ch | tee /etc/apt/sources.list.d/clickhouse.list && \
    echo $repo_java | tee /etc/apt/sources.list.d/java.list && \
    echo $repo_java_src | tee -a /etc/apt/sources.list.d/java.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $repo_ch_key && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $repo_java_key && \
    apt-get update && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
    apt-get install --allow-unauthenticated -y oracle-java8-installer && \
    apt-get install --allow-unauthenticated -y oracle-java8-set-default && \
    apt-get install -y graphouse=$ch_version && \
    rm -rf /var/lib/apt/lists/* /var/cache/debconf /var/cache/oracle-* && \
    apt-get clean && \
    chmod +x /usr/local/bin/run.sh

EXPOSE 2003 2005
USER graphouse
WORKDIR /opt/graphouse

ENTRYPOINT exec /usr/local/bin/run.sh

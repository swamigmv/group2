FROM oraclelinux:8.5

LABEL author="swv"
LABEL email="swamigmv@gmail.com"

RUN yum -y install git

RUN mkdir /dev/geth_install

RUN cd /dev/geth_install

RUN git clone https://github.com/swamigmv/ticketing_system.git

RUN git checkout docker_image

CMD ["tail", "-f", "/dev/null"]
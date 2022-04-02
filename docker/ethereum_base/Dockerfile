FROM oraclelinux:8.5

LABEL author="swv"
LABEL email="swamigmv@gmail.com"

RUN yum -y install git

RUN mkdir /home/ethereum
RUN mkdir /home/ethereum/git_code

WORKDIR /home/ethereum/git_code

RUN git clone https://github.com/swamigmv/ticketing_system.git

CMD ["tail", "-f", "/dev/null"]
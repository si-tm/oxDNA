FROM ubuntu:20.04
 ENV DEBIAN_FRONTEND=noninteractive
 
RUN apt-get update && \
   apt-get install -y build-essential cmake clang python3-dev vim
RUN apt-get install -y pip
RUN pip install -U pip && \
    pip install numpy && \
    pip install matplotlib
RUN apt update -y
RUN apt install git -y
WORKDIR code
RUN git clone --depth 1 https://github.com/si-tm/oxDNA.git
RUN mkdir oxDNA/build
RUN cd oxDNA/build && cmake .. && make -j4
WORKDIR oxDNA/
RUN chmod 755 run_oxdna_random_3.sh

ENTRYPOINT ["./run_oxdna_random_3.sh", "L2"]

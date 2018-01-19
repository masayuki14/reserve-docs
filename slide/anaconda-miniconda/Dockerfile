FROM python:latest

# Install miniconda to /miniconda
RUN curl -LO 'https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh'
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /miniconda
ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda

RUN conda install -y conda-build
RUN conda update  -y conda-build

RUN apt-get update
RUN apt-get install -y vim

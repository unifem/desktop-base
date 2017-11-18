# Builds a Docker image for Spyder and Jupyter Notebook
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM compdatasci/petsc-desktop:latest
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp

ADD image/home $DOCKER_HOME

# Install system packages, Scipy, PyDrive, and jupyter-notebook
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
          python3-dev \
          doxygen \
          meld \
          pandoc \
          libnss3 \
          libdpkg-perl \
          ttf-dejavu \
          \
          swig3.0 \
          python3-mpi4py \
          python3-petsc4py \
          python3-slepc4py && \
    apt-get clean && \
    apt-get autoremove && \
    curl -O https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    pip3 install -U \
          setuptools \
          matplotlib \
          sympy \
          scipy \
          pandas \
          nose \
          sphinx \
          cython \
          \
          autopep8 \
          flake8 \
          pylint \
          flufl.lock \
          ply \
          pytest \
          six \
          PyQt5 \
          spyder \
          \
          urllib3 \
          requests \
          pylint \
          progressbar2 \
          PyDrive \
          \
          ipython \
          jupyter \
          jupyter_latex_envs \
          ipywidgets && \
    jupyter nbextension install --py --system \
         widgetsnbextension && \
    jupyter nbextension enable --py --system \
         widgetsnbextension && \
    jupyter-nbextension install --py --system \
        latex_envs && \
    jupyter-nbextension enable --py --system \
        latex_envs && \
    jupyter-nbextension install --system \
        https://bitbucket.org/ipre/calico/downloads/calico-spell-check-1.0.zip && \
    jupyter-nbextension install --system \
        https://bitbucket.org/ipre/calico/downloads/calico-document-tools-1.0.zip && \
    jupyter-nbextension install --system \
        https://bitbucket.org/ipre/calico/downloads/calico-cell-tools-1.0.zip && \
    jupyter-nbextension enable --system \
        calico-spell-check && \
    \
    curl -L https://github.com/hbin/top-programming-fonts/raw/master/install.sh | bash && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    \
    touch $DOCKER_HOME/.log/jupyter.log && \
    chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME

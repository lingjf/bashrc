FROM ubuntu

# Make add-apt-repository available
RUN apt-get update \
    && apt-get -y install \
        python python3 python-pkg-resources python3-pkg-resources python-pip python3-pip \
        apt-transport-https ca-certificates \
        build-essential software-properties-common \
        vim jq unzip curl wget xz-utils git cmake gcc-multilib g++-multilib \
    && rm -rf /var/lib/apt/lists/*

# Install gcc versions
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && apt-get update \
    && apt-get -y install gcc-11 g++-11 gcc-10 g++-10 gcc-9 g++-9 gcc-8 g++-8 gcc-7 g++-7 gcc-6 g++-6 gcc-5 g++-5 \
    && apt-get -y install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu

# Install clang
# RUN curl -sSL https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.0/clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz \
#         | tar -xJC . && mv clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04 clang13 \
#     && echo "export PATH=/clang13/bin:$PATH" >> ~/.bashrc \
#     && echo "export LD_LIBRARY_PATH=/clang13/lib:$LD_LIBRARY_PATH" >> ~/.bashrc

# Install bazel (https://docs.bazel.build/versions/master/install-ubuntu.html)
RUN apt-get -y install openjdk-8-jdk \
    && echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
    && curl https://bazel.build/bazel-release.pub.gpg | apt-key add - \
    && apt-get update \
    && apt-get -y install bazel && apt-get -y upgrade bazel \
    && bazel version

# Install Ninja (https://ninja-build.org/)
RUN git clone https://github.com/ninja-build/ninja.git \
    && cd ninja && ./configure.py --bootstrap && cp ninja /usr/bin \
    && cd .. && rm -rf ninja

# Install Docker (https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#uninstall-old-versions)
# RUN apt-get -y install linux-image-extra-virtual
# RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
#     && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge" \
#     && apt-get -y update \
#     && apt-get install -y docker-ce docker-ce-cli

# Install Qemu
RUN apt-get -y install qemu-user

# Install matrix
RUN apt-get -y install ncurses-dev \
    && git clone https://github.com/abishekvashok/cmatrix.git \
    && cd cmatrix && cmake . && make install \
    && cd .. && rm -rf cmatrix

# Install autojump
RUN apt-get -y install autojump \
    && echo 'source ./usr/share/autojump/autojump.sh' >> ~/.bashrc

# Install bashrc.sh
COPY ./bashrc.sh /root/.bashrc.sh
RUN echo 'source ~/.bashrc.sh' >> ~/.bashrc

# Generate a new SSH-Key
RUN mkdir /root/.ssh && echo "y" | ssh-keygen -t rsa -b 4096 -C "lingjf@gmail.com" -f /root/.ssh/id_rsa

# Configure git 
RUN git config --global user.name lingjf && git config --global user.email lingjf@gmail.com

CMD /bin/bash

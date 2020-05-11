FROM centos:7
RUN yum install -y centos-release-scl
RUN yum-config-manager --enable rhel-server-rhscl-7-rpms
RUN yum install -y devtoolset-7 openssl-devel
RUN scl enable devtoolset-7 bash
RUN mkdir cmake
RUN cd cmake
RUN curl -o cmake-3.17.1.tar.gz https://cmake.org/files/v3.17/cmake-3.17.1.tar.gz
RUN tar zxvf cmake-3.17.1.tar.gz
RUN source /opt/rh/devtoolset-7/enable \
    && cd cmake-3.17.1 \
    && ./bootstrap --prefix=/usr/local \
    && make -j$(nproc) \
    && make install
RUN curl -o boost_1_71_0.tar.gz -L https://dl.bintray.com/boostorg/release/1.71.0/source/boost_1_71_0.tar.gz
RUN tar zxvf boost_1_71_0.tar.gz
RUN source /opt/rh/devtoolset-7/enable \
    && cd boost_1_71_0 \
    && ./bootstrap.sh --prefix=/usr/local \
    && ./b2 -j $(nproc) cxxflags=-fPIC install ; exit 0
RUN groupadd -g 1003 bamboo
RUN useradd --gid bamboo --create-home --uid 1003 bamboo
USER bamboo

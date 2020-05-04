FROM centos:7
RUN yum install -y centos-release-scl
RUN yum-config-manager --enable rhel-server-rhscl-7-rpms
RUN yum install -y devtoolset-7
RUN yum group install -y "Development Tools"
RUN export CXX=/usr/bin/g++
RUN yum install -y openssl-devel
RUN mkdir cmake
RUN cd cmake
RUN curl -o cmake-3.17.1.tar.gz https://cmake.org/files/v3.17/cmake-3.17.1.tar.gz
RUN tar zxvf cmake-3.17.1.tar.gz
RUN cd cmake-3.17.1 \
    && ./bootstrap --prefix=/usr/local \
    && make -j$(nproc) \
    && make install
RUN yum install -y wget
RUN wget ftp://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-9.2.0/gcc-9.2.0.tar.gz
RUN tar xfz gcc-9.2.0.tar.gz
RUN cd gcc-9.2.0 \
   && ./contrib/download_prerequisites \
   && ./configure --disable-multilib --enable-languages=c,c++ --with-pic \
   && make -j$(nproc) \
   && make install \
#   && cd .. && rm -rf gcc-9.2.0.tar.gz gcc-9.2.0 \
   && chmod +x /usr/local/libexec/gcc/x86_64-pc-linux-gnu/9.2.0/cc1plus
RUN curl -o boost_1_71_0.tar.gz -L https://dl.bintray.com/boostorg/release/1.71.0/source/boost_1_71_0.tar.gz
RUN tar zxvf boost_1_71_0.tar.gz
RUN cd boost_1_71_0 \
    && ./bootstrap.sh --prefix=/usr/local \
    && ./b2 install --prefix=/usr/local --with=all

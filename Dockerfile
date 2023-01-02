FROM ubuntu:20.04

# Install Packages
RUN apt-get update && apt-get install -y git

#Clone Leap 3.2.0 and Submodules
RUN git clone https://github.com/AntelopeIO/leap.git && cd leap && git checkout tags/v3.2.0 && git submodule update --init --recursive

# Build Leap 3.2.0
RUN cd leap && scripts/install_deps.sh && scripts/pinned_build.sh deps build "$(nproc)"

#clone cdt 
RUN git clone --recursive https://github.com/AntelopeIO/cdt 

#build cdt
RUN cd cdt && mkdir build && cd build && cmake .. && make -j "$(nproc)"

#install cdt
RUN cd cdt/build && make install
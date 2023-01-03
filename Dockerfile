FROM ubuntu:20.04

# Install Packages
RUN apt-get update && apt-get install -y git

# Clone Leap 3.2.0 and Submodules
RUN git clone https://github.com/AntelopeIO/leap.git && cd leap && git checkout tags/v3.2.0 && git submodule update --init --recursive

# Build and Install Leap 3.2.0
RUN cd leap && scripts/install_deps.sh && scripts/pinned_build.sh deps build "$(nproc)" && make install

# Remove Leap files
RUN rm -r leap

# Clone cdt 
RUN git clone --recursive https://github.com/AntelopeIO/cdt 

# Build and Install cdt
RUN cd cdt && mkdir build && cd build && cmake .. && make -j "$(nproc)" && make install

# Remove cdt files
RUN rm -r cdt
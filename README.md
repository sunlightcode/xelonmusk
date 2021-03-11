# XElonMusk
XElonMusk is based on the Bitcoin protocol, port number 9628, no pre-mining, a total of 21,000, and mining reward of 50.

XElonMusk is a public blockchain. Anyone can participate in the development of XElonMusk. Simply download the XElonMusk mining wallet and simply install it to experience the application of “blockchain” and “cryptocurrency” technologies.

## How to compile XElonMusk
### Ubuntu 14.04
#### Download
1. sudo apt-get update
2. apt-get install git
3. git clone https://github.com/sunlightcode/xelonmusk.git

#### Configuration
1. sudo apt-get upgrade
2. sudo apt-get install make gcc g++
3. sudo apt-get install pkg-config
4. apt-get install libdb-dev libdb++-dev libboost-dev zlib1g-dev libssl-dev build-essential libminiupnpc-dev autoconf libevent-dev libzmq3-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev libtool libboost-all-dev

#### Compile
1. export CXXFLAGS=-std=c++11
2. ./autogen.sh
3. ./configure -without-gui --with-incompatible-bdb
4. make
5. make install

#### Run
1. XElonMuskd  -conf=/mnt/.XElonMusk/XElonMusk.conf  -datadir=/mnt/.XElonMusk/

### Mac OS X
#### Download
1. xcode-select --install
2. ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 
3. brew install git
4. git clone https://gitee.com/sunlightcode/XElonMusk.git

#### Configuration
1. brew install automake berkeley-db4 libtool boost --c++11 miniupnpc openssl pkg-config protobuf qt libevent python3

#### Compile
1. export LDFLAGS=-L/usr/local/opt/openssl/lib
2. export CPPFLAGS=-I/usr/local/opt/openssl/include 
3. export CXXFLAGS=-std=c++11
4. ./autogen.sh
5. ./configure 
6. make
7. make install

#### Run
1. XElonMusk-qt


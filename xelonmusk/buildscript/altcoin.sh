#!/bin/bash
# Useage:
#    COIN_CONFIG_DIR=/absolute/path/to/model/altcoin sh bash/makecoin.sh
#

COIN_CONFIG_FILE=$COIN_CONFIG_DIR/coin.cfg

if  [ -n "$COIN_CONFIG_DIR" -a -d "$COIN_CONFIG_DIR" -a -f "$COIN_CONFIG_FILE" ] ; then 
	echo Loading configuration from "$COIN_CONFIG_DIR"
else 
	echo $COIN_CONFIG_DIR is not valid directory; 
	exit -2; 
fi


function getValue(){
	value=$(grep "$1=.*" "$COIN_CONFIG_FILE" | sed -e "s/.*=\(.*\)/\1/g" ) 
	echo -n $value;
}

echo Step 0: loading configuration variables
	AnyCoin=$(getValue "name") ; 
	AnyCoin_Lower=$(getValue "name_lower");
	AnyCoin_zh_CN=$(getValue "name_zh_CN"); 
	AnyCoinUint=$(getValue "unit");
	AnyCoinUintUpper=$(getValue "unit_upper");

echo Step 1: replace images
	cp -rf $COIN_CONFIG_DIR/src ./
	cp -rf $COIN_CONFIG_DIR/share ./

echo Step 2: replace locale text
	sed -i -e "s/XElonMusk/$AnyCoin/g" configure.ac
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/qt/locale/xelonmusk_en.ts
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/qt/guiconstants.h
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/qt/res/xelonmusk-qt-res.rc
	sed -i -e "s/XElonMusk/$AnyCoin_zh_CN/g" src/qt/locale/xelonmusk_zh_CN.ts

	sed -i -e "s/XElonMusk/$AnyCoin/g" src/qt/xelonmuskunits.cpp
	sed -i -e "s/XELON/$AnyCoinUintUpper/g" src/qt/xelonmuskunits.cpp
	sed -i -e "s/ftc/$AnyCoinUint/g" src/qt/xelonmuskunits.cpp

	sed -i -e "s/XElonMusk/$AnyCoin/g" src/util.cpp	
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/xelonmusk-cli.cpp
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/clientversion.cpp
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/init.cpp
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/miner.cpp
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/rpcdump.cpp
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/rpcmining.cpp
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/rpcmisc.cpp
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/rpcnet.cpp
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/rpcprotocol.cpp
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/rpcrawtransaction.cpp
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/rpcserver.cpp
	sed -i -e "s/XElonMusk/$AnyCoin/g" src/rpcwallet.cpp
	
	sed -i -e "s/xelonmusk/$AnyCoin_Lower/g" src/util.cpp
	sed -i -e "s/xelonmusk/$AnyCoin_Lower/g" src/xelonmusk-cli.cpp
	sed -i -e "s/xelonmusk/$AnyCoin_Lower/g" src/clientversion.cpp
	sed -i -e "s/xelonmusk/$AnyCoin_Lower/g" src/init.cpp
	sed -i -e "s/xelonmusk/$AnyCoin_Lower/g" src/miner.cpp
	sed -i -e "s/xelonmusk/$AnyCoin_Lower/g" src/rpcdump.cpp
	sed -i -e "s/xelonmusk/$AnyCoin_Lower/g" src/rpcmining.cpp
	sed -i -e "s/xelonmusk/$AnyCoin_Lower/g" src/rpcmisc.cpp
	sed -i -e "s/xelonmusk/$AnyCoin_Lower/g" src/rpcnet.cpp
	sed -i -e "s/xelonmusk/$AnyCoin_Lower/g" src/rpcprotocol.cpp
	sed -i -e "s/xelonmusk/$AnyCoin_Lower/g" src/rpcrawtransaction.cpp
	sed -i -e "s/xelonmusk/$AnyCoin_Lower/g" src/rpcserver.cpp
	sed -i -e "s/xelonmusk/$AnyCoin_Lower/g" src/rpcwallet.cpp

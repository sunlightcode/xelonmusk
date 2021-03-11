DIST_SUBDIRS = secp256k1
AM_LDFLAGS = $(PTHREAD_CFLAGS) $(LIBTOOL_LDFLAGS)


if EMBEDDED_LEVELDB
LEVELDB_CPPFLAGS += -I$(srcdir)/leveldb/include
LEVELDB_CPPFLAGS += -I$(srcdir)/leveldb/helpers/memenv
LIBLEVELDB += $(builddir)/leveldb/libleveldb.a
LIBMEMENV  += $(builddir)/leveldb/libmemenv.a

# NOTE: This dependency is not strictly necessary, but without it make may try to build both in parallel, which breaks the LevelDB build system in a race
$(LIBLEVELDB): $(LIBMEMENV)

$(LIBLEVELDB) $(LIBMEMENV):
	@echo "Building LevelDB ..." && $(MAKE) -C $(@D) $(@F) CXX="$(CXX)" \
	  CC="$(CC)" PLATFORM=$(TARGET_OS) AR="$(AR)" $(LEVELDB_TARGET_FLAGS) \
          OPT="$(CXXFLAGS) $(CPPFLAGS)"
endif

XELONMUSK_CONFIG_INCLUDES=-I$(builddir)/config
XELONMUSK_INCLUDES=-I$(builddir) -I$(builddir)/obj $(BOOST_CPPFLAGS) $(LEVELDB_CPPFLAGS) $(CRYPTO_CFLAGS) $(SSL_CFLAGS)

XELONMUSK_INCLUDES += -I$(srcdir)/secp256k1/include

LIBXELONMUSK_SERVER=libxelonmusk_server.a
LIBXELONMUSK_WALLET=libxelonmusk_wallet.a
LIBXELONMUSK_COMMON=libxelonmusk_common.a
LIBXELONMUSK_CLI=libxelonmusk_cli.a
LIBXELONMUSK_UTIL=libxelonmusk_util.a
LIBXELONMUSK_CRYPTO=crypto/libxelonmusk_crypto.a
LIBXELONMUSK_UNIVALUE=univalue/libxelonmusk_univalue.a
LIBXELONMUSKQT=qt/libxelonmuskqt.a
LIBSECP256K1=secp256k1/libsecp256k1.la

$(LIBSECP256K1): $(wildcard secp256k1/src/*) $(wildcard secp256k1/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)

# Make is not made aware of per-object dependencies to avoid limiting building parallelization
# But to build the less dependent modules first, we manually select their order here:
EXTRA_LIBRARIES = \
  crypto/libxelonmusk_crypto.a \
  libxelonmusk_util.a \
  libxelonmusk_common.a \
  univalue/libxelonmusk_univalue.a \
  libxelonmusk_server.a \
  libxelonmusk_cli.a
if ENABLE_WALLET
XELONMUSK_INCLUDES += $(BDB_CPPFLAGS)
EXTRA_LIBRARIES += libxelonmusk_wallet.a
endif

if BUILD_XELONMUSK_LIBS
lib_LTLIBRARIES = libxelonmuskconsensus.la
LIBXELONMUSK_CONSENSUS=libxelonmuskconsensus.la
else
LIBXELONMUSK_CONSENSUS=
endif

bin_PROGRAMS =
TESTS =

if BUILD_XELONMUSKD
  bin_PROGRAMS += xelonmuskd
endif

if BUILD_XELONMUSK_UTILS
  bin_PROGRAMS += xelonmusk-cli xelonmusk-tx
endif

.PHONY: FORCE
# xelonmusk core #
XELONMUSK_CORE_H = \
  addrman.h \
  alert.h \
  allocators.h \
  amount.h \
  arith_uint256.h \
  base58.h \
  bloom.h \
  chain.h \
  chainparamsbase.h \
  chainparams.h \
  chainparamsseeds.h \
  checkpoints.h \
  checkqueue.h \
  clientversion.h \
  coincontrol.h \
  coins.h \
  compat.h \
  compressor.h \
  core_io.h \
  crypter.h \
  db.h \
  eccryptoverify.h \
  ecwrapper.h \
  hash.h \
  init.h \
  key.h \
  keystore.h \
  leveldbwrapper.h \
  limitedmap.h \
  main.h \
  merkleblock.h \
  miner.h \
  mruset.h \
  netbase.h \
  net.h \
  noui.h \
  pow.h \
  primitives/block.h \
  primitives/transaction.h \
  protocol.h \
  pubkey.h \
  random.h \
  rpcclient.h \
  rpcprotocol.h \
  rpcserver.h \
  script/interpreter.h \
  script/script_error.h \
  script/script.h \
  script/sigcache.h \
  script/sign.h \
  script/standard.h \
  serialize.h \
  streams.h \
  sync.h \
  threadsafety.h \
  timedata.h \
  tinyformat.h \
  txdb.h \
  txmempool.h \
  ui_interface.h \
  uint256.h \
  undo.h \
  util.h \
  utilmoneystr.h \
  utilstrencodings.h \
  utiltime.h \
  version.h \
  walletdb.h \
  wallet.h \
  wallet_ismine.h \
  compat/sanity.h

JSON_H = \
  json/json_spirit.h \
  json/json_spirit_error_position.h \
  json/json_spirit_reader.h \
  json/json_spirit_reader_template.h \
  json/json_spirit_stream_reader.h \
  json/json_spirit_utils.h \
  json/json_spirit_value.h \
  json/json_spirit_writer.h \
  json/json_spirit_writer_template.h
  
obj/build.h: FORCE
	@$(MKDIR_P) $(builddir)/obj
	@$(top_srcdir)/share/genbuild.sh $(abs_top_builddir)/src/obj/build.h \
	  $(abs_top_srcdir)
libxelonmusk_util_a-clientversion.$(OBJEXT): obj/build.h

# server: shared between xelonmuskd and xelonmusk-qt
libxelonmusk_server_a_CPPFLAGS = $(XELONMUSK_INCLUDES) $(MINIUPNPC_CPPFLAGS)
libxelonmusk_server_a_SOURCES = \
  addrman.cpp \
  alert.cpp \
  bloom.cpp \
  chain.cpp \
  checkpoints.cpp \
  init.cpp \
  leveldbwrapper.cpp \
  main.cpp \
  merkleblock.cpp \
  miner.cpp \
  net.cpp \
  noui.cpp \
  pow.cpp \
  rest.cpp \
  rpcblockchain.cpp \
  rpcmining.cpp \
  rpcmisc.cpp \
  rpcnet.cpp \
  rpcrawtransaction.cpp \
  rpcserver.cpp \
  script/sigcache.cpp \
  timedata.cpp \
  txdb.cpp \
  txmempool.cpp \
  $(JSON_H) \
  $(XELONMUSK_CORE_H)

# wallet: shared between xelonmuskd and xelonmusk-qt, but only linked
# when wallet enabled
libxelonmusk_wallet_a_CPPFLAGS = $(XELONMUSK_INCLUDES)
libxelonmusk_wallet_a_SOURCES = \
  db.cpp \
  crypter.cpp \
  rpcdump.cpp \
  rpcwallet.cpp \
  wallet.cpp \
  wallet_ismine.cpp \
  walletdb.cpp \
  $(XELONMUSK_CORE_H)

# crypto primitives library
crypto_libxelonmusk_crypto_a_CPPFLAGS = $(XELONMUSK_CONFIG_INCLUDES) $(KECCAK_INCLUDES)
crypto_libxelonmusk_crypto_a_SOURCES = \
  crypto/sha1.cpp \
  crypto/sha256.cpp \
  crypto/sha512.cpp \
  crypto/hmac_sha256.cpp \
  crypto/rfc6979_hmac_sha256.cpp \
  crypto/hmac_sha512.cpp \
  crypto/ripemd160.cpp \
  crypto/common.h \
  crypto/sha256.h \
  crypto/sha512.h \
  crypto/hmac_sha256.h \
  crypto/rfc6979_hmac_sha256.h \
  crypto/hmac_sha512.h \
  crypto/sha1.h \
  crypto/scrypt.h \
  crypto/scrypt.cpp \
  crypto/keccak256.h \
  crypto/keccak256.cpp \
  crypto/ripemd160.h

# univalue JSON library
univalue_libxelonmusk_univalue_a_SOURCES = \
  univalue/univalue.cpp \
  univalue/univalue_read.cpp \
  univalue/univalue_write.cpp \
  univalue/univalue_escapes.h \
  univalue/univalue.h

# common: shared between xelonmuskd, and xelonmusk-qt and non-server tools
libxelonmusk_common_a_CPPFLAGS = $(XELONMUSK_INCLUDES)
libxelonmusk_common_a_SOURCES = \
  allocators.cpp \
  arith_uint256.cpp \
  amount.cpp \
  base58.cpp \
  chainparams.cpp \
  coins.cpp \
  compressor.cpp \
  primitives/block.cpp \
  primitives/transaction.cpp \
  core_read.cpp \
  core_write.cpp \
  eccryptoverify.cpp \
  ecwrapper.cpp \
  hash.cpp \
  key.cpp \
  keystore.cpp \
  netbase.cpp \
  protocol.cpp \
  pubkey.cpp \
  script/interpreter.cpp \
  script/script.cpp \
  script/sign.cpp \
  script/standard.cpp \
  script/script_error.cpp \
  $(XELONMUSK_CORE_H)

# util: shared between all executables.
# This library *must* be included to make sure that the glibc
# backward-compatibility objects and their sanity checks are linked.
libxelonmusk_util_a_CPPFLAGS = $(XELONMUSK_INCLUDES)
libxelonmusk_util_a_SOURCES = \
  chainparamsbase.cpp \
  clientversion.cpp \
  compat/glibc_sanity.cpp \
  compat/glibcxx_sanity.cpp \
  compat/strnlen.cpp \
  random.cpp \
  rpcprotocol.cpp \
  sync.cpp \
  uint256.cpp \
  util.cpp \
  utilmoneystr.cpp \
  utilstrencodings.cpp \
  utiltime.cpp \
  $(XELONMUSK_CORE_H)

if GLIBC_BACK_COMPAT
libxelonmusk_util_a_SOURCES += compat/glibc_compat.cpp
libxelonmusk_util_a_SOURCES += compat/glibcxx_compat.cpp
endif

# cli: shared between xelonmusk-cli and xelonmusk-qt
libxelonmusk_cli_a_CPPFLAGS = $(XELONMUSK_INCLUDES)
libxelonmusk_cli_a_SOURCES = \
  rpcclient.cpp \
  $(XELONMUSK_CORE_H)

nodist_libxelonmusk_util_a_SOURCES = $(srcdir)/obj/build.h
#

# xelonmuskd binary #
xelonmuskd_LDADD = \
  $(LIBXELONMUSK_SERVER) \
  $(LIBXELONMUSK_COMMON) \
  $(LIBXELONMUSK_UNIVALUE) \
  $(LIBXELONMUSK_UTIL) \
  $(LIBXELONMUSK_CRYPTO) \
  $(LIBLEVELDB) \
  $(LIBMEMENV) \
  $(LIBSECP256K1)

if ENABLE_WALLET
xelonmuskd_LDADD += libxelonmusk_wallet.a
endif
xelonmuskd_SOURCES = xelonmuskd.cpp
#

if TARGET_WINDOWS
xelonmuskd_SOURCES += xelonmuskd-res.rc
endif

xelonmuskd_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(MINIUPNPC_LIBS)
xelonmuskd_CPPFLAGS = $(XELONMUSK_INCLUDES)
xelonmuskd_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

# xelonmusk-cli binary #
xelonmusk_cli_LDADD = \
  $(LIBXELONMUSK_CLI) \
  $(LIBXELONMUSK_UTIL) \
  $(BOOST_LIBS) \
  $(SSL_LIBS) \
  $(CRYPTO_LIBS)

xelonmusk_cli_SOURCES = \
  xelonmusk-cli.cpp

xelonmusk_cli_CPPFLAGS = $(XELONMUSK_INCLUDES)
#

# xelonmusk-tx binary #
xelonmusk_tx_LDADD = \
  $(LIBXELONMUSK_UNIVALUE) \
  $(LIBXELONMUSK_COMMON) \
  $(LIBXELONMUSK_UTIL) \
  $(LIBXELONMUSK_CRYPTO) \
  $(LIBSECP256K1) \
  $(BOOST_LIBS) \
  $(CRYPTO_LIBS)

xelonmusk_tx_SOURCES = xelonmusk-tx.cpp
xelonmusk_tx_CPPFLAGS = $(XELONMUSK_INCLUDES)
#
xelonmusk_tx_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
xelonmusk_cli_SOURCES += xelonmusk-cli-res.rc
endif
xelonmusk_cli_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if BUILD_XELONMUSK_LIBS
include_HEADERS = script/xelonmuskconsensus.h
libxelonmuskconsensus_la_SOURCES = \
  crypto/hmac_sha512.cpp \
  crypto/ripemd160.cpp \
  crypto/sha1.cpp \
  crypto/sha256.cpp \
  crypto/sha512.cpp \
  crypto/scrypt.cpp \
  crypto/keccak256.cpp \
  eccryptoverify.cpp \
  ecwrapper.cpp \
  hash.cpp \
  primitives/transaction.cpp \
  pubkey.cpp \
  script/xelonmuskconsensus.cpp \
  script/interpreter.cpp \
  script/script.cpp \
  uint256.cpp \
  utilstrencodings.cpp

if GLIBC_BACK_COMPAT
  libxelonmuskconsensus_la_SOURCES += compat/glibc_compat.cpp
  libxelonmuskconsensus_la_SOURCES += compat/glibcxx_compat.cpp
endif

libxelonmuskconsensus_la_LDFLAGS = -no-undefined $(RELDFLAGS)
libxelonmuskconsensus_la_LIBADD = $(CRYPTO_LIBS)
libxelonmuskconsensus_la_CPPFLAGS = $(CRYPTO_CFLAGS) -I$(builddir)/obj -DBUILD_XELONMUSK_INTERNAL
if USE_LIBSECP256K1
libxelonmuskconsensus_la_LIBADD += secp256k1/libsecp256k1.la
endif
endif

CLEANFILES = leveldb/libleveldb.a leveldb/libmemenv.a *.gcda *.gcno

DISTCLEANFILES = obj/build.h

EXTRA_DIST = leveldb

clean-local:
	-$(MAKE) -C leveldb clean
	-$(MAKE) -C secp256k1 clean
	rm -f leveldb/*/*.gcno leveldb/helpers/memenv/*.gcno
	-rm -f config.h

.rc.o:
	@test -f $(WINDRES)
	$(AM_V_GEN) $(WINDRES) -DWINDRES_PREPROC -i $< -o $@

.mm.o:
	$(AM_V_CXX) $(OBJCXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) \
	  $(CPPFLAGS) $(AM_CXXFLAGS) $(QT_INCLUDES) $(CXXFLAGS)  -c -o $@ $<

%.pb.cc %.pb.h: %.proto
	@test -f $(PROTOC)
	$(AM_V_GEN) $(PROTOC) --cpp_out=$(@D) --proto_path=$(abspath $(<D) $<)

if ENABLE_TESTS
include Makefile.test.include
endif

if ENABLE_QT
include Makefile.qt.include
endif

if ENABLE_QT_TESTS
include Makefile.qttest.include
endif

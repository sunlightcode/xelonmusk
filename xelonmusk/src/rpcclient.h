// Copyright (c) 2010 Javen Wang
// Copyright (c) 2020-2021 The XElonMusk Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef XELONMUSK_RPCCLIENT_H
#define XELONMUSK_RPCCLIENT_H

#include "json/json_spirit_reader_template.h"
#include "json/json_spirit_utils.h"
#include "json/json_spirit_writer_template.h"

json_spirit::Array RPCConvertValues(const std::string& strMethod, const std::vector<std::string>& strParams);

#endif // XELONMUSK_RPCCLIENT_H

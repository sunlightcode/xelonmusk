// Copyright (c) 2020-2021 Javen Wang
// Copyright (c) 2009-2013 The XElonMusk Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef XELONMUSK_MINER_H
#define XELONMUSK_MINER_H

#include "primitives/block.h"

#include <stdint.h>

class CBlockIndex;
class CReserveKey;
class CScript;
class CWallet;

struct CBlockTemplate
{
    CBlock block;
    std::vector<CAmount> vTxFees;
    std::vector<int64_t> vTxSigOps;
};

/** Run the miner threads */
void GenerateXElonMusks(bool fGenerate, CWallet* pwallet, int nThreads);
/** Generate a new block, without valid proof-of-work */
CBlockTemplate* CreateNewBlock(const CScript& scriptPubKeyIn);
CBlockTemplate* CreateNewBlockWithKey(CReserveKey& reservekey);
/** Modify the extranonce in a block */
void IncrementExtraNonce(CBlock* pblock, CBlockIndex* pindexPrev, unsigned int& nExtraNonce);
void UpdateTime(CBlockHeader* block, const CBlockIndex* pindexPrev);

#endif // XELONMUSK_MINER_H

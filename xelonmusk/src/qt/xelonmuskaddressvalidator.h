// Copyright (c) 2011-2014 The XElonMusk Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef XELONMUSK_QT_XELONMUSKADDRESSVALIDATOR_H
#define XELONMUSK_QT_XELONMUSKADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class XElonMuskAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit XElonMuskAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** XElonMusk address widget validator, checks for a valid xelonmusk address.
 */
class XElonMuskAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit XElonMuskAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // XELONMUSK_QT_XELONMUSKADDRESSVALIDATOR_H

Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id E6727385E447
 for <cygwin-patches@cygwin.com>; Thu,  3 Jun 2021 20:57:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E6727385E447
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id A84BFCB51
 for <cygwin-patches@cygwin.com>; Thu,  3 Jun 2021 16:57:09 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 96DB4CB36
 for <cygwin-patches@cygwin.com>; Thu,  3 Jun 2021 16:57:09 -0400 (EDT)
Date: Thu, 3 Jun 2021 13:57:09 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: respect PC_SYM_FOLLOW and PC_SYM_NOFOLLOW_REP
 with inner links
In-Reply-To: <alpine.BSO.2.21.2106031321380.30039@resin.csoft.net>
Message-ID: <alpine.BSO.2.21.2106031355540.30039@resin.csoft.net>
References: <alpine.BSO.2.21.2105291322180.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105291600460.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105292259570.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105301213380.30039@resin.csoft.net>
 <YLSYIC/yYFz2IdMS@calimero.vinschen.de>
 <alpine.BSO.2.21.2106031321380.30039@resin.csoft.net>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="28213640167424-1930300939-1622753829=:30039"
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_LOW,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 03 Jun 2021 20:57:11 -0000

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--28213640167424-1930300939-1622753829=:30039
Content-Type: text/plain; charset=US-ASCII

On Thu, 3 Jun 2021, Jeremy Drake via Cygwin-patches wrote:

> Just updated for formatting.

Oops, forgot to edit the email address on patch 2.  Resending with that
fixed.
--28213640167424-1930300939-1622753829=:30039
Content-Type: text/plain; charset=US-ASCII; name=0001-Revert-Cygwin-Handle-virtual-drives-as-non-symlinks.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSO.2.21.2106031357090.30039@resin.csoft.net>
Content-Description: 
Content-Disposition: attachment; filename=0001-Revert-Cygwin-Handle-virtual-drives-as-non-symlinks.patch

RnJvbSA0YmI5NTliNTc2MDY0NjVkNWE3YWJlN2QzYWUxNjhkYjY2ZjVmNmZh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSmVyZW15IERyYWtl
IDxjeWd3aW5AamRyYWtlLmNvbT4NCkRhdGU6IFNhdCwgMjkgTWF5IDIwMjEg
MTM6MTc6MDggLTA3MDANClN1YmplY3Q6IFtQQVRDSCAxLzJdIFJldmVydCAi
Q3lnd2luOiBIYW5kbGUgdmlydHVhbCBkcml2ZXMgYXMgbm9uLXN5bWxpbmtz
Ig0KDQpUaGlzIHJldmVydHMgY29tbWl0IGM4OTQ5ZDA0MDAxZTNkYmMwMzY1
MTQ3NWI2Y2QxYzU2MjM0MDA4MzUuDQotLS0NCiB3aW5zdXAvY3lnd2luL3Bh
dGguY2MgfCA5ICsrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS93aW5z
dXAvY3lnd2luL3BhdGguY2MgYi93aW5zdXAvY3lnd2luL3BhdGguY2MNCmlu
ZGV4IDZhMDdmMGQwNi4uZTYyZjhmZTJiIDEwMDY0NA0KLS0tIGEvd2luc3Vw
L2N5Z3dpbi9wYXRoLmNjDQorKysgYi93aW5zdXAvY3lnd2luL3BhdGguY2MN
CkBAIC0zNTA1LDkgKzM1MDUsMTQgQEAgcmVzdGFydDoNCiANCiAJCSAgICAg
c3Vic3QgWDogQzpcZm9vXGJhcg0KIA0KLQkJICAgVHJlYXQgaXQgYXMgYSBu
b3JtYWwgZmlsZS4gKi8NCisJCSAgIFRyZWF0IGl0IGxpa2UgYSBzeW1saW5r
LiAgVGhpcyBpcyByZXF1aXJlZCB0byB0ZWxsIGFuDQorCQkgICBsc3RhdCBj
YWxsZXIgdGhhdCB0aGUgImRyaXZlIiBpcyBhY3R1YWxseSBwb2ludGluZw0K
KwkJICAgc29tZXdoZXJlIGVsc2UsIHRodXMsIGl0J3MgYSBzeW1saW5rIGlu
IFBPU0lYIHNwZWFrLiAqLw0KIAkJaWYgKHVwYXRoLkxlbmd0aCA9PSAxNCkJ
LyogXD8/XFg6XCAqLw0KLQkJICBnb3RvIGZpbGVfbm90X3N5bWxpbms7DQor
CQkgIHsNCisJCSAgICBmaWxlYXR0ciAmPSB+RklMRV9BVFRSSUJVVEVfRElS
RUNUT1JZOw0KKwkJICAgIHBhdGhfZmxhZ3MgfD0gUEFUSF9TWU1MSU5LOw0K
KwkJICB9DQogCQkvKiBGb3IgZmluYWwgcGF0aHMgZGlmZmVyaW5nIGluIGlu
bmVyIHBhdGggY29tcG9uZW50cyByZXR1cm4NCiAJCSAgIGxlbmd0aCBhcyBu
ZWdhdGl2ZSB2YWx1ZS4gIFRoaXMgaW5mb3JtcyBwYXRoX2NvbnY6OmNoZWNr
DQogCQkgICB0byBza2lwIHJlYWxwYXRoIGhhbmRsaW5nIG9uIHRoZSBsYXN0
IHBhdGggY29tcG9uZW50LiAqLw0KLS0gDQoyLjMxLjEud2luZG93cy4xDQoN
Cg==

--28213640167424-1930300939-1622753829=:30039
Content-Type: text/plain; charset=US-ASCII; name=0002-Cygwin-respect-PC_SYM_FOLLOW-and-PC_SYM_NOFOLLOW_REP.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSO.2.21.2106031357091.30039@resin.csoft.net>
Content-Description: 
Content-Disposition: attachment; filename=0002-Cygwin-respect-PC_SYM_FOLLOW-and-PC_SYM_NOFOLLOW_REP.patch

RnJvbSBlYTM2Y2NiMTNiMjA4MDY2MzUzNWQ4NjdlNmZlOGVkZjI0NmVmZTgz
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSmVyZW15IERyYWtl
IDxjeWd3aW5AamRyYWtlLmNvbT4NCkRhdGU6IFNhdCwgMjkgTWF5IDIwMjEg
MTE6NDg6MTEgLTA3MDANClN1YmplY3Q6IFtQQVRDSCAyLzJdIEN5Z3dpbjog
cmVzcGVjdCBQQ19TWU1fRk9MTE9XIGFuZCBQQ19TWU1fTk9GT0xMT1dfUkVQ
DQogd2l0aCBpbm5lciBsaW5rcy4NCg0KVGhlIG5ldyBHZXRGaW5hbFBhdGhO
YW1lVyBoYW5kbGluZyBmb3IgbmF0aXZlIHN5bWxpbmtzIGluIGlubmVyIHBh
dGgNCmNvbXBvbmVudHMgaXMgZGlzYWJsZWQgaWYgY2FsbGVyIGRvZXNuJ3Qg
d2FudCB0byBmb2xsb3cgc3ltbGlua3MsIG9yDQpkb2Vzbid0IHdhbnQgdG8g
Zm9sbG93IHJlcGFyc2UgcG9pbnRzLiAgU2V0IGZsYWcgdG8gbm90IGZvbGxv
dyByZXBhcnNlDQpwb2ludHMgaW4gY2hkaXIsIGFsbG93aW5nIG5hdGl2ZSBw
cm9jZXNzZXMgdG8gc2VlIHRoZWlyIGN3ZCBwb3RlbnRpYWxseQ0KaW5jbHVk
aW5nIG5hdGl2ZSBzeW1saW5rcywgcmF0aGVyIHRoYW4gZGVyZWZlcmVuY2lu
ZyB0aGVtLg0KLS0tDQogd2luc3VwL2N5Z3dpbi9wYXRoLmNjIHwgMTEgKysr
KysrKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9w
YXRoLmNjIGIvd2luc3VwL2N5Z3dpbi9wYXRoLmNjDQppbmRleCBlNjJmOGZl
MmIuLmE2YmIzYWVmZiAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vcGF0
aC5jYw0KKysrIGIvd2luc3VwL2N5Z3dpbi9wYXRoLmNjDQpAQCAtNzIyLDkg
KzcyMiwxMCBAQCBwYXRoX2NvbnY6OmNoZWNrIChjb25zdCBjaGFyICpzcmMs
IHVuc2lnbmVkIG9wdCwNCiAJICBpbnQgc3ltbGVuID0gMDsNCiANCiAJICAv
KiBNYWtlIHN1cmUgdG8gY2hlY2sgY2VydGFpbiBmbGFncyBvbiBsYXN0IGNv
bXBvbmVudCBvbmx5LiAqLw0KLQkgIGZvciAodW5zaWduZWQgcGNfZmxhZ3Mg
PSBvcHQgJiAoUENfTk9fQUNDRVNTX0NIRUNLIHwgUENfS0VFUF9IQU5ETEUp
Ow0KKwkgIGZvciAodW5zaWduZWQgcGNfZmxhZ3MgPSBvcHQgJiAoUENfTk9f
QUNDRVNTX0NIRUNLIHwgUENfS0VFUF9IQU5ETEUNCisJCQkJCSB8IFBDX1NZ
TV9GT0xMT1cgfCBQQ19TWU1fTk9GT0xMT1dfUkVQKTsNCiAJICAgICAgIDsN
Ci0JICAgICAgIHBjX2ZsYWdzID0gMCkNCisJICAgICAgIHBjX2ZsYWdzID0g
b3B0ICYgKFBDX1NZTV9GT0xMT1cgfCBQQ19TWU1fTk9GT0xMT1dfUkVQKSkN
CiAJICAgIHsNCiAJICAgICAgY29uc3Qgc3VmZml4X2luZm8gKnN1ZmY7DQog
CSAgICAgIGNoYXIgKmZ1bGxfcGF0aDsNCkBAIC0zNDUyLDYgKzM0NTMsOCBA
QCByZXN0YXJ0Og0KIAkgICAgYnJlYWs7DQogCX0NCiANCisgICAgICBpZiAo
KHBjX2ZsYWdzICYgKFBDX1NZTV9GT0xMT1cgfCBQQ19TWU1fTk9GT0xMT1df
UkVQKSkgPT0gUENfU1lNX0ZPTExPVykNCisgICAgICB7DQogICAgICAgLyog
Q2hlY2sgaWYgdGhlIGlubmVyIHBhdGggY29tcG9uZW50cyBjb250YWluIG5h
dGl2ZSBzeW1saW5rcyBvcg0KIAkganVuY3Rpb25zLCBvciBpZiB0aGUgZHJp
dmUgaXMgYSB2aXJ0dWFsIGRyaXZlLiAgQ29tcGFyZSBpbmNvbWluZw0KIAkg
cGF0aCB3aXRoIHBhdGggcmV0dXJuZWQgYnkgR2V0RmluYWxQYXRoTmFtZUJ5
SGFuZGxlQS4gIElmIHRoZXkNCkBAIC0zNTIyLDYgKzM1MjUsNyBAQCByZXN0
YXJ0Og0KIAkgICAgICB9DQogCSAgfQ0KICAgICAgIH0NCisgICAgICB9DQog
DQogICAgIC8qIE5vcm1hbCBmaWxlLiAqLw0KICAgICBmaWxlX25vdF9zeW1s
aW5rOg0KQEAgLTM3MDQsNyArMzcwOCw4IEBAIGNoZGlyIChjb25zdCBjaGFy
ICppbl9kaXIpDQogDQogICAgICAgLyogQ29udmVydCBwYXRoLiAgUENfTk9O
VUxMRU1QVFkgZW5zdXJlcyB0aGF0IHdlIGRvbid0IGNoZWNrIGZvcg0KIAkg
TlVMTC9lbXB0eS9pbnZhbGlkIGFnYWluLiAqLw0KLSAgICAgIHBhdGhfY29u
diBwYXRoIChpbl9kaXIsIFBDX1NZTV9GT0xMT1cgfCBQQ19QT1NJWCB8IFBD
X05PTlVMTEVNUFRZKTsNCisgICAgICBwYXRoX2NvbnYgcGF0aCAoaW5fZGly
LCBQQ19TWU1fRk9MTE9XIHwgUENfUE9TSVggfCBQQ19OT05VTExFTVBUWQ0K
KwkJCSAgICAgIHwgUENfU1lNX05PRk9MTE9XX1JFUCk7DQogICAgICAgaWYg
KHBhdGguZXJyb3IpDQogCXsNCiAJICBzZXRfZXJybm8gKHBhdGguZXJyb3Ip
Ow0KLS0gDQoyLjMxLjEud2luZG93cy4xDQoNCg==

--28213640167424-1930300939-1622753829=:30039--

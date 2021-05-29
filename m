Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 07495385802D
 for <cygwin-patches@cygwin.com>; Sat, 29 May 2021 20:35:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 07495385802D
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 8413CCB51
 for <cygwin-patches@cygwin.com>; Sat, 29 May 2021 16:35:00 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 7EED4CB50
 for <cygwin-patches@cygwin.com>; Sat, 29 May 2021 16:35:00 -0400 (EDT)
Date: Sat, 29 May 2021 13:34:59 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: tweak handling of native symlinks from chdir
Message-ID: <alpine.BSO.2.21.2105291322180.30039@resin.csoft.net>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="28213640167424-165291235-1622320500=:30039"
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sat, 29 May 2021 20:35:03 -0000

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--28213640167424-165291235-1622320500=:30039
Content-Type: text/plain; charset=US-ASCII

First, revert the handling of virtual drives as non-symlinks.  This is no
longer necessary.

Then, change the handling that really matters for my situation:

The new GetFinalPathNameW handling for native symlinks in inner path
components is disabled in chdir, allowing native processes to see their
cwd potentially including native symlinks, rather than dereferencing
them.

This seems to work for virtual drives being the CWD for native proceses,
both for the root and subdirectories.

Thoughts?
--28213640167424-165291235-1622320500=:30039
Content-Type: text/plain; charset=US-ASCII; name=0002-Cygwin-tweak-handling-of-native-symlinks-from-chdir.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSO.2.21.2105291334580.30039@resin.csoft.net>
Content-Description: 
Content-Disposition: attachment; filename=0002-Cygwin-tweak-handling-of-native-symlinks-from-chdir.patch

RnJvbSAzNTJkZTM5YzM0NzRmZGI3MzU3MDEyMTgyMGI0OTNiZDgxYTczYmI1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSmVyZW15IERyYWtl
IDxjeWd3aW5AamRyYWtlLmNvbT4NCkRhdGU6IFNhdCwgMjkgTWF5IDIwMjEg
MTE6NDg6MTEgLTA3MDANClN1YmplY3Q6IFtQQVRDSCAyLzJdIEN5Z3dpbjog
dHdlYWsgaGFuZGxpbmcgb2YgbmF0aXZlIHN5bWxpbmtzIGZyb20gY2hkaXIN
Cg0KVGhlIG5ldyBHZXRGaW5hbFBhdGhOYW1lVyBoYW5kbGluZyBmb3IgbmF0
aXZlIHN5bWxpbmtzIGluIGlubmVyIHBhdGgNCmNvbXBvbmVudHMgaXMgZGlz
YWJsZWQgaW4gY2hkaXIsIGFsbG93aW5nIG5hdGl2ZSBwcm9jZXNzZXMgdG8g
c2VlIHRoZWlyDQpjd2QgcG90ZW50aWFsbHkgaW5jbHVkaW5nIG5hdGl2ZSBz
eW1saW5rcywgcmF0aGVyIHRoYW4gZGVyZWZlcmVuY2luZw0KdGhlbS4NCi0t
LQ0KIHdpbnN1cC9jeWd3aW4vcGF0aC5jYyB8IDUgKysrLS0NCiB3aW5zdXAv
Y3lnd2luL3BhdGguaCAgfCAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3dp
bnN1cC9jeWd3aW4vcGF0aC5jYyBiL3dpbnN1cC9jeWd3aW4vcGF0aC5jYw0K
aW5kZXggZTYyZjhmZTJiLi4xMzA5MjZjYmMgMTAwNjQ0DQotLS0gYS93aW5z
dXAvY3lnd2luL3BhdGguY2MNCisrKyBiL3dpbnN1cC9jeWd3aW4vcGF0aC5j
Yw0KQEAgLTc1MSw3ICs3NTEsNyBAQCBwYXRoX2NvbnY6OmNoZWNrIChjb25z
dCBjaGFyICpzcmMsIHVuc2lnbmVkIG9wdCwNCiAJICAgICAgaWYgKGVycm9y
KQ0KIAkJcmV0dXJuOw0KIA0KLQkgICAgICBzeW0ucGNfZmxhZ3MgPSBwY19m
bGFnczsNCisJICAgICAgc3ltLnBjX2ZsYWdzID0gcGNfZmxhZ3MgfCAob3B0
ICYgUENfTk9fTkFUSVZFX1NZTV9JTk5FUik7DQogDQogCSAgICAgIGlmICgh
ZGV2LmV4aXN0cyAoKSkNCiAJCXsNCkBAIC0zNDgwLDYgKzM0ODAsNyBAQCBy
ZXN0YXJ0Og0KIAkgICAgZ290byBmaWxlX25vdF9zeW1saW5rOw0KIAl9DQog
I2VuZGlmIC8qIF9faTM4Nl9fICovDQorICAgICAgaWYgKCEocGNfZmxhZ3Mg
JiBQQ19OT19OQVRJVkVfU1lNX0lOTkVSKSkNCiAgICAgICB7DQogCVBXQ0hB
UiBmcGJ1ZiA9IHRwLndfZ2V0ICgpOw0KIAlEV09SRCByZXQ7DQpAQCAtMzcw
NCw3ICszNzA1LDcgQEAgY2hkaXIgKGNvbnN0IGNoYXIgKmluX2RpcikNCiAN
CiAgICAgICAvKiBDb252ZXJ0IHBhdGguICBQQ19OT05VTExFTVBUWSBlbnN1
cmVzIHRoYXQgd2UgZG9uJ3QgY2hlY2sgZm9yDQogCSBOVUxML2VtcHR5L2lu
dmFsaWQgYWdhaW4uICovDQotICAgICAgcGF0aF9jb252IHBhdGggKGluX2Rp
ciwgUENfU1lNX0ZPTExPVyB8IFBDX1BPU0lYIHwgUENfTk9OVUxMRU1QVFkp
Ow0KKyAgICAgIHBhdGhfY29udiBwYXRoIChpbl9kaXIsIFBDX1NZTV9GT0xM
T1cgfCBQQ19QT1NJWCB8IFBDX05PTlVMTEVNUFRZIHwgUENfTk9fTkFUSVZF
X1NZTV9JTk5FUik7DQogICAgICAgaWYgKHBhdGguZXJyb3IpDQogCXsNCiAJ
ICBzZXRfZXJybm8gKHBhdGguZXJyb3IpOw0KZGlmZiAtLWdpdCBhL3dpbnN1
cC9jeWd3aW4vcGF0aC5oIGIvd2luc3VwL2N5Z3dpbi9wYXRoLmgNCmluZGV4
IGFkYjBjYTExZi4uZDNiMTRhNDBjIDEwMDY0NA0KLS0tIGEvd2luc3VwL2N5
Z3dpbi9wYXRoLmgNCisrKyBiL3dpbnN1cC9jeWd3aW4vcGF0aC5oDQpAQCAt
NTksNiArNTksNyBAQCBlbnVtIHBhdGhjb252X2FyZw0KICAgUENfS0VFUF9I
QU5ETEUJID0gX0JJVCAoMTIpLAkvKiBrZWVwIGhhbmRsZSBmb3IgbGF0ZXIg
c3RhdCBjYWxscyAqLw0KICAgUENfTk9fQUNDRVNTX0NIRUNLCSA9IF9CSVQg
KDEzKSwJLyogaGVscGVyIGZsYWcgZm9yIGVycm9yIGNoZWNrICovDQogICBQ
Q19TWU1fTk9GT0xMT1dfRElSCSA9IF9CSVQgKDE0KSwJLyogZG9uJ3QgZm9s
bG93IGEgdHJhaWxpbmcgc2xhc2ggKi8NCisgIFBDX05PX05BVElWRV9TWU1f
SU5ORVIgPSBfQklUICgxNSksCS8qIHNraXAgbmF0aXZlIHN5bWxpbmsgaW5u
ZXIgaGFuZGxpbmcgKi8NCiAgIFBDX0RPTlRfVVNFCQkgPSBfQklUICgzMSkJ
LyogY29udmVyc2lvbiB0byBzaWduZWQgaGFwcGVucy4gKi8NCiB9Ow0KIA0K
LS0gDQoyLjMxLjEud2luZG93cy4xDQoNCg==

--28213640167424-165291235-1622320500=:30039
Content-Type: text/plain; charset=US-ASCII; name=0001-Revert-Cygwin-Handle-virtual-drives-as-non-symlinks.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSO.2.21.2105291334590.30039@resin.csoft.net>
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

--28213640167424-165291235-1622320500=:30039--

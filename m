Return-Path: <cygwin-patches-return-5169-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24544 invoked by alias); 26 Nov 2004 20:25:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24509 invoked from network); 26 Nov 2004 20:25:19 -0000
Received: from unknown (HELO moutng.kundenserver.de) (212.227.126.171)
  by sourceware.org with SMTP; 26 Nov 2004 20:25:19 -0000
Received: from [212.227.126.179] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CXmec-0000oI-00
	for cygwin-patches@cygwin.com; Fri, 26 Nov 2004 21:25:18 +0100
Received: from [217.245.1.179] (helo=towo.net)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CXmec-00015U-00
	for cygwin-patches@cygwin.com; Fri, 26 Nov 2004 21:25:18 +0100
Received: by towo.net (sSMTP sendmail emulation); Fri, 26 Nov 2004 05:04:01 +0100
Date: Fri, 26 Nov 2004 20:25:00 -0000
To: cygwin-patches@cygwin.com
From: Thomas Wolff <towo@computer.org>
Subject: [Patch] bugs # 512 and 514 / cygwin console handling
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=%%message-boundary%%
Message-Id: <E1CXmec-00015U-00@mrelayng.kundenserver.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:1bd85ed25de6039e01e18a198cf341a2
X-SW-Source: 2004-q4/txt/msg00170.txt.bz2


--%%message-boundary%%
Content-Type: text/plain
Content-length: 538

Hello,
attached is a patch to fhandler_console.cc that fixes two bugs:
512 wrong mouse click position reports in cygwin terminal
514 cygwin terminal: wrong color handling in reverse display mode

After some initial problems :( I have been able to verify that 
this patch works. For # 514, there are actually two useful 
alternatives which I documented in the code and I included an #ifdef 
for them.

I'd appreciate if this patch is integrated into cygwin to 
accomodate interactive programs on the cygwin console.

Kind regards,
Thomas


--%%message-boundary%%
Content-Type: application/octet-stream; name="fhandler_console.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="fhandler_console.patch"
Content-length: 3624

LS0tIGN5Z3dpbi0xLjUuMTItMS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2Nv
bnNvbGUuY2Mub2xkCTIwMDQtMTAtMjggMTc6MzM6MDQuMDAwMDAwMDAwICsw
MjAwCisrKyBjeWd3aW4tMS41LjEyLTEvd2luc3VwL2N5Z3dpbi9maGFuZGxl
cl9jb25zb2xlLmNjCTIwMDQtMTEtMjYgMTY6MjQ6NTEuMDAwMDAwMDAwICsw
MTAwCkBAIC00MjIsMTAgKzQyMiwyNSBAQAogCSAgICAgIGlmIChtb3VzZV9l
dmVudC5kd0V2ZW50RmxhZ3MpCiAJCWNvbnRpbnVlOwogCi0JICAgICAgLyog
SWYgdGhlIG1vdXNlIGV2ZW50IG9jY3VycmVkIG91dCBvZiB0aGUgYXJlYSB3
ZSBjYW4gaGFuZGxlLAotCQkgaWdub3JlIGl0LiAqLworCSAgICAgIC8qIFJl
dHJpZXZlIHJlcG9ydGVkIG1vdXNlIHBvc2l0aW9uICovCiAJICAgICAgaW50
IHggPSBtb3VzZV9ldmVudC5kd01vdXNlUG9zaXRpb24uWDsKIAkgICAgICBp
bnQgeSA9IG1vdXNlX2V2ZW50LmR3TW91c2VQb3NpdGlvbi5ZOworCisJICAg
ICAgLyogQWRqdXN0IG1vdXNlIHBvc2l0aW9uIGJ5IHNjcm9sbCBidWZmZXIg
b2Zmc2V0ICovCisJICAgICAgQ09OU09MRV9TQ1JFRU5fQlVGRkVSX0lORk8g
bm93OworCSAgICAgIGlmIChHZXRDb25zb2xlU2NyZWVuQnVmZmVySW5mbyAo
Z2V0X291dHB1dF9oYW5kbGUgKCksICZub3cpKQorCQl7CisJCSAgeSAtPSBu
b3cuc3JXaW5kb3cuVG9wOworCQkgIHggLT0gbm93LnNyV2luZG93LkxlZnQ7
CisJCX0KKwkgICAgICBlbHNlCisJCXsKKwkJICBzeXNjYWxsX3ByaW50ZiAo
Im1vdXNlOiBjYW5ub3QgYWRqdXN0IHBvc2l0aW9uIGJ5IHNjcm9sbCBidWZm
ZXIgb2Zmc2V0Iik7CisJCSAgY29udGludWU7CisJCX0KKworCSAgICAgIC8q
IElmIHRoZSBtb3VzZSBldmVudCBvY2N1cnJlZCBvdXQgb2YgdGhlIGFyZWEg
d2UgY2FuIGhhbmRsZSwKKwkJIGlnbm9yZSBpdC4gKi8KIAkgICAgICBpZiAo
KHggKyAnICcgKyAxID4gMHhGRikgfHwgKHkgKyAnICcgKyAxID4gMHhGRikp
CiAJCXsKIAkJICBzeXNjYWxsX3ByaW50ZiAoIm1vdXNlOiBwb3NpdGlvbiBv
dXQgb2YgcmFuZ2UiKTsKQEAgLTkyMSwxNCArOTM2LDMyIEBACiAgIGlmIChk
ZXZfc3RhdGUtPnJldmVyc2UpCiAgICAgewogICAgICAgV09SRCBzYXZlX2Zn
ID0gd2luX2ZnOworI2RlZmluZSByZXZlcnNlX2JyaWdodAorI2lmZGVmIHJl
dmVyc2VfYnJpZ2h0CisgICAgICAvKiBUaGlzIHdheSwgYSBicmlnaHQgZm9y
ZWdyb3VuZCB3aWxsIHJldmVyc2UgdG8gYSBicmlnaHQgYmFja2dyb3VuZC4K
KyAgICAgICAqLworICAgICAgd2luX2ZnID0gKHdpbl9iZyAmIEJBQ0tHUk9V
TkRfUkVEICAgPyBGT1JFR1JPVU5EX1JFRCAgIDogMCkgfAorCSAgICAgICAo
d2luX2JnICYgQkFDS0dST1VORF9HUkVFTiA/IEZPUkVHUk9VTkRfR1JFRU4g
OiAwKSB8CisJICAgICAgICh3aW5fYmcgJiBCQUNLR1JPVU5EX0JMVUUgID8g
Rk9SRUdST1VORF9CTFVFICA6IDApIHwKKwkgICAgICAgKHdpbl9iZyAmIEJB
Q0tHUk9VTkRfSU5URU5TSVRZID8gRk9SRUdST1VORF9JTlRFTlNJVFkgOiAw
KTsKKyAgICAgIHdpbl9iZyA9IChzYXZlX2ZnICYgRk9SRUdST1VORF9SRUQg
ICA/IEJBQ0tHUk9VTkRfUkVEICAgOiAwKSB8CisJICAgICAgIChzYXZlX2Zn
ICYgRk9SRUdST1VORF9HUkVFTiA/IEJBQ0tHUk9VTkRfR1JFRU4gOiAwKSB8
CisJICAgICAgIChzYXZlX2ZnICYgRk9SRUdST1VORF9CTFVFICA/IEJBQ0tH
Uk9VTkRfQkxVRSAgOiAwKSB8CisJICAgICAgIChzYXZlX2ZnICYgRk9SRUdS
T1VORF9JTlRFTlNJVFkgPyBCQUNLR1JPVU5EX0lOVEVOU0lUWSA6IDApOwor
I2Vsc2UKKyAgICAgIC8qIFRoaXMgd2F5LCBhIGJyaWdodCBmb3JlZ3JvdW5k
IHdpbGwgcmV2ZXJzZSB0byBhIGRpbSBiYWNrZ3JvdW5kLgorICAgICAgICAg
QnV0IHRoZSBiYWNrZ3JvdW5kIHdpbGwgbm8gbG9uZ2VyIHJldmVyc2UgdG8g
YSBicmlnaHQgZm9yZWdyb3VuZCAKKyAgICAgICAgICh3aGljaCB1c2VkIHRv
IHJlbmRlciByZXZlcnNlIG91dHB1dCB1bnJlYWRhYmxlKS4KKyAgICAgICAq
LwogICAgICAgd2luX2ZnID0gKHdpbl9iZyAmIEJBQ0tHUk9VTkRfUkVEICAg
PyBGT1JFR1JPVU5EX1JFRCAgIDogMCkgfAogCSAgICAgICAod2luX2JnICYg
QkFDS0dST1VORF9HUkVFTiA/IEZPUkVHUk9VTkRfR1JFRU4gOiAwKSB8CiAJ
ICAgICAgICh3aW5fYmcgJiBCQUNLR1JPVU5EX0JMVUUgID8gRk9SRUdST1VO
RF9CTFVFICA6IDApIHwKLQkgICAgICAgKHdpbl9mZyAmIEZPUkVHUk9VTkRf
SU5URU5TSVRZKTsKKwkgICAgICAgKHdpbl9iZyAmIEZPUkVHUk9VTkRfSU5U
RU5TSVRZKTsKICAgICAgIHdpbl9iZyA9IChzYXZlX2ZnICYgRk9SRUdST1VO
RF9SRUQgICA/IEJBQ0tHUk9VTkRfUkVEICAgOiAwKSB8CiAJICAgICAgIChz
YXZlX2ZnICYgRk9SRUdST1VORF9HUkVFTiA/IEJBQ0tHUk9VTkRfR1JFRU4g
OiAwKSB8CiAJICAgICAgIChzYXZlX2ZnICYgRk9SRUdST1VORF9CTFVFICA/
IEJBQ0tHUk9VTkRfQkxVRSAgOiAwKSB8Ci0JICAgICAgICh3aW5fYmcgJiBC
QUNLR1JPVU5EX0lOVEVOU0lUWSk7CisJICAgICAgIChzYXZlX2ZnICYgQkFD
S0dST1VORF9JTlRFTlNJVFkpOworI2VuZGlmCiAgICAgfQogICBpZiAoZGV2
X3N0YXRlLT51bmRlcmxpbmUpCiAgICAgd2luX2ZnID0gZGV2X3N0YXRlLT51
bmRlcmxpbmVfY29sb3I7Cg==

--%%message-boundary%%--

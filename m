Return-Path: <cygwin-patches-return-7529-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 532 invoked by alias); 13 Oct 2011 14:20:57 -0000
Received: (qmail 521 invoked by uid 22791); 13 Oct 2011 14:20:56 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from out5.smtp.messagingengine.com (HELO out5.smtp.messagingengine.com) (66.111.4.29)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 13 Oct 2011 14:20:39 +0000
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B8BA321DC3	for <cygwin-patches@cygwin.com>; Thu, 13 Oct 2011 10:20:38 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])  by compute1.internal (MEProxy); Thu, 13 Oct 2011 10:20:38 -0400
Received: from [192.168.1.3] (50-88-210-98.res.bhn.net [50.88.210.98])	by mail.messagingengine.com (Postfix) with ESMTPSA id 5BB6A404303;	Thu, 13 Oct 2011 10:20:38 -0400 (EDT)
Message-ID: <4E96F392.9030605@cwilson.fastmail.fm>
Date: Thu, 13 Oct 2011 14:20:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Add cygwin_internal CW_GET_MODULE_PATH_FOR_ADDR
Content-Type: multipart/mixed; boundary="------------080807070900010402090804"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00019.txt.bz2

This is a multi-part message in MIME format.
--------------080807070900010402090804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1347

From discussions with Bruno Haible about the slowness of full relocation
support in libintl and libiconv, he said:

>   - The Cygwin API only allows me to get _all_ file names behind all
>     addresses across the entire current process, and this is slow.

(talking about parsing /proc/self/maps)

>   - It would be useful to have a Cygwin API that gives me the file
>     file name behind one particular address in the current process.
>     This should not be that slow.

This patch is a proof of concept for the latter.  Naturally, it needs
additional work -- updating version.h, real changelog entries,
documentation somewhere, etc.  But...is it worth the effort?  Is
something like this likely to be accepted?

I've also attached a test program.  To compile it (using g++), you need
to ensure that the updated sys/cygwin.h is in the search path.  It
prints the contents of /proc/self/maps, and then you can type any (hex)
memory address and it should report the func's return value, and the
correct path to the associated module.  CTRL-D to exit.

61000020
0x61000020 (0) /usr/bin/cygwin1.dll
00020000
0x00020000 (1)

The call signature is:

	unsigned long
	cygwin_internal (CW_GET_MODULE_PATH_FOR_ADDR,
                         uintptr_t addr,
                         PWCHAR    buf,
                         size_t    buflen);

--
Chuck



--------------080807070900010402090804
Content-Type: application/x-patch;
 name="cygwin-internal-new-fnc.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cygwin-internal-new-fnc.patch"
Content-length: 7878

SW5kZXg6IGV4dGVybmFsLmNjCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2V4dGVybmFsLmNj
LHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjEyNApkaWZmIC11IC1wIC1yMS4x
MjQgZXh0ZXJuYWwuY2MKLS0tIGV4dGVybmFsLmNjCTUgT2N0IDIwMTEgMTI6
Mjc6MzYgLTAwMDAJMS4xMjQKKysrIGV4dGVybmFsLmNjCTEzIE9jdCAyMDEx
IDA2OjUwOjQzIC0wMDAwCkBAIC0xOTcsNiArMTk3LDkgQEAgZXhpdF9wcm9j
ZXNzIChVSU5UIHN0YXR1cywgYm9vbCB1c2VUZXJtaQogICBFeGl0UHJvY2Vz
cyAoc3RhdHVzKTsKIH0KIAorLyogRGVmaW5lZCBpbiBmaGFuZGxlcl9wcm9j
ZXNzLmNjICovCitleHRlcm4gaW50CitnZXRfbW9kdWxlX3BhdGhfZm9yX2Fk
ZHIgKHVpbnRwdHJfdCBhZGRyLCBQV0NIQVIgZGVzdCwgc2l6ZV90IGRsZW4p
OwogCiBleHRlcm4gIkMiIHVuc2lnbmVkIGxvbmcKIGN5Z3dpbl9pbnRlcm5h
bCAoY3lnd2luX2dldGluZm9fdHlwZXMgdCwgLi4uKQpAQCAtNTI4LDYgKzUz
MSwxNSBAQCBjeWd3aW5faW50ZXJuYWwgKGN5Z3dpbl9nZXRpbmZvX3R5cGVz
IHQsCiAJfQogCWJyZWFrOwogCisgICAgICBjYXNlIENXX0dFVF9NT0RVTEVf
UEFUSF9GT1JfQUREUjoKKwl7CisJICB1aW50cHRyX3QgYWRkciA9IHZhX2Fy
ZyAoYXJnLCB1aW50cHRyX3QpOworCSAgUFdDSEFSIGRlc3QgPSB2YV9hcmcg
KGFyZywgUFdDSEFSKTsKKwkgIHNpemVfdCBkbGVuID0gdmFfYXJnIChhcmcs
IHNpemVfdCk7CisJICByZXMgPSBnZXRfbW9kdWxlX3BhdGhfZm9yX2FkZHIg
KGFkZHIsIGRlc3QsIGRsZW4pOworCX0KKwlicmVhazsKKwogICAgICAgZGVm
YXVsdDoKIAlzZXRfZXJybm8gKEVOT1NZUyk7CiAgICAgfQpJbmRleDogZmhh
bmRsZXJfcHJvY2Vzcy5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBm
aWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9wcm9j
ZXNzLmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjExMApkaWZmIC11IC1w
IC1yMS4xMTAgZmhhbmRsZXJfcHJvY2Vzcy5jYwotLS0gZmhhbmRsZXJfcHJv
Y2Vzcy5jYwkxMCBPY3QgMjAxMSAxODo1OTo1NiAtMDAwMAkxLjExMAorKysg
ZmhhbmRsZXJfcHJvY2Vzcy5jYwkxMyBPY3QgMjAxMSAwNjo1MDo0NCAtMDAw
MApAQCAtMTQ0MSwzICsxNDQxLDk3IEBAIG91dDoKICAgQ2xvc2VIYW5kbGUg
KGhQcm9jZXNzKTsKICAgcmV0dXJuIHJlczsKIH0KKworLyogSGVscGVyIGZ1
bmN0aW9uIGZvciBjeWd3aW5faW50ZXJuYWwuIEltcGxlbWVudGVkIGhlcmUs
IHJhdGhlcgorICogdGhhbiBpbiBleHRlcm5hbC5jYywgc28gYXMgdG8gcmV1
c2UgZG9zX2RyaXZlX21hcHBpbmdzLAorICogaGVhcF9pbmZvLCBhbmQgdGhy
ZWFkX2luZm8gaGVscGVyIGNsYXNzZXMuIFJldHVybnMgMCBvbiBzdWNjZXNz
LAorICogbm9uemVybyBvdGhlcndpc2UuIEJvcnJvd3MgaGVhdmlseSBmcm9t
IGZvcm1hdF9wcm9jZXNzX21hcHMoKS4KKyAqLworaW50CitnZXRfbW9kdWxl
X3BhdGhfZm9yX2FkZHIgKHVpbnRwdHJfdCBhZGRyLCBQV0NIQVIgZGVzdCwg
c2l6ZV90IGRsZW4pCit7CisgIGludCBydmFsID0gLTE7CisgIERXT1JEIHdw
aWQgPSBHZXRDdXJyZW50UHJvY2Vzc0lkICgpOworICBIQU5ETEUgcHJvYyA9
IE9wZW5Qcm9jZXNzIChQUk9DRVNTX1FVRVJZX0lORk9STUFUSU9OIHwgUFJP
Q0VTU19WTV9SRUFELAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBG
QUxTRSwgd3BpZCk7CisgIGlmICghcHJvYykKKyAgICByZXR1cm4gcnZhbDsK
KworICBOVFNUQVRVUyBzdGF0dXM7CisgIFBST0NFU1NfQkFTSUNfSU5GT1JN
QVRJT04gcGJpOworCisgIG1lbXNldCAoJnBiaSwgMCwgc2l6ZW9mIChwYmkp
KTsKKyAgc3RhdHVzID0gTnRRdWVyeUluZm9ybWF0aW9uUHJvY2VzcyAocHJv
YywgUHJvY2Vzc0Jhc2ljSW5mb3JtYXRpb24sCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZwYmksIHNpemVvZiBwYmksIE5VTEwp
OworICBpZiAoIU5UX1NVQ0NFU1MgKHN0YXR1cykpCisgICAgeworICAgICAg
Q2xvc2VIYW5kbGUgKHByb2MpOworICAgICAgcmV0dXJuIHJ2YWw7CisgICAg
fQorICBQUEVCIHBlYiA9IHBiaS5QZWJCYXNlQWRkcmVzczsKKworICAvKiBt
eXNlbGYgaXMgaW4gdGhlIHNhbWUgc3BvdCBpbiBldmVyeSBwcm9jZXNzLCBz
byBpcyB0aGUgcG9pbnRlciB0byB0aGUKKyAgICAgcHJvY2luZm8uICBCdXQg
bWFrZSBzdXJlIHRoZSBkZXN0cnVjdG9yIGRvZXNuJ3QgdHJ5IHRvIHJlbGVh
c2UgcHJvY2luZm8hICovCisgIHBpbmZvIHByb2NfcGluZm87CisgIGlmIChS
ZWFkUHJvY2Vzc01lbW9yeSAocHJvYywgJm15c2VsZiwgJnByb2NfcGluZm8s
IHNpemVvZiBwcm9jX3BpbmZvLCBOVUxMKSkKKyAgICBwcm9jX3BpbmZvLnBy
ZXNlcnZlICgpOworICAvKiBUaGUgaGVhcCBpbmZvIG9uIHRoZSBjeWdoZWFw
IGlzIGFsc28gaW4gdGhlIHNhbWUgc3BvdCBpbiBlYWNoIHByb2Nlc3MKKyAg
ICAgYmVjYXVzZSB0aGUgY3lnaGVhcCBpcyBsb2NhdGVkIGF0IHRoZSBzYW1l
IGFkZHJlc3MuICovCisgIHVzZXJfaGVhcF9pbmZvIHVzZXJfaGVhcDsKKyAg
UmVhZFByb2Nlc3NNZW1vcnkgKHByb2MsICZjeWdoZWFwLT51c2VyX2hlYXAs
ICZ1c2VyX2hlYXAsCisgICAgICAgICAgICAgICAgICAgICBzaXplb2YgdXNl
cl9oZWFwLCBOVUxMKTsKKworICBNRU1PUllfQkFTSUNfSU5GT1JNQVRJT04g
bWI7CisgIFZpcnR1YWxRdWVyeUV4IChwcm9jLCAoY29uc3Qgdm9pZCopYWRk
ciwgJm1iLCBzaXplb2YgbWIpOworCisgIGRvc19kcml2ZV9tYXBwaW5ncyBk
cml2ZV9tYXBzOworICBoZWFwX2luZm8gaGVhcHMgKHdwaWQpOworICB0aHJl
YWRfaW5mbyB0aHJlYWRzICh3cGlkLCBwcm9jKTsKKworICB0bXBfcGF0aGJ1
ZiB0cDsKKyAgUE1FTU9SWV9TRUNUSU9OX05BTUUgbXNpID0gKFBNRU1PUllf
U0VDVElPTl9OQU1FKSB0cC53X2dldCAoKTsKKyAgY2hhciAqcG9zaXhfbW9k
bmFtZSA9IHRwLmNfZ2V0KCk7CisgIHBvc2l4X21vZG5hbWVbMF0gPSAnXDAn
OworICAvKiBJZiB0aGUgcmV0dXJuIGxlbmd0aCBwb2ludGVyIGlzIG1pc3Np
bmcsIE50UXVlcnlWaXJ0dWFsTWVtb3J5CisgICAqIHJldHVybnMgd2l0aCBT
VEFUVVNfQUNDRVNTX1ZJT0xBVElPTiBvbiBXaW5kb3dzIDIwMDAuICovCisg
IFVMT05HIHJldF9sZW4gPSAwOworCisgIGlmICgobWIuU3RhdGUgIT0gTUVN
X0ZSRUUpCisgICAgICAmJiAobWIuVHlwZSAmIChNRU1fTUFQUEVEIHwgTUVN
X0lNQUdFKSkKKyAgICAgICYmIE5UX1NVQ0NFU1MgKHN0YXR1cyA9IE50UXVl
cnlWaXJ0dWFsTWVtb3J5IChwcm9jLCBtYi5BbGxvY2F0aW9uQmFzZSwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBNZW1vcnlTZWN0aW9uTmFtZSwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2ksIDY1NTM2LCAm
cmV0X2xlbikpKQorICAgIHsKKyAgICAgIFBXQ0hBUiBkb3NuYW1lID0KKyAg
ICAgICAgZHJpdmVfbWFwcy5maXh1cF9pZl9tYXRjaCAobXNpLT5TZWN0aW9u
RmlsZU5hbWUuQnVmZmVyKTsKKyAgICAgIGlmIChtb3VudF90YWJsZS0+Y29u
dl90b19wb3NpeF9wYXRoIChkb3NuYW1lLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHBvc2l4X21vZG5hbWUsIDApKQor
ICAgICAgICBzeXNfd2NzdG9tYnMgKHBvc2l4X21vZG5hbWUsIE5UX01BWF9Q
QVRILCBkb3NuYW1lKTsKKyAgICB9CisgIGVsc2UgaWYgKCF0aHJlYWRzLmZp
bGxfaWZfbWF0Y2ggKChjaGFyKiltYi5BbGxvY2F0aW9uQmFzZSwgbWIuVHlw
ZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcG9zaXhf
bW9kbmFtZSkKKyAgICAgICAgICAgJiYgIWhlYXBzLmZpbGxfaWZfbWF0Y2gg
KChjaGFyKiltYi5BbGxvY2F0aW9uQmFzZSwgbWIuVHlwZSwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBvc2l4X21vZG5hbWUpKQor
ICAgIHsKKyAgICAgIGlmIChtYi5BbGxvY2F0aW9uQmFzZSA9PSAoY2hhciAq
KSBwZWIpCisgICAgICAgIHN0cmNweSAocG9zaXhfbW9kbmFtZSwgIltwZWJd
Iik7CisgICAgICBlbHNlIGlmIChtYi5BbGxvY2F0aW9uQmFzZSA9PSAoY2hh
ciAqKSAmU2hhcmVkVXNlckRhdGEpCisgICAgICAgIHN0cmNweSAocG9zaXhf
bW9kbmFtZSwgIltzaGFyZWQtdXNlci1kYXRhXSIpOworICAgICAgZWxzZSBp
ZiAobWIuQWxsb2NhdGlvbkJhc2UgPT0gKGNoYXIgKikgY3lnd2luX3NoYXJl
ZCkKKyAgICAgICAgc3RyY3B5IChwb3NpeF9tb2RuYW1lLCAiW2N5Z3dpbi1z
aGFyZWRdIik7CisgICAgICBlbHNlIGlmIChtYi5BbGxvY2F0aW9uQmFzZSA9
PSAoY2hhciAqKSB1c2VyX3NoYXJlZCkKKyAgICAgICAgc3RyY3B5IChwb3Np
eF9tb2RuYW1lLCAiW2N5Z3dpbi11c2VyLXNoYXJlZF0iKTsKKyAgICAgIGVs
c2UgaWYgKG1iLkFsbG9jYXRpb25CYXNlID09IChjaGFyICopICpwcm9jX3Bp
bmZvKQorICAgICAgICBzdHJjcHkgKHBvc2l4X21vZG5hbWUsICJbcHJvY2lu
Zm9dIik7CisgICAgICBlbHNlIGlmIChtYi5BbGxvY2F0aW9uQmFzZSA9PSB1
c2VyX2hlYXAuYmFzZSkKKyAgICAgICAgc3RyY3B5IChwb3NpeF9tb2RuYW1l
LCAiW2hlYXBdIik7CisgICAgICBlbHNlCisgICAgICAgIHBvc2l4X21vZG5h
bWVbMF0gPSAwOworICAgIH0KKworICBDbG9zZUhhbmRsZSAocHJvYyk7Cisg
IHJ2YWwgPSAocG9zaXhfbW9kbmFtZVswXSA9PSAwKTsKKyAgc3lzX21ic3Rv
d2NzIChkZXN0LCBkbGVuLCBwb3NpeF9tb2RuYW1lLCBOVF9NQVhfUEFUSCk7
CisgIHJldHVybiBydmFsOworfQorCkluZGV4OiBpbmNsdWRlL3N5cy9jeWd3
aW4uaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3ZzL3Ny
Yy9zcmMvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL3N5cy9jeWd3aW4uaCx2CnJl
dHJpZXZpbmcgcmV2aXNpb24gMS45NwpkaWZmIC11IC1wIC1yMS45NyBjeWd3
aW4uaAotLS0gaW5jbHVkZS9zeXMvY3lnd2luLmgJNyBPY3QgMjAxMSAxMzo0
OToxNyAtMDAwMAkxLjk3CisrKyBpbmNsdWRlL3N5cy9jeWd3aW4uaAkxMyBP
Y3QgMjAxMSAwNjo1MDo0NCAtMDAwMApAQCAtMTM1LDcgKzEzNSw4IEBAIHR5
cGVkZWYgZW51bQogICAgIENXX0NWVF9NTlRfT1BUUywKICAgICBDV19MU1Rf
TU5UX09QVFMsCiAgICAgQ1dfU1RSRVJST1IsCi0gICAgQ1dfQ1ZUX0VOVl9U
T19XSU5FTlYKKyAgICBDV19DVlRfRU5WX1RPX1dJTkVOViwKKyAgICBDV19H
RVRfTU9EVUxFX1BBVEhfRk9SX0FERFIKICAgfSBjeWd3aW5fZ2V0aW5mb190
eXBlczsKIAogI2RlZmluZSBDV19MT0NLX1BJTkZPIENXX0xPQ0tfUElORk8K
QEAgLTE4Myw2ICsxODQsNyBAQCB0eXBlZGVmIGVudW0KICNkZWZpbmUgQ1df
TFNUX01OVF9PUFRTIENXX0xTVF9NTlRfT1BUUwogI2RlZmluZSBDV19TVFJF
UlJPUiBDV19TVFJFUlJPUgogI2RlZmluZSBDV19DVlRfRU5WX1RPX1dJTkVO
ViBDV19DVlRfRU5WX1RPX1dJTkVOVgorI2RlZmluZSBDV19HRVRfTU9EVUxF
X1BBVEhfRk9SX0FERFIgQ1dfR0VUX01PRFVMRV9QQVRIX0ZPUl9BRERSCiAK
IC8qIFRva2VuIHR5cGUgZm9yIENXX1NFVF9FWFRFUk5BTF9UT0tFTiAqLwog
ZW51bQo=

--------------080807070900010402090804
Content-Type: text/plain;
 name="test-get-module-path-for-addr.cc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="test-get-module-path-for-addr.cc"
Content-length: 877

#include <iostream>
#include <iomanip>
#include <sstream>
#include <fstream>
#include <string>
#include <unistd.h>
#include <sys/cygwin.h>
#include <limits.h>

#define NO_MINMAX
#include <windows.h>

int main(int argc, char* argv[])
{
  int pid = getpid ();
  std::ostringstream ostr;
  ostr << "/proc/" << pid << "/maps";
  std::ifstream ifs(ostr.str().c_str());
  std::cout << ifs.rdbuf() << std::endl;

  uintptr_t addr;
  WCHAR wbuf[PATH_MAX];
  char  nbuf[4*PATH_MAX];

  while (std::cin)
  {
    std::cin >> std::hex >> addr;
    if (std::cin)
    {
      wbuf[0] = L'\0';
      int rval = cygwin_internal(CW_GET_MODULE_PATH_FOR_ADDR,
        addr, wbuf, PATH_MAX);
      wcstombs (nbuf, wbuf, 4*PATH_MAX);
      std::cout << "0x" << std::hex << std::setw(8) << std::setfill('0')
	<< addr << " (" << std::dec << rval << ") " << nbuf << std::endl;
    }
  }
  return 0;
}

--------------080807070900010402090804--

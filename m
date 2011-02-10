Return-Path: <cygwin-patches-return-7171-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25215 invoked by alias); 10 Feb 2011 00:21:10 -0000
Received: (qmail 25205 invoked by uid 22791); 10 Feb 2011 00:21:08 -0000
X-SWARE-Spam-Status: No, hits=-6.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,TW_CP,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 10 Feb 2011 00:21:03 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p1A0L2bK007860	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Wed, 9 Feb 2011 19:21:02 -0500
Received: from [10.3.113.122] (ovpn-113-122.phx2.redhat.com [10.3.113.122])	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p1A0L01r031466	for <cygwin-patches@cygwin.com>; Wed, 9 Feb 2011 19:21:01 -0500
Message-ID: <4D532F6B.5080104@redhat.com>
Date: Thu, 10 Feb 2011 00:21:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.7
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: provide __xpg_strerror_r
References: <4D4DAD40.3060904@redhat.com> <20110205202806.GA11118@ednor.casa.cgf.cx> <4D4DB682.3070601@redhat.com> <20110206095423.GA19356@calimero.vinschen.de>
In-Reply-To: <20110206095423.GA19356@calimero.vinschen.de>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enig2429EF93AB377E331CFD5D9F"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00026.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2429EF93AB377E331CFD5D9F
Content-Type: multipart/mixed;
 boundary="------------070100060809050405090404"

This is a multi-part message in MIME format.
--------------070100060809050405090404
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1660

On 02/06/2011 02:54 AM, Corinna Vinschen wrote:
>> We already provide our own strerror() (it provides a better experience
>> for out-of-range values that the newlib interface), but we're currently
>> using the newlib strerror_r() (in spite of its truncation flaw).
>>
>> How should I rework this patch?
>=20
> It would be better if we implement strerror_r locally, in two versions,
> just as on Linux.  I think the best approach is to implement this in
> newlib first (I replied to your mail there) and then, given that we use
> the newlib string.h, copy the method over to Cygwin to match our current
> strerror more closely.

Here's the cygwin side of things, to match newlib's <string.h> changes.
 Surprisingly, strerror_r turned out to be identical even when based on
different root strerror(), so I left that inside #if 0, but it's easy
enough to kill the #if 0 if you don't want cygwin to use any of newlib's
strerror*.

---
 winsup/cygwin/ChangeLog                |    9 +++
 winsup/cygwin/cygwin.din               |    1 +
 winsup/cygwin/errno.cc                 |   84
+++++++++++++++++++++-----------
 winsup/cygwin/include/cygwin/version.h |    3 +-
 4 files changed, 68 insertions(+), 29 deletions(-)

2011-02-09  Eric Blake  <eblake@redhat.com>

	* errno.cc (__xpg_strerror_r): New function.
	(strerror_r): Update comments to match newlib's fixes.
	(strerror): Set errno on failure.
	(_sys_errlist): Cause EINVAL failure for reserved values.
	* cygwin.din: Export new function.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org

--------------070100060809050405090404
Content-Type: text/plain;
 name="cygwin.patch40"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cygwin.patch40"
Content-length: 7223

ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vY3lnd2luLmRpbiBiL3dpbnN1
cC9jeWd3aW4vY3lnd2luLmRpbgppbmRleCAyZTdlNjQ3Li43ODAxNzlhIDEw
MDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2N5Z3dpbi5kaW4KKysrIGIvd2lu
c3VwL2N5Z3dpbi9jeWd3aW4uZGluCkBAIC0xOTMzLDYgKzE5MzMsNyBAQCB4
ZHJyZWNfc2tpcHJlY29yZCBTSUdGRQogX194ZHJyZWNfZ2V0cmVjIFNJR0ZF
CiBfX3hkcnJlY19zZXRub25ibG9jayBTSUdGRQogeGRyc3RkaW9fY3JlYXRl
IFNJR0ZFCitfX3hwZ19zdHJlcnJvcl9yIFNJR0ZFCiB5MCBOT1NJR0ZFCiB5
MGYgTk9TSUdGRQogeTEgTk9TSUdGRQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5
Z3dpbi9lcnJuby5jYyBiL3dpbnN1cC9jeWd3aW4vZXJybm8uY2MKaW5kZXgg
YTk4NjBmNC4uMGU5Yzg2MyAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9l
cnJuby5jYworKysgYi93aW5zdXAvY3lnd2luL2Vycm5vLmNjCkBAIC0xOTks
OSArMTk5LDkgQEAgY29uc3QgY2hhciAqX3N5c19lcnJsaXN0W10gTk9fQ09Q
WV9JTklUID0KIC8qIEVMMkhMVCA0NCAqLwkJICAiTGV2ZWwgMiBoYWx0ZWQi
LAogLyogRURFQURMSyA0NSAqLwkgICJSZXNvdXJjZSBkZWFkbG9jayBhdm9p
ZGVkIiwKIC8qIEVOT0xDSyA0NiAqLwkJICAiTm8gbG9ja3MgYXZhaWxhYmxl
IiwKLQkJCSAgImVycm9yIDQ3IiwKLQkJCSAgImVycm9yIDQ4IiwKLQkJCSAg
ImVycm9yIDQ5IiwKKwkJCSAgTlVMTCwKKwkJCSAgTlVMTCwKKwkJCSAgTlVM
TCwKIC8qIEVCQURFIDUwICovCQkgICJJbnZhbGlkIGV4Y2hhbmdlIiwKIC8q
IEVCQURSIDUxICovCQkgICJJbnZhbGlkIHJlcXVlc3QgZGVzY3JpcHRvciIs
CiAvKiBFWEZVTEwgNTIgKi8JCSAgIkV4Y2hhbmdlIGZ1bGwiLApAQCAtMjEw
LDggKzIxMCw4IEBAIGNvbnN0IGNoYXIgKl9zeXNfZXJybGlzdFtdIE5PX0NP
UFlfSU5JVCA9CiAvKiBFQkFEU0xUIDU1ICovCSAgIkludmFsaWQgc2xvdCIs
CiAvKiBFREVBRExPQ0sgNTYgKi8JICAiRmlsZSBsb2NraW5nIGRlYWRsb2Nr
IGVycm9yIiwKIC8qIEVCRk9OVCA1NyAqLwkJICAiQmFkIGZvbnQgZmlsZSBm
b3JtYXQiLAotCQkJICAiZXJyb3IgNTgiLAotCQkJICAiZXJyb3IgNTkiLAor
CQkJICBOVUxMLAorCQkJICBOVUxMLAogLyogRU5PU1RSIDYwICovCQkgICJE
ZXZpY2Ugbm90IGEgc3RyZWFtIiwKIC8qIEVOT0RBVEEgNjEgKi8JICAiTm8g
ZGF0YSBhdmFpbGFibGUiLAogLyogRVRJTUUgNjIgKi8JCSAgIlRpbWVyIGV4
cGlyZWQiLApAQCAtMjI0LDEzICsyMjQsMTMgQEAgY29uc3QgY2hhciAqX3N5
c19lcnJsaXN0W10gTk9fQ09QWV9JTklUID0KIC8qIEVTUk1OVCA2OSAqLwkJ
ICAiU3Jtb3VudCBlcnJvciIsCiAvKiBFQ09NTSA3MCAqLwkJICAiQ29tbXVu
aWNhdGlvbiBlcnJvciBvbiBzZW5kIiwKIC8qIEVQUk9UTyA3MSAqLwkJICAi
UHJvdG9jb2wgZXJyb3IiLAotCQkJICAiZXJyb3IgNzIiLAotCQkJICAiZXJy
b3IgNzMiLAorCQkJICBOVUxMLAorCQkJICBOVUxMLAogLyogRU1VTFRJSE9Q
IDc0ICovCSAgIk11bHRpaG9wIGF0dGVtcHRlZCIsCiAvKiBFTEJJTiA3NSAq
LwkJICAiSW5vZGUgaXMgcmVtb3RlIChub3QgcmVhbGx5IGVycm9yKSIsCiAv
KiBFRE9URE9UIDc2ICovCSAgIlJGUyBzcGVjaWZpYyBlcnJvciIsCiAvKiBF
QkFETVNHIDc3ICovCSAgIkJhZCBtZXNzYWdlIiwKLQkJCSAgImVycm9yIDc4
IiwKKwkJCSAgTlVMTCwKIC8qIEVGVFlQRSA3OSAqLwkJICAiSW5hcHByb3By
aWF0ZSBmaWxlIHR5cGUgb3IgZm9ybWF0IiwKIC8qIEVOT1RVTklRIDgwICov
CSAgIk5hbWUgbm90IHVuaXF1ZSBvbiBuZXR3b3JrIiwKIC8qIEVCQURGRCA4
MSAqLwkJICAiRmlsZSBkZXNjcmlwdG9yIGluIGJhZCBzdGF0ZSIsCkBAIC0y
NDUsMTcgKzI0NSwxNyBAQCBjb25zdCBjaGFyICpfc3lzX2Vycmxpc3RbXSBO
T19DT1BZX0lOSVQgPQogLyogRU5PVEVNUFRZIDkwCSovCSAgIkRpcmVjdG9y
eSBub3QgZW1wdHkiLAogLyogRU5BTUVUT09MT05HIDkxICovCSAgIkZpbGUg
bmFtZSB0b28gbG9uZyIsCiAvKiBFTE9PUCA5MiAqLwkJICAiVG9vIG1hbnkg
bGV2ZWxzIG9mIHN5bWJvbGljIGxpbmtzIiwKLQkJCSAgImVycm9yIDkzIiwK
LQkJCSAgImVycm9yIDk0IiwKKwkJCSAgTlVMTCwKKwkJCSAgTlVMTCwKIC8q
IEVPUE5PVFNVUFAgOTUgKi8JICAiT3BlcmF0aW9uIG5vdCBzdXBwb3J0ZWQi
LAogLyogRVBGTk9TVVBQT1JUIDk2ICovCSAgIlByb3RvY29sIGZhbWlseSBu
b3Qgc3VwcG9ydGVkIiwKLQkJCSAgImVycm9yIDk3IiwKLQkJCSAgImVycm9y
IDk4IiwKLQkJCSAgImVycm9yIDk5IiwKLQkJCSAgImVycm9yIDEwMCIsCi0J
CQkgICJlcnJvciAxMDEiLAotCQkJICAiZXJyb3IgMTAyIiwKLQkJCSAgImVy
cm9yIDEwMyIsCisJCQkgIE5VTEwsCisJCQkgIE5VTEwsCisJCQkgIE5VTEws
CisJCQkgIE5VTEwsCisJCQkgIE5VTEwsCisJCQkgIE5VTEwsCisJCQkgIE5V
TEwsCiAvKiBFQ09OTlJFU0VUIDEwNCAqLwkgICJDb25uZWN0aW9uIHJlc2V0
IGJ5IHBlZXIiLAogLyogRU5PQlVGUyAxMDUgKi8JICAiTm8gYnVmZmVyIHNw
YWNlIGF2YWlsYWJsZSIsCiAvKiBFQUZOT1NVUFBPUlQgMTA2ICovCSAgIkFk
ZHJlc3MgZmFtaWx5IG5vdCBzdXBwb3J0ZWQgYnkgcHJvdG9jb2wiLApAQCAt
MzU3LDI3ICszNTcsNTUgQEAgc3RyZXJyb3Jfd29ya2VyIChpbnQgZXJybnVt
KQogICByZXR1cm4gcmVzOwogfQoKLS8qIHN0cmVycm9yOiBjb252ZXJ0IGZy
b20gZXJybm8gdmFsdWVzIHRvIGVycm9yIHN0cmluZ3MgKi8KKy8qIHN0cmVy
cm9yOiBjb252ZXJ0IGZyb20gZXJybm8gdmFsdWVzIHRvIGVycm9yIHN0cmlu
Z3MuICBOZXdsaWIncworICAgc3RyZXJyb3JfciByZXR1cm5zICIiIGZvciB1
bmtub3duIHZhbHVlcywgc28gd2Ugb3ZlcnJpZGUgaXQgdG8KKyAgIHByb3Zp
ZGUgYSBuaWNlciB0aHJlYWQtc2FmZSByZXN1bHQgc3RyaW5nIGFuZCBzZXQg
ZXJybm8uICAqLwogZXh0ZXJuICJDIiBjaGFyICoKIHN0cmVycm9yIChpbnQg
ZXJybnVtKQogewogICBjaGFyICplcnJzdHIgPSBzdHJlcnJvcl93b3JrZXIg
KGVycm51bSk7CiAgIGlmICghZXJyc3RyKQotICAgIF9fc21hbGxfc3ByaW50
ZiAoZXJyc3RyID0gX215X3Rscy5sb2NhbHMuc3RyZXJyb3JfYnVmLCAiVW5r
bm93biBlcnJvciAldSIsCi0JCSAgICAgKHVuc2lnbmVkKSBlcnJudW0pOwor
ICAgIHsKKyAgICAgIF9fc21hbGxfc3ByaW50ZiAoZXJyc3RyID0gX215X3Rs
cy5sb2NhbHMuc3RyZXJyb3JfYnVmLCAiVW5rbm93biBlcnJvciAldSIsCisJ
CSAgICAgICAodW5zaWduZWQpIGVycm51bSk7CisgICAgICBlcnJubyA9IF9p
bXB1cmVfcHRyLT5fZXJybm8gPSBFSU5WQUw7CisgICAgfQogICByZXR1cm4g
ZXJyc3RyOwogfQoKKy8qIE5ld2xpYidzIDxzdHJpbmcuaD4gcHJvdmlkZXMg
ZGVjbGFyYXRpb25zIGZvciB0d28gc3RyZXJyb3JfcgorICAgdmFyaWFudHMs
IGFjY29yZGluZyB0byBwcmVwcm9jZXNzb3IgZmVhdHVyZSBtYWNyb3MuICBJ
dCBkb2VzIHRoZQorICAgcmlnaHQgdGhpbmcgZm9yIEdOVSBzdHJlcnJvcl9y
LCBidXQgaXRzIF9feHBnX3N0cmVycm9yX3IgbWlzaGFuZGxlcworICAgYSBj
YXNlIG9mIEVJTlZBTCB3aGVuIGNvdXBsZWQgd2l0aCBvdXIgc3RyZXJyb3Io
KSBvdmVycmlkZS4qLwogI2lmIDAKLWV4dGVybiAiQyIgaW50CitleHRlcm4g
IkMiIGNoYXIgKgogc3RyZXJyb3JfciAoaW50IGVycm51bSwgY2hhciAqYnVm
LCBzaXplX3QgbikKIHsKLSAgY2hhciAqZXJyc3RyID0gc3RyZXJyb3Jfd29y
a2VyIChlcnJudW0pOwotICBpZiAoIWVycnN0cikKLSAgICByZXR1cm4gRUlO
VkFMOwotICBpZiAoc3RybGVuIChlcnJzdHIpID49IG4pCi0gICAgcmV0dXJu
IEVSQU5HRTsKLSAgc3RyY3B5IChidWYsIGVycnN0cik7Ci0gIHJldHVybiAw
OworICBjaGFyICplcnJvciA9IHN0cmVycm9yIChlcnJudW0pOworICBpZiAo
c3RybGVuIChlcnJvcikgPj0gbikKKyAgICByZXR1cm4gZXJyb3I7CisgIHJl
dHVybiBzdHJjcHkgKGJ1ZiwgZXJyb3IpOwogfQogI2VuZGlmCisKK2V4dGVy
biAiQyIgaW50CitfX3hwZ19zdHJlcnJvcl9yIChpbnQgZXJybnVtLCBjaGFy
ICpidWYsIHNpemVfdCBuKQoreworICBpZiAoIW4pCisgICAgcmV0dXJuIEVS
QU5HRTsKKyAgaW50IHJlc3VsdCA9IDA7CisgIGNoYXIgKmVycm9yID0gc3Ry
ZXJyb3Jfd29ya2VyIChlcnJudW0pOworICAgIHsKKyAgICAgIF9fc21hbGxf
c3ByaW50ZiAoZXJyb3IgPSBfbXlfdGxzLmxvY2Fscy5zdHJlcnJvcl9idWYs
ICJVbmtub3duIGVycm9yICV1IiwKKwkJICAgICAgICh1bnNpZ25lZCkgZXJy
bnVtKTsKKyAgICAgIHJlc3VsdCA9IEVJTlZBTDsKKyAgICB9CisgIGlmIChz
dHJsZW4gKGVycm9yKSA+PSBuKQorICAgIHsKKyAgICAgIG1lbWNweSAoYnVm
LCBlcnJvciwgbiAtIDEpOworICAgICAgYnVmW24gLSAxXSA9ICdcMCc7Cisg
ICAgICByZXR1cm4gRVJBTkdFOworICAgIH0KKyAgc3RyY3B5IChidWYsIGVy
cm9yKTsKKyAgcmV0dXJuIHJlc3VsdDsKK30KZGlmZiAtLWdpdCBhL3dpbnN1
cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vdmVyc2lvbi5oIGIvd2luc3VwL2N5
Z3dpbi9pbmNsdWRlL2N5Z3dpbi92ZXJzaW9uLmgKaW5kZXggYzc1NzgyNy4u
NzI0NmU4ZSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5
Z3dpbi92ZXJzaW9uLmgKKysrIGIvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5
Z3dpbi92ZXJzaW9uLmgKQEAgLTM5OSwxMiArMzk5LDEzIEBAIGRldGFpbHMu
ICovCiAgICAgICAyMzM6IEFkZCBUSU9DR1BHUlAsIFRJT0NTUEdSUC4gIEV4
cG9ydCBsbHJvdW5kLCBsbHJvdW5kZi4KICAgICAgIDIzNDogRXhwb3J0IHBy
b2dyYW1faW52b2NhdGlvbl9uYW1lLCBwcm9ncmFtX2ludm9jYXRpb25fc2hv
cnRfbmFtZS4KICAgICAgIDIzNTogRXhwb3J0IG1hZHZpc2UuCisgICAgICAy
MzY6IEV4cG9ydCBfX3hwZ19zdHJlcnJvcl9yLgogICAgICAqLwoKICAgICAg
LyogTm90ZSB0aGF0IHdlIGZvcmdvdCB0byBidW1wIHRoZSBhcGkgZm9yIHVh
bGFybSwgc3RydG9sbCwgc3RydG91bGwgKi8KCiAjZGVmaW5lIENZR1dJTl9W
RVJTSU9OX0FQSV9NQUpPUiAwCi0jZGVmaW5lIENZR1dJTl9WRVJTSU9OX0FQ
SV9NSU5PUiAyMzUKKyNkZWZpbmUgQ1lHV0lOX1ZFUlNJT05fQVBJX01JTk9S
IDIzNgoKICAgICAgLyogVGhlcmUgaXMgYWxzbyBhIGNvbXBhdGliaXR5IHZl
cnNpb24gbnVtYmVyIGFzc29jaWF0ZWQgd2l0aCB0aGUKIAlzaGFyZWQgbWVt
b3J5IHJlZ2lvbnMuICBJdCBpcyBpbmNyZW1lbnRlZCB3aGVuIGluY29tcGF0
aWJsZQotLSAKMS43LjMuMwoK

--------------070100060809050405090404--

--------------enig2429EF93AB377E331CFD5D9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 619

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNUy9rAAoJEKeha0olJ0Nq2LAIAIfhea6zyqwpk3nIb+EofhBZ
rNuc6uMXvx6PEAEG8O4UXgYGZWto2SjpKdsqQVAu7hN5D5JsxDx9KVtOrGw2lJDt
g+vGc498Wb6w28fKOUdiG7sTA1BPnEYKFlXb7geCCxh29j8f/5SvYoNZHK5eRriu
jegUE0t1WJ5BfgR7htuMSN9wfXpWrNJFDHfrw6wMgATr468oQR77Pw7Fw+Yuu5H6
YXk2i/EGtunZvcPfYPUMy/6y1t/AnDHAeLSOsgk/jwDeMjz4yQgj5CpF80rMYMq1
v6GheIA3aLzds7RBhfAf6hT2tnsee5xfNpetG5SuIOB9dWv4uq7X4IB40irWwMA=
=eRD0
-----END PGP SIGNATURE-----

--------------enig2429EF93AB377E331CFD5D9F--

Return-Path: <cygwin-patches-return-5222-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 868 invoked by alias); 16 Dec 2004 23:49:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 337 invoked from network); 16 Dec 2004 23:48:54 -0000
Received: from unknown (HELO omzesmtp02.mci.com) (199.249.17.9)
  by sourceware.org with SMTP; 16 Dec 2004 23:48:54 -0000
Received: from pmismtp02.mcilink.com ([166.38.62.37])
 by firewall.mci.com (Iplanet MTA 5.2)
 with ESMTP id <0I8U005BAA5H0M@firewall.mci.com> for cygwin-patches@cygwin.com;
 Thu, 16 Dec 2004 23:48:53 +0000 (GMT)
Received: from pmismtp02.mcilink.com by pmismtp02.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with SMTP id <0I8U00B01A5GQ8@pmismtp02.mcilink.com> for
 cygwin-patches@cygwin.com; Thu, 16 Dec 2004 23:48:53 +0000 (GMT)
Received: from WS117V6220509.mcilink.com ([166.34.132.122])
 by pmismtp02.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0I8U00B7XA5G0E@pmismtp02.mcilink.com> for
 cygwin-patches@cygwin.com; Thu, 16 Dec 2004 23:48:52 +0000 (GMT)
Date: Thu, 16 Dec 2004 23:49:00 -0000
From: Mark Paulus <mark.paulus@mci.com>
Subject: Another attempt to patch path.cc for trailing dots
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Message-id: <0I8U00B7YA5G0E@pmismtp02.mcilink.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_sxkdFNOtnmn3tHdPNqolbg)"
Priority: Normal
X-SW-Source: 2004-q4/txt/msg00223.txt.bz2


--Boundary_(ID_sxkdFNOtnmn3tHdPNqolbg)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Content-length: 162

	* path.cc (path_conv::check): retain trailing dots and spaces
	* path.cc (mount_item::build_win32):  strip trailing dots and spaces for 
	unmanaged filesystems


--Boundary_(ID_sxkdFNOtnmn3tHdPNqolbg)
Content-type: application/octet-stream; name=path.cc.patch
Content-transfer-encoding: base64
Content-disposition: attachment; filename=path.cc.patch
Content-length: 2209

SW5kZXg6IHBhdGguY2MKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmls
ZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vcGF0aC5jYyx2CnJldHJp
ZXZpbmcgcmV2aXNpb24gMS4zMjYKZGlmZiAtdSAtcCAtcjEuMzI2IHBhdGgu
Y2MKLS0tIHBhdGguY2MJMyBEZWMgMjAwNCAwMjowMDozNyAtMDAwMAkxLjMy
NgorKysgcGF0aC5jYwkxNiBEZWMgMjAwNCAyMzo0NDoyNCAtMDAwMApAQCAt
NTU1LDYgKzU1NSw3IEBAIHBhdGhfY29udjo6Y2hlY2sgKGNvbnN0IGNoYXIg
KnNyYywgdW5zaWcKIAkgICAgfQogCSAgLyogUmVtb3ZlIHRyYWlsaW5nIGRv
dHMgYW5kIHNwYWNlcyB3aGljaCBhcmUgaWdub3JlZCBieSBXaW4zMiBmdW5j
dGlvbnMgYnV0CiAJICAgICBub3QgYnkgbmF0aXZlIE5UIGZ1bmN0aW9ucy4g
Ki8KKwkgIGNoYXIgKnRtcFRhaWwgPSB0YWlsOwogCSAgd2hpbGUgKHRhaWxb
LTFdID09ICcuJyB8fCB0YWlsWy0xXSA9PSAnICcpCiAJICAgIHRhaWwtLTsK
IAkgIGlmICh0YWlsID4gcGF0aF9jb3B5ICsgMSAmJiBpc3NsYXNoICh0YWls
Wy0xXSkpCkBAIC01NjIsNiArNTYzLDcgQEAgcGF0aF9jb252OjpjaGVjayAo
Y29uc3QgY2hhciAqc3JjLCB1bnNpZwogCSAgICAgIGVycm9yID0gRU5PRU5U
OwogCSAgICAgIHJldHVybjsKIAkgICAgfQorCSAgdGFpbCA9IHRtcFRhaWw7
CiAJfQogICAgICAgcGF0aF9lbmQgPSB0YWlsOwogICAgICAgKnRhaWwgPSAn
XDAnOwpAQCAtMTMyOSw2ICsxMzMxLDcgQEAgbW91bnRfaXRlbTo6YnVpbGRf
d2luMzIgKGNoYXIgKmRzdCwgY29ucwogICBpbnQgbiwgZXJyID0gMDsKICAg
Y29uc3QgY2hhciAqcmVhbF9uYXRpdmVfcGF0aDsKICAgaW50IHJlYWxfcG9z
aXhfcGF0aGxlbjsKKyAgZGVidWdfcHJpbnRmICgiYnVpbGRfd2luMzIgKCVz
KSIsIHNyYyk7CiAgIHNldF9mbGFncyAob3V0ZmxhZ3MsICh1bnNpZ25lZCkg
ZmxhZ3MpOwogICBpZiAoIWN5Z2hlYXAtPnJvb3QuZXhpc3RzICgpIHx8IHBv
c2l4X3BhdGhsZW4gIT0gMSB8fCBwb3NpeF9wYXRoWzBdICE9ICcvJykKICAg
ICB7CkBAIC0xMzUzLDcgKzEzNTYsMTUgQEAgbW91bnRfaXRlbTo6YnVpbGRf
d2luMzIgKGNoYXIgKmRzdCwgY29ucwogICAgICAgaWYgKChuICsgc3RybGVu
IChwKSkgPiBDWUdfTUFYX1BBVEgpCiAJZXJyID0gRU5BTUVUT09MT05HOwog
ICAgICAgZWxzZQotCWJhY2tzbGFzaGlmeSAocCwgZHN0ICsgbiwgMCk7Cisg
ICAgICAgIHsKKwkgIGJhY2tzbGFzaGlmeSAocCwgZHN0ICsgbiwgMCk7CisJ
ICBjaGFyICp0YWlsID0gZHN0ICsgc3RybGVuKGRzdCk7CisJICB3aGlsZSAo
dGFpbFstMV0gPT0gJy4nIHx8IHRhaWxbLTFdID09ICcgJykKKwkgICAgewor
CSAgICAgIHRhaWxbLTFdID0gJ1wwJzsKKwkgICAgICB0YWlsLS07CisJICAg
IH0KKwl9CiAgICAgfQogICBlbHNlCiAgICAgewpAQCAtMTM3NSw2ICsxMzg2
LDcgQEAgbW91bnRfaXRlbTo6YnVpbGRfd2luMzIgKGNoYXIgKmRzdCwgY29u
cwogCSAgcCA9IHM7CiAJfQogICAgIH0KKyAgZGVidWdfcHJpbnRmICgic3Jj
ID0gJyVzJywgZHN0ID0gJyVzJyIsIHNyYywgZHN0KTsKICAgcmV0dXJuIGVy
cjsKIH0KIAo=

--Boundary_(ID_sxkdFNOtnmn3tHdPNqolbg)--

Return-Path: <cygwin-patches-return-4413-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6158 invoked by alias); 17 Nov 2003 21:29:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6147 invoked from network); 17 Nov 2003 21:29:08 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Mon, 17 Nov 2003 21:29:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: (fhandler_base::lseek): Include high order bits in return.
Message-ID: <Pine.GSO.4.56.0311171454590.922@eos>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-641078858-1069102622=:922"
Content-ID: <Pine.GSO.4.56.0311171457250.922@eos>
X-SW-Source: 2003-q4/txt/msg00132.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-641078858-1069102622=:922
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.56.0311171457251.922@eos>
Content-length: 529

This bug fix got our app past its first problem with > 2 Gig files, but
then it tripped over ftello.  I'm still trying to figure that one out.

It looks like it got a 32 bit sign extended value somewhere.  Any help would
be appreciated.  Thanks.

2003-11-17  Brian Ford  <ford@vss.fsi.com>

	* fhandler.cc (fhandler_base::lseek): Include high order offset
	bits in return value.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-641078858-1069102622=:922
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="fhandler.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.56.0311171457020.922@eos>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="fhandler.patch"
Content-length: 850

SW5kZXg6IGZoYW5kbGVyLmNjDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIu
Y2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjE2MQ0KZGlmZiAtdSAtcCAt
cjEuMTYxIGZoYW5kbGVyLmNjDQotLS0gZmhhbmRsZXIuY2MJMjUgT2N0IDIw
MDMgMTI6MzI6NTYgLTAwMDAJMS4xNjENCisrKyBmaGFuZGxlci5jYwkxNyBO
b3YgMjAwMyAyMDo1NDozNCAtMDAwMA0KQEAgLTg3NCw2ICs4NzQsOSBAQCBm
aGFuZGxlcl9iYXNlOjpsc2VlayAoX29mZjY0X3Qgb2Zmc2V0LCBpDQogICAg
IH0NCiAgIGVsc2UNCiAgICAgew0KKyAgICAgIGlmIChwb2ZmX2hpZ2gpDQor
CXJlcyArPSAoX29mZjY0X3QpICpwb2ZmX2hpZ2ggPDwgMzI7DQorDQogICAg
ICAgLyogV2hlbiBuZXh0IHdlIHdyaXRlKCksIHdlIHdpbGwgY2hlY2sgdG8g
c2VlIGlmICp0aGlzKiBzZWVrIHdlbnQgYmV5b25kDQogCSB0aGUgZW5kIG9m
IHRoZSBmaWxlLCBhbmQgYmFjay1zZWVrIGFuZCBmaWxsIHdpdGggemVyb3Mg
aWYgc28gLSBESiAqLw0KICAgICAgIHNldF9kaWRfbHNlZWsgKCk7DQo=

---559023410-641078858-1069102622=:922--

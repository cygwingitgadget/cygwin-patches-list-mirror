Return-Path: <cygwin-patches-return-4357-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17006 invoked by alias); 12 Nov 2003 00:08:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16997 invoked from network); 12 Nov 2003 00:08:09 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Wed, 12 Nov 2003 00:08:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: dtable.cc typo
Message-ID: <Pine.GSO.4.56.0311111612280.9584@eos>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-675537891-1068594348=:9584"
Content-ID: <Pine.GSO.4.56.0311111806450.9584@eos>
X-SW-Source: 2003-q4/txt/msg00076.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-675537891-1068594348=:9584
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.56.0311111806451.9584@eos>
Content-length: 444

I don't know c++ much/at all, but this looks wrong to me.  I don't
understand how it even compiled before?  Feel free to slap me in the face
because you can switch on a struct in c++? :)

2003-11-11  Brian Ford  <ford@vss.fsi.com>

	* dtable.cc (build_fh_pc): Fix typo in device number switch.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-675537891-1068594348=:9584
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="dtable.cc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.56.0311111745480.9584@eos>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="dtable.cc.patch"
Content-length: 663

SW5kZXg6IGR0YWJsZS5jYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2R0YWJsZS5jYyx2
DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTE5DQpkaWZmIC11IC1wIC1yMS4x
MTkgZHRhYmxlLmNjDQotLS0gZHRhYmxlLmNjCTEgT2N0IDIwMDMgMTI6MzY6
MzkgLTAwMDAJMS4xMTkNCisrKyBkdGFibGUuY2MJMTEgTm92IDIwMDMgMjI6
MDg6NTkgLTAwMDANCkBAIC0zNDAsNyArMzQwLDcgQEAgYnVpbGRfZmhfcGMg
KHBhdGhfY29udiYgcGMpDQogCWZoID0gY25ldyAoZmhhbmRsZXJfZGV2X3Rh
cGUpICgpOw0KIAlicmVhazsNCiAgICAgICBkZWZhdWx0Og0KLQlzd2l0Y2gg
KHBjLmRldikNCisJc3dpdGNoIChwYy5kZXYuZGV2bikNCiAJICB7DQogCSAg
Y2FzZSBGSF9DT05TT0xFOg0KIAkgIGNhc2UgRkhfQ09OSU46DQo=

---559023410-675537891-1068594348=:9584--

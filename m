Return-Path: <cygwin-patches-return-4358-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22544 invoked by alias); 12 Nov 2003 00:25:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22535 invoked from network); 12 Nov 2003 00:25:42 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Wed, 12 Nov 2003 00:25:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: dtable.cc (build_fh_pc): serial port handling
In-Reply-To: <Pine.GSO.4.56.0311111612280.9584@eos>
Message-ID: <Pine.GSO.4.56.0311111819230.9584@eos>
References: <Pine.GSO.4.56.0311111612280.9584@eos>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-2073894790-1068596741=:9584"
X-SW-Source: 2003-q4/txt/msg00077.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-2073894790-1068596741=:9584
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 310

Here is one I think I do understand.

2003-11-11  Brian Ford  <ford@vss.fsi.com>

 	* dtable.cc (build_fh_pc): Use DEV_SERIAL_MAJOR to catch all
	serial ports.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-2073894790-1068596741=:9584
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="dtable.cc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.56.0311111825410.9584@eos>
Content-Description: 
Content-Disposition: attachment; filename="dtable.cc.patch"
Content-length: 1082

SW5kZXg6IGR0YWJsZS5jYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2R0YWJsZS5jYyx2
DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTE5DQpkaWZmIC11IC1wIC1yMS4x
MTkgZHRhYmxlLmNjDQotLS0gZHRhYmxlLmNjCTEgT2N0IDIwMDMgMTI6MzY6
MzkgLTAwMDAJMS4xMTkNCisrKyBkdGFibGUuY2MJMTIgTm92IDIwMDMgMDA6
MjU6MTYgLTAwMDANCkBAIC0zMzksNiArMzM5LDkgQEAgYnVpbGRfZmhfcGMg
KHBhdGhfY29udiYgcGMpDQogICAgICAgY2FzZSBERVZfVEFQRV9NQUpPUjoN
CiAJZmggPSBjbmV3IChmaGFuZGxlcl9kZXZfdGFwZSkgKCk7DQogCWJyZWFr
Ow0KKyAgICAgIGNhc2UgREVWX1NFUklBTF9NQUpPUjoNCisJZmggPSBjbmV3
IChmaGFuZGxlcl9zZXJpYWwpICgpOw0KKwlicmVhazsNCiAgICAgICBkZWZh
dWx0Og0KIAlzd2l0Y2ggKHBjLmRldikNCiAJICB7DQpAQCAtMzU1LDkgKzM1
OCw2IEBAIGJ1aWxkX2ZoX3BjIChwYXRoX2NvbnYmIHBjKQ0KIAkgICAgYnJl
YWs7DQogCSAgY2FzZSBGSF9XSU5ET1dTOg0KIAkgICAgZmggPSBjbmV3IChm
aGFuZGxlcl93aW5kb3dzKSAoKTsNCi0JICAgIGJyZWFrOw0KLQkgIGNhc2Ug
RkhfU0VSSUFMOg0KLQkgICAgZmggPSBjbmV3IChmaGFuZGxlcl9zZXJpYWwp
ICgpOw0KIAkgICAgYnJlYWs7DQogCSAgY2FzZSBGSF9GSUZPOg0KIAkgICAg
ZmggPSBjbmV3IChmaGFuZGxlcl9maWZvKSAoKTsNCg==

---559023410-2073894790-1068596741=:9584--

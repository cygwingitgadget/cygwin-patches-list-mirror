Return-Path: <cygwin-patches-return-1845-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21462 invoked by alias); 6 Feb 2002 19:19:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21419 invoked from network); 6 Feb 2002 19:19:06 -0000
Date: Thu, 07 Feb 2002 05:50:00 -0000
From: Alexander Gottwald <Alexander.Gottwald@informatik.tu-chemnitz.de>
To: cygwin-patches@cygwin.com
Subject: Tokenring support for network interfaces
Message-ID: <Pine.LNX.4.21.0202062016350.1196-300000@lupus.ago.vpn>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463760102-1134970777-1013023138=:1196"
X-SW-Source: 2002-q1/txt/msg00202.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463760102-1134970777-1013023138=:1196
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 300

Hi, the patch adds support for enumerating tokenring network interfaces.

bye
    ago
-- 
 Alexander.Gottwald@informatik.tu-chemnitz.de 
 http://www.gotti.org           ICQ: 126018723
 phone: +49 3725 349 80 80	mobile: +49 172 7854017
 4. Chemnitzer Linux-Tag http://www.tu-chemnitz.de/linux/tag/lt4

---1463760102-1134970777-1013023138=:1196
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=Changelog
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0202062018580.1196@lupus.ago.vpn>
Content-Description: 
Content-Disposition: attachment; filename=Changelog
Content-length: 208

MjAwMi0wMi0wNiAgQWxleGFuZGVyIEdvdHR3YWxkIDxBbGV4YW5kZXIuR290
dHdhbGRAczE5OTkudHVjaGVtbml0ei5kZT4NCg0KICAgICogbmV0LmNjIChn
ZXRfMmtfaWZjb25mKTogQ3JlYXRlIGludGVyZmFjZSBlbnRyaWVzIGZvciB0
b2tlbnJpbmcgY2FyZHMuDQo=

---1463760102-1134970777-1013023138=:1196
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="netdev-tokenring.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0202062018581.1196@lupus.ago.vpn>
Content-Description: 
Content-Disposition: attachment; filename="netdev-tokenring.diff"
Content-length: 1050

LS0tIG5ldC5jYwlXZWQgRmViICA2IDIwOjEwOjM0IDIwMDINCisrKyBuZXQu
Y2MubmV3CVdlZCBGZWIgIDYgMjA6MTA6MjIgMjAwMg0KQEAgLTE2NTIsNyAr
MTY1Miw3IEBAIHN0YXRpYyB2b2lkDQogZ2V0XzJrX2lmY29uZiAoc3RydWN0
IGlmY29uZiAqaWZjLCBpbnQgd2hhdCkNCiB7DQogICBpbnQgY250ID0gMDsN
Ci0gIGNoYXIgZXRoWzJdID0gIi8iLCBwcHBbMl0gPSAiLyIsIHNscFsyXSA9
ICIvIiwgc3ViWzJdID0gIjAiOw0KKyAgY2hhciBldGhbMl0gPSAiLyIsIHBw
cFsyXSA9ICIvIiwgc2xwWzJdID0gIi8iLCBzdWJbMl0gPSAiMCIsIHRva1sy
XSA9ICIvIjsNCiANCiAgIC8qIFVuaW9uIG1hcHMgYnVmZmVyIHRvIGNvcnJl
Y3Qgc3RydWN0ICovDQogICBzdHJ1Y3QgaWZyZXEgKmlmciA9IGlmYy0+aWZj
X3JlcTsNCkBAIC0xNjg1LDYgKzE2ODUsMTEgQEAgZ2V0XzJrX2lmY29uZiAo
c3RydWN0IGlmY29uZiAqaWZjLCBpbnQgdw0KIAkJICAvKiBTZXR1cCB0aGUg
aW50ZXJmYWNlIG5hbWUgKi8NCiAJCSAgc3dpdGNoIChpZnQtPnRhYmxlW2lm
X2NudF0uZHdUeXBlKQ0KIAkJICAgIHsNCisJCSAgICAgIGNhc2UgTUlCX0lG
X1RZUEVfVE9LRU5SSU5HOg0KKwkJCSAgKysqdG9rOw0KKwkJCXN0cmNweSAo
aWZyLT5pZnJfbmFtZSwgInRvayIpOw0KKwkJCXN0cmNhdCAoaWZyLT5pZnJf
bmFtZSwgdG9rKTsNCisJCQlicmVhazsNCiAJCSAgICAgIGNhc2UgTUlCX0lG
X1RZUEVfRVRIRVJORVQ6DQogCQkJaWYgKCpzdWIgPT0gJzAnKQ0KIAkJCSAg
KysqZXRoOw0K

---1463760102-1134970777-1013023138=:1196--

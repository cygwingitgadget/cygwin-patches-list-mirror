Return-Path: <cygwin-patches-return-2913-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4688 invoked by alias); 2 Sep 2002 13:30:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4673 invoked from network); 2 Sep 2002 13:30:41 -0000
Date: Mon, 02 Sep 2002 06:30:00 -0000
From: Joshua Daniel Franklin <joshua@iocc.com>
X-X-Originator: joshua@joshua.iocc.com
Reply-To: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: very small passwd patch
Message-ID: <Pine.CYG.4.44.0209020825510.1164-200000@joshua.iocc.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-2015742409-1030973287=:1164"
X-SW-Source: 2002-q3/txt/msg00361.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-2015742409-1030973287=:1164
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 259

I thought there was some mention of this already, but I guess
not. This adds a note about passwd not working with Win9x/ME.

ChangeLog:

2002-09-02  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

	* passwd.c (usage): Add note about Win9x/ME not working.

---559023410-2015742409-1030973287=:1164
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="passwd.c-patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.44.0209020828060.1164@joshua.iocc.com>
Content-Description: 
Content-Disposition: attachment; filename="passwd.c-patch"
Content-length: 574

LS0tIHBhc3N3ZC5jLW9yaWcJMjAwMi0wOS0wMiAwODoyMzo0MC4wMDAwMDAw
MDAgLTA1MDANCisrKyBwYXNzd2QuYwkyMDAyLTA5LTAyIDA4OjI0OjM4LjAw
MDAwMDAwMCAtMDUwMA0KQEAgLTI1OSw2ICsyNTksOCBAQCB1c2FnZSAoRklM
RSAqIHN0cmVhbSwgaW50IHN0YXR1cykNCiAgICJPdGhlciBvcHRpb25zOlxu
Ig0KICAgIiAtaCwgLS1oZWxwICAgICAgb3V0cHV0IHVzYWdlIGluZm9ybWF0
aW9uIGFuZCBleGl0XG4iDQogICAiIC12LCAtLXZlcnNpb24gICBvdXRwdXQg
dmVyc2lvbiBpbmZvcm1hdGlvbiBhbmQgZXhpdFxuIg0KKyAgIlxuIg0KKyAg
Ik5vdGU6IHBhc3N3ZCBkb2VzIG5vdCB3b3JrIG9uIFdpbjl4L01FIHN5c3Rl
bXMuXG4iDQogICAiIiwgcHJvZ19uYW1lLCBwcm9nX25hbWUpOw0KICAgZXhp
dCAoc3RhdHVzKTsNCiB9DQo=

---559023410-2015742409-1030973287=:1164--

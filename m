Return-Path: <cygwin-patches-return-4312-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12893 invoked by alias); 23 Oct 2003 23:06:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12884 invoked from network); 23 Oct 2003 23:06:10 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Thu, 23 Oct 2003 23:06:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: fhandler_base::ioctl (FIONBIO)
Message-ID: <Pine.GSO.4.56.0310231800010.823@eos>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-861614531-1066950369=:823"
X-SW-Source: 2003-q4/txt/msg00031.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-861614531-1066950369=:823
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 483

Any reason not to support this?  It seams to me that this patch just
parallels what is already in fhandler_base::fcntl (F_SETFL) for
O_NONBLOCK.

I was trying to fix this issue:

http://www.cygwin.com/ml/cygwin/2003-10/msg01159.html

2003-10-23  Brian Ford  <ford@vss.fsi.com>

	* fhandler.cc (fhandler_base::ioctl): Handle FIONBIO.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-861614531-1066950369=:823
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fhandler.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.56.0310231806090.823@eos>
Content-Description: 
Content-Disposition: attachment; filename="fhandler.patch"
Content-length: 1115

SW5kZXg6IGZoYW5kbGVyLmNjDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIu
Y2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjE1OQ0KZGlmZiAtdSAtcCAt
cjEuMTU5IGZoYW5kbGVyLmNjDQotLS0gZmhhbmRsZXIuY2MJMzAgU2VwIDIw
MDMgMjE6NDY6MDggLTAwMDAJMS4xNTkNCisrKyBmaGFuZGxlci5jYwkyMyBP
Y3QgMjAwMyAyMTozODo1MSAtMDAwMA0KQEAgLTkwOSwxMyArOTA5LDIxIEBA
IGZoYW5kbGVyX2Jhc2U6OmNsb3NlICgpDQogaW50DQogZmhhbmRsZXJfYmFz
ZTo6aW9jdGwgKHVuc2lnbmVkIGludCBjbWQsIHZvaWQgKmJ1ZikNCiB7DQor
ICBpbnQgcmVzOw0KKw0KICAgaWYgKGNtZCA9PSBGSU9OQklPKQ0KLSAgICBz
eXNjYWxsX3ByaW50ZiAoImlvY3RsIChGSU9OQklPLCAlcCkiLCBidWYpOw0K
KyAgICB7DQorICAgICAgc2V0X25vbmJsb2NraW5nICgqKGludCAqKSBidWYp
Ow0KKyAgICAgIHJlcyA9IDA7DQorICAgIH0NCiAgIGVsc2UNCi0gICAgc3lz
Y2FsbF9wcmludGYgKCJpb2N0bCAoJXgsICVwKSIsIGNtZCwgYnVmKTsNCisg
ICAgew0KKyAgICAgIHNldF9lcnJubyAoRUlOVkFMKTsNCisgICAgICByZXMg
PSAtMTsNCisgICAgfQ0KIA0KLSAgc2V0X2Vycm5vIChFSU5WQUwpOw0KLSAg
cmV0dXJuIC0xOw0KKyAgc3lzY2FsbF9wcmludGYgKCIlZCA9IGlvY3RsICgl
eCwgJXApIiwgcmVzLCBjbWQsIGJ1Zik7DQorICByZXR1cm4gcmVzOw0KIH0N
CiANCiBpbnQNCg==

---559023410-861614531-1066950369=:823--

Return-Path: <cygwin-patches-return-4308-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20760 invoked by alias); 23 Oct 2003 22:14:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20750 invoked from network); 23 Oct 2003 22:14:48 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Thu, 23 Oct 2003 22:14:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: fhandler_tty_slave::ioctl (FIONBIO) return status
Message-ID: <Pine.GSO.4.56.0310231702270.823@eos>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-726264360-1066947287=:823"
X-SW-Source: 2003-q4/txt/msg00027.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-726264360-1066947287=:823
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 431

I don't really understand the code here in depth, but could someone
explain to me why the attached trivial patch would'nt fix a minor bug?
Thanks.

2003-10-23  Brian Ford  <ford@vss.fsi.com>

	* fhandler_tty.c (fhandler_tty_slave::ioctl): Assure correct
	return value for FIONBIO.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-726264360-1066947287=:823
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fhandler_tty.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.56.0310231714470.823@eos>
Content-Description: 
Content-Disposition: attachment; filename="fhandler_tty.patch"
Content-length: 753

SW5kZXg6IGZoYW5kbGVyX3R0eS5jYw0KPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2ZoYW5k
bGVyX3R0eS5jYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTEzDQpkaWZm
IC11IC1wIC1yMS4xMTMgZmhhbmRsZXJfdHR5LmNjDQotLS0gZmhhbmRsZXJf
dHR5LmNjCTIyIE9jdCAyMDAzIDEwOjA3OjU4IC0wMDAwCTEuMTEzDQorKysg
ZmhhbmRsZXJfdHR5LmNjCTIzIE9jdCAyMDAzIDIxOjU2OjQ1IC0wMDAwDQpA
QCAtMTAzMyw2ICsxMDMzLDcgQEAgZmhhbmRsZXJfdHR5X3NsYXZlOjppb2N0
bCAodW5zaWduZWQgaW50IA0KICAgICAgIGJyZWFrOw0KICAgICBjYXNlIEZJ
T05CSU86DQogICAgICAgc2V0X25vbmJsb2NraW5nICgqKGludCAqKSBhcmcp
Ow0KKyAgICAgIGdldF90dHlwICgpLT5pb2N0bF9yZXR2YWwgPSAwOw0KICAg
ICAgIGdvdG8gb3V0Ow0KICAgICBkZWZhdWx0Og0KICAgICAgIHNldF9lcnJu
byAoRUlOVkFMKTsNCg==

---559023410-726264360-1066947287=:823--

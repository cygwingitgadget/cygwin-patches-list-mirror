Return-Path: <cygwin-patches-return-4311-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4094 invoked by alias); 23 Oct 2003 22:53:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4072 invoked from network); 23 Oct 2003 22:53:15 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Thu, 23 Oct 2003 22:53:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: fhandler_base::fcntl (F_SETFL)
Message-ID: <Pine.GSO.4.56.0310231746410.823@eos>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-572109243-1066949348=:823"
Content-ID: <Pine.GSO.4.56.0310231749360.823@eos>
X-SW-Source: 2003-q4/txt/msg00030.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-572109243-1066949348=:823
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.56.0310231749361.823@eos>
Content-length: 375

I'm working on my stupid pedantic patch tricks.  Can you tell? :)

2003-10-23  Brian Ford  <ford@vss.fsi.com>

	* fhandler.cc (fhandler_base::fcntl): Don't clobber O_APPEND when
	both O_NONBLOCK/O_NDELAY are set for F_SETFL.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-572109243-1066949348=:823
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="fhandler.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.56.0310231749080.823@eos>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="fhandler.patch"
Content-length: 920

SW5kZXg6IGZoYW5kbGVyLmNjDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIu
Y2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjE1OQ0KZGlmZiAtdSAtcCAt
cjEuMTU5IGZoYW5kbGVyLmNjDQotLS0gZmhhbmRsZXIuY2MJMzAgU2VwIDIw
MDMgMjE6NDY6MDggLTAwMDAJMS4xNTkNCisrKyBmaGFuZGxlci5jYwkyMyBP
Y3QgMjAwMyAyMjo0NjowNiAtMDAwMA0KQEAgLTEwNjgsNyArMTA2OCw3IEBA
IGludCBmaGFuZGxlcl9iYXNlOjpmY250bCAoaW50IGNtZCwgdm9pZCANCiAJ
ICAgU2V0IG9ubHkgdGhlIGZsYWcgdGhhdCBoYXMgYmVlbiBwYXNzZWQgaW4u
ICBJZiBib3RoIGFyZSBzZXQsIGp1c3QNCiAJICAgcmVjb3JkIE9fTk9OQkxP
Q0suICAgKi8NCiAJaWYgKChuZXdfZmxhZ3MgJiBPTERfT19OREVMQVkpICYm
IChuZXdfZmxhZ3MgJiBPX05PTkJMT0NLKSkNCi0JICBuZXdfZmxhZ3MgPSBP
X05PTkJMT0NLOw0KKyAgICAgICAgIG5ld19mbGFncyAmPSB+T0xEX09fTkRF
TEFZOw0KIAlzZXRfZmxhZ3MgKChnZXRfZmxhZ3MgKCkgJiB+YWxsb3dlZF9m
bGFncykgfCBuZXdfZmxhZ3MpOw0KICAgICAgIH0NCiAgICAgICByZXMgPSAw
Ow0K

---559023410-572109243-1066949348=:823--

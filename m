Return-Path: <cygwin-patches-return-5945-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14316 invoked by alias); 27 Jul 2006 03:18:34 -0000
Received: (qmail 14263 invoked by uid 22791); 27 Jul 2006 03:18:28 -0000
X-Spam-Check-By: sourceware.org
Received: from mailgw04.flightsafety.com (HELO mailgw04.flightsafety.com) (66.109.93.21)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 27 Jul 2006 03:18:20 +0000
Received: from mailgw04.flightsafety.com (localhost [127.0.0.1]) 	by mailgw04.flightsafety.com (8.13.6/8.13.1) with ESMTP id k6R3E1lX018746 	for <cygwin-patches@cygwin.com>; Wed, 26 Jul 2006 23:14:01 -0400 (EDT)
Received: from xgate2k3.flightsafety.com ([192.168.31.134]) 	by mailgw04.flightsafety.com (8.13.6/8.13.1) with ESMTP id k6R3E0Ur018727 	for <cygwin-patches@cygwin.com>; Wed, 26 Jul 2006 23:14:00 -0400 (EDT)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by xgate2k3.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 26 Jul 2006 23:18:39 -0400
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 26 Jul 2006 22:18:37 -0500
Date: Thu, 27 Jul 2006 03:18:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: get_readahead; remove duplicate
Message-ID: <Pine.CYG.4.58.0607262215190.2228@PC1163-8460-XP.flightsafety.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1197850080-1153970325=:2228"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00040.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1197850080-1153970325=:2228
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 345

One more tiny one.

2006-07-26  Brian ford  <Brian.Ford@FlightSafety.com>

	* fhandler.cc (fhandler_base::read): Call
	get_readahead_into_buffer instead of duplicating it.

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained crew...
---559023410-1197850080-1153970325=:2228
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="get_readahead.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0607262218450.2228@PC1163-8460-XP.flightsafety.com>
Content-Description: 
Content-Disposition: attachment; filename="get_readahead.patch"
Content-length: 1225

SW5kZXg6IGZoYW5kbGVyLmNjDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIu
Y2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjI1Nw0KZGlmZiAtdSAtcCAt
cjEuMjU3IGZoYW5kbGVyLmNjDQotLS0gZmhhbmRsZXIuY2MJMjUgSnVsIDIw
MDYgMTk6MjM6MjMgLTAwMDAJMS4yNTcNCisrKyBmaGFuZGxlci5jYwkyNyBK
dWwgMjAwNiAwMzoxMzo1MiAtMDAwMA0KQEAgLTcxNiwxNyArNzE2LDcgQEAg
dm9pZA0KIGZoYW5kbGVyX2Jhc2U6OnJlYWQgKHZvaWQgKmluX3B0ciwgc2l6
ZV90JiBsZW4pDQogew0KICAgY2hhciAqcHRyID0gKGNoYXIgKikgaW5fcHRy
Ow0KLSAgc3NpemVfdCBjb3BpZWRfY2hhcnMgPSAwOw0KLSAgaW50IGM7DQot
DQotICB3aGlsZSAobGVuKQ0KLSAgICBpZiAoKGMgPSBnZXRfcmVhZGFoZWFk
ICgpKSA8IDApDQotICAgICAgYnJlYWs7DQotICAgIGVsc2UNCi0gICAgICB7
DQotCXB0cltjb3BpZWRfY2hhcnMrK10gPSAodW5zaWduZWQgY2hhcikgKGMg
JiAweGZmKTsNCi0JbGVuLS07DQotICAgICAgfQ0KKyAgc3NpemVfdCBjb3Bp
ZWRfY2hhcnMgPSBnZXRfcmVhZGFoZWFkX2ludG9fYnVmZmVyIChwdHIsIGxl
bik7DQogDQogICBpZiAoY29waWVkX2NoYXJzICYmIGlzX3Nsb3cgKCkpDQog
ICAgIHsNCkBAIC03MzQsNiArNzI0LDcgQEAgZmhhbmRsZXJfYmFzZTo6cmVh
ZCAodm9pZCAqaW5fcHRyLCBzaXplXw0KICAgICAgIGdvdG8gb3V0Ow0KICAg
ICB9DQogDQorICBsZW4gLT0gY29waWVkX2NoYXJzOw0KICAgaWYgKCFsZW4p
DQogICAgIHsNCiAgICAgICBsZW4gPSAoc2l6ZV90KSBjb3BpZWRfY2hhcnM7
DQo=

---559023410-1197850080-1153970325=:2228--

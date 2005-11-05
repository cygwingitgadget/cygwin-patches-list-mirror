Return-Path: <cygwin-patches-return-5671-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3249 invoked by alias); 5 Nov 2005 16:41:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3229 invoked by uid 22791); 5 Nov 2005 16:41:41 -0000
Received: from mailgw01n.flightsafety.com (HELO mailgw01n.flightsafety.com) (66.109.90.23)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sat, 05 Nov 2005 16:41:41 +0000
Received: from mailgw01n.flightsafety.com (localhost [127.0.0.1])
	by mailgw01n.flightsafety.com (8.13.1/8.13.1) with ESMTP id jA5GesdH002517
	for <cygwin-patches@cygwin.com>; Sat, 5 Nov 2005 11:40:54 -0500 (EST)
Received: from xgate2k3.flightsafety.com ([192.168.31.134])
	by mailgw01n.flightsafety.com (8.13.1/8.13.1) with ESMTP id jA5Ges85002514
	for <cygwin-patches@cygwin.com>; Sat, 5 Nov 2005 11:40:54 -0500 (EST)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by xgate2k3.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 5 Nov 2005 11:41:37 -0500
Received: from PC1163-8460-XP.flightsafety.com ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 5 Nov 2005 10:41:36 -0600
Date: Sat, 05 Nov 2005 16:41:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH] Translate INSUFFICIENT_RESOURCES errno
Message-ID: <Pine.CYG.4.58.0511051037180.508@PC1163-8460-XP.flightsafety.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-560884333-1131208895=:508"
X-SW-Source: 2005-q4/txt/msg00013.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-560884333-1131208895=:508
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 429

Trivial patch to do subject.  This would have made the error in this
thread more consistent:

http://cygwin.com/ml/cygwin/2005-11/msg00110.html

2005-11-05  Brian Ford  <Brian.Ford@FlightSafety.com>

	* errno.cc (errmap): Handle INSUFFICIENT_RESOURCES.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
---559023410-560884333-1131208895=:508
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="errno.cc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0511051041350.508@PC1163-8460-XP.flightsafety.com>
Content-Description: 
Content-Disposition: attachment; filename="errno.cc.patch"
Content-length: 769

SW5kZXg6IGVycm5vLmNjDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1Mg
ZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vZXJybm8uY2Msdg0K
cmV0cmlldmluZyByZXZpc2lvbiAxLjYxDQpkaWZmIC11IC1wIC1yMS42MSBl
cnJuby5jYw0KLS0tIGVycm5vLmNjCTI2IFNlcCAyMDA1IDE1OjI3OjE1IC0w
MDAwCTEuNjENCisrKyBlcnJuby5jYwk1IE5vdiAyMDA1IDE2OjM2OjU5IC0w
MDAwDQpAQCAtNzEsNiArNzEsNyBAQCBzdGF0aWMgTk9fQ09QWSBzdHJ1Y3QN
CiAgIFggKEZJTEVfTk9UX0ZPVU5ELAkJRU5PRU5UKSwNCiAgIFggKEhBTkRM
RV9ESVNLX0ZVTEwsCQlFTk9TUEMpLA0KICAgWCAoSEFORExFX0VPRiwJCUVO
T0RBVEEpLA0KKyAgWCAoSU5TVUZGSUNJRU5UX1JFU09VUkNFUywJRUFHQUlO
KSwNCiAgIFggKElOVkFMSURfQUREUkVTUywJCUVJTlZBTCksDQogICBYIChJ
TlZBTElEX0FUX0lOVEVSUlVQVF9USU1FLAlFSU5UUiksDQogICBYIChJTlZB
TElEX0JMT0NLX0xFTkdUSCwJRUlPKSwNCg==

---559023410-560884333-1131208895=:508--

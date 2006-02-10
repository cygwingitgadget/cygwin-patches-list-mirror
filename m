Return-Path: <cygwin-patches-return-5740-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24032 invoked by alias); 10 Feb 2006 23:52:12 -0000
Received: (qmail 24021 invoked by uid 22791); 10 Feb 2006 23:52:12 -0000
X-Spam-Check-By: sourceware.org
Received: from mailgw01n.flightsafety.com (HELO mailgw01n.flightsafety.com) (66.109.90.23)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 10 Feb 2006 23:52:10 +0000
Received: from mailgw01n.flightsafety.com (localhost [127.0.0.1]) 	by mailgw01n.flightsafety.com (8.13.1/8.13.1) with ESMTP id k1ANpemM010643 	for <cygwin-patches@cygwin.com>; Fri, 10 Feb 2006 18:51:40 -0500 (EST)
Received: from VXS2.flightsafety.com (internal-31-146.flightsafety.com [192.168.31.146]) 	by mailgw01n.flightsafety.com (8.13.1/8.13.1) with ESMTP id k1ANpdLR010638 	for <cygwin-patches@cygwin.com>; Fri, 10 Feb 2006 18:51:39 -0500 (EST)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by VXS2.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 10 Feb 2006 18:52:55 -0500
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 10 Feb 2006 17:52:54 -0600
Date: Fri, 10 Feb 2006 23:52:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: clock_[get|set]time timespec conversions
Message-ID: <Pine.CYG.4.58.0602101743300.1780@PC1163-8460-XP.flightsafety.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1720703112-1139615625=:1780"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00049.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1720703112-1139615625=:1780
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 587

It's late and I haven't had time to test this, but I thought it deserved a
look.  There appears to be some confusion (at least in my head) about the
units of gtod.resolution() and minperiod.

2006-02-10  Brian Ford  <Brian.Ford@FlightSafety.com>

	* times.cc (clock_gettime): Properly convert ms period to struct
	timespec.
	(clock_settime): Likewise reverse convert.

Let me know if I'm just crazy ;-).  Thanks.

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
---559023410-1720703112-1139615625=:1780
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="times.cc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0602101753450.1780@PC1163-8460-XP.flightsafety.com>
Content-Description: 
Content-Disposition: attachment; filename="times.cc.patch"
Content-length: 1164

SW5kZXg6IHRpbWVzLmNjDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1Mg
ZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vdGltZXMuY2Msdg0K
cmV0cmlldmluZyByZXZpc2lvbiAxLjg3DQpkaWZmIC11IC1wIC1yMS44NyB0
aW1lcy5jYw0KLS0tIHRpbWVzLmNjCTEzIERlYyAyMDA1IDAyOjU1OjExIC0w
MDAwCTEuODcNCisrKyB0aW1lcy5jYwkxMCBGZWIgMjAwNiAyMzo0MjoxOSAt
MDAwMA0KQEAgLTcxMSw4ICs3MTEsOCBAQCBjbG9ja19nZXRyZXMgKGNsb2Nr
aWRfdCBjbGtfaWQsIHN0cnVjdCB0DQogDQogICBEV09SRCBwZXJpb2QgPSBn
dG9kLnJlc29sdXRpb24gKCk7DQogDQotICB0cC0+dHZfc2VjID0gcGVyaW9k
IC8gMTAwMDAwMDsNCi0gIHRwLT50dl9uc2VjID0gKHBlcmlvZCAlIDEwMDAw
MDApICogMTAwMDsNCisgIHRwLT50dl9zZWMgPSBwZXJpb2QgLyAxMDAwOw0K
KyAgdHAtPnR2X25zZWMgPSAocGVyaW9kICUgMTAwMCkgKiAxMDAwMDAwOw0K
IA0KICAgcmV0dXJuIDA7DQogfQ0KQEAgLTczMCw3ICs3MzAsNyBAQCBjbG9j
a19zZXRyZXMgKGNsb2NraWRfdCBjbGtfaWQsIHN0cnVjdCB0DQogICBpZiAo
cGVyaW9kX3NldCkNCiAgICAgdGltZUVuZFBlcmlvZCAobWlucGVyaW9kKTsN
CiANCi0gIERXT1JEIHBlcmlvZCA9ICh0cC0+dHZfc2VjICogMTAwMCkgKyAo
KHRwLT50dl9uc2VjKSAvIDEwMDApOw0KKyAgRFdPUkQgcGVyaW9kID0gKHRw
LT50dl9zZWMgKiAxMDAwKSArICgodHAtPnR2X25zZWMpIC8gMTAwMDAwMCk7
DQogDQogICBpZiAodGltZUJlZ2luUGVyaW9kIChwZXJpb2QpKQ0KICAgICB7
DQo=

---559023410-1720703112-1139615625=:1780--

Return-Path: <cygwin-patches-return-5954-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6502 invoked by alias); 17 Aug 2006 20:09:02 -0000
Received: (qmail 6492 invoked by uid 22791); 17 Aug 2006 20:09:01 -0000
X-Spam-Check-By: sourceware.org
Received: from mailgw01n.flightsafety.com (HELO mailgw01n.flightsafety.com) (66.109.90.23)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 17 Aug 2006 20:08:48 +0000
Received: from VXS2.flightsafety.com (internal-31-146.flightsafety.com [192.168.31.146]) 	by mailgw01n.flightsafety.com (8.13.6.20060614/8.13.6) with ESMTP id k7HK8mfu008165 	for <cygwin-patches@cygwin.com>; Thu, 17 Aug 2006 16:08:48 -0400 (EDT) 	(envelope-from brian.ford@flightsafety.com)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by VXS2.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Thu, 17 Aug 2006 16:09:09 -0400
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Thu, 17 Aug 2006 15:09:08 -0500
Date: Thu, 17 Aug 2006 20:09:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Prevent closing a NULL pinfo handle
Message-ID: <Pine.CYG.4.58.0608171502550.2408@PC1163-8460-XP.flightsafety.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-377433483-1155845353=:2408"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00049.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-377433483-1155845353=:2408
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 801

I confess to not having a clue what is really going on here, but I'm
seeing the following errors from a CVS build (yes, I know debugging has
been turned on), and it looks like this would be the right thing to do:

CloseHandle(moreinfo->myself_pinfo) 0x0 failed
child_info_spawn::~child_info_spawn():125, Win32 error 6

2006-08-17  Brian Ford  <Brian.Ford@FlightSafety.com>

	* child_info.h (~child_info_spawn): Prevent closing a NULL handle.

Although, I suspect if the correct thing to do were that simple, it would
already have been noticed and fixed?  And yes, I know that functionally
this doesn't make much difference.

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained crew...
.


---559023410-377433483-1155845353=:2408
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="child_info.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0608171509130.2408@PC1163-8460-XP.flightsafety.com>
Content-Description: 
Content-Disposition: attachment; filename="child_info.patch"
Content-length: 728

SW5kZXg6IGNoaWxkX2luZm8uaA0KPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
UkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2NoaWxkX2lu
Zm8uaCx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNjkNCmRpZmYgLXUgLXAg
LXIxLjY5IGNoaWxkX2luZm8uaA0KLS0tIGNoaWxkX2luZm8uaAk2IEp1bCAy
MDA2IDE3OjE2OjM2IC0wMDAwCTEuNjkNCisrKyBjaGlsZF9pbmZvLmgJMTcg
QXVnIDIwMDYgMjA6MDE6NTUgLTAwMDANCkBAIC0xMjIsNyArMTIyLDggQEAg
cHVibGljOg0KIAkgICAgICBjZnJlZSAoKmUpOw0KIAkgICAgY2ZyZWUgKG1v
cmVpbmZvLT5lbnZwKTsNCiAJICB9DQotCUNsb3NlSGFuZGxlIChtb3JlaW5m
by0+bXlzZWxmX3BpbmZvKTsNCisJaWYgKG1vcmVpbmZvLT5teXNlbGZfcGlu
Zm8pDQorCSAgQ2xvc2VIYW5kbGUgKG1vcmVpbmZvLT5teXNlbGZfcGluZm8p
Ow0KIAljZnJlZSAobW9yZWluZm8pOw0KICAgICAgIH0NCiAgIH0NCg==

---559023410-377433483-1155845353=:2408--

Return-Path: <cygwin-patches-return-6019-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23410 invoked by alias); 2 Jan 2007 18:05:12 -0000
Received: (qmail 23398 invoked by uid 22791); 2 Jan 2007 18:05:11 -0000
X-Spam-Check-By: sourceware.org
Received: from mailgw01n.flightsafety.com (HELO mailgw01n.flightsafety.com) (66.109.90.23)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 02 Jan 2007 18:04:56 +0000
Received: from mailgw01n.flightsafety.com (localhost [127.0.0.1]) 	by localhost (Postfix) with SMTP id 6AE3298C72 	for <cygwin-patches@cygwin.com>; Tue,  2 Jan 2007 13:05:18 -0500 (EST)
Received: from dradmast.flightsafety.com (unknown [192.168.93.130]) 	by mailgw01n.flightsafety.com (Postfix) with ESMTP id 6D89E98C7C 	for <cygwin-patches@cygwin.com>; Tue,  2 Jan 2007 13:05:17 -0500 (EST)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by dradmast.flightsafety.com with Microsoft SMTPSVC(6.0.3790.211); 	 Tue, 2 Jan 2007 12:04:52 -0600
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Tue, 2 Jan 2007 12:04:51 -0600
Date: Tue, 02 Jan 2007 18:05:00 -0000
From: Brian Ford <Brian.Ford@FlightSafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Increase st_blksize to 64k
Message-ID: <Pine.CYG.4.58.0701021158490.2464@PC1163-8460-XP.flightsafety.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1368531373-1167761089=:2464"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00000.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1368531373-1167761089=:2464
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 496

As suggested here:

http://cygwin.com/ml/cygwin/2006-12/msg00911.html

2007-01-02  Brian Ford  <Brian.Ford@FlightSafety.com>

	* fhandler.cc (fhandler_base::fstat): Use system page size (64k)
	as the st_blksize prefered I/O size for improved performance.
	* fhandler_disk_file.cc (fhandler_base::fstat_helper): Likewise.

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained crew...


---559023410-1368531373-1167761089=:2464
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="st_blksize.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0701021204491.2464@PC1163-8460-XP.flightsafety.com>
Content-Description: 
Content-Disposition: attachment; filename="st_blksize.patch"
Content-length: 1692

SW5kZXg6IGZoYW5kbGVyLmNjDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIu
Y2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjI3Mw0KZGlmZiAtdSAtcCAt
cjEuMjczIGZoYW5kbGVyLmNjDQotLS0gZmhhbmRsZXIuY2MJMTEgRGVjIDIw
MDYgMTg6NTU6MjggLTAwMDAJMS4yNzMNCisrKyBmaGFuZGxlci5jYwkyIEph
biAyMDA3IDE3OjU1OjA3IC0wMDAwDQpAQCAtMTMyOCw3ICsxMzI4LDcgQEAg
ZmhhbmRsZXJfYmFzZTo6ZnN0YXQgKHN0cnVjdCBfX3N0YXQ2NCAqYg0KICAg
YnVmLT5zdF91aWQgPSBnZXRldWlkMzIgKCk7DQogICBidWYtPnN0X2dpZCA9
IGdldGVnaWQzMiAoKTsNCiAgIGJ1Zi0+c3RfbmxpbmsgPSAxOw0KLSAgYnVm
LT5zdF9ibGtzaXplID0gU19CTEtTSVpFOw0KKyAgYnVmLT5zdF9ibGtzaXpl
ID0gZ2V0cGFnZXNpemUgKCk7DQogICB0aW1lX2FzX3RpbWVzdHJ1Y190ICgm
YnVmLT5zdF9jdGltKTsNCiAgIGJ1Zi0+c3RfYXRpbSA9IGJ1Zi0+c3RfbXRp
bSA9IGJ1Zi0+c3RfY3RpbTsNCiAgIHJldHVybiAwOw0KSW5kZXg6IGZoYW5k
bGVyX2Rpc2tfZmlsZS5jYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2Rp
c2tfZmlsZS5jYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMjAwDQpkaWZm
IC11IC1wIC1yMS4yMDAgZmhhbmRsZXJfZGlza19maWxlLmNjDQotLS0gZmhh
bmRsZXJfZGlza19maWxlLmNjCTIxIERlYyAyMDA2IDEwOjU5OjQ3IC0wMDAw
CTEuMjAwDQorKysgZmhhbmRsZXJfZGlza19maWxlLmNjCTIgSmFuIDIwMDcg
MTc6NTU6MDcgLTAwMDANCkBAIC00MzYsNyArNDM2LDcgQEAgZmhhbmRsZXJf
YmFzZTo6ZnN0YXRfaGVscGVyIChzdHJ1Y3QgX19zdA0KICAgZWxzZQ0KICAg
ICBidWYtPnN0X2lubyA9IGdldF9uYW1laGFzaCAoKTsNCiANCi0gIGJ1Zi0+
c3RfYmxrc2l6ZSA9IFNfQkxLU0laRTsNCisgIGJ1Zi0+c3RfYmxrc2l6ZSA9
IGdldHBhZ2VzaXplICgpOw0KIA0KICAgaWYgKG5BbGxvY1NpemUgPj0gMExM
KQ0KICAgICAvKiBBIHN1Y2Nlc3NmdWwgTnRRdWVyeUluZm9ybWF0aW9uRmls
ZSByZXR1cm5zIHRoZSBhbGxvY2F0aW9uIHNpemUNCg==

---559023410-1368531373-1167761089=:2464--

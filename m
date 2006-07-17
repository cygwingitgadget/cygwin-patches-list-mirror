Return-Path: <cygwin-patches-return-5923-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28807 invoked by alias); 17 Jul 2006 17:25:25 -0000
Received: (qmail 28728 invoked by uid 22791); 17 Jul 2006 17:25:24 -0000
X-Spam-Check-By: sourceware.org
Received: from mailgw01n.flightsafety.com (HELO mailgw01n.flightsafety.com) (66.109.90.23)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 17 Jul 2006 17:25:14 +0000
Received: from VXS3.flightsafety.com (internal-31-147.flightsafety.com [192.168.31.147]) 	by mailgw01n.flightsafety.com (8.13.6.20060614/8.13.6) with ESMTP id k6HHP9nw016693 	for <cygwin-patches@cygwin.com>; Mon, 17 Jul 2006 13:25:09 -0400 (EDT) 	(envelope-from brian.ford@flightsafety.com)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by VXS3.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Mon, 17 Jul 2006 13:25:27 -0400
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Mon, 17 Jul 2006 12:25:26 -0500
Date: Mon, 17 Jul 2006 17:25:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: allow read into untouched noreserve mappings
In-Reply-To: <20060714155523.GL8759@calimero.vinschen.de>
Message-ID: <Pine.CYG.4.58.0607171205100.2704@PC1163-8460-XP.flightsafety.com>
References: <Pine.CYG.4.58.0607121030410.3792@PC1163-8460-XP.flightsafety.com>  <20060712165900.GQ8759@calimero.vinschen.de>  <Pine.CYG.4.58.0607121318080.2284@PC1163-8460-XP.flightsafety.com>  <20060712202215.GS8759@calimero.vinschen.de>  <Pine.CYG.4.58.0607121536330.3784@PC1163-8460-XP.flightsafety.com>  <20060713103431.GA17383@calimero.vinschen.de>  <Pine.CYG.4.58.0607130933400.1164@PC1163-8460-XP.flightsafety.com>  <Pine.CYG.4.58.0607131315110.3316@PC1163-8460-XP.flightsafety.com>  <20060714091601.GD8759@calimero.vinschen.de>  <Pine.CYG.4.58.0607140931050.3316@PC1163-8460-XP.flightsafety.com>  <20060714155523.GL8759@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1041243210-1153157125=:2704"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00018.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1041243210-1153157125=:2704
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 905

On Fri, 14 Jul 2006, Corinna Vinschen wrote:

> The idea is to have features working for most cases and then
> to get it working gradually better.

Well, in that spirit then, the attached patch allows read and varients to
use untouched noreserve mappings as buffers.  If this is accepted, I'll
consider doing something similar for recvmsg and recvfrom.  That should
cover the majority of cases, I believe.

2006-07-17  Brian Ford  <Brian.Ford@FlightSafety.com>

	* winsup.h (mmap_commit_noreserve_pages): New prototype.
	* mmap.cc (fhandler_base::raw_read): New function.
	* fhandler.cc (fhandler_base::raw_read): Call it for
	INVALID_PARAMETER errors, and retry on success to allow
	reads into untouched MAP_NORESERVE buffers.

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained crew...
.


---559023410-1041243210-1153157125=:2704
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="read_noreserve.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0607171225240.2704@PC1163-8460-XP.flightsafety.com>
Content-Description: 
Content-Disposition: attachment; filename="read_noreserve.patch"
Content-length: 4946

SW5kZXg6IGZoYW5kbGVyLmNjDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIu
Y2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjI1Ng0KZGlmZiAtdSAtcCAt
dSAtcCAtcjEuMjU2IGZoYW5kbGVyLmNjDQotLS0gZmhhbmRsZXIuY2MJMTMg
SnVsIDIwMDYgMjA6NTY6MjQgLTAwMDAJMS4yNTYNCisrKyBmaGFuZGxlci5j
YwkxNyBKdWwgMjAwNiAxNzowMjoxMCAtMDAwMA0KQEAgLTIyMyw4ICsyMjMs
MTAgQEAgZmhhbmRsZXJfYmFzZTo6cmF3X3JlYWQgKHZvaWQgKnB0ciwgc2l6
ZQ0KIA0KICAgSEFORExFIGggPSBOVUxMOwkvKiBncnVtYmxlICovDQogICBp
bnQgcHJpbyA9IDA7CQkvKiBkaXR0byAqLw0KKyAgaW50IHRyeV9ub3Jlc2Vy
dmUgPSAxOw0KICAgRFdPUkQgbGVuID0gdWxlbjsNCiANCityZXRyeToNCiAg
IHVsZW4gPSAoc2l6ZV90KSAtMTsNCiAgIGlmIChyZWFkX3N0YXRlKQ0KICAg
ICB7DQpAQCAtMjU5LDggKzI2MSwxNCBAQCBmaGFuZGxlcl9iYXNlOjpyYXdf
cmVhZCAodm9pZCAqcHRyLCBzaXplDQogCSAgICAgIGJ5dGVzX3JlYWQgPSAw
Ow0KIAkgICAgICBicmVhazsNCiAJICAgIH0NCi0JY2FzZSBFUlJPUl9JTlZB
TElEX0ZVTkNUSU9OOg0KIAljYXNlIEVSUk9SX0lOVkFMSURfUEFSQU1FVEVS
Og0KKwkgIGlmICh0cnlfbm9yZXNlcnZlKQ0KKwkgICAgew0KKwkgICAgICB0
cnlfbm9yZXNlcnZlID0gMDsNCisJICAgICAgaWYgKG1tYXBfY29tbWl0X25v
cmVzZXJ2ZV9wYWdlcyAocHRyLCBsZW4pKQ0KKwkJZ290byByZXRyeTsNCisJ
ICAgIH0NCisJY2FzZSBFUlJPUl9JTlZBTElEX0ZVTkNUSU9OOg0KIAljYXNl
IEVSUk9SX0lOVkFMSURfSEFORExFOg0KIAkgIGlmIChwYy5pc2RpciAoKSkN
CiAJICAgIHsNCkluZGV4OiBtbWFwLmNjDQo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09DQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vbW1h
cC5jYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTMwDQpkaWZmIC11IC1w
IC11IC1wIC1yMS4xMzAgbW1hcC5jYw0KLS0tIG1tYXAuY2MJMTMgSnVsIDIw
MDYgMTA6Mjk6MjEgLTAwMDAJMS4xMzANCisrKyBtbWFwLmNjCTE3IEp1bCAy
MDA2IDE3OjAyOjExIC0wMDAwDQpAQCAtODk5LDYgKzg5OSw1OCBAQCBtYXA6
OmRlbF9saXN0ICh1bnNpZ25lZCBpKQ0KICAgICB9DQogfQ0KIA0KKy8qIFRo
aXMgZnVuY3Rpb24gc2hvdWxkIGJlIGNhbGxlZCBieSBhbGwgQ3lnd2luIGZ1
bmN0aW9ucyB0aGF0IHdhbnQgdG8NCisgICBzdXBwb3J0IHBhc3Npbmcgbm9y
ZXNlcnZlIG1tYXAgcGFnZSBhZGRyZXNzZXMgdG8gV2luZG93cyBzeXN0ZW0g
Y2FsbHMuDQorICAgSXQgc2hvdWxkIGJlIGNhbGxlZCBvbmx5IGFmdGVyIGEg
c3lzdGVtIGNhbGwgaW5kaWNhdGVzIHRoYXQgdGhlDQorICAgYXBwbGljYXRp
b24gYnVmZmVyIHBhc3NlZCBoYWQgYW4gaW52YWxpZCB2aXJ0dWFsIGFkZHJl
c3MgdG8gYXZvaWQNCisgICBhbnkgcGVyZm9ybWFuY2UgaW1wYWN0IGluIG5v
bi1ub3Jlc2VydmUgY2FzZXMuDQorICAgDQorICAgQ2hlY2sgaWYgdGhlIGFk
ZHJlc3MgcmFuZ2UgaXMgYWxsIHdpdGhpbiAibm9yZXNlcnZlIiBtbWFwIHJl
Z2lvbnMuDQorICAgSWYgc28sIGNhbGwgVmlydHVhbEFsbG9jIHRvIGNvbW1p
dCB0aGUgcGFnZXMgYW5kIHJldHVybiAxIG9uIHN1Y2Nlc3MuDQorICAgSWYg
VmlydHVhbEFsbG9jIGZhaWxzLCByYWlzZSBTSUdCVVMgYW5kIHJldHVybiAw
LiAgQWxzbyByZXR1cm4gMCBpZg0KKyAgIHRoZSBhZGRyZXNzIHJhbmdlIHdh
cyBub3QgY292ZXJlZCBieSBhIG5vcmVzZXJ2ZSBtYXAuDQorDQorICAgT24g
c3VjY2VzcywgdGhlIGNhbGxpbmcgQ3lnd2luIGZ1bmN0aW9uIHNob3VsZCBy
ZXRyeSB0aGUgV2luZG93cyBzeXN0ZW0NCisgICBjYWxsLiAqLw0KK2ludA0K
K21tYXBfY29tbWl0X25vcmVzZXJ2ZV9wYWdlcyAodm9pZCAqYWRkciwgc2l6
ZV90IGxlbikNCit7DQorICBsaXN0ICptYXBfbGlzdCA9IG1tYXBwZWRfYXJl
YXMuZ2V0X2xpc3RfYnlfZmQgKC0xKTsNCisNCisgIGlmIChtYXBfbGlzdCA9
PSBOVUxMKQ0KKyAgICByZXR1cm4gMDsNCisNCisgIHdoaWxlIChsZW4gPiAw
KSANCisgICAgew0KKyAgICAgIGNhZGRyX3QgdV9hZGRyOw0KKyAgICAgIERX
T1JEIHVfbGVuOw0KKyAgICAgIGxvbmcgcmVjb3JkX2lkeCA9IG1hcF9saXN0
LT5zZWFyY2hfcmVjb3JkICgoY2FkZHJfdClhZGRyLCAxLA0KKwkJCQkJCSB1
X2FkZHIsIHVfbGVuLCAtMSk7DQorICAgICAgaWYgKHJlY29yZF9pZHggPCAw
KQ0KKwlyZXR1cm4gMDsNCisNCisgICAgICBtbWFwX3JlY29yZCAqcmVjID0g
bWFwX2xpc3QtPmdldF9yZWNvcmQgKHJlY29yZF9pZHgpOw0KKyAgICAgIGlm
ICghcmVjLT5ub3Jlc2VydmUgKCkpDQorCXJldHVybiAwOw0KKw0KKyAgICAg
IHNpemVfdCBjb21taXRfbGVuID0gdV9sZW4gLSAoKGNoYXIgKilhZGRyIC0g
dV9hZGRyKTsNCisgICAgICBpZiAoY29tbWl0X2xlbiA+IGxlbikNCisJY29t
bWl0X2xlbiA9IGxlbjsNCisNCisgICAgICBpZiAoVmlydHVhbEFsbG9jIChh
ZGRyLCBjb21taXRfbGVuLCBNRU1fQ09NTUlULCByZWMtPmdlbl9wcm90ZWN0
ICgpKQ0KKwkgID09IE5VTEwpDQorICAgICAgew0KKwlyYWlzZShTSUdCVVMp
Ow0KKwlyZXR1cm4gMDsNCisgICAgICB9DQorDQorICAgICAgYWRkciAgPSAo
Y2hhciAqKWFkZHIgKyBjb21taXRfbGVuOw0KKyAgICAgIGxlbiAgLT0gY29t
bWl0X2xlbjsNCisgICAgfQ0KKw0KKyAgICByZXR1cm4gMTsNCit9DQorDQog
LyogVGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgZnJvbSBleGNlcHRpb25faGFu
ZGxlciB3aGVuIGEgc2VnbWVudGF0aW9uDQogICAgdmlvbGF0aW9uIGhhcyBo
YXBwZW5lZC4gIFdlIGhhdmUgdHdvIGNhc2VzIHRvIGNoZWNrIGhlcmUuDQog
ICAgDQpJbmRleDogd2luc3VwLmgNCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi93aW5zdXAu
aCx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTg5DQpkaWZmIC11IC1wIC11
IC1wIC1yMS4xODkgd2luc3VwLmgNCi0tLSB3aW5zdXAuaAkxMyBKdWwgMjAw
NiAwODozMzozNCAtMDAwMAkxLjE4OQ0KKysrIHdpbnN1cC5oCTE3IEp1bCAy
MDA2IDE3OjAyOjExIC0wMDAwDQpAQCAtMzAwLDYgKzMwMCw3IEBAIHNpemVf
dCBnZXRzeXN0ZW1wYWdlc2l6ZSAoKTsNCiAvKiBtbWFwIGZ1bmN0aW9ucy4g
Ki8NCiB2b2lkIG1tYXBfaW5pdCAoKTsNCiBpbnQgbW1hcF9pc19hdHRhY2hl
ZF9vcl9ub3Jlc2VydmVfcGFnZSAoVUxPTkdfUFRSIGFkZHIpOw0KK2ludCBt
bWFwX2NvbW1pdF9ub3Jlc2VydmVfcGFnZXMgKHZvaWQgKmFkZHIsIHNpemVf
dCBsZW4pOw0KIA0KIGludCB3aW5wcmlvX3RvX25pY2UgKERXT1JEKSBfX2F0
dHJpYnV0ZV9fICgocmVncGFybSAoMSkpKTsNCiBEV09SRCBuaWNlX3RvX3dp
bnByaW8gKGludCAmKSBfX2F0dHJpYnV0ZV9fICgocmVncGFybSAoMSkpKTsN
Cg==

---559023410-1041243210-1153157125=:2704--

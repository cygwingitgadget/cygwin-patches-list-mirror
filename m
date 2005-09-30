Return-Path: <cygwin-patches-return-5657-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30603 invoked by alias); 30 Sep 2005 23:39:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30564 invoked by uid 22791); 30 Sep 2005 23:39:37 -0000
Received: from mailgw02.flightsafety.com (HELO mailgw02.flightsafety.com) (66.109.90.21)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 30 Sep 2005 23:39:37 +0000
Received: from mailgw02.flightsafety.com (localhost [127.0.0.1])
	by mailgw02.flightsafety.com (8.13.1/8.13.1) with ESMTP id j8UNcCCM017625
	for <cygwin-patches@cygwin.com>; Fri, 30 Sep 2005 19:38:12 -0400 (EDT)
Received: from VXS2.flightsafety.com (internal-31-146.flightsafety.com [192.168.31.146])
	by mailgw02.flightsafety.com (8.13.1/8.13.1) with ESMTP id j8UNcBfQ017622
	for <cygwin-patches@cygwin.com>; Fri, 30 Sep 2005 19:38:12 -0400 (EDT)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by VXS2.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 30 Sep 2005 19:39:34 -0400
Received: from PC1163-8460-XP.flightsafety.com ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 30 Sep 2005 18:39:33 -0500
Date: Fri, 30 Sep 2005 23:39:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH] Re: IP_MULTICAST_IF et all / Winsock[2] value conflict
In-Reply-To: <20050930200048.GE12256@calimero.vinschen.de>
Message-ID: <Pine.CYG.4.58.0509301817260.1904@PC1163-8460-XP.flightsafety.com>
References: <Pine.CYG.4.58.0509291103421.2244@PC1163-8460-XP.flightsafety.com>
 <20050929165053.GU12256@calimero.vinschen.de>
 <Pine.CYG.4.58.0509291152490.2244@PC1163-8460-XP.flightsafety.com>
 <20050930081701.GB27423@calimero.vinschen.de>
 <Pine.CYG.4.58.0509300947210.2244@PC1163-8460-XP.flightsafety.com>
 <20050930200048.GE12256@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-965003248-1128123573=:1904"
X-SW-Source: 2005-q3/txt/msg00112.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-965003248-1128123573=:1904
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 2099

On Fri, 30 Sep 2005, Corinna Vinschen wrote:
> On Sep 30 10:07, Brian Ford wrote:
> > We can simply translate the current constant Winsock 1 values to Winsock 2
> > ones when necessary in cygwin_[set|get]sockopt.  There are only 8 values
> > that need changing, I think.
>
> Yeah, I think that we can basically do something like this.  But we
> should not try to guess what the application really meant to do
> based on the incoming value and the winsock version in use.

Why not?  There is no guessing involved if we do not change Cygwin's
system headers.  If someone used a Windows header directly and called the
Cygwin [set|get]sockopt, well then..., that's their fault.

> Actually we have two states, applications built before we changed the
> header file and applications built after we changed the header file.

Let's just not change it ;-).

> This is visible by an internal version number maintained by Cygwin.

Ok, I'm not aware of how that works.

> The problem is that the value can be simply wrong today, because the
> application is built against the old (wrong) header file, but running
> under a Cygwin which is run-time loading Winsock2.  Anyway, the idea
> to convert the incoming values based on some internal information is
> a good one.

Ok, here's an untested (as yet) patch:

2005-09-30  Brian Ford  <Brian.Ford@FlightSafety.com>

	* net.cc (ws2ip_optname): New function to convert IP_* socket
	options from Winsock 1.1 values to Winsock 2 ones.
	(cygwin_setsockopt): Use it.
	(cygwin_getsockopt): Likewise.

> I want to drop Winsock1 support nevertheless.  It only complicates the
> code and has no real gain.

I think I'll let you handle that one ;-).

> Yup, that's something for 1.5.20 or, more likely 1.5.21.  We can discuss
> implementation details on cygwin-developers.

I was hoping this would be simple enough that it might make it in before,
but it's obviously up to you and cgf to decide.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
---559023410-965003248-1128123573=:1904
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="winsock2_IP_sockopt.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0509301839330.1904@PC1163-8460-XP.flightsafety.com>
Content-Description: 
Content-Disposition: attachment; filename="winsock2_IP_sockopt.patch"
Content-length: 4104

SW5kZXg6IG5ldC5jYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNTIGZp
bGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL25ldC5jYyx2DQpyZXRy
aWV2aW5nIHJldmlzaW9uIDEuMTk0DQpkaWZmIC11IC1wIC1yMS4xOTQgbmV0
LmNjDQotLS0gbmV0LmNjCTIzIFNlcCAyMDA1IDIzOjI1OjI1IC0wMDAwCTEu
MTk0DQorKysgbmV0LmNjCTMwIFNlcCAyMDA1IDIzOjM1OjU2IC0wMDAwDQpA
QCAtNjYzLDYgKzY2Myw1OSBAQCBjeWd3aW5fcmVjdmZyb20gKGludCBmZCwg
dm9pZCAqYnVmLCBpbnQgDQogICByZXR1cm4gcmVzOw0KIH0NCiANCisvKiBj
b252ZXJ0IElQXyogc29ja2V0IG9wdGlvbnMgZnJvbSBXaW5zb2NrIDEuMSB0
byBXaW5zb2NrIDIgKi8NCitzdGF0aWMgaW50DQord3MyaXBfb3B0bmFtZSAo
aW50IG9wdG5hbWUpDQorew0KKyAgLyoNCisgICAqIEN5Z3dpbidzIHN5c3Rl
bSBpbmNsdWRlcyBkZWZpbmUgdGhlIElQXyogbWFjcm9zIGluIHRlcm1zIG9m
IFdpbnNvY2sgMS4xDQorICAgKiAoV2luc29jay5oLCB3c29jazMyLmxpYiku
ICBJbiBXaW5zb2NrIDIgKFdzMnRjcGlwLmgsIHdzMl8zMi5saWIpLCBzb21l
DQorICAgKiBvZiB0aGVzZSBtYWNyb3MgaGF2ZSByZWRlZmluZWQgdmFsdWVz
LiAgVGhlIDEuMSB2YWx1ZXMgYXJlIGNvbnNpc3RlbnQNCisgICAqIHdpdGgg
dGhlIG9yaWdpbmFsIG9uZXMgU3RldmUgRGVlcmluZyBkZWZpbmVkIGluICJJ
UCBNdWx0aWNhc3QgRXh0ZW5zaW9ucw0KKyAgICogZm9yIDQuM0JTRCBVTklY
IHJlbGF0ZWQgc3lzdGVtcyAoTVVMVElDQVNUIDEuMiBSZWxlYXNlKS4iICBI
b3dldmVyLCB0aGVzZQ0KKyAgICogY29uZmxpY3RlZCB3aXRoIHRoZSBkZWZp
bml0aW9ucyBmb3Igc29tZSBJUFBST1RPX0lQIGxldmVsIHNvY2tldCBvcHRp
b25zDQorICAgKiBhbHJlYWR5IGFzc2lnbmVkIGJ5IEJTRCwgc28gQmVya2Vs
ZXkgY2hhbmdlZCBhbGwgdGhlIHZhbHVlcyBieSBhZGRpbmcgNy4NCisgICAq
IFRoZSBXaW5zb2NrIDIgdmFsdWVzIGFyZSB0aGUgQlNEIDQuNCBjb21wYXRp
YmxlIG9uZXMgdGhhdCB3ZSB0cmFuc2xhdGUNCisgICAqIHRvIGhlcmUuDQor
ICAgKg0KKyAgICogU2VlIGFsc286IE1TRE4gS0IgYXJ0aWNsZSBRMjU3NDYw
DQorICAgKiBodHRwOi8vc3VwcG9ydC5taWNyb3NvZnQuY29tL3N1cHBvcnQv
a2IvYXJ0aWNsZXMvUTI1Ny80LzYwLmFzcA0KKyAgICogDQorICAgKiBXaW5z
b2NrIDIgZGVmaW5lcyAgICAgICAgICAgICAgV2luc29jayAxLjEgdmFsdWUN
CisgICAqDQorICAgKiAjZGVmaW5lIElQX1RPUyAgICAgICAgICAgICAzICAg
Ly8gOA0KKyAgICogI2RlZmluZSBJUF9UVEwgICAgICAgICAgICAgNCAgIC8v
IDcNCisgICAqICNkZWZpbmUgSVBfTVVMVElDQVNUX0lGICAgIDkgICAvLyAy
DQorICAgKiAjZGVmaW5lIElQX01VTFRJQ0FTVF9UVEwgICAxMCAgLy8gMw0K
KyAgICogI2RlZmluZSBJUF9NVUxUSUNBU1RfTE9PUCAgMTEgIC8vIDQNCisg
ICAqICNkZWZpbmUgSVBfQUREX01FTUJFUlNISVAgIDEyICAvLyA1DQorICAg
KiAjZGVmaW5lIElQX0RST1BfTUVNQkVSU0hJUCAxMyAgLy8gNg0KKyAgICog
I2RlZmluZSBJUF9ET05URlJBR01FTlQgICAgMTQgIC8vIDkNCisgICAqLw0K
Kw0KKyAgc3dpdGNoIChvcHRuYW1lKQ0KKyAgICB7DQorICAgICAgY2FzZSBJ
UF9UT1M6DQorCW9wdG5hbWUgPSAzOw0KKwlicmVhazsNCisgICAgICBjYXNl
IElQX1RUTDoNCisJb3B0bmFtZSA9IDQ7DQorCWJyZWFrOw0KKyAgICAgIGNh
c2UgSVBfTVVMVElDQVNUX0lGOg0KKyAgICAgIGNhc2UgSVBfTVVMVElDQVNU
X1RUTDoNCisgICAgICBjYXNlIElQX01VTFRJQ0FTVF9MT09QOg0KKyAgICAg
IGNhc2UgSVBfQUREX01FTUJFUlNISVA6DQorICAgICAgY2FzZSBJUF9EUk9Q
X01FTUJFUlNISVA6DQorCW9wdG5hbWUgKz0gNzsNCisJYnJlYWs7DQorICAg
ICAgY2FzZSBJUF9ET05URlJBR01FTlQ6DQorCW9wdG5hbWUgPSAxNDsNCisJ
YnJlYWs7DQorICAgIH0NCisNCisgIHJldHVybiBvcHRuYW1lOw0KK30NCisN
CiAvKiBleHBvcnRlZCBhcyBzZXRzb2Nrb3B0OiBzdGFuZGFyZHM/ICovDQog
ZXh0ZXJuICJDIiBpbnQNCiBjeWd3aW5fc2V0c29ja29wdCAoaW50IGZkLCBp
bnQgbGV2ZWwsIGludCBvcHRuYW1lLCBjb25zdCB2b2lkICpvcHR2YWwsDQpA
QCAtNzEyLDcgKzc2NSwxMCBAQCBjeWd3aW5fc2V0c29ja29wdCAoaW50IGZk
LCBpbnQgbGV2ZWwsIGluDQogICAgIHJlcyA9IC0xOw0KICAgZWxzZQ0KICAg
ICB7DQotICAgICAgcmVzID0gc2V0c29ja29wdCAoZmgtPmdldF9zb2NrZXQg
KCksIGxldmVsLCBvcHRuYW1lLA0KKyAgICAgIGludCB3c19vcHRuYW1lID0g
bGV2ZWwgPT0gSVBQUk9UT19JUCAmJiB3aW5zb2NrMl9hY3RpdmUNCisJCSAg
ICAgICA/IHdzMmlwX29wdG5hbWUgKG9wdG5hbWUpIDogb3B0bmFtZTsNCisN
CisgICAgICByZXMgPSBzZXRzb2Nrb3B0IChmaC0+Z2V0X3NvY2tldCAoKSwg
bGV2ZWwsIHdzX29wdG5hbWUsDQogCQkJKGNvbnN0IGNoYXIgKikgb3B0dmFs
LCBvcHRsZW4pOw0KIA0KICAgICAgIGlmIChvcHRsZW4gPT0gNCkNCkBAIC03
ODIsNyArODM4LDEwIEBAIGN5Z3dpbl9nZXRzb2Nrb3B0IChpbnQgZmQsIGlu
dCBsZXZlbCwgaW4NCiAgICAgfQ0KICAgZWxzZQ0KICAgICB7DQotICAgICAg
cmVzID0gZ2V0c29ja29wdCAoZmgtPmdldF9zb2NrZXQgKCksIGxldmVsLCBv
cHRuYW1lLCAoY2hhciAqKSBvcHR2YWwsDQorICAgICAgaW50IHdzX29wdG5h
bWUgPSBsZXZlbCA9PSBJUFBST1RPX0lQICYmIHdpbnNvY2syX2FjdGl2ZQ0K
KwkJICAgICAgID8gd3MyaXBfb3B0bmFtZSAob3B0bmFtZSkgOiBvcHRuYW1l
Ow0KKw0KKyAgICAgIHJlcyA9IGdldHNvY2tvcHQgKGZoLT5nZXRfc29ja2V0
ICgpLCBsZXZlbCwgd3Nfb3B0bmFtZSwgKGNoYXIgKikgb3B0dmFsLA0KIAkJ
CShpbnQgKikgb3B0bGVuKTsNCiANCiAgICAgICBpZiAob3B0bmFtZSA9PSBT
T19FUlJPUikNCg==

---559023410-965003248-1128123573=:1904--

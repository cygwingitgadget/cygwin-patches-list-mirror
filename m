Return-Path: <cygwin-patches-return-5944-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3552 invoked by alias); 27 Jul 2006 03:03:44 -0000
Received: (qmail 3446 invoked by uid 22791); 27 Jul 2006 03:03:18 -0000
X-Spam-Check-By: sourceware.org
Received: from mailgw04.flightsafety.com (HELO mailgw04.flightsafety.com) (66.109.93.21)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 27 Jul 2006 03:02:52 +0000
Received: from mailgw04.flightsafety.com (localhost [127.0.0.1]) 	by mailgw04.flightsafety.com (8.13.6/8.13.1) with ESMTP id k6R2wXpC009876 	for <cygwin-patches@cygwin.com>; Wed, 26 Jul 2006 22:58:33 -0400 (EDT)
Received: from VXS1.flightsafety.com ([192.168.93.145]) 	by mailgw04.flightsafety.com (8.13.6/8.13.1) with ESMTP id k6R2wWKQ009866 	for <cygwin-patches@cygwin.com>; Wed, 26 Jul 2006 22:58:32 -0400 (EDT)
Received: from srv1163ex1.flightsafety.com ([198.51.28.39]) by VXS1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 26 Jul 2006 23:03:11 -0400
Received: from pc1163-8460-xp ([198.51.27.93]) by srv1163ex1.flightsafety.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 26 Jul 2006 22:03:10 -0500
Date: Thu, 27 Jul 2006 03:03:00 -0000
From: Brian Ford <Brian.Ford@flightsafety.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [send|recv]msg tidy
Message-ID: <Pine.CYG.4.58.0607262142390.2228@PC1163-8460-XP.flightsafety.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1746432294-1153969394=:2228"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00039.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1746432294-1153969394=:2228
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 611

Ok, I'll try this one.

2006-07-26  Brian Ford  <Brian.Ford@FlightSafety.com>

	* fhandler_socket.cc (fhandler_socket::recvmsg): Remove unused tot
	argument.  All callers changed.
	(fhandler_socket::sendmsg): Likewise.
	* net.cc (cygwin_recvmsg): Likewise.
	(cygwin_sendmsg): Likewise, and prevent calling sendmsg whith an
	invalid iovec.
	* fhandler.h (fhandler_socket::recvmsg): Adjust prototype.
	(fhandler_socket::sendmsg): Likewise.

-- 
Brian Ford
Lead Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained crew...
---559023410-1746432294-1153969394=:2228
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="send_recv_msg_cleanup.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0607262203140.2228@PC1163-8460-XP.flightsafety.com>
Content-Description: 
Content-Disposition: attachment; filename="send_recv_msg_cleanup.patch"
Content-length: 4645

SW5kZXg6IGZoYW5kbGVyLmgNCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJD
UyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9maGFuZGxlci5o
LHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4yOTkNCmRpZmYgLXUgLXAgLXUg
LXAgLXIxLjI5OSBmaGFuZGxlci5oDQotLS0gZmhhbmRsZXIuaAkyNSBKdWwg
MjAwNiAxOToyMzoyMyAtMDAwMAkxLjI5OQ0KKysrIGZoYW5kbGVyLmgJMjcg
SnVsIDIwMDYgMDI6Mzk6MjAgLTAwMDANCkBAIC00NjMsMTQgKzQ2MywxNCBA
QCBjbGFzcyBmaGFuZGxlcl9zb2NrZXQ6IHB1YmxpYyBmaGFuZGxlcl9iDQog
CQkJCXN0cnVjdCBzb2NrYWRkciAqZnJvbSwgaW50ICpmcm9tbGVuKTsNCiAg
IHNzaXplX3QgcmVjdmZyb20gKHZvaWQgKnB0ciwgc2l6ZV90IGxlbiwgaW50
IGZsYWdzLA0KIAkJICAgIHN0cnVjdCBzb2NrYWRkciAqZnJvbSwgaW50ICpm
cm9tbGVuKTsNCi0gIHNzaXplX3QgcmVjdm1zZyAoc3RydWN0IG1zZ2hkciAq
bXNnLCBpbnQgZmxhZ3MsIHNzaXplX3QgdG90ID0gLTEpOw0KKyAgc3NpemVf
dCByZWN2bXNnIChzdHJ1Y3QgbXNnaGRyICptc2csIGludCBmbGFncyk7DQog
DQogICBzc2l6ZV90IHdyaXRldiAoY29uc3Qgc3RydWN0IGlvdmVjICosIGlu
dCBpb3ZjbnQsIHNzaXplX3QgdG90ID0gLTEpOw0KICAgaW5saW5lIHNzaXpl
X3Qgc2VuZF9pbnRlcm5hbCAoc3RydWN0IF9XU0FCVUYgKndzYWJ1ZiwgRFdP
UkQgd3NhY250LCBpbnQgZmxhZ3MsDQogCQkJCWNvbnN0IHN0cnVjdCBzb2Nr
YWRkciAqdG8sIGludCB0b2xlbik7DQogICBzc2l6ZV90IHNlbmR0byAoY29u
c3Qgdm9pZCAqcHRyLCBzaXplX3QgbGVuLCBpbnQgZmxhZ3MsDQogCSAgICAg
IGNvbnN0IHN0cnVjdCBzb2NrYWRkciAqdG8sIGludCB0b2xlbik7DQotICBz
c2l6ZV90IHNlbmRtc2cgKGNvbnN0IHN0cnVjdCBtc2doZHIgKm1zZywgaW50
IGZsYWdzLCBzc2l6ZV90IHRvdCA9IC0xKTsNCisgIHNzaXplX3Qgc2VuZG1z
ZyAoY29uc3Qgc3RydWN0IG1zZ2hkciAqbXNnLCBpbnQgZmxhZ3MpOw0KIA0K
ICAgaW50IGlvY3RsICh1bnNpZ25lZCBpbnQgY21kLCB2b2lkICopOw0KICAg
aW50IGZjbnRsIChpbnQgY21kLCB2b2lkICopOw0KSW5kZXg6IGZoYW5kbGVy
X3NvY2tldC5jYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNTIGZpbGU6
IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3NvY2tldC5j
Yyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTkyDQpkaWZmIC11IC1wIC11
IC1wIC1yMS4xOTIgZmhhbmRsZXJfc29ja2V0LmNjDQotLS0gZmhhbmRsZXJf
c29ja2V0LmNjCTI1IEp1bCAyMDA2IDE5OjIzOjIzIC0wMDAwCTEuMTkyDQor
KysgZmhhbmRsZXJfc29ja2V0LmNjCTI3IEp1bCAyMDA2IDAyOjM5OjIxIC0w
MDAwDQpAQCAtMTI0Nyw3ICsxMjQ3LDcgQEAgZmhhbmRsZXJfc29ja2V0Ojpy
ZWFkdiAoY29uc3Qgc3RydWN0IGlvdg0KICAgICAgIG1zZ19mbGFnczoJMA0K
ICAgICB9Ow0KIA0KLSAgcmV0dXJuIHJlY3Ztc2cgKCZtc2csIDAsIHRvdCk7
DQorICByZXR1cm4gcmVjdm1zZyAoJm1zZywgMCk7DQogfQ0KIA0KIGlubGlu
ZSBzc2l6ZV90DQpAQCAtMTMxMSw3ICsxMzExLDcgQEAgZmhhbmRsZXJfc29j
a2V0OjpyZWN2ZnJvbSAodm9pZCAqcHRyLCBzaQ0KIH0NCiANCiBpbnQNCi1m
aGFuZGxlcl9zb2NrZXQ6OnJlY3Ztc2cgKHN0cnVjdCBtc2doZHIgKm1zZywg
aW50IGZsYWdzLCBzc2l6ZV90IHRvdCkNCitmaGFuZGxlcl9zb2NrZXQ6OnJl
Y3Ztc2cgKHN0cnVjdCBtc2doZHIgKm1zZywgaW50IGZsYWdzKQ0KIHsNCiAg
IGlmIChDWUdXSU5fVkVSU0lPTl9DSEVDS19GT1JfVVNJTkdfQU5DSUVOVF9N
U0dIRFIpDQogICAgICgoc3RydWN0IE9MRF9tc2doZHIgKikgbXNnKS0+bXNn
X2FjY3JpZ2h0c2xlbiA9IDA7DQpAQCAtMTM2MCw3ICsxMzYwLDcgQEAgZmhh
bmRsZXJfc29ja2V0Ojp3cml0ZXYgKGNvbnN0IHN0cnVjdCBpbw0KICAgICAg
IG1zZ19mbGFnczoJMA0KICAgICB9Ow0KIA0KLSAgcmV0dXJuIHNlbmRtc2cg
KCZtc2csIDAsIHRvdCk7DQorICByZXR1cm4gc2VuZG1zZyAoJm1zZywgMCk7
DQogfQ0KIA0KIGlubGluZSBzc2l6ZV90DQpAQCAtMTQxNyw3ICsxNDE3LDcg
QEAgZmhhbmRsZXJfc29ja2V0OjpzZW5kdG8gKGNvbnN0IHZvaWQgKnB0cg0K
IH0NCiANCiBpbnQNCi1maGFuZGxlcl9zb2NrZXQ6OnNlbmRtc2cgKGNvbnN0
IHN0cnVjdCBtc2doZHIgKm1zZywgaW50IGZsYWdzLCBzc2l6ZV90IHRvdCkN
CitmaGFuZGxlcl9zb2NrZXQ6OnNlbmRtc2cgKGNvbnN0IHN0cnVjdCBtc2do
ZHIgKm1zZywgaW50IGZsYWdzKQ0KIHsNCiAgIGlmIChnZXRfYWRkcl9mYW1p
bHkgKCkgPT0gQUZfTE9DQUwpDQogICAgIHsNCkluZGV4OiBuZXQuY2MNCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMv
d2luc3VwL2N5Z3dpbi9uZXQuY2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAx
LjIxNA0KZGlmZiAtdSAtcCAtdSAtcCAtcjEuMjE0IG5ldC5jYw0KLS0tIG5l
dC5jYwkyNSBKdWwgMjAwNiAxOToyMzoyMyAtMDAwMAkxLjIxNA0KKysrIG5l
dC5jYwkyNyBKdWwgMjAwNiAwMjozOToyMSAtMDAwMA0KQEAgLTIwNzAsNyAr
MjA3MCw3IEBAIGN5Z3dpbl9yZWN2bXNnIChpbnQgZmQsIHN0cnVjdCBtc2do
ZHIgKm0NCiAgICAgew0KICAgICAgIHJlcyA9IGNoZWNrX2lvdmVjX2Zvcl9y
ZWFkIChtc2ctPm1zZ19pb3YsIG1zZy0+bXNnX2lvdmxlbik7DQogICAgICAg
aWYgKHJlcyA+IDApDQotCXJlcyA9IGZoLT5yZWN2bXNnIChtc2csIGZsYWdz
LCByZXMpOyAvLyByZXMgPT0gaW92ZWMgdG90DQorCXJlcyA9IGZoLT5yZWN2
bXNnIChtc2csIGZsYWdzKTsNCiAgICAgfQ0KIA0KICAgc3lzY2FsbF9wcmlu
dGYgKCIlZCA9IHJlY3Ztc2cgKCVkLCAlcCwgJXgpIiwgcmVzLCBmZCwgbXNn
LCBmbGFncyk7DQpAQCAtMjA5Miw3ICsyMDkyLDggQEAgY3lnd2luX3NlbmRt
c2cgKGludCBmZCwgY29uc3Qgc3RydWN0IG1zZw0KICAgZWxzZQ0KICAgICB7
DQogICAgICAgcmVzID0gY2hlY2tfaW92ZWNfZm9yX3dyaXRlIChtc2ctPm1z
Z19pb3YsIG1zZy0+bXNnX2lvdmxlbik7DQotICAgICAgcmVzID0gZmgtPnNl
bmRtc2cgKG1zZywgZmxhZ3MsIHJlcyk7IC8vIHJlcyA9PSBpb3ZlYyB0b3QN
CisgICAgICBpZiAocmVzID49IDApDQorCXJlcyA9IGZoLT5zZW5kbXNnICht
c2csIGZsYWdzKTsNCiAgICAgfQ0KIA0KICAgc3lzY2FsbF9wcmludGYgKCIl
ZCA9IHNlbmRtc2cgKCVkLCAlcCwgJXgpIiwgcmVzLCBmZCwgbXNnLCBmbGFn
cyk7DQo=

---559023410-1746432294-1153969394=:2228--

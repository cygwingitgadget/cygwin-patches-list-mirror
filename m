Return-Path: <cygwin-patches-return-2162-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25890 invoked by alias); 8 May 2002 02:28:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25876 invoked from network); 8 May 2002 02:28:22 -0000
Date: Tue, 07 May 2002 19:28:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
X-X-Sender: joshua@iocc.com
To: cygwin-patches@cygwin.com
Subject: long-option kill patch 
Message-ID: <Pine.CYG.4.44.0205072117300.1100-200000@iocc.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-3750401-1020824900=:1100"
X-SW-Source: 2002-q2/txt/msg00146.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-3750401-1020824900=:1100
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 519

And I'm sorry for the delay in keeping this help/version ball rolling.
No, I haven't been temporarily dead, just my 'net connection's been
flaky. Here's another small one. I'm keeping the patches to kill
small and managable as discussed.

This patch changes the option-handling in kill to use a switch instead
of if/else if/else clauses. It also adds basic long-option handling.

2001-05-07 Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
	* kill.cc (main): Handle options in a switch. Add long-option
	for --force.

---559023410-3750401-1020824900=:1100
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="kill.cc-patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.44.0205072128200.1100@iocc.com>
Content-Description: 
Content-Disposition: attachment; filename="kill.cc-patch"
Content-length: 2327

LS0tIGtpbGwuY2Mtb3JpZwlNb24gTWFyIDExIDE5OjQ4OjM0IDIwMDINCisr
KyBraWxsLmNjCU1vbiBNYXIgMTEgMTk6NTU6MTkgMjAwMg0KQEAgLTEsNiAr
MSw2IEBADQogLyoga2lsbC5jYw0KIA0KLSAgIENvcHlyaWdodCAxOTk2LCAx
OTk3LCAxOTk4LCAxOTk5LCAyMDAwLCAyMDAxIFJlZCBIYXQsIEluYy4NCisg
ICBDb3B5cmlnaHQgMTk5NiwgMTk5NywgMTk5OCwgMTk5OSwgMjAwMCwgMjAw
MSwgMjAwMiBSZWQgSGF0LCBJbmMuDQogDQogVGhpcyBmaWxlIGlzIHBhcnQg
b2YgQ3lnd2luLg0KIA0KQEAgLTYxLDI2ICs2MSw1MCBAQCBtYWluIChpbnQg
YXJnYywgY2hhciAqKmFyZ3YpDQogICBpbnQgZm9yY2UgPSAwOw0KICAgaW50
IGdvdHNpZyA9IDA7DQogICBpbnQgcmV0ID0gMDsNCisgIGludCBvcHQgPSAw
Ow0KKyAgY2hhciAqbG9uZ29wdDsNCiANCiAgIGlmIChhcmdjID09IDEpDQog
ICAgIHVzYWdlICgpOw0KIA0KICAgd2hpbGUgKCorK2FyZ3YgJiYgKiphcmd2
ID09ICctJykNCi0gICAgaWYgKHN0cmNtcCAoKmFyZ3YgKyAxLCAiZiIpID09
IDApDQotICAgICAgZm9yY2UgPSAxOw0KLSAgICBlbHNlIGlmIChnb3RzaWcp
DQotICAgICAgYnJlYWs7DQotICAgIGVsc2UgaWYgKHN0cmNtcCgqYXJndiAr
IDEsICIwIikgIT0gMCkNCi0gICAgICB7DQotCXNpZyA9IGdldHNpZyAoKmFy
Z3YgKyAxKTsNCi0JZ290c2lnID0gMTsNCi0gICAgICB9DQotICAgIGVsc2UN
Ci0gICAgICB7DQotCWFyZ3YrKzsNCi0Jc2lnID0gMDsNCi0JZ290byBzaWcw
Ow0KLSAgICAgIH0NCisgICAgew0KKyAgICAgIG9wdCA9ICooKmFyZ3YgKyAx
KTsNCisgICAgICBpZiAoIWdvdHNpZykNCisgICAgICAgIHN3aXRjaCAob3B0
KQ0KKyAgICAgICAgICB7DQorICAgICAgICAgIGNhc2UgJ2YnOg0KKyAgICAg
ICAgICAgIGZvcmNlID0gMTsNCisgICAgICAgICAgICBicmVhazsNCisNCisg
ICAgICAgICAgY2FzZSAnMCc6DQorICAgICAgICAgICAgYXJndisrOw0KKyAg
ICAgICAgICAgIHNpZyA9IDA7DQorICAgICAgICAgICAgZ290byBzaWcwOw0K
KyAgICAgICAgICAgIHJldHVybiByZXQ7DQorDQorICAgICAgICAgIC8qIEhh
bmRsZSBsb25nIG9wdGlvbnMgKi8NCisgICAgICAgICAgY2FzZSAnLSc6DQor
ICAgICAgICAgICAgbG9uZ29wdCA9ICphcmd2ICsgMjsNCisgICAgICAgICAg
ICBpZiAoc3RyY21wIChsb25nb3B0LCAiZm9yY2UiKSA9PSAwKQ0KKyAgICAg
ICAgICAgICAgZm9yY2UgPSAxOw0KKyAgICAgICAgICAgIGVsc2UNCisgICAg
ICAgICAgICAgIHsNCisgICAgICAgICAgICAgICAgZnByaW50ZiAoc3RkZXJy
LCAia2lsbDogdW5rbm93biBsb25nIG9wdGlvbjogLS0lc1xuXG4iLA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICBsb25nb3B0KTsNCisgICAgICAgICAg
ICAgICAgdXNhZ2UgKCk7DQorICAgICAgICAgICAgICB9DQorICAgICAgICAg
ICAgKmFyZ3YgKz0gc3RybGVuIChsb25nb3B0KTsNCisgICAgICAgICAgICBi
cmVhazsNCisgICAgICAgICAgLyogRW5kIG9mIGxvbmcgb3B0aW9ucyAqLw0K
Kw0KKyAgICAgICAgICBkZWZhdWx0Og0KKyAgICAgICAgICAgIHNpZyA9IGdl
dHNpZyAoKmFyZ3YgKyAxKTsNCisgICAgICAgICAgICBnb3RzaWcgPSAxOw0K
KyAgICAgICAgICB9DQorICAgICAgZWxzZQ0KKyAgICAgICAgYnJlYWs7DQor
ICAgIH0NCiANCiAgIGlmIChzaWcgPD0gMCB8fCBzaWcgPiBOU0lHKQ0KICAg
ICB7DQo=

---559023410-3750401-1020824900=:1100--

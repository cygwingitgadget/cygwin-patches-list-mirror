Return-Path: <cygwin-patches-return-4495-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22454 invoked by alias); 10 Dec 2003 20:57:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22443 invoked from network); 10 Dec 2003 20:57:02 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Wed, 10 Dec 2003 20:57:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: Fix tcflush hang with streaming devices
Message-ID: <Pine.GSO.4.58.0312101416580.28297@eos>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1489380298-1071089820=:28297"
X-SW-Source: 2003-q4/txt/msg00214.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1489380298-1071089820=:28297
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 953

This trivial clean up patch fixes the problem reported here:

http://www.cygwin.com/ml/cygwin/2003-10/msg00797.html

Tested and confirmed by the reporter on 98 and 2000sp2.

I tried to find some reason for the previous implimentation via cvs log
and the developers archives, but it seems to have been this way forever.
If anyone knows why this is bad, please speak up.

The reporter is still experiencing "random hangs" in write, but has not
supplied sufficient information for me to track it down.  This problem
existed before and after the patch, so it is unrelated.  I will try to fix
it too if the reporter supplies more info.

2003-12-10  Brian Ford  <ford@vss.fsi.com>

	* fhandler_serial.cc (fhandler_serial::tcflush): Simplify.  Remove
	read polling loop to avoid a hang with streaming devices.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-1489380298-1071089820=:28297
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fhandler_serial.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.58.0312101457000.28297@eos>
Content-Description: 
Content-Disposition: attachment; filename="fhandler_serial.patch"
Content-length: 2103

SW5kZXg6IGZoYW5kbGVyX3NlcmlhbC5jYw0KPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2Zo
YW5kbGVyX3NlcmlhbC5jYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNDYN
CmRpZmYgLXUgLXAgLXIxLjQ2IGZoYW5kbGVyX3NlcmlhbC5jYw0KLS0tIGZo
YW5kbGVyX3NlcmlhbC5jYwk3IERlYyAyMDAzIDIyOjM3OjExIC0wMDAwCTEu
NDYNCisrKyBmaGFuZGxlcl9zZXJpYWwuY2MJMTAgRGVjIDIwMDMgMjA6MTM6
MDggLTAwMDANCkBAIC00OTcsMjEgKzQ5NywzMCBAQCBmaGFuZGxlcl9zZXJp
YWw6OmlvY3RsICh1bnNpZ25lZCBpbnQgY21kDQogaW50DQogZmhhbmRsZXJf
c2VyaWFsOjp0Y2ZsdXNoIChpbnQgcXVldWUpDQogew0KLSAgaWYgKHF1ZXVl
ID09IFRDT0ZMVVNIIHx8IHF1ZXVlID09IFRDSU9GTFVTSCkNCi0gICAgUHVy
Z2VDb21tIChnZXRfaGFuZGxlICgpLCBQVVJHRV9UWEFCT1JUIHwgUFVSR0Vf
VFhDTEVBUik7DQorICBEV09SRCBmbGFnczsNCiANCi0gIGlmIChxdWV1ZSA9
PSBUQ0lGTFVTSCB8fCBxdWV1ZSA9PSBUQ0lPRkxVU0gpDQotICAgIC8qIElu
cHV0IGZsdXNoaW5nIGJ5IHBvbGxpbmcgdW50aWwgbm90aGluZyB0dXJucyB1
cA0KLSAgICAgICAod2Ugc3RvcCBhZnRlciAxMDAwIGNoYXJzIGFueXdheSkg
Ki8NCi0gICAgZm9yIChpbnQgbWF4ID0gMTAwMDsgbWF4ID4gMDsgbWF4LS0p
DQotICAgICAgew0KLQlDT01TVEFUIHN0Ow0KLQlpZiAoIVB1cmdlQ29tbSAo
Z2V0X2hhbmRsZSAoKSwgUFVSR0VfUlhBQk9SVCB8IFBVUkdFX1JYQ0xFQVIp
KQ0KLQkgIGJyZWFrOw0KLQlsb3dfcHJpb3JpdHlfc2xlZXAgKDEwMCk7DQot
CWlmICghQ2xlYXJDb21tRXJyb3IgKGdldF9oYW5kbGUgKCksICZldiwgJnN0
KSB8fCAhc3QuY2JJblF1ZSkNCi0JICBicmVhazsNCi0gICAgICB9DQorICBz
d2l0Y2ggKHF1ZXVlKQ0KKyAgICB7DQorICAgIGNhc2UgVENPRkxVU0g6DQor
ICAgICAgZmxhZ3MgPSBQVVJHRV9UWEFCT1JUIHwgUFVSR0VfVFhDTEVBUjsN
CisgICAgICBicmVhazsNCisgICAgY2FzZSBUQ0lGTFVTSDoNCisgICAgICBm
bGFncyA9IFBVUkdFX1JYQUJPUlQgfCBQVVJHRV9SWENMRUFSOw0KKyAgICAg
IGJyZWFrOw0KKyAgICBjYXNlIFRDSU9GTFVTSDoNCisgICAgICBmbGFncyA9
IFBVUkdFX1RYQUJPUlQgfCBQVVJHRV9UWENMRUFSIHwgUFVSR0VfUlhBQk9S
VCB8IFBVUkdFX1JYQ0xFQVI7DQorICAgICAgYnJlYWs7DQorICAgIGRlZmF1
bHQ6DQorICAgICAgdGVybWlvc19wcmludGYgKCJJbnZhbGlkIHRjZmx1c2gg
cXVldWUgJWQiLCBxdWV1ZSk7DQorICAgICAgc2V0X2Vycm5vIChFSU5WQUwp
Ow0KKyAgICAgIHJldHVybiAtMTsNCisgICAgfQ0KKwkNCisgIGlmICghUHVy
Z2VDb21tIChnZXRfaGFuZGxlICgpLCBmbGFncykpDQorICAgIHsNCisgICAg
ICBfX3NldGVycm5vICgpOw0KKyAgICAgIHJldHVybiAtMTsNCisgICAgfQ0K
IA0KICAgcmV0dXJuIDA7DQogfQ0K

---559023410-1489380298-1071089820=:28297--

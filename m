Return-Path: <cygwin-patches-return-4524-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12403 invoked by alias); 22 Jan 2004 23:07:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12387 invoked from network); 22 Jan 2004 23:07:39 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Thu, 22 Jan 2004 23:07:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: Fix write deadlock with streaming serial devices
Message-ID: <Pine.GSO.4.58.0401221638310.17483@eos>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-675537891-1074811835=:17483"
Content-ID: <Pine.GSO.4.58.0401221651270.17483@eos>
X-SW-Source: 2004-q1/txt/msg00014.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-675537891-1074811835=:17483
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.58.0401221651271.17483@eos>
Content-length: 1293

This trivial patch fixes the problem reported here:

http://www.cygwin.com/ml/cygwin/2004-01/msg00664.html

Tested and confirmed by the reporter here:

http://www.cygwin.com/ml/cygwin/2004-01/msg00716.html

and by Martin Farnik in a previous private email discussion.

If the input buffer overflows because a device is streaming faster than
the application is reading, all serial communications cease and calls
return ERROR_OPERATION_ABORTED.  In order to restart communication,
ClearCommError must be called.  Without this patch, a deadlock inside
fhandler_serial::raw_write could occur.

Martin has supplied me with an strace log of another hang, but I have yet
to fully understand it.  A patch for it is hopefully forth comming.

The fhandler_serial::raw_read patch is merely a suggestion to correct a
possible thinko.  Feel free to ignore it, or correct my limited analysis.

Thanks.

2004-01-22  Brian Ford  <ford@vss.fsi.com>

	* fhandler_serial.cc (fhandler_serial::raw_write): Prevent a
	deadlock when the input buffer overflows.
	(fhandler_serial::raw_read): Correct to print the actual error
	and only call PurgeComm when necessary.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-675537891-1074811835=:17483
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="fhandler_serial.cc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.58.0401221650350.17483@eos>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="fhandler_serial.cc.patch"
Content-length: 1530

SW5kZXg6IGZoYW5kbGVyX3NlcmlhbC5jYw0KPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2Zo
YW5kbGVyX3NlcmlhbC5jYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNDcN
CmRpZmYgLXUgLXAgLXIxLjQ3IGZoYW5kbGVyX3NlcmlhbC5jYw0KLS0tIGZo
YW5kbGVyX3NlcmlhbC5jYwkxMSBEZWMgMjAwMyAxODowNzo0MiAtMDAwMAkx
LjQ3DQorKysgZmhhbmRsZXJfc2VyaWFsLmNjCTIyIEphbiAyMDA0IDIyOjM4
OjA0IC0wMDAwDQpAQCAtMTMzLDE2ICsxMzMsMTYgQEAgZmhhbmRsZXJfc2Vy
aWFsOjpyYXdfcmVhZCAodm9pZCAqcHRyLCBzaQ0KICAgICAgIGNvbnRpbnVl
Ow0KIA0KICAgICBlcnI6DQotICAgICAgUHVyZ2VDb21tIChnZXRfaGFuZGxl
ICgpLCBQVVJHRV9SWEFCT1JUKTsNCiAgICAgICBkZWJ1Z19wcmludGYgKCJl
cnIgJUUiKTsNCi0gICAgICBpZiAoR2V0TGFzdEVycm9yICgpID09IEVSUk9S
X09QRVJBVElPTl9BQk9SVEVEKQ0KLQluID0gMDsNCi0gICAgICBlbHNlDQor
ICAgICAgaWYgKEdldExhc3RFcnJvciAoKSAhPSBFUlJPUl9PUEVSQVRJT05f
QUJPUlRFRCkNCiAJew0KKyAgICAgICAgICBQdXJnZUNvbW0gKGdldF9oYW5k
bGUgKCksIFBVUkdFX1JYQUJPUlQpOw0KIAkgIHRvdCA9IC0xOw0KIAkgIF9f
c2V0ZXJybm8gKCk7DQogCSAgYnJlYWs7DQogCX0NCisNCisgICAgICBuID0g
MDsNCiAgICAgfQ0KIA0KIG91dDoNCkBAIC0xNjksNiArMTY5LDkgQEAgZmhh
bmRsZXJfc2VyaWFsOjpyYXdfd3JpdGUgKGNvbnN0IHZvaWQgKg0KICAgICAg
IHN3aXRjaCAoR2V0TGFzdEVycm9yICgpKQ0KIAl7DQogCWNhc2UgRVJST1Jf
T1BFUkFUSU9OX0FCT1JURUQ6DQorICAgICAgICAgIERXT1JEIGV2Ow0KKyAg
ICAgICAgICBpZiAoIUNsZWFyQ29tbUVycm9yIChnZXRfaGFuZGxlICgpLCAm
ZXYsIE5VTEwpKSBnb3RvIGVycjsNCisgICAgICAgICAgaWYgKGV2KSB0ZXJt
aW9zX3ByaW50ZiAoImVycm9yIGRldGVjdGVkICV4IiwgZXYpOw0KIAkgIGNv
bnRpbnVlOw0KIAljYXNlIEVSUk9SX0lPX1BFTkRJTkc6DQogCSAgYnJlYWs7
DQo=

---559023410-675537891-1074811835=:17483--

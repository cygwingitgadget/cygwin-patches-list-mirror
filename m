Return-Path: <cygwin-patches-return-4501-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11817 invoked by alias); 12 Dec 2003 19:14:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11808 invoked from network); 12 Dec 2003 19:14:33 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Fri, 12 Dec 2003 19:14:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: termios.cc: Restore setting of EBADF appropriately throughout
Message-ID: <Pine.GSO.4.58.0312121305400.23399@eos>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-559023410-1489380298-1071089820=:28297"
Content-ID: <Pine.GSO.4.58.0312121305401.23399@eos>
X-SW-Source: 2003-q4/txt/msg00220.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1489380298-1071089820=:28297
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.58.0312121305402.23399@eos>
Content-length: 563

I noticed this while digging through other serial port problems.  It
appears to have been lost in version 1.16, although there did not appear
to be a reason for the loss in that change.  Please let me know if it was
intentional for some reason that I do not understand.  Thanks.

2003-12-12  Brian Ford  <ford@vss.fsi.com>

	* termios.cc: Restore setting of EBADF appropriately throughout.
	Lost in version 1.16.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-1489380298-1071089820=:28297
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="termios.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.58.0312121314320.23399@eos>
Content-Description: 
Content-Disposition: attachment; filename="termios.patch"
Content-length: 2745

SW5kZXg6IHRlcm1pb3MuY2MNCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJD
UyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi90ZXJtaW9zLmNj
LHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4yNg0KZGlmZiAtdSAtcCAtcjEu
MjYgdGVybWlvcy5jYw0KLS0tIHRlcm1pb3MuY2MJMjggTm92IDIwMDMgMjA6
NTU6NTggLTAwMDAJMS4yNg0KKysrIHRlcm1pb3MuY2MJMTIgRGVjIDIwMDMg
MTk6MDQ6MzcgLTAwMDANCkBAIC0zMywxNCArMzMsMTIgQEAgdGNzZW5kYnJl
YWsgKGludCBmZCwgaW50IGR1cmF0aW9uKQ0KIA0KICAgY3lnaGVhcF9mZGdl
dCBjZmQgKGZkKTsNCiAgIGlmIChjZmQgPCAwKQ0KLSAgICBnb3RvIG91dDsN
Ci0NCi0gIGlmICghY2ZkLT5pc190dHkgKCkpDQorICAgIHNldF9lcnJubyAo
RUJBREYpOw0KKyAgZWxzZSBpZiAoIWNmZC0+aXNfdHR5ICgpKQ0KICAgICBz
ZXRfZXJybm8gKEVOT1RUWSk7DQogICBlbHNlIGlmICgocmVzID0gY2ZkLT5i
Z19jaGVjayAoLVNJR1RUT1UpKSA+IGJnX2VvZikNCiAgICAgcmVzID0gY2Zk
LT50Y3NlbmRicmVhayAoZHVyYXRpb24pOw0KIA0KLW91dDoNCiAgIHN5c2Nh
bGxfcHJpbnRmICgiJWQgPSB0Y3NlbmRicmVhayAoJWQsICVkKSIsIHJlcywg
ZmQsIGR1cmF0aW9uKTsNCiAgIHJldHVybiByZXM7DQogfQ0KQEAgLTU1LDE0
ICs1MywxMiBAQCB0Y2RyYWluIChpbnQgZmQpDQogDQogICBjeWdoZWFwX2Zk
Z2V0IGNmZCAoZmQpOw0KICAgaWYgKGNmZCA8IDApDQotICAgIGdvdG8gb3V0
Ow0KLQ0KLSAgaWYgKCFjZmQtPmlzX3R0eSAoKSkNCisgICAgc2V0X2Vycm5v
IChFQkFERik7DQorICBlbHNlIGlmICghY2ZkLT5pc190dHkgKCkpDQogICAg
IHNldF9lcnJubyAoRU5PVFRZKTsNCiAgIGVsc2UgaWYgKChyZXMgPSBjZmQt
PmJnX2NoZWNrICgtU0lHVFRPVSkpID4gYmdfZW9mKQ0KICAgICByZXMgPSBj
ZmQtPnRjZHJhaW4gKCk7DQogDQotb3V0Og0KICAgc3lzY2FsbF9wcmludGYg
KCIlZCA9IHRjZHJhaW4gKCVkKSIsIHJlcywgZmQpOw0KICAgcmV0dXJuIHJl
czsNCiB9DQpAQCAtNzUsMTYgKzcxLDE0IEBAIHRjZmx1c2ggKGludCBmZCwg
aW50IHF1ZXVlKQ0KIA0KICAgY3lnaGVhcF9mZGdldCBjZmQgKGZkKTsNCiAg
IGlmIChjZmQgPCAwKQ0KLSAgICBnb3RvIG91dDsNCi0NCi0gIGlmICghY2Zk
LT5pc190dHkgKCkpDQorICAgIHNldF9lcnJubyAoRUJBREYpOw0KKyAgZWxz
ZSBpZiAoIWNmZC0+aXNfdHR5ICgpKQ0KICAgICBzZXRfZXJybm8gKEVOT1RU
WSk7DQogICBlbHNlIGlmIChxdWV1ZSAhPSBUQ0lGTFVTSCAmJiBxdWV1ZSAh
PSBUQ09GTFVTSCAmJiBxdWV1ZSAhPSBUQ0lPRkxVU0gpDQotICAgICAgc2V0
X2Vycm5vIChFSU5WQUwpOw0KKyAgICBzZXRfZXJybm8gKEVJTlZBTCk7DQog
ICBlbHNlIGlmICgocmVzID0gY2ZkLT5iZ19jaGVjayAoLVNJR1RUT1UpKSA+
IGJnX2VvZikNCiAgICAgcmVzID0gY2ZkLT50Y2ZsdXNoIChxdWV1ZSk7DQog
DQotb3V0Og0KICAgdGVybWlvc19wcmludGYgKCIlZCA9IHRjZmx1c2ggKCVk
LCAlZCkiLCByZXMsIGZkLCBxdWV1ZSk7DQogICByZXR1cm4gcmVzOw0KIH0N
CkBAIC05NywxNCArOTEsMTIgQEAgdGNmbG93IChpbnQgZmQsIGludCBhY3Rp
b24pDQogDQogICBjeWdoZWFwX2ZkZ2V0IGNmZCAoZmQpOw0KICAgaWYgKGNm
ZCA8IDApDQotICAgIGdvdG8gb3V0Ow0KLQ0KLSAgaWYgKCFjZmQtPmlzX3R0
eSAoKSkNCisgICAgc2V0X2Vycm5vIChFQkFERik7DQorICBlbHNlIGlmICgh
Y2ZkLT5pc190dHkgKCkpDQogICAgIHNldF9lcnJubyAoRU5PVFRZKTsNCiAg
IGVsc2UgaWYgKChyZXMgPSBjZmQtPmJnX2NoZWNrICgtU0lHVFRPVSkpID4g
YmdfZW9mKQ0KICAgICByZXMgPSBjZmQtPnRjZmxvdyAoYWN0aW9uKTsNCiAN
Ci1vdXQ6DQogICBzeXNjYWxsX3ByaW50ZiAoIiVkID0gdGNmbG93ICglZCwg
JWQpIiwgcmVzLCBmZCwgYWN0aW9uKTsNCiAgIHJldHVybiByZXM7DQogfQ0K

---559023410-1489380298-1071089820=:28297--

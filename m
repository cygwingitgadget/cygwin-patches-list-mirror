Return-Path: <cygwin-patches-return-3833-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5488 invoked by alias); 28 Apr 2003 20:07:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5436 invoked from network); 28 Apr 2003 20:07:54 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Mon, 28 Apr 2003 20:07:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: profil fixes
Message-ID: <Pine.GSO.4.44.0304281456300.18331-200000@eos>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1903590565-1051560465=:18331"
X-SW-Source: 2003-q2/txt/msg00060.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1903590565-1051560465=:18331
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 364

2003-04-28  Brian Ford  <ford@vss.fsi.com>

        * profil.h (PROFADDR): Prevent overflow when text segments
	are larger than 256k.
	* profil.c (profthr_func): Raise thread priority for more accurate
	sampling.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444

---559023410-1903590565-1051560465=:18331
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="profil.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0304281507450.18331@eos>
Content-Description: 
Content-Disposition: attachment; filename="profil.patch"
Content-length: 1546

SW5kZXg6IHByb2ZpbC5jDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1Mg
ZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vcHJvZmlsLmMsdg0K
cmV0cmlldmluZyByZXZpc2lvbiAxLjUNCmRpZmYgLXUgLXAgLXIxLjUgcHJv
ZmlsLmMNCi0tLSBwcm9maWwuYwkxMSBTZXAgMjAwMSAyMDowMTowMCAtMDAw
MAkxLjUNCisrKyBwcm9maWwuYwkyOCBBcHIgMjAwMyAxOTo1NTo1NSAtMDAw
MA0KQEAgLTYyLDYgKzYyLDggQEAgcHJvZnRocl9mdW5jIChMUFZPSUQgYXJn
KQ0KICAgc3RydWN0IHByb2ZpbmZvICpwID0gKHN0cnVjdCBwcm9maW5mbyAq
KSBhcmc7DQogICB1X2xvbmcgcGMsIGlkeDsNCiANCisgIFNldFRocmVhZFBy
aW9yaXR5KHAtPnByb2Z0aHIsIFRIUkVBRF9QUklPUklUWV9USU1FX0NSSVRJ
Q0FMKTsNCisNCiAgIGZvciAoOzspDQogICAgIHsNCiAgICAgICBwYyA9ICh1
X2xvbmcpIGdldF90aHJwYyAocC0+dGFyZ3Rocik7DQpJbmRleDogcHJvZmls
LmgNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3ZzL3Ny
Yy9zcmMvd2luc3VwL2N5Z3dpbi9wcm9maWwuaCx2DQpyZXRyaWV2aW5nIHJl
dmlzaW9uIDEuMw0KZGlmZiAtdSAtcCAtcjEuMyBwcm9maWwuaA0KLS0tIHBy
b2ZpbC5oCTExIFNlcCAyMDAxIDIwOjAxOjAwIC0wMDAwCTEuMw0KKysrIHBy
b2ZpbC5oCTI4IEFwciAyMDAzIDE5OjU1OjU2IC0wMDAwDQpAQCAtMjQsNyAr
MjQsNyBAQCBkZXRhaWxzLiAqLw0KIA0KIC8qIGNvbnZlcnQgYW4gaW5kZXgg
aW50byBhbiBhZGRyZXNzICovDQogI2RlZmluZSBQUk9GQUREUihpZHgsIGJh
c2UsIHNjYWxlKQlcDQotCSgoYmFzZSkgKyAoKCgoaWR4KSA8PCAxNikgLyAo
c2NhbGUpKSA8PCAxKSkNCisJKChiYXNlKSArICgoKCh1bnNpZ25lZCBsb25n
IGxvbmcpKGlkeCkgPDwgMTYpIC8gKHNjYWxlKSkgPDwgMSkpDQogDQogLyog
Y29udmVydCBhIGJpbiBzaXplIGludG8gYSBzY2FsZSAqLw0KICNkZWZpbmUg
UFJPRlNDQUxFKHJhbmdlLCBiaW5zKQkJKCgoYmlucykgPDwgMTYpIC8gKChy
YW5nZSkgPj4gMSkpDQo=

---559023410-1903590565-1051560465=:18331--

Return-Path: <cygwin-patches-return-3213-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13214 invoked by alias); 22 Nov 2002 04:45:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13200 invoked from network); 22 Nov 2002 04:45:28 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 21 Nov 2002 20:45:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: cygwin_intenral va_arg bugs
Message-ID: <Pine.GSO.4.44.0211212341420.4275-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1635017012-1037940328=:4275"
X-SW-Source: 2002-q4/txt/msg00164.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1635017012-1037940328=:4275
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 524

Hi,
This patch fixes two bugs in va_arg handling in cygwin_internal.
	Igor

ChangeLog:
2002-11-21  Igor Pechtchanski <pechtcha@cs.nyu.edu>

	* external.cc: (cygwin_internal) Fix va_arg references.
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Water molecules expand as they grow warmer" (C) Popular Science, Oct'02, p.51


---559023410-1635017012-1037940328=:4275
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="external-va_arg-fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0211212345280.4275@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="external-va_arg-fix.patch"
Content-length: 1627

SW5kZXg6IHdpbnN1cC9jeWd3aW4vZXh0ZXJuYWwuY2MNCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5
Z3dpbi9leHRlcm5hbC5jYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNDUN
CmRpZmYgLXUgLXAgLXIxLjQ1IGV4dGVybmFsLmNjDQotLS0gd2luc3VwL2N5
Z3dpbi9leHRlcm5hbC5jYwkzMCBPY3QgMjAwMiAyMTowNToxNyAtMDAwMAkx
LjQ1DQorKysgd2luc3VwL2N5Z3dpbi9leHRlcm5hbC5jYwkyMiBOb3YgMjAw
MiAwNDoyOTo1NyAtMDAwMA0KQEAgLTE4Miw3ICsxODIsNyBAQCBjeWd3aW5f
aW50ZXJuYWwgKGN5Z3dpbl9nZXRpbmZvX3R5cGVzIHQsDQogCXJldHVybiAo
RFdPUkQpIGZpbGxvdXRfcGluZm8gKHZhX2FyZyAoYXJnLCBwaWRfdCksIDEp
Ow0KIA0KICAgICAgIGNhc2UgQ1dfSU5JVF9FWENFUFRJT05TOg0KLQlpbml0
X2V4Y2VwdGlvbnMgKChleGNlcHRpb25fbGlzdCAqKSBhcmcpOw0KKwlpbml0
X2V4Y2VwdGlvbnMgKHZhX2FyZyAoYXJnLCBleGNlcHRpb25fbGlzdCAqKSk7
DQogCXJldHVybiAwOw0KIA0KICAgICAgIGNhc2UgQ1dfR0VUX0NZR0RSSVZF
X0lORk86DQpAQCAtMTk2LDE2ICsxOTYsMTUgQEAgY3lnd2luX2ludGVybmFs
IChjeWd3aW5fZ2V0aW5mb190eXBlcyB0LA0KIA0KICAgICAgIGNhc2UgQ1df
U0VUX0NZR1dJTl9SRUdJU1RSWV9OQU1FOg0KIAl7DQotIwkgIGRlZmluZSBj
ciAoKGNoYXIgKikgYXJnKQ0KKwkgIGNvbnN0IGNoYXIgKmNyID0gdmFfYXJn
IChhcmcsIGNoYXIgKik7DQogCSAgaWYgKGNoZWNrX251bGxfZW1wdHlfc3Ry
X2Vycm5vIChjcikpDQogCSAgICByZXR1cm4gKERXT1JEKSBOVUxMOw0KIAkg
IGN5Z2hlYXAtPmN5Z3dpbl9yZWduYW1lID0gKGNoYXIgKikgY3JlYWxsb2Mg
KGN5Z2hlYXAtPmN5Z3dpbl9yZWduYW1lLA0KIAkJCQkJCSAgICAgICBzdHJs
ZW4gKGNyKSArIDEpOw0KIAkgIHN0cmNweSAoY3lnaGVhcC0+Y3lnd2luX3Jl
Z25hbWUsIGNyKTsNCisJfQ0KICAgICAgIGNhc2UgQ1dfR0VUX0NZR1dJTl9S
RUdJU1RSWV9OQU1FOg0KIAkgIHJldHVybiAoRFdPUkQpIGN5Z2hlYXAtPmN5
Z3dpbl9yZWduYW1lOw0KLSMJICB1bmRlZiBjcg0KLQl9DQogDQogICAgICAg
Y2FzZSBDV19TVFJBQ0VfVE9HR0xFOg0KIAl7DQo=

---559023410-1635017012-1037940328=:4275--

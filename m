Return-Path: <cygwin-patches-return-3706-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26290 invoked by alias); 14 Mar 2003 19:46:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26243 invoked from network); 14 Mar 2003 19:46:39 -0000
To: cygwin-patches@cygwin.com
Subject: [PATCH]: (newlib) Allow wcschr(x, L'\0')
MIME-Version: 1.0
Message-ID: <OF5F37C502.04A60CCA-ON85256CE9.006C05FA-85256CE9.006CA1A3@abinitio.com>
From: Bob Cassels <bcassels@abinitio.com>
Date: Fri, 14 Mar 2003 19:46:00 -0000
Content-Type: multipart/mixed; boundary="=_mixed 006CA19D85256CE9_="
X-SW-Source: 2003-q1/txt/msg00355.txt.bz2

--=_mixed 006CA19D85256CE9_=
Content-Type: text/plain; charset="US-ASCII"
Content-length: 354

This simple patch for newlib allows using wcschr to find pointers to null 
characters, rather than returning NULL.  I hope it's simple enough to not 
require paperwork.

2003-03-14  Bob Cassels  <bcassels@abinitio.com>

        * libc/string/wcschr.c: (wcschr): Look for character first, then 
for
        end of string, so you can do wcschr(x, '\0').



--=_mixed 006CA19D85256CE9_=
Content-Type: text/plain; name="wcschr-patch.txt"
Content-Disposition: attachment; filename="wcschr-patch.txt"
Content-Transfer-Encoding: base64
Content-length: 802

SW5kZXg6IGxpYmMvc3RyaW5nL3djc2Noci5jDQo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09DQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL25ld2xpYi9saWJjL3N0
cmluZy93Y3NjaHIuYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMg0KZGlm
ZiAtdSAtcCAtcjEuMiB3Y3NjaHIuYw0KLS0tIGxpYmMvc3RyaW5nL3djc2No
ci5jCTMgU2VwIDIwMDIgMTk6NTI6MTAgLTAwMDAJMS4yDQorKysgbGliYy9z
dHJpbmcvd2NzY2hyLmMJMTQgTWFyIDIwMDMgMTk6MzU6MDEgLTAwMDANCkBA
IC02OSwxNCArNjksMTMgQEAgX0RFRlVOICh3Y3NjaHIsIChzLCBjKSwNCiAg
IF9DT05TVCB3Y2hhcl90ICpwOw0KIA0KICAgcCA9IHM7DQotICB3aGlsZSAo
KnApDQorICBkbw0KICAgICB7DQogICAgICAgaWYgKCpwID09IGMpDQogCXsN
CiAJICAvKiBMSU5URUQgaW50ZXJmYWNlIHNwZWNpZmljYXRpb24gKi8NCiAJ
ICByZXR1cm4gKHdjaGFyX3QgKikgcDsNCiAJfQ0KLSAgICAgIHArKzsNCi0g
ICAgfQ0KKyAgICB9IHdoaWxlICgqcCsrKTsNCiAgIHJldHVybiBOVUxMOw0K
IH0NCg==

--=_mixed 006CA19D85256CE9_=--

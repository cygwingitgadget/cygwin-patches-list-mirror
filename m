Return-Path: <cygwin-patches-return-4319-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30368 invoked by alias); 29 Oct 2003 00:44:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30359 invoked from network); 29 Oct 2003 00:44:19 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Wed, 29 Oct 2003 00:44:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH] Allow filenames ending with a "." in managed mode
Message-ID: <Pine.GSO.4.56.0310281935190.9558@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1067388258=:9558"
X-SW-Source: 2003-q4/txt/msg00038.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1067388258=:9558
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 834

The attached patch allows creating and working with files ending in "."
(or multiple "."s) in managed mode.
	Igor
==============================================================================
ChangeLog:
2003-10-28  Igor Pechtchanski  <pechtcha@cs.nyu.edu>

	* path.cc (dot_special_chars): New global variable.
	(special_name): Make files ending in "." special.
	(fnunmunge): Allow encoded ".".
	(mount_item::fnmunge): Handle trailing ".".

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
---559023410-851401618-1067388258=:9558
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="path-managed-dots.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.56.0310281944180.9558@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="path-managed-dots.patch"
Content-length: 2550

SW5kZXg6IHdpbnN1cC9jeWd3aW4vcGF0aC5jYw0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2lu
L3BhdGguY2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjI3Nw0KZGlmZiAt
dSAtcCAtcjEuMjc3IHBhdGguY2MNCi0tLSB3aW5zdXAvY3lnd2luL3BhdGgu
Y2MJMjUgT2N0IDIwMDMgMTY6MTI6NDUgLTAwMDAJMS4yNzcNCisrKyB3aW5z
dXAvY3lnd2luL3BhdGguY2MJMjkgT2N0IDIwMDMgMDA6Mzc6MTAgLTAwMDAN
CkBAIC0xMTQxLDcgKzExNDEsOCBAQCBzZXRfZmxhZ3MgKHVuc2lnbmVkICpm
bGFncywgdW5zaWduZWQgdmFsDQogICAgIH0NCiB9DQogDQotc3RhdGljIGNo
YXIgc3BlY2lhbF9jaGFyc1tdID0NCitzdGF0aWMgY2hhciBkb3Rfc3BlY2lh
bF9jaGFyc1tdID0NCisgICAgIi4iDQogICAgICJcMDAxIiAiXDAwMiIgIlww
MDMiICJcMDA0IiAiXDAwNSIgIlwwMDYiICJcMDA3IiAiXDAxMCINCiAgICAg
IlwwMTEiICJcMDEyIiAiXDAxMyIgIlwwMTQiICJcMDE1IiAiXDAxNiIgIlww
MTciICJcMDIwIg0KICAgICAiXDAyMSIgIlwwMjIiICJcMDIzIiAiXDAyNCIg
IlwwMjUiICJcMDI2IiAiXDAyNyIgIlwwMzAiDQpAQCAtMTE1MSw2ICsxMTUy
LDcgQEAgc3RhdGljIGNoYXIgc3BlY2lhbF9jaGFyc1tdID0NCiAgICAgIkki
ICAgICJKIiAgICAiSyIgICAgIkwiICAgICJNIiAgICAiTiIgICAgIk8iICAg
ICJQIg0KICAgICAiUSIgICAgIlIiICAgICJTIiAgICAiVCIgICAgIlUiICAg
ICJWIiAgICAiVyIgICAgIlgiDQogICAgICJZIiAgICAiWiI7DQorc3RhdGlj
IGNoYXIgKnNwZWNpYWxfY2hhcnMgPSBkb3Rfc3BlY2lhbF9jaGFycyArIDE7
DQogc3RhdGljIGNoYXIgc3BlY2lhbF9pbnRyb2R1Y2Vyc1tdID0NCiAgICAg
ImFucGNsIjsNCiANCkBAIC0xMTc4LDYgKzExODAsMTEgQEAgc3BlY2lhbF9u
YW1lIChjb25zdCBjaGFyICpzLCBpbnQgaW5jID0gMQ0KICAgaWYgKHN0cnBi
cmsgKHMsIHNwZWNpYWxfY2hhcnMpKQ0KICAgICByZXR1cm4gIXN0cm5jYXNl
bWF0Y2ggKHMsICIlMmYiLCAzKTsNCiANCisgIGlmIChzdHJjYXNlbWF0Y2gg
KHMsICIuIikgfHwgc3RyY2FzZW1hdGNoIChzLCAiLi4iKSkNCisgICAgcmV0
dXJuIGZhbHNlOw0KKyAgaWYgKHNbc3RybGVuIChzKS0xXSA9PSAnLicpDQor
ICAgIHJldHVybiB0cnVlOw0KKw0KICAgY29uc3QgY2hhciAqcDsNCiAgIGlm
IChzdHJjYXNlbWF0Y2ggKHMsICJjb25pbiQiKSB8fCBzdHJjYXNlbWF0Y2gg
KHMsICJjb25vdXQkIikpDQogICAgIHJldHVybiAtMTsNCkBAIC0xMjEyLDcg
KzEyMTksNyBAQCBmbnVubXVuZ2UgKGNoYXIgKmRzdCwgY29uc3QgY2hhciAq
c3JjKQ0KICAgICB9DQogDQogICB3aGlsZSAoKnNyYykNCi0gICAgaWYgKCEo
YyA9IHNwZWNpYWxfY2hhciAoc3JjKSkpDQorICAgIGlmICghKGMgPSBzcGVj
aWFsX2NoYXIgKHNyYywgZG90X3NwZWNpYWxfY2hhcnMpKSkNCiAgICAgICAq
ZHN0KysgPSAqc3JjKys7DQogICAgIGVsc2UNCiAgICAgICB7DQpAQCAtMTI0
Myw2ICsxMjUwLDEzIEBAIG1vdW50X2l0ZW06OmZubXVuZ2UgKGNoYXIgKmRz
dCwgY29uc3QgY2gNCiAJICAqZCsrID0gKnNyYysrOw0KIAllbHNlDQogCSAg
ZCArPSBfX3NtYWxsX3NwcmludGYgKGQsICIlJSUwMngiLCAodW5zaWduZWQg
Y2hhcikgKnNyYysrKTsNCisNCisgICAgICAtLWQ7DQorICAgICAgaWYgKCpk
ICE9ICcuJykNCisJZCsrOw0KKyAgICAgIGVsc2UNCisJZCArPSBfX3NtYWxs
X3NwcmludGYgKGQsICIlJSUwMngiLCAodW5zaWduZWQgY2hhcikgJy4nKTsN
CisNCiAgICAgICAqZCA9ICpzcmM7DQogICAgIH0NCiANCg==

---559023410-851401618-1067388258=:9558--

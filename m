Return-Path: <cygwin-patches-return-4207-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20254 invoked by alias); 11 Sep 2003 15:23:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14679 invoked from network); 11 Sep 2003 15:20:27 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 11 Sep 2003 15:23:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygcheck: do not check package integrity with a -d flag
Message-ID: <Pine.GSO.4.56.0309111108450.5235@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-654246144-1063293156=:5235"
X-SW-Source: 2003-q3/txt/msg00219.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-654246144-1063293156=:5235
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1064

Hi,

As requested on cygwin-developers@ and cygwin@, this patch adds a flag
("-d", or "--dump-only") that instructs cygcheck to not check for the
presense of all package files on "-c".  So, to get the "old" "cygcheck -c"
functionality, call "cygcheck -cd".
	Igor
==============================================================================
ChangeLog:
2003-09-11  Igor Pechtchanski  <pechtcha@cs.nyu.edu>

	* cygcheck.cc (dump_only): New global variable.
	(usage): Add "--dump-only" option, fix "--verbose" line.
	(longopts, opts): Add "--dump-only" option.
	(main): Process the "--dump-only" flag.  Add new semantic check.
	Pass dump_only information to dump_setup().

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
---559023410-654246144-1063293156=:5235
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cygcheck-dumponly.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.56.0309111112360.5235@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="cygcheck-dumponly.patch"
Content-length: 3238

SW5kZXg6IHdpbnN1cC91dGlscy9jeWdjaGVjay5jYw0KPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvdXRp
bHMvY3lnY2hlY2suY2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjM3DQpk
aWZmIC11IC1wIC1yMS4zNyBjeWdjaGVjay5jYw0KLS0tIHdpbnN1cC91dGls
cy9jeWdjaGVjay5jYwkxMSBTZXAgMjAwMyAwMjo1Njo0MCAtMDAwMAkxLjM3
DQorKysgd2luc3VwL3V0aWxzL2N5Z2NoZWNrLmNjCTExIFNlcCAyMDAzIDE1
OjA0OjA3IC0wMDAwDQpAQCAtMjYsNiArMjYsNyBAQCBpbnQgc3lzaW5mbyA9
IDA7DQogaW50IGdpdmVoZWxwID0gMDsNCiBpbnQga2V5Y2hlY2sgPSAwOw0K
IGludCBjaGVja19zZXR1cCA9IDA7DQoraW50IGR1bXBfb25seSA9IDA7DQog
aW50IGZpbmRfcGFja2FnZSA9IDA7DQogaW50IGxpc3RfcGFja2FnZSA9IDA7
DQogDQpAQCAtMTMyMiw4ICsxMzIzLDkgQEAgVXNhZ2U6IGN5Z2NoZWNrIFtP
UFRJT05TXSBbUFJPR1JBTS4uLl1cbg0KIENoZWNrIHN5c3RlbSBpbmZvcm1h
dGlvbiBvciBQUk9HUkFNIGxpYnJhcnkgZGVwZW5kZW5jaWVzXG5cDQogXG5c
DQogIC1jLCAtLWNoZWNrLXNldHVwICAgY2hlY2sgcGFja2FnZXMgaW5zdGFs
bGVkIHZpYSBzZXR1cC5leGVcblwNCisgLWQsIC0tZHVtcC1vbmx5ICAgICBu
byBpbnRlZ3JpdHkgY2hlY2tpbmcgb2YgcGFja2FnZSBjb250ZW50cyAocmVx
dWlyZXMgLWMpXG5cDQogIC1zLCAtLXN5c2luZm8gICAgICAgc3lzdGVtIGlu
Zm9ybWF0aW9uIChub3Qgd2l0aCAtaylcblwNCi0gLXYsIC0tdmVyYm9zZSAg
ICAgICB2ZXJib3NlIG91dHB1dCAoaW5kZW50ZWQpIChmb3IgLXMgb3IgcHJv
Z3JhbXMpXG5cDQorIC12LCAtLXZlcmJvc2UgICAgICAgdmVyYm9zZSBvdXRw
dXQgKGluZGVudGVkKSAoZm9yIC1bY2Zsc10gb3IgcHJvZ3JhbXMpXG5cDQog
IC1yLCAtLXJlZ2lzdHJ5ICAgICAgcmVnaXN0cnkgc2VhcmNoIChyZXF1aXJl
cyAtcylcblwNCiAgLWssIC0ta2V5Y2hlY2sgICAgICBwZXJmb3JtIGEga2V5
Ym9hcmQgY2hlY2sgc2Vzc2lvbiAobm90IHdpdGggLVtzY2ZsXSlcblwNCiAg
LWYsIC0tZmluZC1wYWNrYWdlICBmaW5kIGluc3RhbGxlZCBwYWNrYWdlcyBj
b250YWluaW5nIGZpbGVzIChub3Qgd2l0aCAtW2NsXSlcblwNCkBAIC0xMzM2
LDYgKzEzMzgsNyBAQCBZb3UgbXVzdCBhdCBsZWFzdCBnaXZlIGVpdGhlciAt
cyBvciAtayBvDQogDQogc3RydWN0IG9wdGlvbiBsb25nb3B0c1tdID0gew0K
ICAgeyJjaGVjay1zZXR1cCIsIG5vX2FyZ3VtZW50LCBOVUxMLCAnYyd9LA0K
KyAgeyJkdW1wLW9ubHkiLCBub19hcmd1bWVudCwgTlVMTCwgJ2QnfSwNCiAg
IHsic3lzaW5mbyIsIG5vX2FyZ3VtZW50LCBOVUxMLCAncyd9LA0KICAgeyJy
ZWdpc3RyeSIsIG5vX2FyZ3VtZW50LCBOVUxMLCAncid9LA0KICAgeyJ2ZXJi
b3NlIiwgbm9fYXJndW1lbnQsIE5VTEwsICd2J30sDQpAQCAtMTM0Nyw3ICsx
MzUwLDcgQEAgc3RydWN0IG9wdGlvbiBsb25nb3B0c1tdID0gew0KICAgezAs
IG5vX2FyZ3VtZW50LCBOVUxMLCAwfQ0KIH07DQogDQotc3RhdGljIGNoYXIg
b3B0c1tdID0gImNmaGtscnN2ViI7DQorc3RhdGljIGNoYXIgb3B0c1tdID0g
ImNkZmhrbHJzdlYiOw0KIA0KIHN0YXRpYyB2b2lkDQogcHJpbnRfdmVyc2lv
biAoKQ0KQEAgLTEzODYsNiArMTM4OSw5IEBAIG1haW4gKGludCBhcmdjLCBj
aGFyICoqYXJndikNCiAgICAgICBjYXNlICdjJzoNCiAJY2hlY2tfc2V0dXAg
PSAxOw0KIAlicmVhazsNCisgICAgICBjYXNlICdkJzoNCisJZHVtcF9vbmx5
ID0gMTsNCisJYnJlYWs7DQogICAgICAgY2FzZSAncic6DQogCXJlZ2lzdHJ5
ID0gMTsNCiAJYnJlYWs7DQpAQCAtMTQyNSw2ICsxNDMxLDkgQEAgbWFpbiAo
aW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KICAgaWYgKChmaW5kX3BhY2thZ2Ug
fHwgbGlzdF9wYWNrYWdlKSAmJiBjaGVja19zZXR1cCkNCiAgICAgdXNhZ2Ug
KHN0ZGVyciwgMSk7DQogDQorICBpZiAoZHVtcF9vbmx5ICYmICFjaGVja19z
ZXR1cCkNCisgICAgdXNhZ2UgKHN0ZGVyciwgMSk7DQorDQogICBpZiAoZmlu
ZF9wYWNrYWdlICYmIGxpc3RfcGFja2FnZSkNCiAgICAgdXNhZ2UgKHN0ZGVy
ciwgMSk7DQogDQpAQCAtMTQ0Niw3ICsxNDU1LDcgQEAgbWFpbiAoaW50IGFy
Z2MsIGNoYXIgKiphcmd2KQ0KIA0KICAgaWYgKGNoZWNrX3NldHVwKQ0KICAg
ICB7DQotICAgICAgZHVtcF9zZXR1cCAodmVyYm9zZSwgYXJndiwgdHJ1ZSk7
DQorICAgICAgZHVtcF9zZXR1cCAodmVyYm9zZSwgYXJndiwgIWR1bXBfb25s
eSk7DQogICAgIH0NCiAgIGVsc2UgaWYgKGZpbmRfcGFja2FnZSkNCiAgICAg
ew0K

---559023410-654246144-1063293156=:5235--

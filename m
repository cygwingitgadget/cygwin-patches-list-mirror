Return-Path: <cygwin-patches-return-3542-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13486 invoked by alias); 7 Feb 2003 19:55:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13468 invoked from network); 7 Feb 2003 19:55:12 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Fri, 07 Feb 2003 19:55:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
To: cygwin-patches@cygwin.com
Subject: cygcheck output alignment
Message-ID: <Pine.GSO.4.44.0302071444310.12312-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-351212254-1044647711=:12312"
X-SW-Source: 2003-q1/txt/msg00191.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-351212254-1044647711=:12312
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 651

Hi all,

This patch fixes the badly aligned output of "cygcheck -c".
	Igor
=======================================================================
ChangeLog:
2003-02-07  Igor Pechtchanski <pechtcha@cs.nyu.edu>

	* dump_setup.cc (dump_setup): Compute the longest
	package name and align columns properly.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Oh, boy, virtual memory! Now I'm gonna make myself a really *big* RAMdisk!
  -- /usr/games/fortune

---559023410-351212254-1044647711=:12312
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cygcheck-package-format.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0302071455110.12312@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="cygcheck-package-format.patch"
Content-length: 1985

SW5kZXg6IHdpbnN1cC91dGlscy9kdW1wX3NldHVwLmNjDQo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC91
dGlscy9kdW1wX3NldHVwLmNjLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS40
DQpkaWZmIC11IC1wIC1yMS40IGR1bXBfc2V0dXAuY2MNCi0tLSB3aW5zdXAv
dXRpbHMvZHVtcF9zZXR1cC5jYwkyOSBKYW4gMjAwMiAxODozNzowMCAtMDAw
MAkxLjQNCisrKyB3aW5zdXAvdXRpbHMvZHVtcF9zZXR1cC5jYwk3IEZlYiAy
MDAzIDE5OjUxOjAxIC0wMDAwDQpAQCAtMjA0LDcgKzIwNCw2IEBAIGR1bXBf
c2V0dXAgKGludCB2ZXJib3NlLCBjaGFyICoqYXJndiwgYm8NCiAgIHBrZ3Zl
ciAqcGFja2FnZXM7DQogDQogICBwYWNrYWdlcyA9IChwa2d2ZXIgKikgY2Fs
bG9jIChubGluZXMsIHNpemVvZihwYWNrYWdlc1swXSkpOw0KLSAgcHJpbnRm
ICgiJS0qcyUtKnNcbiIsIHBhY2thZ2VfbGVuLCAiUGFja2FnZSIsIHZlcnNp
b25fbGVuLCAiVmVyc2lvbiIpOw0KICAgaW50IG47DQogICBmb3IgKG4gPSAw
OyBmZ2V0cyAoYnVmLCA0MDk2LCBmcCkgJiYgbiA8IG5saW5lczspDQogICAg
IHsNCkBAIC0yMjUsNyArMjI0LDEzIEBAIGR1bXBfc2V0dXAgKGludCB2ZXJi
b3NlLCBjaGFyICoqYXJndiwgYm8NCiAJICBzdHJjcHkgKHBhY2thZ2VzW25d
Lm5hbWUgLCBwYWNrYWdlKTsNCiAJICBpZiAoZi53aGF0WzBdKQ0KIAkgICAg
c3RyY2F0IChzdHJjYXQgKHBhY2thZ2VzW25dLm5hbWUsICItIiksIGYud2hh
dCk7DQorCSAgaW50IHBrZ19sZW4gPSBzdHJsZW4ocGFja2FnZXNbbl0ubmFt
ZSk7DQorCSAgaWYgKHBhY2thZ2VfbGVuIDwgcGtnX2xlbisxKQ0KKwkgICAg
cGFja2FnZV9sZW4gPSBwa2dfbGVuKzE7DQogCSAgcGFja2FnZXNbbl0udmVy
ID0gc3RyZHVwIChmLnZlcik7DQorCSAgaW50IHZlcl9sZW4gPSBzdHJsZW4o
cGFja2FnZXNbbl0udmVyKTsNCisJICBpZiAodmVyc2lvbl9sZW4gPCB2ZXJf
bGVuKzEpDQorCSAgICB2ZXJzaW9uX2xlbiA9IHZlcl9sZW4rMTsNCiAJICBu
Kys7DQogCSAgaWYgKHN0cnRvayAoTlVMTCwgIiAiKSA9PSBOVUxMKQ0KIAkg
ICAgYnJlYWs7DQpAQCAtMjM0LDYgKzIzOSw3IEBAIGR1bXBfc2V0dXAgKGlu
dCB2ZXJib3NlLCBjaGFyICoqYXJndiwgYm8NCiANCiAgIHFzb3J0IChwYWNr
YWdlcywgbiwgc2l6ZW9mIChwYWNrYWdlc1swXSksIGNvbXBhcik7DQogDQor
ICBwcmludGYgKCIlLSpzJS0qc1xuIiwgcGFja2FnZV9sZW4sICJQYWNrYWdl
IiwgdmVyc2lvbl9sZW4sICJWZXJzaW9uIik7DQogICBmb3IgKGludCBpID0g
MDsgaSA8IG47IGkrKykNCiAgICAgcHJpbnRmICgiJS0qcyUtKnNcbiIsIHBh
Y2thZ2VfbGVuLCBwYWNrYWdlc1tpXS5uYW1lLA0KIAkJCSAgdmVyc2lvbl9s
ZW4sIHBhY2thZ2VzW2ldLnZlcik7DQo=

---559023410-351212254-1044647711=:12312--

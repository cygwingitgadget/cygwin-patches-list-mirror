Return-Path: <cygwin-patches-return-2957-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26652 invoked by alias); 13 Sep 2002 03:39:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26638 invoked from network); 13 Sep 2002 03:39:06 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 12 Sep 2002 20:39:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
To: cygwin-patches@cygwin.com
Subject: `cygpath --version` missing a newline
Message-ID: <Pine.GSO.4.44.0209122333300.19696-200000@slinky.cs.nyu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-33463914-1031888345=:19696"
X-SW-Source: 2002-q3/txt/msg00405.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-33463914-1031888345=:19696
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 928

Hi,
`cygpath --version` is missing a trailing newline.  I'm attaching a patch.
This probably doesn't merit a ChangeLog entry, but I'm providing one
anyway, feel free to disregard it.  I also took the opportunity to factor
out the short options array into a global variable.  I can split this into
two separate patches, if necessary.
	Igor

2002-09-12  Igor Pechtchanski <pechtcha@cs.nyu.edu>
	* cygpath.cc (options) New global variable.
	(main) Make short options global for easier change.
	(print_version) Add a missing newline.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

It took the computational power of three Commodore 64s to fly to the moon.
It takes a 486 to run Windows 95.  Something is wrong here. -- SC sig file

---559023410-33463914-1031888345=:19696
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cygpath.cc-diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0209122339050.19696@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="cygpath.cc-diff"
Content-length: 1444

SW5kZXg6IGN5Z3BhdGguY2MNCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJD
UyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL3V0aWxzL2N5Z3BhdGguY2Ms
dg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjIyDQpkaWZmIC11IC1wIC1yMS4y
MiBjeWdwYXRoLmNjDQotLS0gY3lncGF0aC5jYwkyMyBBdWcgMjAwMiAxNTo0
NjowMCAtMDAwMAkxLjIyDQorKysgY3lncGF0aC5jYwkxMyBTZXAgMjAwMiAw
MzozNjoxOSAtMDAwMA0KQEAgLTU3LDYgKzU3LDggQEAgc3RhdGljIHN0cnVj
dCBvcHRpb24gbG9uZ19vcHRpb25zW10gPSB7DQogICB7MCwgbm9fYXJndW1l
bnQsIDAsIDB9DQogfTsNCiANCitzdGF0aWMgY2hhciBvcHRpb25zW10gPSAi
YWM6ZGY6aGlsbW9wc3Q6dXZ3QURIUFNXIjsNCisNCiBzdGF0aWMgdm9pZA0K
IHVzYWdlIChGSUxFICogc3RyZWFtLCBpbnQgc3RhdHVzKQ0KIHsNCkBAIC01
MzQsNyArNTM2LDggQEAgcHJpbnRfdmVyc2lvbiAoKQ0KIGN5Z3BhdGggKGN5
Z3dpbikgJS4qc1xuXA0KIFBhdGggQ29udmVyc2lvbiBVdGlsaXR5XG5cDQog
Q29weXJpZ2h0IDE5OTgsIDE5OTksIDIwMDAsIDIwMDEsIDIwMDIgUmVkIEhh
dCwgSW5jLlxuXA0KLUNvbXBpbGVkIG9uICVzIiwgbGVuLCB2LCBfX0RBVEVf
Xyk7DQorQ29tcGlsZWQgb24gJXNcblwNCisiLCBsZW4sIHYsIF9fREFURV9f
KTsNCiB9DQogDQogaW50DQpAQCAtNTYyLDcgKzU2NSw3IEBAIG1haW4gKGlu
dCBhcmdjLCBjaGFyICoqYXJndikNCiAgIG9wdGlvbnNfZnJvbV9maWxlX2Zs
YWcgPSAwOw0KICAgYWxsdXNlcnNfZmxhZyA9IDA7DQogICBvdXRwdXRfZmxh
ZyA9IDA7DQotICB3aGlsZSAoKGMgPSBnZXRvcHRfbG9uZyAoYXJnYywgYXJn
diwgKGNoYXIgKikgImFjOmRmOmhpbG1vcHN0OnV2d0FESFBTVyIsDQorICB3
aGlsZSAoKGMgPSBnZXRvcHRfbG9uZyAoYXJnYywgYXJndiwgb3B0aW9ucywN
CiAJCQkgICBsb25nX29wdGlvbnMsIChpbnQgKikgTlVMTCkpICE9IEVPRikN
CiAgICAgew0KICAgICAgIHN3aXRjaCAoYykNCg==

---559023410-33463914-1031888345=:19696--

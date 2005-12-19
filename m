Return-Path: <cygwin-patches-return-5689-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21844 invoked by alias); 19 Dec 2005 16:34:13 -0000
Received: (qmail 21835 invoked by uid 22791); 19 Dec 2005 16:34:12 -0000
X-Spam-Check-By: sourceware.org
Received: from SLINKY.CS.NYU.EDU (HELO slinky.cs.nyu.edu) (128.122.20.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 19 Dec 2005 16:34:11 +0000
Received: from localhost (localhost [127.0.0.1]) 	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id jBJGY9c9014031 	for <cygwin-patches@cygwin.com>; Mon, 19 Dec 2005 11:34:09 -0500 (EST)
Date: Mon, 19 Dec 2005 16:34:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Fix /lib=/usr/lib alias in "cygcheck -f"
Message-ID: <Pine.GSO.4.63.0512191131550.9894@slinky.cs.nyu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1903590565-1135010049=:9894"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2005-q4/txt/msg00031.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1903590565-1135010049=:9894
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 823

Hi,

Due to a missing trailing "/", "cygcheck -f" did not recognize "/lib" as
being the same as "/usr/lib".  The attached patch fixes this.  ChangeLog
below.
	Igor
==============================================================================
2005-12-19  Igor Pechtchanski  <pechtcha@cs.nyu.edu>

	* dump_setup.cc (package_find): Fix is_alias computation for
	"/usr/lib".

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
---559023410-1903590565-1135010049=:9894
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=cygcheck-find-lib-magic.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.63.0512191134090.9894@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename=cygcheck-find-lib-magic.patch
Content-length: 972

SW5kZXg6IGR1bXBfc2V0dXAuY2MNCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL3V0aWxzL2R1bXBfc2V0
dXAuY2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjE3DQpkaWZmIC11IC1w
IC1yMS4xNyBkdW1wX3NldHVwLmNjDQotLS0gZHVtcF9zZXR1cC5jYwkyNSBP
Y3QgMjAwNCAxNTo0OTozNiAtMDAwMAkxLjE3DQorKysgZHVtcF9zZXR1cC5j
YwkxOSBEZWMgMjAwNSAxNjozMDowMSAtMDAwMA0KQEAgLTQ3OCw3ICs0Nzgs
NyBAQCBwYWNrYWdlX2ZpbmQgKGludCB2ZXJib3NlLCBjaGFyICoqYXJndikN
CiAJICAgIHsNCiAJICAgICAgLy8gRklYTUU6IHZlcmlmeSB0aGF0IC9iaW4g
aXMgbW91bnRlZCBvbiAvdXNyL2JpbjsgZGl0dG8gZm9yIC9saWINCiAJICAg
ICAgYm9vbCBpc19hbGlhcyA9ICFzdHJuY21wKGZpbGVuYW1lLCAiL3Vzci9i
aW4vIiwgOSkgfHwNCi0JCQkgICAgICAhc3RybmNtcChmaWxlbmFtZSwgIi91
c3IvbGliIiwgOSk7DQorCQkJICAgICAgIXN0cm5jbXAoZmlsZW5hbWUsICIv
dXNyL2xpYi8iLCA5KTsNCiAJICAgICAgaW50IGEgPSBtYXRjaF9hcmd2IChh
cmd2LCBmaWxlbmFtZSk7DQogCSAgICAgIGlmICghYSAmJiBpc19hbGlhcykN
CiAJCWEgPSBtYXRjaF9hcmd2IChhcmd2LCBmaWxlbmFtZSArIDQpOw0K

---559023410-1903590565-1135010049=:9894--

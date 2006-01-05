Return-Path: <cygwin-patches-return-5696-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8428 invoked by alias); 5 Jan 2006 14:46:50 -0000
Received: (qmail 8419 invoked by uid 22791); 5 Jan 2006 14:46:50 -0000
X-Spam-Check-By: sourceware.org
Received: from SLINKY.CS.NYU.EDU (HELO slinky.cs.nyu.edu) (128.122.20.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 05 Jan 2006 14:46:48 +0000
Received: from localhost (localhost [127.0.0.1]) 	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k05Ekkc9007075 	for <cygwin-patches@cygwin.com>; Thu, 5 Jan 2006 09:46:46 -0500 (EST)
Date: Thu, 05 Jan 2006 14:46:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Correctly compute whether the process is a non-Cygwin process in  spawn_guts
Message-ID: <Pine.GSO.4.63.0601050944160.1754@slinky.cs.nyu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1903590565-1136472406=:1754"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00005.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1903590565-1136472406=:1754
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 820

The attached patch fixes the "no output from commands invoked through ssh"
for me.  The ChangeLog is below.
	Igor
==============================================================================
2006-01-05  Igor Peshansky  <pechtcha@cs.nyu.edu>

	* spawn.cc (spawn_guts): Invert the argument to
	set_console_state_for_spawn.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
---559023410-1903590565-1136472406=:1754
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=spawn_console_state-fix.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.63.0601050946460.1754@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename=spawn_console_state-fix.patch
Content-length: 936

SW5kZXg6IHdpbnN1cC9jeWd3aW4vc3Bhd24uY2MNCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dp
bi9zcGF3bi5jYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMjA0DQpkaWZm
IC11IC1wIC1yMS4yMDQgc3Bhd24uY2MNCi0tLSB3aW5zdXAvY3lnd2luL3Nw
YXduLmNjCTQgSmFuIDIwMDYgMDM6NDM6NTUgLTAwMDAJMS4yMDQNCisrKyB3
aW5zdXAvY3lnd2luL3NwYXduLmNjCTUgSmFuIDIwMDYgMTQ6NDM6MzcgLTAw
MDANCkBAIC02MTcsNyArNjE3LDcgQEAgc3Bhd25fZ3V0cyAoY29uc3QgY2hh
ciAqIHByb2dfYXJnLCBjb25zdA0KICAgICAgIGVsc2UNCiAJc3lzdGVtX3By
aW50ZiAoImR1cGxpY2F0ZSB0byBwaWRfaGFuZGxlIGZhaWxlZCwgJUUiKTsN
CiAgICAgICBpZiAobW9kZSAhPSBfUF9ERVRBQ0gpDQotCXNldF9jb25zb2xl
X3N0YXRlX2Zvcl9zcGF3biAocmVhbF9wYXRoLmlzY3lnZXhlYyAoKSk7DQor
CXNldF9jb25zb2xlX3N0YXRlX2Zvcl9zcGF3biAoIXJlYWxfcGF0aC5pc2N5
Z2V4ZWMgKCkpOw0KICAgICB9DQogDQogICAvKiBTb21lIGZpbGUgdHlwZXMg
KGN1cnJlbnRseSBvbmx5IHNvY2tldHMpIG5lZWQgZXh0cmEgZWZmb3J0IGlu
IHRoZSBwYXJlbnQNCg==

---559023410-1903590565-1136472406=:1754--

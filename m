Return-Path: <cygwin-patches-return-5748-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29605 invoked by alias); 13 Feb 2006 18:47:56 -0000
Received: (qmail 29595 invoked by uid 22791); 13 Feb 2006 18:47:56 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 13 Feb 2006 18:47:50 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k1DIlmA7024686 	for <cygwin-patches@cygwin.com>; Mon, 13 Feb 2006 13:47:48 -0500 (EST)
Date: Mon, 13 Feb 2006 18:47:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH] Add missing include to mntent.h
Message-ID: <Pine.GSO.4.63.0602131347010.17217@access1.cims.nyu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1144747756-1139856468=:17217"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00057.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1144747756-1139856468=:17217
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 728

Hi.  This patch adds a missing include to mntent.h.
	Igor
==============================================================================
2006-02-03  Igor Peshansky  <pechtcha@cs.nyu.edu>

	* include/mntent.h: Add missing #include.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
---559023410-1144747756-1139856468=:17217
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=mntent-missing-include.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.63.0602131347480.17217@access1.cims.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename=mntent-missing-include.patch
Content-length: 846

SW5kZXg6IHdpbnN1cC9jeWd3aW4vaW5jbHVkZS9tbnRlbnQuaA0KPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5z
dXAvY3lnd2luL2luY2x1ZGUvbW50ZW50Lmgsdg0KcmV0cmlldmluZyByZXZp
c2lvbiAxLjMNCmRpZmYgLXUgLXAgLXIxLjMgbW50ZW50LmgNCi0tLSB3aW5z
dXAvY3lnd2luL2luY2x1ZGUvbW50ZW50LmgJNSBNYXIgMjAwMSAyMToyOToy
MCAtMDAwMAkxLjMNCisrKyB3aW5zdXAvY3lnd2luL2luY2x1ZGUvbW50ZW50
LmgJMyBGZWIgMjAwNiAxODoxMjoyMCAtMDAwMA0KQEAgLTI2LDYgKzI2LDgg
QEAgc3RydWN0IG1udGVudA0KIH07DQogDQogI2lmbmRlZiBfTk9NTlRFTlRf
RlVOQ1MNCisjaW5jbHVkZSA8c3RkaW8uaD4gIC8qIEZvciBGSUxFIHR5cGUu
ICovDQorDQogRklMRSAqc2V0bW50ZW50IChjb25zdCBjaGFyICpfX2ZpbGVw
LCBjb25zdCBjaGFyICpfX3R5cGUpOw0KIHN0cnVjdCBtbnRlbnQgKmdldG1u
dGVudCAoRklMRSAqX19maWxlcCk7DQogaW50IGFkZG1udGVudCAoRklMRSAq
X19maWxlcCwgY29uc3Qgc3RydWN0IG1udGVudCAqX19tbnQpOw0K

---559023410-1144747756-1139856468=:17217--

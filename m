Return-Path: <cygwin-patches-return-5706-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6853 invoked by alias); 12 Jan 2006 02:32:52 -0000
Received: (qmail 6842 invoked by uid 22791); 12 Jan 2006 02:32:51 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 12 Jan 2006 02:32:48 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k0C2WkA7019051 	for <cygwin-patches@cygwin.com>; Wed, 11 Jan 2006 21:32:46 -0500 (EST)
Date: Thu, 12 Jan 2006 02:32:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Ignore CVS directories when building documentation
Message-ID: <Pine.GSO.4.63.0601112129230.9317@access1.cims.nyu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-351212254-1137033166=:9317"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00015.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-351212254-1137033166=:9317
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1079

The doctool program recursively searches for SGML/XML chunks in
subdirectories.  CVS keeps base copies of "cvs edit"ed files in CVS/Base.
Including both the base copy and the modified file results in duplicate
ids and other validation errors (not to mention wrong output).  This patch
tells doctool to ignore CVS directories during recursive traversals.

As usual, the ChangeLog is below.
	Igor
==============================================================================
2006-01-11  Igor Peshansky  <pechtcha@cs.nyu.edu>

	* doctool.c (scan_directory): Ignore "CVS" directories.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
---559023410-351212254-1137033166=:9317
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=doctool-cvs-dir-fix.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.63.0601112132460.9317@access1.cims.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename=doctool-cvs-dir-fix.patch
Content-length: 667

SW5kZXg6IGRvY3Rvb2wuYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvZG9jL2RvY3Rvb2wuYyx2DQpy
ZXRyaWV2aW5nIHJldmlzaW9uIDEuMg0KZGlmZiAtdSAtcCAtcjEuMiBkb2N0
b29sLmMNCi0tLSBkb2N0b29sLmMJNCBEZWMgMjAwMSAwNDoyMDozMCAtMDAw
MAkxLjINCisrKyBkb2N0b29sLmMJMTIgSmFuIDIwMDYgMDI6Mjc6MzMgLTAw
MDANCkBAIC0xNTcsNyArMTU3LDcgQEAgc2Nhbl9kaXJlY3RvcnkoZGlybmFt
ZSkNCiANCiAgICAgU1RBVChuYW1lLCAmc3QpOw0KIA0KLSAgICBpZiAoU19J
U0RJUihzdC5zdF9tb2RlKSkNCisgICAgaWYgKFNfSVNESVIoc3Quc3RfbW9k
ZSkgJiYgc3RyY21wKGRlLT5kX25hbWUsICJDVlMiKSAhPSAwKQ0KICAgICB7
DQogICAgICAgc2Nhbl9kaXJlY3RvcnkobmFtZSk7DQogICAgIH0NCg==

---559023410-351212254-1137033166=:9317--

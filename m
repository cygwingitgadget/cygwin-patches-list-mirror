Return-Path: <cygwin-patches-return-5746-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27642 invoked by alias); 13 Feb 2006 18:45:47 -0000
Received: (qmail 27627 invoked by uid 22791); 13 Feb 2006 18:45:45 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 13 Feb 2006 18:45:39 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k1DIjbA7023840 	for <cygwin-patches@cygwin.com>; Mon, 13 Feb 2006 13:45:37 -0500 (EST)
Date: Mon, 13 Feb 2006 18:45:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH] Minor fix for regtool
Message-ID: <Pine.GSO.4.63.0602131344320.17217@access1.cims.nyu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-126398554-1139856337=:17217"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00055.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-126398554-1139856337=:17217
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 731

Hi.  This patch clarifies the regtool help message.
	Igor
==============================================================================
2006-02-03  Igor Peshansky  <pechtcha@cs.nyu.edu>

	* regtool.cc (usage): Clarify help for "-K".

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
---559023410-126398554-1139856337=:17217
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=regtool-typo-fix.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.63.0602131345370.17217@access1.cims.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename=regtool-typo-fix.patch
Content-length: 1143

SW5kZXg6IHdpbnN1cC91dGlscy9yZWd0b29sLmNjDQo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC91dGls
cy9yZWd0b29sLmNjLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4xOA0KZGlm
ZiAtdSAtcCAtcjEuMTggcmVndG9vbC5jYw0KLS0tIHdpbnN1cC91dGlscy9y
ZWd0b29sLmNjCTggU2VwIDIwMDUgMDk6MjQ6NDEgLTAwMDAJMS4xOA0KKysr
IHdpbnN1cC91dGlscy9yZWd0b29sLmNjCTMgRmViIDIwMDYgMTg6MTI6MjMg
LTAwMDANCkBAIC04OSw4ICs4OSw4IEBAIHVzYWdlIChGSUxFICp3aGVyZSA9
IHN0ZGVycikNCiAgICIgLW0sIC0tbXVsdGktc3RyaW5nICAgc2V0IHR5cGUg
dG8gUkVHX01VTFRJX1NaXG4iDQogICAiIC1zLCAtLXN0cmluZyAgICAgICAg
IHNldCB0eXBlIHRvIFJFR19TWlxuIg0KICAgIlxuIg0KLSAgIk9wdGlvbnMg
Zm9yICdzZXQnIGFuZCAndW5zZXQnIEFjdGlvbnM6XG4iDQotICAiIC1LPGM+
LCAtLWtleS1zZXBhcmF0b3JbPV08Yz4gIHNldCBrZXkgc2VwYXJhdG9yIHRv
IDxjPiBpbnN0ZWFkIG9mICdcXCdcbiINCisgICJPcHRpb25zIGZvciAnc2V0
JywgJ3Vuc2V0JywgYW5kICdnZXQnIEFjdGlvbnM6XG4iDQorICAiIC1LPGM+
LCAtLWtleS1zZXBhcmF0b3JbPV08Yz4gIHNldCBrZXktdmFsdWUgc2VwYXJh
dG9yIHRvIDxjPiBpbnN0ZWFkIG9mICdcXCdcbiINCiAgICJcbiINCiAgICJP
dGhlciBPcHRpb25zOlxuIg0KICAgIiAtaCwgLS1oZWxwICAgICBvdXRwdXQg
dXNhZ2UgaW5mb3JtYXRpb24gYW5kIGV4aXRcbiINCg==

---559023410-126398554-1139856337=:17217--

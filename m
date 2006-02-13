Return-Path: <cygwin-patches-return-5747-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28136 invoked by alias); 13 Feb 2006 18:46:52 -0000
Received: (qmail 28118 invoked by uid 22791); 13 Feb 2006 18:46:51 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 13 Feb 2006 18:46:49 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k1DIkmA7024107 	for <cygwin-patches@cygwin.com>; Mon, 13 Feb 2006 13:46:48 -0500 (EST)
Date: Mon, 13 Feb 2006 18:46:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix typo in gentls_offsets
Message-ID: <Pine.GSO.4.63.0602131345390.17217@access1.cims.nyu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-351212254-1139856408=:17217"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00056.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-351212254-1139856408=:17217
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 753

Hi.  This (old) patch fixes a typo in an error message in gentls_offsets.
	Igor
==============================================================================
2004-07-06  Igor Peshansky  <pechtcha@cs.nyu.edu>

	* gentls_offsets: Fix typo in error message.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
---559023410-351212254-1139856408=:17217
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=gentls_offsets-typo.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.63.0602131346480.17217@access1.cims.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename=gentls_offsets-typo.patch
Content-length: 1269

SW5kZXg6IHdpbnN1cC9jeWd3aW4vZ2VudGxzX29mZnNldHMNCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3Vw
L2N5Z3dpbi9nZW50bHNfb2Zmc2V0cyx2DQpyZXRyaWV2aW5nIHJldmlzaW9u
IDEuNg0KZGlmZiAtdSAtcCAtcjEuNiBnZW50bHNfb2Zmc2V0cw0KLS0tIHdp
bnN1cC9jeWd3aW4vZ2VudGxzX29mZnNldHMJMjUgRmViIDIwMDQgMDQ6MDg6
MDAgLTAwMDAJMS42DQorKysgd2luc3VwL2N5Z3dpbi9nZW50bHNfb2Zmc2V0
cwk2IEp1bCAyMDA0IDE2OjQzOjIxIC0wMDAwDQpAQCAtNzQsNyArNzQsNyBA
QCBzeXN0ZW0gQEFSR1YsICctbycsICIvdG1wLyQkLTEuY2MiLCAnLUUnDQog
c3lzdGVtICdnKysnLCAnLW8nLCAiL3RtcC8kJC5hLm91dCIsICIvdG1wLyQk
LTEuY2MiIGFuZA0KICgkPyA9PSAxMjcgJiYgc3lzdGVtICdjKysnLCAgJy1v
JywgIi90bXAvJCQuYS5vdXQiLCAiL3RtcC8kJC0xLmNjIikgYW5kDQogZGll
ICIkMDogY291bGRuJ3QgZ2VuZXJhdGUgZXhlY3V0YWJsZSBmb3Igb2Zmc2V0
IGNhbGN1bGF0aW9uIFwiL3RtcC8kJC5hLm91dFwiIC0gJCFcbiI7DQotb3Bl
bihUTFNfT1VULCAnPicsICR0bHNfb3V0KSBvciBkaWUgIiQwOiBjb3VsZG4n
dCBvcGVuIHRscyBpbmRleCBmaWxlIFwidGxzX291dFwiIC0gJCFcbiI7DQor
b3BlbihUTFNfT1VULCAnPicsICR0bHNfb3V0KSBvciBkaWUgIiQwOiBjb3Vs
ZG4ndCBvcGVuIHRscyBpbmRleCBmaWxlIFwiJHRsc19vdXRcIiAtICQhXG4i
Ow0KIG9wZW4oT0ZGUywgIi90bXAvJCQuYS5vdXR8Iikgb3IgZGllICIkMDog
Y291bGRuJ3QgcnVuIFwiL3RtcC8kJC5hLm91dFwiIC0gJCFcbiI7DQogcHJp
bnQgVExTX09VVCA8T0ZGUz47DQogY2xvc2UgT0ZGUzsNCg==

---559023410-351212254-1139856408=:17217--

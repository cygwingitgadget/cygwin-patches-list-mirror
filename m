Return-Path: <cygwin-patches-return-3028-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23685 invoked by alias); 23 Sep 2002 12:34:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23663 invoked from network); 23 Sep 2002 12:34:39 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 23 Sep 2002 05:34:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] pthread key destructor
Message-ID: <Pine.WNT.4.44.0209231427310.294-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="430859-25930-1032784475=:294"
X-SW-Source: 2002-q3/txt/msg00476.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--430859-25930-1032784475=:294
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 369


See
http://www.opengroup.org/onlinepubs/007904975/functions/pthread_key_create.html

I do not think that we should support more than one iterations at the
moment. This seems to be a rather new addition to the pthread
specification.

2002-09-23  Thomas Pfaff  <tpfaff@gmx.net>

	* thread.cc (pthread_key::run_destructor): Run destructor only if
	key value is not NULL.

--430859-25930-1032784475=:294
Content-Type: TEXT/plain; name="pthread_key_destructor.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0209231434350.294@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="pthread_key_destructor.patch"
Content-length: 566

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2Mgc3Jj
L3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCi0tLSBzcmMub2xkL3dpbnN1cC9j
eWd3aW4vdGhyZWFkLmNjCU1vbiBTZXAgMjMgMTQ6MTU6MTcgMjAwMgorKysg
c3JjL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCU1vbiBTZXAgMjMgMTQ6MjI6
MjIgMjAwMgpAQCAtMTAzMSw3ICsxMDMxLDExIEBAIHZvaWQKIHB0aHJlYWRf
a2V5OjpydW5fZGVzdHJ1Y3RvciAoKSBjb25zdAogewogICBpZiAoZGVzdHJ1
Y3RvcikKLSAgICBkZXN0cnVjdG9yIChnZXQgKCkpOworICAgIHsKKyAgICAg
IHZvaWQgKnZhbHVlID0gZ2V0ICgpOworICAgICAgaWYgKHZhbHVlKQorICAg
ICAgICBkZXN0cnVjdG9yICh2YWx1ZSk7CisgICAgfQogfQogCiAvKnBzaGFy
ZWQgbXV0ZXhzOgo=

--430859-25930-1032784475=:294--

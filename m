Return-Path: <cygwin-patches-return-3029-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24058 invoked by alias); 23 Sep 2002 12:36:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24041 invoked from network); 23 Sep 2002 12:36:39 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 23 Sep 2002 05:36:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Reset threadcount after fork
Message-ID: <Pine.WNT.4.44.0209231434400.294-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="551247-10487-1032784595=:294"
X-SW-Source: 2002-q3/txt/msg00477.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--551247-10487-1032784595=:294
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 127


2002-09-23  Thomas Pfaff  <tpfaff@gmx.net>

	* thread.cc (MTinterface::fixup_after_fork): Reset threadcount to
	1 after fork.

--551247-10487-1032784595=:294
Content-Type: TEXT/plain; name="mtinterface_threadcount.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0209231436350.294@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="mtinterface_threadcount.patch"
Content-length: 627

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2Mgc3Jj
L3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCi0tLSBzcmMub2xkL3dpbnN1cC9j
eWd3aW4vdGhyZWFkLmNjCU1vbiBTZXAgMjMgMTQ6MjY6MzAgMjAwMgorKysg
c3JjL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCU1vbiBTZXAgMjMgMTQ6MjU6
MzQgMjAwMgpAQCAtMjEwLDYgKzIxMCw4IEBAIE1UaW50ZXJmYWNlOjpmaXh1
cF9iZWZvcmVfZm9yayAodm9pZCkKIHZvaWQKIE1UaW50ZXJmYWNlOjpmaXh1
cF9hZnRlcl9mb3JrICh2b2lkKQogeworICB0aHJlYWRjb3VudCA9IDE7IC8q
MSBjdXJyZW50IHRocmVhZCBhZnRlciBmb3JrLiovCisKICAgcHRocmVhZF9r
ZXk6OmZpeHVwX2FmdGVyX2ZvcmsgKCk7CiAgIHB0aHJlYWRfbXV0ZXggKm11
dGV4ID0gbXV0ZXhzOwogICBkZWJ1Z19wcmludGYgKCJtdXRleHMgaXMgJXgi
LG11dGV4cyk7Cg==

--551247-10487-1032784595=:294--

Return-Path: <cygwin-patches-return-2525-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10047 invoked by alias); 27 Jun 2002 07:33:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10018 invoked from network); 27 Jun 2002 07:33:31 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Thu, 27 Jun 2002 07:18:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Additional trace printf in pthread::create
Message-ID: <Pine.WNT.4.44.0206270928100.315-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="129386-8341-1025163009=:315"
Content-ID: <Pine.WNT.4.44.0206270930390.315@algeria.intern.net>
X-SW-Source: 2002-q2/txt/msg00508.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--129386-8341-1025163009=:315
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.WNT.4.44.0206270930391.315@algeria.intern.net>
Content-length: 137

Changelog

2002-06-27  Thomas Pfaff  <tpfaff@gmx.net>

	*thread.cc (pthread::create): Added trace printf to get
	CreateThread LastError.

--129386-8341-1025163009=:315
Content-Type: TEXT/PLAIN; NAME="pthread_trace.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0206270930090.315@algeria.intern.net>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="pthread_trace.patch"
Content-length: 716

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2Mgc3Jj
L3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCi0tLSBzcmMub2xkL3dpbnN1cC9j
eWd3aW4vdGhyZWFkLmNjCU1vbiBKdW4gMjQgMDM6MTI6MzggMjAwMgorKysg
c3JjL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCVRodSBKdW4gMjcgMDk6MTk6
MzYgMjAwMgpAQCAtMzk5LDcgKzM5OSwxMCBAQCBwdGhyZWFkOjpjcmVhdGUg
KHZvaWQgKigqZnVuYykgKHZvaWQgKiksCiAJCQkJdGhpcywgQ1JFQVRFX1NV
U1BFTkRFRCwgJnRocmVhZF9pZCk7CiAKICAgaWYgKCF3aW4zMl9vYmpfaWQp
Ci0gICAgbWFnaWMgPSAwOworICAgIHsKKyAgICAgIHRocmVhZF9wcmludGYg
KCJDcmVhdGVUaHJlYWQgZmFpbGVkOiB0aGlzICVwIExhc3RFcnJvciAlZCIs
IHRoaXMsIEdldExhc3RFcnJvcigpKTsKKyAgICAgIG1hZ2ljID0gMDsKKyAg
ICB9CiAgIGVsc2UKICAgICB7CiAgICAgICBJbnRlcmxvY2tlZEluY3JlbWVu
dCAoJk1UX0lOVEVSRkFDRS0+dGhyZWFkY291bnQpOwo=

--129386-8341-1025163009=:315--

Return-Path: <cygwin-patches-return-3630-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20461 invoked by alias); 27 Feb 2003 12:25:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20452 invoked from network); 27 Feb 2003 12:25:31 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Thu, 27 Feb 2003 12:25:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] MTInterface fixup_after_fork
Message-ID: <Pine.WNT.4.44.0302271021490.285-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="384237-16749-1046338085=:285"
Content-ID: <Pine.WNT.4.44.0302271324220.285@algeria.intern.net>
X-SW-Source: 2003-q1/txt/msg00279.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--384237-16749-1046338085=:285
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.WNT.4.44.0302271324221.285@algeria.intern.net>
Content-length: 173


Required for the rwlock patch.

2003-02-27  Thomas Pfaff  <tpfaff@gmx.net>

	* thread.cc (MTinterface::fixup_after_fork): Initialize mainthread
	prior to pthread objects.


--384237-16749-1046338085=:285
Content-Type: TEXT/PLAIN; NAME="mtinterface.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0302271028050.285@algeria.intern.net>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="mtinterface.patch"
Content-length: 911

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2Mgc3Jj
L3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCi0tLSBzcmMub2xkL3dpbnN1cC9j
eWd3aW4vdGhyZWFkLmNjCTIwMDMtMDEtMTQgMjE6MzI6MjYuMDAwMDAwMDAw
ICswMTAwCisrKyBzcmMvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2MJMjAwMy0w
Mi0yNiAxNjo1OTo0MS4wMDAwMDAwMDAgKzAxMDAKQEAgLTIxMyw2ICsyMTMs
MTAgQEAgdm9pZAogTVRpbnRlcmZhY2U6OmZpeHVwX2FmdGVyX2ZvcmsgKHZv
aWQpCiB7CiAgIHB0aHJlYWRfa2V5OjpmaXh1cF9hZnRlcl9mb3JrICgpOwor
CisgIHRocmVhZGNvdW50ID0gMTsKKyAgcHRocmVhZDo6aW5pdE1haW5UaHJl
YWQgKHRydWUpOworCiAgIHB0aHJlYWRfbXV0ZXggKm11dGV4ID0gbXV0ZXhz
OwogICBkZWJ1Z19wcmludGYgKCJtdXRleHMgaXMgJXgiLG11dGV4cyk7CiAg
IHdoaWxlIChtdXRleCkKQEAgLTIzNCwxMCArMjM4LDYgQEAgTVRpbnRlcmZh
Y2U6OmZpeHVwX2FmdGVyX2ZvcmsgKHZvaWQpCiAgICAgICBzZW0tPmZpeHVw
X2FmdGVyX2ZvcmsgKCk7CiAgICAgICBzZW0gPSBzZW0tPm5leHQ7CiAgICAg
fQotCi0gIHB0aHJlYWQ6OmluaXRNYWluVGhyZWFkICh0cnVlKTsKLQotICB0
aHJlYWRjb3VudCA9IDE7CiB9CiAKIC8qIHB0aHJlYWQgY2FsbHMgKi8K

--384237-16749-1046338085=:285--

Return-Path: <cygwin-patches-return-3367-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18216 invoked by alias); 10 Jan 2003 08:58:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18146 invoked from network); 10 Jan 2003 08:58:28 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Fri, 10 Jan 2003 08:58:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] make handle_sigsuspend a cancellation point
Message-ID: <Pine.WNT.4.44.0301100953500.299-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="850713-9445-1042189077=:299"
X-SW-Source: 2003-q1/txt/msg00016.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--850713-9445-1042189077=:299
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 314

This patch will make handle_sigsuspend (used by pause, sigpause
and sigsuspend) a pthread cancellation point.


2003-01-10  Thomas Pfaff  <tpfaff@gmx.net>

	* exceptions.cc (handle_sigsuspend): Add pthread_testcancel call.
	Wait for signal and cancellation event.
	* thread.cc: Update list of cancellation points.

--850713-9445-1042189077=:299
Content-Type: TEXT/plain; name="handle_sigsuspend-cancel.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0301100957570.299@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="handle_sigsuspend-cancel.patch"
Content-length: 1448

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi9leGNlcHRpb25zLmNj
IHNyYy93aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MKLS0tIHNyYy5vbGQv
d2luc3VwL2N5Z3dpbi9leGNlcHRpb25zLmNjCTIwMDItMTItMjUgMjE6MzI6
MDUuMDAwMDAwMDAwICswMTAwCisrKyBzcmMvd2luc3VwL2N5Z3dpbi9leGNl
cHRpb25zLmNjCTIwMDMtMDEtMDkgMTA6MTk6MjguMDAwMDAwMDAwICswMTAw
CkBAIC01NzYsNyArNTc2LDggQEAgaGFuZGxlX3NpZ3N1c3BlbmQgKHNpZ3Nl
dF90IHRlbXBtYXNrKQogCQkJCS8vICBpbnRlcmVzdGVkIGluIHRocm91Z2gu
CiAgIHNpZ3Byb2NfcHJpbnRmICgib2xkIG1hc2sgJXgsIG5ldyBtYXNrICV4
Iiwgb2xkbWFzaywgdGVtcG1hc2spOwogCi0gIFdhaXRGb3JTaW5nbGVPYmpl
Y3QgKHNpZ25hbF9hcnJpdmVkLCBJTkZJTklURSk7CisgIHB0aHJlYWRfdGVz
dGNhbmNlbCAoKTsKKyAgcHRocmVhZDo6Y2FuY2VsYWJsZV93YWl0IChzaWdu
YWxfYXJyaXZlZCwgSU5GSU5JVEUpOwogCiAgIHNldF9zaWdfZXJybm8gKEVJ
TlRSKTsJLy8gUGVyIFBPU0lYCiAKZGlmZiAtdXJwIHNyYy5vbGQvd2luc3Vw
L2N5Z3dpbi90aHJlYWQuY2Mgc3JjL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNj
Ci0tLSBzcmMub2xkL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCTIwMDMtMDEt
MDkgMDk6NDI6MjguMDAwMDAwMDAwICswMTAwCisrKyBzcmMvd2luc3VwL2N5
Z3dpbi90aHJlYWQuY2MJMjAwMy0wMS0xMCAwOTo0MjozNy4wMDAwMDAwMDAg
KzAxMDAKQEAgLTQ1OCw3ICs0NTgsNyBAQCBtc2dzbmQgKCkKIG1zeW5jICgp
CiBuYW5vc2xlZXAgKCkKIG9wZW4gKCkKLXBhdXNlICgpCisqcGF1c2UgKCkK
IHBvbGwgKCkKIHByZWFkICgpCiBwdGhyZWFkX2NvbmRfdGltZWR3YWl0ICgp
CkBAIC00NzIsOCArNDcyLDggQEAgcmVhZCAoKQogcmVhZHYgKCkKIHNlbGVj
dCAoKQogKnNlbV93YWl0ICgpCi1zaWdwYXVzZSAoKQotc2lnc3VzcGVuZCAo
KQorKnNpZ3BhdXNlICgpCisqc2lnc3VzcGVuZCAoKQogc2lndGltZWR3YWl0
ICgpCiBzaWd3YWl0ICgpCiBzaWd3YWl0aW5mbyAoKQo=

--850713-9445-1042189077=:299--

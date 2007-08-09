Return-Path: <cygwin-patches-return-6130-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9210 invoked by alias); 9 Aug 2007 17:12:10 -0000
Received: (qmail 9146 invoked by uid 22791); 9 Aug 2007 17:12:08 -0000
X-Spam-Check-By: sourceware.org
Received: from nat1.steeleye.com (HELO exgate.steeleye.com) (71.30.118.249)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 09 Aug 2007 17:12:02 +0000
Received: from steelpo.steeleye.com ([172.17.4.222]) by exgate.steeleye.com with Microsoft SMTPSVC(5.0.2195.6713); 	 Thu, 9 Aug 2007 13:11:57 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; 	boundary="----_=_NextPart_001_01C7DAA8.63FBA0F3"
Subject: Signal handler not executed
Date: Thu, 09 Aug 2007 17:12:00 -0000
Message-ID: <76087731258D2545B1016BB958F00ADA123A4B@STEELPO.steeleye.com>
From: "Ernie Coskrey" <Ernie.Coskrey@steeleye.com>
To: <cygwin-patches@cygwin.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00005.txt.bz2

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7DAA8.63FBA0F3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-length: 523

There's a very small window of vulnerability in _sigbe, which can lead
to signal handlers not being executed.  In _sigbe, the _cygtls lock is
released before incyg is decremented.  If setup_handler acquires the
lock just after _sigbe releases it, but before incyg is decremented,
setup_handler will mistakenly believe that the thread is in Cygwin code,
and will set up the interrupt using the tls stack.
=20
_sigbe should decrement incyg before releasing the lock.

---------
Ernie Coskrey        SteelEye Technology, Inc.

------_=_NextPart_001_01C7DAA8.63FBA0F3
Content-Type: application/octet-stream;
	name="gendef.diff"
Content-Transfer-Encoding: base64
Content-Description: gendef.diff
Content-Disposition: attachment;
	filename="gendef.diff"
Content-length: 529

LS0tIGdlbmRlZi5vcmlnaW5hbAkyMDA3LTA4LTA5IDEyOjU2OjA3LjQyODcx
NDUwMCAtMDQwMAorKysgZ2VuZGVmCTIwMDctMDgtMDkgMTI6NTY6NDMuMjg4
MDg5NTAwIC0wNDAwCkBAIC0xNTgsOSArMTU4LDkgQEAKIAl4b3JsCSVlZHgs
JWVkeAogCXhjaGdsCSVlZHgsLTQoJWVheCkJCQkJIyBnZXQgcmV0dXJuIGFk
ZHJlc3MgZnJvbSBzaWduYWwgc3RhY2sKIAl4Y2hnbAklZWR4LDgoJWVzcCkJ
CQkJIyByZXN0b3JlIGVkeC9yZWFsIHJldHVybiBhZGRyZXNzCisJZGVjbAkk
dGxzOjppbmN5ZyglZWJ4KQogCWRlY2wJJHRsczo6c3RhY2tsb2NrKCVlYngp
CQkJIyByZWxlYXNlIGxvY2sKIAlwb3BsCSVlYXgKLQlkZWNsCSR0bHM6Omlu
Y3lnKCVlYngpCiAJcG9wbAklZWJ4CiAJcmV0CiAK

------_=_NextPart_001_01C7DAA8.63FBA0F3--

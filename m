Return-Path: <cygwin-patches-return-4633-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32580 invoked by alias); 29 Mar 2004 08:29:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32561 invoked from network); 29 Mar 2004 08:29:00 -0000
Date: Mon, 29 Mar 2004 08:29:00 -0000
From: "Thomas Pfaff" <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary189181080548778"
Subject: [PATCH]: Trivial move in pthread::atforkprepare
X-Authenticated: #623905
Message-ID: <18918.1080548778@www17.gmx.net>
X-Flags: 0001
X-SW-Source: 2004-q1/txt/msg00123.txt.bz2

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary189181080548778
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-length: 511

MT_INTERFACE->fixup_before_fork () should be done as the last step  in
pthread::atforkprepare.

I am sorrry if the Changelog contains spaces, but i have limited internet
access at the moment (only Webmail).

2004-03-29  Thomas Pfaff  <tpfaff@gmx.net>

	* thread.cc (pthread::atforkprepare): Call
	MT_INTERFACE->fixup_before_fork at the end of atforkprepare.

-- 
+++ NEU bei GMX und erstmalig in Deutschland: TÜV-geprüfter Virenschutz +++
100% Virenerkennung nach Wildlist. Infos: http://www.gmx.net/virenschutz
--========GMXBoundary189181080548778
Content-Type: plain/text; name="thread.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="thread.patch"
Content-length: 606

LS0tIHRocmVhZC5jYy5vcmlnCTIwMDQtMDMtMjkgMDk6MTQ6MTAuNDgxNDM2
ODAwICswMjAwCisrKyB0aHJlYWQuY2MJMjAwNC0wMy0yOSAwOToxODowMS43
Njg1NjE2MDAgKzAyMDAKQEAgLTE5NDEsOCArMTk0MSw2IEBAIHB0aHJlYWQ6
OmNhbmNlbCAocHRocmVhZF90IHRocmVhZCkKIHZvaWQKIHB0aHJlYWQ6OmF0
Zm9ya3ByZXBhcmUgKHZvaWQpCiB7Ci0gIE1UX0lOVEVSRkFDRS0+Zml4dXBf
YmVmb3JlX2ZvcmsgKCk7Ci0KICAgY2FsbGJhY2sgKmNiID0gTVRfSU5URVJG
QUNFLT5wdGhyZWFkX3ByZXBhcmU7CiAgIHdoaWxlIChjYikKICAgICB7CkBA
IC0xOTUxLDYgKzE5NDksOCBAQCBwdGhyZWFkOjphdGZvcmtwcmVwYXJlICh2
b2lkKQogICAgIH0KIAogICBfX2ZwX2xvY2tfYWxsICgpOworCisgIE1UX0lO
VEVSRkFDRS0+Zml4dXBfYmVmb3JlX2ZvcmsgKCk7CiB9CiAKIHZvaWQK

--========GMXBoundary189181080548778--

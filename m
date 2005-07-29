Return-Path: <cygwin-patches-return-5591-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 427 invoked by alias); 29 Jul 2005 10:39:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 406 invoked by uid 22791); 29 Jul 2005 10:39:20 -0000
Received: from mailgw1.wm.net (HELO mailgw1.wm.net) (194.18.224.214)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 29 Jul 2005 10:39:20 +0000
Received: from WMSI001556.corp.wmdata.net (wmsi001556.wmdata.se [164.9.238.12])
	by mailgw1.wm.net (BorderWare MXtreme Mail Firewall) with ESMTP id 654F80241S
	for <cygwin-patches@cygwin.com>; Fri, 29 Jul 2005 12:39:15 +0200 (CEST)
Received: from WMRI000166.corp.wmdata.net ([164.9.238.15]) by WMSI001556.corp.wmdata.net with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 29 Jul 2005 12:39:15 +0200
Received: from 172.27.117.80 ([172.27.117.80]) by WMRI000166.corp.wmdata.net ([164.9.238.19]) via Exchange Front-End Server mail.wmdata.com ([164.9.238.13]) with Microsoft Exchange Server HTTP-DAV ;
 Fri, 29 Jul 2005 10:39:14 +0000
Received: from tkuwhuuskartlnx.novogroup.com by mail.wmdata.com; 29 Jul 2005 13:39:14 +0300
Subject: Try to remove possible race pinfo::init
From: Arto Huusko <arto.huusko@wmdata.fi>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary="=-FpfGKaT+YjnGNW34ZHk3"
Date: Fri, 29 Jul 2005 10:39:00 -0000
Message-Id: <1122633554.7369.170.camel@tkuwhuuskartlnx.novogroup.com>
Mime-Version: 1.0
X-SW-Source: 2005-q3/txt/msg00046.txt.bz2


--=-FpfGKaT+YjnGNW34ZHk3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-length: 772

On some systems, I was frequent segmentation faults on fork(), and
I was able to track it down to the patch I just sent. However, my
scripts don't run much better, because they now fail only a bit
more cleanly with "fork: Resource temporarily unavailable".

Since my previous patch transformed seg faults to EAGAIN errors,
I tried to find potential races or other errors in pinfo::init.
I didn't really take the time to try to understand the code, but
if I'm guessing right, the MapViewOfFileEx() call is doing something
that depends on the child. If that's right, then it seems to me
that the retry loop in open_shared() failure case is a bit too
tight.


2005-07-29  Arto Huusko  <arto.huusko@wmdata.fi>

	* pinfo.cc (pinfo::init): Sleep before retrying open_shared().


--=-FpfGKaT+YjnGNW34ZHk3
Content-Disposition: attachment; filename=pinfo.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=pinfo.patch; charset=us-ascii
Content-length: 411

LS0tIHBpbmZvLmNjCTIwMDUtMDctMjkgMTE6MjU6NDMuNTAxNjg3NDYwICsw
MzAwDQorKysgcGluZm8uY2MuZml4ZWQJMjAwNS0wNy0yOSAxMToyNjoxNy45
MzE0Nzg1MTkgKzAzMDANCkBAIC0yMzUsNiArMjM1LDcgQEAgcGluZm86Omlu
aXQgKHBpZF90IG4sIERXT1JEIGZsYWcsIEhBTkRMRQ0KIAkgICAgfQ0KIA0K
IAkgIGRlYnVnX3ByaW50ZiAoIk1hcFZpZXdPZkZpbGVFeCBoMCAlcCwgaSAl
ZCBmYWlsZWQsICVFIiwgaDAsIGkpOw0KKwkgIGxvd19wcmlvcml0eV9zbGVl
cCAoMCk7DQogCSAgY29udGludWU7DQogCX0NCiANCg==

--=-FpfGKaT+YjnGNW34ZHk3--

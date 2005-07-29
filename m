Return-Path: <cygwin-patches-return-5590-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27892 invoked by alias); 29 Jul 2005 10:24:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27864 invoked by uid 22791); 29 Jul 2005 10:24:51 -0000
Received: from mailgw1.wm.net (HELO mailgw1.wm.net) (194.18.224.214)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 29 Jul 2005 10:24:51 +0000
Received: from WMSI001556.corp.wmdata.net (wmbridgehead.wmdata.se [164.9.238.12])
	by mailgw1.wm.net (BorderWare MXtreme Mail Firewall) with ESMTP id FABDC348AL
	for <cygwin-patches@cygwin.com>; Fri, 29 Jul 2005 12:24:48 +0200 (CEST)
Received: from WMRI000166.corp.wmdata.net ([164.9.238.15]) by WMSI001556.corp.wmdata.net with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 29 Jul 2005 12:24:48 +0200
Received: from 172.27.117.80 ([172.27.117.80]) by WMRI000166.corp.wmdata.net ([164.9.238.19]) via Exchange Front-End Server mail.wmdata.com ([164.9.238.13]) with Microsoft Exchange Server HTTP-DAV ;
 Fri, 29 Jul 2005 10:24:48 +0000
Received: from tkuwhuuskartlnx.novogroup.com by mail.wmdata.com; 29 Jul 2005 13:24:48 +0300
Subject: Fix seg fault in fork_parent
From: Arto Huusko <arto.huusko@wmdata.fi>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary="=-MenitA14MdNPdmKilwra"
Date: Fri, 29 Jul 2005 10:24:00 -0000
Message-Id: <1122632688.7369.160.camel@tkuwhuuskartlnx.novogroup.com>
Mime-Version: 1.0
X-SW-Source: 2005-q3/txt/msg00045.txt.bz2


--=-MenitA14MdNPdmKilwra
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-length: 425

This patch fixes null deref in fork_parent() when pinfo::init fails.

I'm sorry the patch is not against CVS, but I am unable to use CVS from
where I work. If this is not acceptable, please tell me, and I can try
to do this from home.

In any case, the patch is against fork.cc rev 1.156.


2005-07-29  Arto Huusko  <arto.huusko@wmdata.fi>

	* fork.cc (fork_parent): Fix null deref if creation of pinfo
	of the child fails.


--=-MenitA14MdNPdmKilwra
Content-Disposition: attachment; filename=fork.patch
Content-Type: text/x-patch; name=fork.patch; charset=us-ascii
Content-Transfer-Encoding: base64
Content-length: 1005

LS0tIGZvcmsuY2MJMjAwNS0wNy0yOSAxMToyNDo1My4yNTI3NDkyMzUgKzAz
MDANCisrKyBmb3JrLmNjLmZpeGVkCTIwMDUtMDctMjkgMTE6MjU6MDcuMjk2
MjE2NjYzICswMzAwDQpAQCAtMzcwLDggKzM3MCw2IEBAIGZvcmtfcGFyZW50
IChIQU5ETEUmLCBkbGwgKiZmaXJzdF9kbGwsIGINCiANCiAgIGludCBjaGls
ZF9waWQgPSBjeWd3aW5fcGlkIChwaS5kd1Byb2Nlc3NJZCk7DQogICBwaW5m
byBjaGlsZCAoY2hpbGRfcGlkLCAxKTsNCi0gIGNoaWxkLT5zdGFydF90aW1l
ID0gdGltZSAoTlVMTCk7IC8qIFJlZ2lzdGVyIGNoaWxkJ3Mgc3RhcnRpbmcg
dGltZS4gKi8NCi0gIGNoaWxkLT5uaWNlID0gbXlzZWxmLT5uaWNlOw0KIA0K
ICAgaWYgKCFjaGlsZCkNCiAgICAgew0KQEAgLTM4MSw2ICszNzksOSBAQCBm
b3JrX3BhcmVudCAoSEFORExFJiwgZGxsIComZmlyc3RfZGxsLCBiDQogICAg
ICAgZ290byBjbGVhbnVwOw0KICAgICB9DQogDQorICBjaGlsZC0+c3RhcnRf
dGltZSA9IHRpbWUgKE5VTEwpOyAvKiBSZWdpc3RlciBjaGlsZCdzIHN0YXJ0
aW5nIHRpbWUuICovDQorICBjaGlsZC0+bmljZSA9IG15c2VsZi0+bmljZTsN
CisNCiAgIC8qIEluaXRpYWxpemUgdGhpbmdzIHRoYXQgYXJlIGRvbmUgbGF0
ZXIgaW4gZGxsX2NydDBfMSB0aGF0IGFyZW4ndCBkb25lDQogICAgICBmb3Ig
dGhlIGZvcmtlZS4gICovDQogICBzdHJjcHkgKGNoaWxkLT5wcm9nbmFtZSwg
bXlzZWxmLT5wcm9nbmFtZSk7DQo=

--=-MenitA14MdNPdmKilwra--

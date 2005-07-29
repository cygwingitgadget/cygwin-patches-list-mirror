Return-Path: <cygwin-patches-return-5592-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2327 invoked by alias); 29 Jul 2005 10:44:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2296 invoked by uid 22791); 29 Jul 2005 10:44:25 -0000
Received: from mailgw1.wm.net (HELO mailgw1.wm.net) (194.18.224.214)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 29 Jul 2005 10:44:25 +0000
Received: from WMSI001556.corp.wmdata.net (wmbridgehead.wmdata.se [164.9.238.12])
	by mailgw1.wm.net (BorderWare MXtreme Mail Firewall) with ESMTP id DA5E2700DP
	for <cygwin-patches@cygwin.com>; Fri, 29 Jul 2005 12:44:23 +0200 (CEST)
Received: from WMRI000166.corp.wmdata.net ([164.9.238.15]) by WMSI001556.corp.wmdata.net with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 29 Jul 2005 12:44:22 +0200
Received: from 172.27.117.80 ([172.27.117.80]) by WMRI000166.corp.wmdata.net ([164.9.238.19]) via Exchange Front-End Server mail.wmdata.com ([164.9.238.13]) with Microsoft Exchange Server HTTP-DAV ;
 Fri, 29 Jul 2005 10:44:22 +0000
Received: from tkuwhuuskartlnx.novogroup.com by mail.wmdata.com; 29 Jul 2005 13:44:22 +0300
Subject: Fix race in cygthread when simplestub is used
From: Arto Huusko <arto.huusko@wmdata.fi>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary="=-BG4HtL5p9g5+SQNhEG/8"
Date: Fri, 29 Jul 2005 10:44:00 -0000
Message-Id: <1122633861.7369.174.camel@tkuwhuuskartlnx.novogroup.com>
Mime-Version: 1.0
X-SW-Source: 2005-q3/txt/msg00047.txt.bz2


--=-BG4HtL5p9g5+SQNhEG/8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-length: 336

There is a race condition between cygthread::cygthread and
cygthread::simplestub. If cygthread::simplestub is used, it is possible
that "ev" field is never initialized, which leads to hang when
cygthread::operator HANDLE() is called.

2005-07-29  Arto Huusko  <arto.huusko@wmdata.fi>

	* cygthread.cc (cygthread::simplestub): fix race.

--=-BG4HtL5p9g5+SQNhEG/8
Content-Disposition: attachment; filename=cygthread.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=cygthread.patch; charset=us-ascii
Content-length: 562

LS0tIGN5Z3RocmVhZC5jYwkyMDA1LTA3LTI5IDExOjMwOjA3LjY0MTA1NDI3
MSArMDMwMA0KKysrIGN5Z3RocmVhZC5jYy5maXhlZAkyMDA1LTA3LTI5IDEx
OjMwOjM5Ljk5MDIyMDczNyArMDMwMA0KQEAgLTExMSw2ICsxMTEsOCBAQCBj
eWd0aHJlYWQ6OnNpbXBsZXN0dWIgKFZPSUQgKmFyZykNCiAgIGN5Z3RocmVh
ZCAqaW5mbyA9IChjeWd0aHJlYWQgKikgYXJnOw0KICAgX215X3Rscy5fY3Rp
bmZvID0gaW5mbzsNCiAgIGluZm8tPnN0YWNrX3B0ciA9ICZhcmc7DQorICB3
aGlsZSAoISBpbmZvLT5oKQ0KKyAgICBsb3dfcHJpb3JpdHlfc2xlZXAgKDAp
Ow0KICAgaW5mby0+ZXYgPSBpbmZvLT5oOw0KICAgaW5mby0+ZnVuYyAoaW5m
by0+YXJnID09IGN5Z3NlbGYgPyBpbmZvIDogaW5mby0+YXJnKTsNCiAgIHJl
dHVybiAwOw0K

--=-BG4HtL5p9g5+SQNhEG/8--

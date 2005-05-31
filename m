Return-Path: <cygwin-patches-return-5499-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15531 invoked by alias); 31 May 2005 22:52:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15505 invoked by uid 22791); 31 May 2005 22:52:20 -0000
Received: from service.sh.cvut.cz (HELO service.sh.cvut.cz) (147.32.127.214)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 31 May 2005 22:52:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by service.sh.cvut.cz (Postfix) with ESMTP id 56DA51A3393
	for <cygwin-patches@cygwin.com>; Wed,  1 Jun 2005 00:52:18 +0200 (CEST)
Received: from service.sh.cvut.cz ([127.0.0.1])
	by localhost (service [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10909-07 for <cygwin-patches@cygwin.com>;
	Wed, 1 Jun 2005 00:52:17 +0200 (CEST)
Received: from logout.sh.cvut.cz (logout.sh.cvut.cz [147.32.127.203])
	by service.sh.cvut.cz (Postfix) with ESMTP id B10EE1A3333
	for <cygwin-patches@cygwin.com>; Wed,  1 Jun 2005 00:52:17 +0200 (CEST)
Received: from logout (logout [147.32.127.203])
	by logout.sh.cvut.cz (Postfix) with ESMTP id BBB9E3C306
	for <cygwin-patches@cygwin.com>; Wed,  1 Jun 2005 00:52:26 +0200 (CEST)
Date: Tue, 31 May 2005 22:52:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: winbase.h (ilockexch)
Message-ID: <20050601004223.I56374@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-990224239-1117579946=:56374"
X-SW-Source: 2005-q2/txt/msg00095.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-990224239-1117579946=:56374
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 171


I think that ilockexch() in winbase.h should look like what is in my patch.
Explicit lock prefix is not needed because xchg instruction sets LOCK# signal
implicitly.

VH.
--0-990224239-1117579946=:56374
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cygwin-winbase_h.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <20050601005226.V56374@logout.sh.cvut.cz>
Content-Description: 
Content-Disposition: attachment; filename="cygwin-winbase_h.diff"
Content-length: 1001

SW5kZXg6IHdpbmJhc2UuaA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL3dpbmJhc2UuaCx2
DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTINCmRpZmYgLWMgLXAgLWQgLXIx
LjEyIHdpbmJhc2UuaA0KKioqIHdpbmJhc2UuaAk0IEp1biAyMDA0IDIzOjU1
OjQ0IC0wMDAwCTEuMTINCi0tLSB3aW5iYXNlLmgJMzEgTWF5IDIwMDUgMjI6
NDA6MDEgLTAwMDANCioqKioqKioqKioqKioqKiBpbG9ja2V4Y2ggKGxvbmcg
KnQsIGxvbmcgdikNCioqKiA0MCw0OCAqKioqDQogIHsNCiAgICByZWdpc3Rl
ciBpbnQgX19yZXM7DQogICAgX19hc21fXyBfX3ZvbGF0aWxlX18gKCJcblwN
CiEgMToJbG9jawljbXB4Y2hnbCAlMywoJTEpXG5cDQohIAlqbmUgMWJcblwN
CiEgIAkiOiAiPWEiIChfX3JlcyksICI9cSIgKHQpOiAiMSIgKHQpLCAicSIg
KHYpLCAiMCIgKCp0KTogImNjIik7DQogICAgcmV0dXJuIF9fcmVzOw0KICB9
DQogIA0KLS0tIDQwLDQ3IC0tLS0NCiAgew0KICAgIHJlZ2lzdGVyIGludCBf
X3JlczsNCiAgICBfX2FzbV9fIF9fdm9sYXRpbGVfXyAoIlxuXA0KISAgICAg
ICAgIHhjaGdsICUzLCAlMlxuXA0KISAgICAgICAgICI6ICI9ciIgKF9fcmVz
KSwgIj1tIiAoKnQpOiAibSIgKCp0KSwgIjAiICh2KSk7DQogICAgcmV0dXJu
IF9fcmVzOw0KICB9DQogIA0K

--0-990224239-1117579946=:56374--

Return-Path: <cygwin-patches-return-5489-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14487 invoked by alias); 29 May 2005 15:03:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14457 invoked by uid 22791); 29 May 2005 15:03:35 -0000
Received: from service.sh.cvut.cz (HELO service.sh.cvut.cz) (147.32.127.214)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sun, 29 May 2005 15:03:35 +0000
Received: from localhost (localhost [127.0.0.1])
	by service.sh.cvut.cz (Postfix) with ESMTP id 984071A32FA
	for <cygwin-patches@cygwin.com>; Sun, 29 May 2005 17:03:33 +0200 (CEST)
Received: from service.sh.cvut.cz ([127.0.0.1])
	by localhost (service [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03352-04 for <cygwin-patches@cygwin.com>;
	Sun, 29 May 2005 17:03:32 +0200 (CEST)
Received: from logout.sh.cvut.cz (logout.sh.cvut.cz [147.32.127.203])
	by service.sh.cvut.cz (Postfix) with ESMTP id E60031A32F8
	for <cygwin-patches@cygwin.com>; Sun, 29 May 2005 17:03:32 +0200 (CEST)
Received: from logout (logout [147.32.127.203])
	by logout.sh.cvut.cz (Postfix) with ESMTP id 8DF383C306
	for <cygwin-patches@cygwin.com>; Sun, 29 May 2005 17:03:36 +0200 (CEST)
Date: Sun, 29 May 2005 15:03:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Probably unnecessary InterlockedCompareExchangePointer in List_remove
 in thread.h
Message-ID: <20050529165435.H81503@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1610508929-1117378978=:81503"
Content-ID: <20050529170305.U81503@logout.sh.cvut.cz>
X-SW-Source: 2005-q2/txt/msg00085.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-1610508929-1117378978=:81503
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <20050529170305.W81503@logout.sh.cvut.cz>
Content-length: 341


I think that the call to InterlockedCompareExchangePointer() can and should be
replaced by ordinary if and assignment. The synchronization it provides doesn't
seem to be necessary.

VH.


2005-05-29  Vaclav Haisman  <v.haisman@sh.cvut.cz>

	* thread.h (List_remove): Make node parameter const. Don't use
	InterlockedCompareExchangePointer.

--0-1610508929-1117378978=:81503
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="cygwin-thread_h.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <20050529170258.S81503@logout.sh.cvut.cz>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="cygwin-thread_h.diff"
Content-length: 1355

SW5kZXg6IHRocmVhZC5oDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1Mg
ZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmgsdg0K
cmV0cmlldmluZyByZXZpc2lvbiAxLjkyDQpkaWZmIC1jIC1wIC1kIC1yMS45
MiB0aHJlYWQuaA0KKioqIHRocmVhZC5oCTI4IE1heSAyMDA0IDE5OjUwOjA3
IC0wMDAwCTEuOTINCi0tLSB0aHJlYWQuaAkyOSBNYXkgMjAwNSAxNDo0Njow
OCAtMDAwMA0KKioqKioqKioqKioqKioqIExpc3RfaW5zZXJ0IChsaXN0X25v
ZGUgKiZoZWFkLCBsaXN0X25vZGUNCioqKiAxMzYsMTQ5ICoqKioNCiAgfQ0K
ICANCiAgdGVtcGxhdGUgPGNsYXNzIGxpc3Rfbm9kZT4gaW5saW5lIHZvaWQN
CiEgTGlzdF9yZW1vdmUgKGZhc3RfbXV0ZXggJm14LCBsaXN0X25vZGUgKiZo
ZWFkLCBsaXN0X25vZGUgKm5vZGUpDQogIHsNCiAgICBpZiAoIW5vZGUpDQog
ICAgICByZXR1cm47DQogICAgbXgubG9jayAoKTsNCiAgICBpZiAoaGVhZCkN
CiAgICAgIHsNCiEgICAgICAgaWYgKEludGVybG9ja2VkQ29tcGFyZUV4Y2hh
bmdlUG9pbnRlciAoJmhlYWQsIG5vZGUtPm5leHQsIG5vZGUpICE9IG5vZGUp
DQogIAl7DQogIAkgIGxpc3Rfbm9kZSAqY3VyID0gaGVhZDsNCiAgDQotLS0g
MTM2LDE1MSAtLS0tDQogIH0NCiAgDQogIHRlbXBsYXRlIDxjbGFzcyBsaXN0
X25vZGU+IGlubGluZSB2b2lkDQohIExpc3RfcmVtb3ZlIChmYXN0X211dGV4
ICZteCwgbGlzdF9ub2RlIComaGVhZCwgbGlzdF9ub2RlIGNvbnN0ICpub2Rl
KQ0KICB7DQogICAgaWYgKCFub2RlKQ0KICAgICAgcmV0dXJuOw0KICAgIG14
LmxvY2sgKCk7DQogICAgaWYgKGhlYWQpDQogICAgICB7DQohICAgICAgIGlm
IChoZWFkID09IG5vZGUpDQohICAgICAgICAgaGVhZCA9IGhlYWQtPm5leHQ7
DQohICAgICAgIGVsc2UNCiAgCXsNCiAgCSAgbGlzdF9ub2RlICpjdXIgPSBo
ZWFkOw0KDQo=

--0-1610508929-1117378978=:81503--

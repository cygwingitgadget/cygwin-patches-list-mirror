Return-Path: <cygwin-patches-return-5544-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4315 invoked by alias); 24 Jun 2005 10:21:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4288 invoked by uid 22791); 24 Jun 2005 10:21:21 -0000
Received: from ingbln.ingenico.de (HELO ingbln.ingenico.de) (212.222.157.218)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 24 Jun 2005 10:21:21 +0000
Received: from elberon.bln.de.ingenico.com (unknown [10.12.5.29])
	by ingbln.ingenico.de (Postfix on SuSE Linux 8.0 (i386) (Hali)) with ESMTP id 529447F82
	for <cygwin-patches@cygwin.com>; Fri, 24 Jun 2005 12:21:19 +0200 (CEST)
Date: Fri, 24 Jun 2005 10:21:00 -0000
From: "Anschuetz, Andreas" <aanschuetz@ingenico.de>
X-Sender: atz@elberon.bln.de.ingenico.com
To: cygwin-patches@cygwin.com
Subject: signal.h: sa_handler not usable when compiling with `gcc -ansi' 
Message-ID: <Pine.LNX.4.21.0506232031380.31102-400000@elberon.bln.de.ingenico.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="201989381-41933191-1119554122=:31102"
Content-ID: <Pine.LNX.4.21.0506241218290.31102@elberon.bln.de.ingenico.com>
X-SW-Source: 2005-q2/txt/msg00140.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--201989381-41933191-1119554122=:31102
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0506241218291.31102@elberon.bln.de.ingenico.com>
Content-length: 849

cygwin: cygwin-1.5.17-1
Win OS tested: Windows 2000

The sa_handler entry of the sigaction structure is not accessible
when I compile with `gcc -ansi' (Makefile and example `signal-test.c'
attached):

gcc -ansi -o signal-ansi signal.c
signal.c: In function `main':
signal.c:13: error: structure has no member named `sa_handler'

The following line caused the error:
   sa_on.sa_handler = sighandler;

The same program is compilable with `gcc -std=gnu89'. I assume that
the anonymous union in `struct sigaction' in /usr/include/cygwin/signal.h
is not iso9899:1990 conform. 

Is compiling with the `-ansi' option not supported by cygwin or is this
a bug?

In case of it is a bug in cygwin I've also included an example patch
which fixes the problem, the code which fixes the problem is taken from
/usr/include/signal.h.

Regards,
   Andreas Anschuetz

--201989381-41933191-1119554122=:31102
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="signal.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0506232115220.31102@elberon.bln.de.ingenico.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="signal.patch"
Content-length: 936

LS0tIHNpZ25hbC5oLm9yaWcJMjAwNS0wNi0yMyAyMDo0MjoyNS44Mjg4NTkw
MDAgKzAyMDANDQorKysgc2lnbmFsLmgJMjAwNS0wNi0yMyAyMDo1ODo1My43
Njk0NDgwMDAgKzAyMDANDQpAQCAtMTUwLDExICsxNTAsMTYgQEANDQogICB7
DQ0KICAgICBfc2lnX2Z1bmNfcHRyIHNhX2hhbmRsZXI7ICAJCS8qIFNJR19E
RkwsIFNJR19JR04sIG9yIHBvaW50ZXIgdG8gYSBmdW5jdGlvbiAqLw0NCiAg
ICAgdm9pZCAgKCpzYV9zaWdhY3Rpb24pICggaW50LCBzaWdpbmZvX3QgKiwg
dm9pZCAqICk7DQ0KLSAgfTsNDQorICB9IF9zaWduYWxfaGFuZGxlcnM7DQ0K
ICAgc2lnc2V0X3Qgc2FfbWFzazsNDQogICBpbnQgc2FfZmxhZ3M7DQ0KIH07
DQ0KIA0NCisjZGVmaW5lIHNhX2hhbmRsZXIgICAgX3NpZ25hbF9oYW5kbGVy
cy5zYV9oYW5kbGVyDQ0KKyNpZiBkZWZpbmVkKF9QT1NJWF9SRUFMVElNRV9T
SUdOQUxTKQ0NCisjZGVmaW5lIHNhX3NpZ2FjdGlvbiAgX3NpZ25hbF9oYW5k
bGVycy5zYV9zaWdhY3Rpb24NDQorI2VuZGlmDQ0KKw0NCiAjZGVmaW5lIFNB
X05PQ0xEU1RPUCAxICAgCQkvKiBEbyBub3QgZ2VuZXJhdGUgU0lHQ0hMRCB3
aGVuIGNoaWxkcmVuDQ0KIAkJCQkJICAgc3RvcCAqLw0NCiAjZGVmaW5lIFNB
X1NJR0lORk8gICAyICAgCQkvKiBJbnZva2UgdGhlIHNpZ25hbCBjYXRjaGlu
ZyBmdW5jdGlvbg0NCg==

--201989381-41933191-1119554122=:31102
Content-Type: TEXT/X-CSRC; NAME="signal-test.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0506232115221.31102@elberon.bln.de.ingenico.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="signal-test.c"
Content-length: 338

I2luY2x1ZGUgPHNpZ25hbC5oPg0NCg0NCnZvaWQgc2lnaGFuZGxlcihpbnQg
c2lnKQ0NCnsNDQp9DQ0KDQ0KaW50DQ0KbWFpbihpbnQgYXJnYywgY2hhciog
YXJndltdKQ0NCnsNDQogICBzdGF0aWMgIHN0cnVjdCBzaWdhY3Rpb24gICAg
ICAgIHNhX29uOw0NCiAgIHNhX29uLnNhX2ZsYWdzID0gMDsNDQogICBzYV9v
bi5zYV9tYXNrID0gKHNpZ3NldF90KSgwKTsNDQogICBzYV9vbi5zYV9oYW5k
bGVyID0gc2lnaGFuZGxlcjsNDQp9DQ0K

--201989381-41933191-1119554122=:31102
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=Makefile
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0506232115222.31102@elberon.bln.de.ingenico.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=Makefile
Content-length: 175

DQ0Kc2lnbmFsLWFuc2k6DQ0KCWdjYyAtYW5zaSAtbyBzaWduYWwtYW5zaSBz
aWduYWwtdGVzdC5jDQ0KDQ0Kc2lnbmFsLWdudTg5Og0NCglnY2MgLXN0ZD1n
bnU4OSAtbyBzaWduYWwtZ251ODkgc2lnbmFsLXRlc3QuYw0NCg==

--201989381-41933191-1119554122=:31102--

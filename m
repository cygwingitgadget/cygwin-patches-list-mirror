Return-Path: <cygwin-patches-return-3057-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17423 invoked by alias); 17 Oct 2002 08:11:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17414 invoked from network); 17 Oct 2002 08:11:13 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Thu, 17 Oct 2002 01:11:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] fix segv in pthread_mutex::init
Message-ID: <Pine.WNT.4.44.0210170959560.243-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="180870-26747-1034841769=:243"
Content-ID: <Pine.WNT.4.44.0210171003060.243@algeria.intern.net>
X-SW-Source: 2002-q4/txt/msg00008.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--180870-26747-1034841769=:243
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.WNT.4.44.0210171003061.243@algeria.intern.net>
Content-length: 344


This patch should fix the segfault in pthread_mutex::init by changing the
test order for a valid object and checking for valid initializer object
first..

Thomas


2002-10-17  Thomas Pfaff  <tpfaff@gmx.net>

	* thread.cc (verifyable_object_isvalid): Test for static object	first.
	(pthread_mutex::init): Add test for valid initializer object.

--180870-26747-1034841769=:243
Content-Type: TEXT/PLAIN; NAME="init.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0210171002490.243@algeria.intern.net>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="init.patch"
Content-length: 1347

LS0tIHRocmVhZC5jYy5vcmcJU3VuIE9jdCAgNiAwMzowMDoyMyAyMDAyCisr
KyB0aHJlYWQuY2MJVGh1IE9jdCAxNyAwOTo1Nzo1MyAyMDAyCkBAIC0xMzU2
LDEyICsxMzU2LDEyIEBAIHZlcmlmeWFibGVfb2JqZWN0X3N0YXRlCiB2ZXJp
ZnlhYmxlX29iamVjdF9pc3ZhbGlkICh2b2lkIGNvbnN0ICogb2JqZWN0cHRy
LCBsb25nIG1hZ2ljLCB2b2lkICpzdGF0aWNfcHRyKQogewogICB2ZXJpZnlh
YmxlX29iamVjdCAqKm9iamVjdCA9ICh2ZXJpZnlhYmxlX29iamVjdCAqKilv
YmplY3RwdHI7CisgIGlmIChzdGF0aWNfcHRyICYmICpvYmplY3QgPT0gc3Rh
dGljX3B0cikKKyAgICByZXR1cm4gVkFMSURfU1RBVElDX09CSkVDVDsKICAg
aWYgKGNoZWNrX3ZhbGlkX3BvaW50ZXIgKG9iamVjdCkpCiAgICAgcmV0dXJu
IElOVkFMSURfT0JKRUNUOwogICBpZiAoISpvYmplY3QpCiAgICAgcmV0dXJu
IElOVkFMSURfT0JKRUNUOwotICBpZiAoc3RhdGljX3B0ciAmJiAqb2JqZWN0
ID09IHN0YXRpY19wdHIpCi0gICAgcmV0dXJuIFZBTElEX1NUQVRJQ19PQkpF
Q1Q7CiAgIGlmIChjaGVja192YWxpZF9wb2ludGVyICgqb2JqZWN0KSkKICAg
ICByZXR1cm4gSU5WQUxJRF9PQkpFQ1Q7CiAgIGlmICgoKm9iamVjdCktPm1h
Z2ljICE9IG1hZ2ljKQpAQCAtMjI1Nyw3ICsyMjU3LDggQEAgcHRocmVhZF9t
dXRleDo6aW5pdCAocHRocmVhZF9tdXRleF90ICptdQogICAgIHJldHVybiBF
SU5WQUw7CiAKICAgLyogRklYTUU6IGJ1Z2ZpeDogd2Ugc2hvdWxkIGNoZWNr
ICptdXRleCBiZWluZyBhIHZhbGlkIGFkZHJlc3MgKi8KLSAgaWYgKGlzR29v
ZE9iamVjdCAobXV0ZXgpKQorICBpZiAoIXB0aHJlYWRfbXV0ZXg6OmlzR29v
ZEluaXRpYWxpemVyIChtdXRleCkgJiYKKyAgICAgIHB0aHJlYWRfbXV0ZXg6
OmlzR29vZE9iamVjdCAobXV0ZXgpKQogICAgIHsKICAgICAgIG11dGV4SW5p
dGlhbGl6YXRpb25Mb2NrLnVubG9jayAoKTsKICAgICAgIHJldHVybiBFQlVT
WTsK

--180870-26747-1034841769=:243--

Return-Path: <cygwin-patches-return-3058-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29626 invoked by alias); 17 Oct 2002 08:33:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29615 invoked from network); 17 Oct 2002 08:33:43 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Thu, 17 Oct 2002 01:33:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix segv in pthread_mutex::init
In-Reply-To: <Pine.WNT.4.44.0210170959560.243-200000@algeria.intern.net>
Message-ID: <Pine.WNT.4.44.0210171030480.259-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="181721-32605-1034843563=:259"
Content-ID: <Pine.WNT.4.44.0210171032490.259@algeria.intern.net>
X-SW-Source: 2002-q4/txt/msg00009.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--181721-32605-1034843563=:259
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.WNT.4.44.0210171032491.259@algeria.intern.net>
Content-length: 471


Stripped the patch a little. Changelog remains unchanged.

Thomas

2002-10-17  Thomas Pfaff  <tpfaff@gmx.net>

	* thread.cc (verifyable_object_isvalid): Test for static object
	first.
 	(pthread_mutex::init): Add test for valid initializer object.

On Thu, 17 Oct 2002, Thomas Pfaff wrote:
>
> This patch should fix the segfault in pthread_mutex::init by changing
> the
> test order for a valid object and checking for valid initializer object
> first..
>
> Thomas
>
>


--181721-32605-1034843563=:259
Content-Type: TEXT/PLAIN; NAME="init.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0210171032430.259@algeria.intern.net>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="init.patch"
Content-length: 1298

LS0tIHRocmVhZC5jYy5vcmcJU3VuIE9jdCAgNiAwMzowMDoyMyAyMDAyCisr
KyB0aHJlYWQuY2MJVGh1IE9jdCAxNyAxMDoyODozMiAyMDAyCkBAIC0xMzU2
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
Z2ljICE9IG1hZ2ljKQpAQCAtMjI1Nyw3ICsyMjU3LDcgQEAgcHRocmVhZF9t
dXRleDo6aW5pdCAocHRocmVhZF9tdXRleF90ICptdQogICAgIHJldHVybiBF
SU5WQUw7CiAKICAgLyogRklYTUU6IGJ1Z2ZpeDogd2Ugc2hvdWxkIGNoZWNr
ICptdXRleCBiZWluZyBhIHZhbGlkIGFkZHJlc3MgKi8KLSAgaWYgKGlzR29v
ZE9iamVjdCAobXV0ZXgpKQorICBpZiAoIWlzR29vZEluaXRpYWxpemVyICht
dXRleCkgJiYgaXNHb29kT2JqZWN0IChtdXRleCkpCiAgICAgewogICAgICAg
bXV0ZXhJbml0aWFsaXphdGlvbkxvY2sudW5sb2NrICgpOwogICAgICAgcmV0
dXJuIEVCVVNZOwo=

--181721-32605-1034843563=:259--

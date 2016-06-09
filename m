Return-Path: <cygwin-patches-return-8575-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104598 invoked by alias); 9 Jun 2016 14:07:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104581 invoked by uid 89); 9 Jun 2016 14:07:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.8 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, our
X-HELO: limerock02.mail.cornell.edu
Received: from limerock02.mail.cornell.edu (HELO limerock02.mail.cornell.edu) (128.84.13.242) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 09 Jun 2016 14:07:26 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock02.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id u59E7NSi029337	for <cygwin-patches@cygwin.com>; Thu, 9 Jun 2016 10:07:24 -0400
Received: from [192.168.1.3] (mta-68-175-148-36.twcny.rr.com [68.175.148.36] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id u59E7MxY027572	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Thu, 9 Jun 2016 10:07:23 -0400
Subject: Re: Declaration of crypt
To: cygwin-patches@cygwin.com
References: <b1986513-81eb-39a0-959f-ba9f98521e03@cornell.edu> <20160609090004.GK30368@calimero.vinschen.de> <0479db42-e977-24ae-fc35-407c5067d256@cornell.edu> <20160609123245.GL30368@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <4a4c8f09-9488-bb0c-7d7b-d2cb21435c2f@cornell.edu>
Date: Thu, 09 Jun 2016 14:07:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160609123245.GL30368@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------055AACAE8C2711C9FF2C709B"
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00050.txt.bz2

This is a multi-part message in MIME format.
--------------055AACAE8C2711C9FF2C709B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 812

On 6/9/2016 8:32 AM, Corinna Vinschen wrote:
> Can you please define crypt, encrypt and setkey explicitely in unistd.h
> per POSIX, rather than including crypt.h?  This would not only be target
> independent, it would also be more correct.  As a side effect I will
> have to come up with a new version of the crypt package, because our
> crypt.h is using a wrong prototypes for setkey (const is missing).

setkey is supposed to be in stdlib.h rather than unistd.h, so I've done 
that.

One minor question about encrypt: The Posix prototype has 'char 
block[64]' as the first argument, but Cygwin's crypt.h simply has 'char 
*block'.  FreeBSD and glibc also use 'char *block', so I did the same. 
Or would you rather follow Posix here?

> Thanks a lot and sorry again,

No problem.  Revised patch attached.

Ken


--------------055AACAE8C2711C9FF2C709B
Content-Type: text/plain; charset=UTF-8;
 name="0001-Declare-crypt-encrypt-and-setkey-per-Posix.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Declare-crypt-encrypt-and-setkey-per-Posix.patch"
Content-length: 2587

RnJvbSBlNmFiOGJiZjQ0ZDEwNDJkZjNkZDllOTg5OTY3YTY0OTUyM2QxOTNk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogV2VkLCA4IEp1biAyMDE2IDE3OjA0
OjA2IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gRGVjbGFyZSBjcnlwdCwgZW5j
cnlwdCwgYW5kIHNldGtleSBwZXIgUG9zaXgKCi0tLQogbmV3bGliL2xpYmMv
aW5jbHVkZS9zdGRsaWIuaCAgICAgfCAzICsrKwogbmV3bGliL2xpYmMvaW5j
bHVkZS9zeXMvdW5pc3RkLmggfCA2ICsrKysrKwogMiBmaWxlcyBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9uZXdsaWIvbGliYy9p
bmNsdWRlL3N0ZGxpYi5oIGIvbmV3bGliL2xpYmMvaW5jbHVkZS9zdGRsaWIu
aAppbmRleCAzMTk0ZDZiLi4zZDFiOGE5IDEwMDY0NAotLS0gYS9uZXdsaWIv
bGliYy9pbmNsdWRlL3N0ZGxpYi5oCisrKyBiL25ld2xpYi9saWJjL2luY2x1
ZGUvc3RkbGliLmgKQEAgLTE0NCw2ICsxNDQsOSBAQCBjaGFyICoJX0VYRlVO
KHJlYWxwYXRoLCAoY29uc3QgY2hhciAqX19yZXN0cmljdCBwYXRoLCBjaGFy
ICpfX3Jlc3RyaWN0IHJlc29sdmVkXwogI2lmIF9fQlNEX1ZJU0lCTEUKIGlu
dAlfRVhGVU4ocnBtYXRjaCwgKGNvbnN0IGNoYXIgKnJlc3BvbnNlKSk7CiAj
ZW5kaWYKKyNpZiBfX1hTSV9WSVNJQkxFCitfVk9JRAlfRVhGVU4oc2V0a2V5
LCAoY29uc3QgY2hhciAqX19rZXkpKTsKKyNlbmRpZgogX1ZPSUQJX0VYRlVO
KHNyYW5kLCh1bnNpZ25lZCBfX3NlZWQpKTsKIGRvdWJsZQlfRVhGVU4oc3Ry
dG9kLChjb25zdCBjaGFyICpfX3Jlc3RyaWN0IF9fbiwgY2hhciAqKl9fcmVz
dHJpY3QgX19lbmRfUFRSKSk7CiBkb3VibGUJX0VYRlVOKF9zdHJ0b2Rfciwo
c3RydWN0IF9yZWVudCAqLGNvbnN0IGNoYXIgKl9fcmVzdHJpY3QgX19uLCBj
aGFyICoqX19yZXN0cmljdCBfX2VuZF9QVFIpKTsKZGlmZiAtLWdpdCBhL25l
d2xpYi9saWJjL2luY2x1ZGUvc3lzL3VuaXN0ZC5oIGIvbmV3bGliL2xpYmMv
aW5jbHVkZS9zeXMvdW5pc3RkLmgKaW5kZXggZWYwMDU3NS4uMDViNGY5ZCAx
MDA2NDQKLS0tIGEvbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvdW5pc3RkLmgK
KysrIGIvbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvdW5pc3RkLmgKQEAgLTMx
LDYgKzMxLDkgQEAgaW50ICAgICBfRVhGVU4oY2xvc2UsIChpbnQgX19maWxk
ZXMgKSk7CiAjaWYgX19QT1NJWF9WSVNJQkxFID49IDE5OTIwOQogc2l6ZV90
CV9FWEZVTihjb25mc3RyLCAoaW50IF9fbmFtZSwgY2hhciAqX19idWYsIHNp
emVfdCBfX2xlbikpOwogI2VuZGlmCisjaWYgX19YU0lfVklTSUJMRQorY2hh
ciAqICBfRVhGVU4oY3J5cHQsIChjb25zdCBjaGFyICpfX2tleSwgY29uc3Qg
Y2hhciAqX19zYWx0KSk7CisjZW5kaWYKICNpZiBfX1hTSV9WSVNJQkxFICYm
IF9fWFNJX1ZJU0lCTEUgPCA3MDAKIGNoYXIgKiAgX0VYRlVOKGN0ZXJtaWQs
IChjaGFyICpfX3MgKSk7CiAjZW5kaWYKQEAgLTQ2LDYgKzQ5LDkgQEAgaW50
ICAgICBfRVhGVU4oZHVwMiwgKGludCBfX2ZpbGRlcywgaW50IF9fZmlsZGVz
MiApKTsKIGludCAgICAgX0VYRlVOKGR1cDMsIChpbnQgX19maWxkZXMsIGlu
dCBfX2ZpbGRlczIsIGludCBmbGFncykpOwogaW50CV9FWEZVTihlYWNjZXNz
LCAoY29uc3QgY2hhciAqX19wYXRoLCBpbnQgX19tb2RlKSk7CiAjZW5kaWYK
KyNpZiBfX1hTSV9WSVNJQkxFCit2b2lkCV9FWEZVTihlbmNyeXB0LCAoY2hh
ciAqX19ibG9jaywgaW50IF9fZWRmbGFnKSk7CisjZW5kaWYKICNpZiBfX0JT
RF9WSVNJQkxFIHx8IChfX1hTSV9WSVNJQkxFICYmIF9fWFNJX1ZJU0lCTEUg
PCA1MDApCiB2b2lkCV9FWEZVTihlbmR1c2Vyc2hlbGwsICh2b2lkKSk7CiAj
ZW5kaWYKLS0gCjIuOC4zCgo=

--------------055AACAE8C2711C9FF2C709B--

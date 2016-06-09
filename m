Return-Path: <cygwin-patches-return-8573-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62995 invoked by alias); 9 Jun 2016 12:05:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62108 invoked by uid 89); 9 Jun 2016 12:05:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.8 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:2628, HTo:U*cygwin-patches
X-HELO: limerock02.mail.cornell.edu
Received: from limerock02.mail.cornell.edu (HELO limerock02.mail.cornell.edu) (128.84.13.242) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 09 Jun 2016 12:05:13 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock02.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id u59C5Bj9018344	for <cygwin-patches@cygwin.com>; Thu, 9 Jun 2016 08:05:11 -0400
Received: from [192.168.1.3] (mta-68-175-148-36.twcny.rr.com [68.175.148.36] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id u59C59ww012953	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Thu, 9 Jun 2016 08:05:11 -0400
Subject: Re: Declaration of crypt
To: cygwin-patches@cygwin.com
References: <b1986513-81eb-39a0-959f-ba9f98521e03@cornell.edu> <20160609090004.GK30368@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <0479db42-e977-24ae-fc35-407c5067d256@cornell.edu>
Date: Thu, 09 Jun 2016 12:05:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160609090004.GK30368@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------4753DA8C6FB2CC6BE1A3A948"
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00048.txt.bz2

This is a multi-part message in MIME format.
--------------4753DA8C6FB2CC6BE1A3A948
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-length: 1796

On 6/9/2016 5:00 AM, Corinna Vinschen wrote:
> Hi Ken,
>
> On Jun  8 17:18, Ken Brown wrote:
>> According to Posix, including <unistd.h> should bring in the declaration of
>> crypt.  The glibc and FreeBSD headers are consistent with this, but Cygwin's
>> aren't.
>>
>> $ cat test.c
>> #include <unistd.h>
>>
>> int
>> main (void)
>> {
>>   const char *key = NULL;
>>   const char *salt = NULL;
>>   crypt (key, salt);
>> }
>>
>> $ gcc -c test.c
>> test.c: In function âmainâ:
>> test.c:8:3: warning: implicit declaration of function âcryptâ
>> [-Wimplicit-function-declaration]
>>    crypt (key, salt);
>>    ^
>>
>> The attached patch is one way to fix this.  It means that cygwin-devel would
>> have to require libcrypt-devel.
>>
>> I'm not sure if I used the right feature-test macro in the patch.  It's
>> marked XSI by Posix, but using __XSI_VISIBLE didn't work.
>
> What do you mean by "didn't work"?  __XSI_VISIBLE should be the right
> thing to use.  Your application would have to define, e.g.,
> _XOPEN_SOURCE before including the file.

Ah, that's what I missed.  I tried defining __XSI_VISIBLE in the test 
file, and I still got the implicit declaration warning.  I see now, 
reading /usr/include/sys/features.h, that __XSI_VISIBLE is a private 
macro and shouldn't have been used in my test.

> Another point is the && defined(__CYGWIN__).  This should go away.
> We're trying to make the headers more standards compatible without
> going into too much detial what targat provides which function.

I wasn't sure that <crypt.h> was portable to all newlib targets.

>> P.S. Is cygwin-patches OK for this sort of thing, or should I have sent it
>> to the newlib list?
>
> Ideally to the newlib list, but no worries :)

OK, I'll do that next time.

Revised patch attached.

Ken


--------------4753DA8C6FB2CC6BE1A3A948
Content-Type: text/plain; charset=UTF-8;
 name="0001-Make-unistd.h-declare-crypt.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Make-unistd.h-declare-crypt.patch"
Content-length: 1147

RnJvbSBjYjhjMjQ1NDYxOGMxZDg2MmI5MjZkNjFhYzk1NDExYjM4NGQwNDE0
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogV2VkLCA4IEp1biAyMDE2IDE3OjA0
OjA2IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gTWFrZSA8dW5pc3RkLmg+IGRl
Y2xhcmUgY3J5cHQKClRoaXMgaXMgbWFuZGF0ZWQgYnkgUG9zaXggYW5kIGlz
IGRvbmUgYnkgdGhlIGdsaWJjIGFuZCBGcmVlQlNEIGhlYWRlcnMuCi0tLQog
bmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvdW5pc3RkLmggfCAzICsrKwogMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL25l
d2xpYi9saWJjL2luY2x1ZGUvc3lzL3VuaXN0ZC5oIGIvbmV3bGliL2xpYmMv
aW5jbHVkZS9zeXMvdW5pc3RkLmgKaW5kZXggZWYwMDU3NS4uMGNiYjVkZSAx
MDA2NDQKLS0tIGEvbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvdW5pc3RkLmgK
KysrIGIvbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvdW5pc3RkLmgKQEAgLTMx
LDYgKzMxLDkgQEAgaW50ICAgICBfRVhGVU4oY2xvc2UsIChpbnQgX19maWxk
ZXMgKSk7CiAjaWYgX19QT1NJWF9WSVNJQkxFID49IDE5OTIwOQogc2l6ZV90
CV9FWEZVTihjb25mc3RyLCAoaW50IF9fbmFtZSwgY2hhciAqX19idWYsIHNp
emVfdCBfX2xlbikpOwogI2VuZGlmCisjaWYgX19YU0lfVklTSUJMRQorI2lu
Y2x1ZGUgPGNyeXB0Lmg+CisjZW5kaWYKICNpZiBfX1hTSV9WSVNJQkxFICYm
IF9fWFNJX1ZJU0lCTEUgPCA3MDAKIGNoYXIgKiAgX0VYRlVOKGN0ZXJtaWQs
IChjaGFyICpfX3MgKSk7CiAjZW5kaWYKLS0gCjIuOC4zCgo=

--------------4753DA8C6FB2CC6BE1A3A948--

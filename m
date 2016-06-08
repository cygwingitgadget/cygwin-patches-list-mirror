Return-Path: <cygwin-patches-return-8571-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109008 invoked by alias); 8 Jun 2016 21:19:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108994 invoked by uid 89); 8 Jun 2016 21:19:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=__len, Hx-languages-length:1669, HTo:U*cygwin-patches
X-HELO: limerock01.mail.cornell.edu
Received: from limerock01.mail.cornell.edu (HELO limerock01.mail.cornell.edu) (128.84.13.241) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 08 Jun 2016 21:18:57 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite3.serverfarm.cornell.edu [10.16.197.8])	by limerock01.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id u58LIsVK007324	for <cygwin-patches@cygwin.com>; Wed, 8 Jun 2016 17:18:55 -0400
Received: from [10.128.133.220] (dhcp-gs-1500.eduroam.cornell.edu [10.128.133.220])	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id u58LIrWr018978	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)	for <cygwin-patches@cygwin.com>; Wed, 8 Jun 2016 17:18:54 -0400
To: cygwin-patches <cygwin-patches@cygwin.com>
From: Ken Brown <kbrown@cornell.edu>
Subject: Declaration of crypt
Message-ID: <b1986513-81eb-39a0-959f-ba9f98521e03@cornell.edu>
Date: Wed, 08 Jun 2016 21:19:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------F20DEA140B4CBF98BB84D3C9"
X-PMX-Cornell-Gauge: Gauge=X
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00046.txt.bz2

This is a multi-part message in MIME format.
--------------F20DEA140B4CBF98BB84D3C9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-length: 819

According to Posix, including <unistd.h> should bring in the declaration 
of crypt.  The glibc and FreeBSD headers are consistent with this, but 
Cygwin's aren't.

$ cat test.c
#include <unistd.h>

int
main (void)
{
   const char *key = NULL;
   const char *salt = NULL;
   crypt (key, salt);
}

$ gcc -c test.c
test.c: In function âmainâ:
test.c:8:3: warning: implicit declaration of function âcryptâ 
[-Wimplicit-function-declaration]
    crypt (key, salt);
    ^

The attached patch is one way to fix this.  It means that cygwin-devel 
would have to require libcrypt-devel.

I'm not sure if I used the right feature-test macro in the patch.  It's 
marked XSI by Posix, but using __XSI_VISIBLE didn't work.

Ken

P.S. Is cygwin-patches OK for this sort of thing, or should I have sent 
it to the newlib list?

--------------F20DEA140B4CBF98BB84D3C9
Content-Type: text/plain; charset=UTF-8;
 name="0001-Make-unistd.h-declare-crypt.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Make-unistd.h-declare-crypt.patch"
Content-length: 1180

RnJvbSA5MWVkNzgxNmU3NzFhNzgxNzA1NTVkYjI0NmUwZTM1ZGM2ZDJjYTNl
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGti
cm93bkBjb3JuZWxsLmVkdT4KRGF0ZTogV2VkLCA4IEp1biAyMDE2IDE3OjA0
OjA2IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gTWFrZSA8dW5pc3RkLmg+IGRl
Y2xhcmUgY3J5cHQKClRoaXMgaXMgbWFuZGF0ZWQgYnkgUG9zaXggYW5kIGlz
IGRvbmUgYnkgdGhlIGdsaWJjIGFuZCBGcmVlQlNEIGhlYWRlcnMuCi0tLQog
bmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvdW5pc3RkLmggfCAzICsrKwogMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL25l
d2xpYi9saWJjL2luY2x1ZGUvc3lzL3VuaXN0ZC5oIGIvbmV3bGliL2xpYmMv
aW5jbHVkZS9zeXMvdW5pc3RkLmgKaW5kZXggZWYwMDU3NS4uZWJhZTVkOCAx
MDA2NDQKLS0tIGEvbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvdW5pc3RkLmgK
KysrIGIvbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvdW5pc3RkLmgKQEAgLTMx
LDYgKzMxLDkgQEAgaW50ICAgICBfRVhGVU4oY2xvc2UsIChpbnQgX19maWxk
ZXMgKSk7CiAjaWYgX19QT1NJWF9WSVNJQkxFID49IDE5OTIwOQogc2l6ZV90
CV9FWEZVTihjb25mc3RyLCAoaW50IF9fbmFtZSwgY2hhciAqX19idWYsIHNp
emVfdCBfX2xlbikpOwogI2VuZGlmCisjaWYgX19CU0RfVklTSUJMRSAmJiBk
ZWZpbmVkKF9fQ1lHV0lOX18pCisjaW5jbHVkZSA8Y3J5cHQuaD4KKyNlbmRp
ZgogI2lmIF9fWFNJX1ZJU0lCTEUgJiYgX19YU0lfVklTSUJMRSA8IDcwMAog
Y2hhciAqICBfRVhGVU4oY3Rlcm1pZCwgKGNoYXIgKl9fcyApKTsKICNlbmRp
ZgotLSAKMi44LjMKCg==

--------------F20DEA140B4CBF98BB84D3C9--

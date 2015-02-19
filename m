Return-Path: <cygwin-patches-return-8057-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14166 invoked by alias); 19 Feb 2015 13:00:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14138 invoked by uid 89); 19 Feb 2015 13:00:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out4-smtp.messagingengine.com
Received: from out4-smtp.messagingengine.com (HELO out4-smtp.messagingengine.com) (66.111.4.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 19 Feb 2015 13:00:09 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])	by mailout.nyi.internal (Postfix) with ESMTP id C762220ACA	for <cygwin-patches@cygwin.com>; Thu, 19 Feb 2015 08:00:06 -0500 (EST)
Received: from frontend2 ([10.202.2.161])  by compute4.internal (MEProxy); Thu, 19 Feb 2015 08:00:06 -0500
Received: from [192.168.1.102] (unknown [86.179.113.106])	by mail.messagingengine.com (Postfix) with ESMTPA id 6C9F268015E	for <cygwin-patches@cygwin.com>; Thu, 19 Feb 2015 08:00:06 -0500 (EST)
Message-ID: <54E5DE55.90603@dronecode.org.uk>
Date: Thu, 19 Feb 2015 13:00:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Prototype initstate() etc. if _XOPEN_SOURCE is defined appropriately
References: <52838E8C.5060708@dronecode.org.uk>
In-Reply-To: <52838E8C.5060708@dronecode.org.uk>
Content-Type: multipart/mixed; boundary="------------030004030501020303050004"
X-SW-Source: 2015-q1/txt/msg00012.txt.bz2

This is a multi-part message in MIME format.
--------------030004030501020303050004
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-length: 901

On 13/11/2013 14:37, Jon TURNEY wrote:
>
> Not sure if this is wanted, but mesa likes to compile with '-std=c99
> D_XOPEN_SOURCE=500', which leads to exciting crashes on x86_64 because
> initstate() is not prototyped.
>
> 2013-11-13  Jon TURNEY  <jon.turney@dronecode.org.uk>
>
> 	* include/cygwin/stdlib.h(initstate, random, setstate, srandom) :
> 	Prototype if not __STRICT_ANSI__ or _XOPEN_SOURCE is defined appropriately.

It seems this doesn't do the correct thing if _GNU_SOURCE is defined 
(which is supposed to imply _XOPEN_SOURCE)

Attached is an additional patch which instead includes sys/cdefs.h, and 
uses __XSI_VISIBLE.

$ cat test.c

#include <stdlib.h>

int main()
{
  return random();
}

before:

$ gcc test.c -Wall -ansi -D_GNU_SOURCE
test.c: In function âmainâ:
test.c:6:2: warning: implicit declaration of function ârandomâ

after:

$ gcc test.c -Wall -ansi -D_GNU_SOURCE


--------------030004030501020303050004
Content-Type: text/plain; charset=windows-1252;
 name="stdlib.h.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stdlib.h.patch"
Content-length: 1680

MjAxNS0wMi0xOSAgSm9uIFRVUk5FWSAgPGpvbi50dXJuZXlAZHJvbmVjb2Rl
Lm9yZy51az4KCgkqIGluY2x1ZGUvY3lnd2luL3N0ZGxpYi5oIChpbml0c3Rh
dGUsIHJhbmRvbSwgc2V0c3RhdGUsIHNyYW5kb20pOgoJQ2hlY2sgaWYgX19Y
U0lfVklTSUJMRSBpcyBzZXQgYnkgc3lzL2NkZWZzLmgsIHJhdGhlciB0aGFu
IHRlc3RpbmcKCWZvciBfWE9QRU5fU09VUkNFIGRpcmVjdGx5LCB0byB3b3Jr
IGNvcnJlY3RseSB3aGVuIF9HTlVfU09VUkNFIGlzCglzZXQuCgpJbmRleDog
Y3lnd2luL2luY2x1ZGUvY3lnd2luL3N0ZGxpYi5oCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2lu
L2luY2x1ZGUvY3lnd2luL3N0ZGxpYi5oLHYKcmV0cmlldmluZyByZXZpc2lv
biAxLjE3CmRpZmYgLXUgLXUgLXAgLXIxLjE3IHN0ZGxpYi5oCi0tLSBjeWd3
aW4vaW5jbHVkZS9jeWd3aW4vc3RkbGliLmgJOSBEZWMgMjAxMyAxMDoxMjo0
MiAtMDAwMAkxLjE3CisrKyBjeWd3aW4vaW5jbHVkZS9jeWd3aW4vc3RkbGli
LmgJMTkgRmViIDIwMTUgMTI6NDE6MDAgLTAwMDAKQEAgLTExLDYgKzExLDcg
QEAgZGV0YWlscy4gKi8KICNpZm5kZWYgX0NZR1dJTl9TVERMSUJfSAogI2Rl
ZmluZSBfQ1lHV0lOX1NURExJQl9ICiAKKyNpbmNsdWRlIDxzeXMvY2RlZnMu
aD4KICNpbmNsdWRlIDxjeWd3aW4vd2FpdC5oPgogCiAjaWZkZWYgX19jcGx1
c3BsdXMKQEAgLTMxLDkgKzMyLDcgQEAgdm9pZAlzZXRwcm9nbmFtZSAoY29u
c3QgY2hhciAqKTsKIGNoYXIgKmNhbm9uaWNhbGl6ZV9maWxlX25hbWUgKGNv
bnN0IGNoYXIgKik7CiBpbnQgdW5zZXRlbnYgKGNvbnN0IGNoYXIgKik7CiAj
ZW5kaWYgLypfX1NUUklDVF9BTlNJX18qLwotI2lmICFkZWZpbmVkKF9fU1RS
SUNUX0FOU0lfXykgXAotICAgIHx8IChkZWZpbmVkKF9YT1BFTl9TT1VSQ0Up
IFwKLQkmJiAoKF9YT1BFTl9TT1VSQ0UgLSAwID49IDUwMCkgfHwgZGVmaW5l
ZChfWE9QRU5fU09VUkNFX0VYVEVOREVEKSkpCisjaWYgIWRlZmluZWQoX19T
VFJJQ1RfQU5TSV9fKSB8fCAoX19YU0lfVklTSUJMRSA+PSA1MDApCiBjaGFy
ICppbml0c3RhdGUgKHVuc2lnbmVkIHNlZWQsIGNoYXIgKnN0YXRlLCBzaXpl
X3Qgc2l6ZSk7CiBsb25nIHJhbmRvbSAodm9pZCk7CiBjaGFyICpzZXRzdGF0
ZSAoY29uc3QgY2hhciAqc3RhdGUpOwo=

--------------030004030501020303050004--

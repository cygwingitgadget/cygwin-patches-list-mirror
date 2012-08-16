Return-Path: <cygwin-patches-return-7703-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25062 invoked by alias); 16 Aug 2012 14:21:04 -0000
Received: (qmail 24961 invoked by uid 22791); 16 Aug 2012 14:20:59 -0000
X-SWARE-Spam-Status: No, hits=-3.3 required=5.0	tests=AWL,BAYES_00,KHOP_THREADED,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SPF_HELO_PASS,TW_CP,TW_YG
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.126.186)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 16 Aug 2012 14:20:23 +0000
Received: from [10.255.170.24] ([62.159.77.186])	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)	id 0LZjFg-1TPISG0ljA-00lV5m; Thu, 16 Aug 2012 16:20:20 +0200
Message-ID: <502D0199.6040203@towo.net>
Date: Thu, 16 Aug 2012 14:21:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: /dev/clipboard pasting with small read() buffer
References: <502ABB77.2080502@towo.net> <20120816093334.GB20051@calimero.vinschen.de> <502CE384.8050709@towo.net> <20120816123033.GH17546@calimero.vinschen.de>
In-Reply-To: <20120816123033.GH17546@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------020605070102040105030707"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00024.txt.bz2

This is a multi-part message in MIME format.
--------------020605070102040105030707
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2305

On 16.08.2012 14:30, Corinna Vinschen wrote:
> On Aug 16 14:11, Thomas Wolff wrote:
>> Hi Corinna,
>>
>> On 16.08.2012 11:33, Corinna Vinschen wrote:
>>> Hi Thomas,
>>>
>>> thanks for the patch.   I have a few minor nits:
>>>
>>> On Aug 14 22:56, Thomas Wolff wrote:
>>> ... 
>>>> +	  char cprabuf [8 + 1];	/* need this length for surrogates */
>>>> +	  if (len < 8)
>>>> +	    {
>>>> +	      _ptr = cprabuf;
>>>> +	      _len = 8;
>>>> +	    }
>>> 8?  Why 8?  The size appears to be rather artificial.  The code should
>>> use MB_CUR_MAX instead.
>> MB_CUR_MAX does not work because its value is 1 at this point
> So what about MB_LEN_MAX then?  There's no problem using a multiplier,
> but a symbolic constant is always better than a numerical constant.
I've now used _MB_LEN_MAX from newlib.h, rather than MB_LEN_MAX from 
limits.h (note the "_" distinction :) ),
because the latter, by its preceding comment, reserves the option to be 
changed into a dynamic function in the future, which could then possibly 
have the same problems as MB_CUR_MAX.

About the surrogates problem, I think I've found a solution:
I've added an explicit test to avoid processing of split surrogate pairs 
(to that loop...); this seems to work now.

>>>> +	      /* If using read-ahead buffer, copy to class read-ahead buffer
>>>> +	         and deliver first byte. */
>>>> +	      if (_ptr == cprabuf)
>>>> +		{
>>>> +		  puts_readahead (cprabuf, ret);
>>>> +		  * (char *) ptr = get_readahead ();
>>>> +		  ret = 1;
>>> (*) Ok, that works, but wouldn't it be more efficient to do that in
>>> a tiny loop along the lines of
>>>
>>> 		  int x;
>>> 		  ret = 0;
>>>                    while (ret < len && (x = get_readahead ()) >= 0)
>>> 		    ptr++ = x;
>>> 		    ret++;
>>>
>>> ?
>> I can add it if you prefer; I just didn't think it's worth the
>> effort and concerning efficiency, after that prior trial-and-error
>> count-down-loop...
> Yeah, that's a valid point.  But maybe we shouldn't make it slower
> than necessary?  If you have a good idea how to avoid the other
> loop, don't hesitate to submit a patch.
Added the loop to use up the caller's buffer.
About avoiding the trial-and-error loop, I think that would require 
digging into sys_mbstowcs (which doesn't even seem to behave as documented).

------
Thomas

--------------020605070102040105030707
Content-Type: text/plain; charset=windows-1252;
 name="clipboard-small-buffer.patch.3"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="clipboard-small-buffer.patch.3"
Content-length: 4047

LS0tIHNhdi9maGFuZGxlcl9jbGlwYm9hcmQuY2MJMjAxMi0wNy0wOCAwMjoz
Njo0Ny4wMDAwMDAwMDAgKzAyMDAKKysrIC4vZmhhbmRsZXJfY2xpcGJvYXJk
LmNjCTIwMTItMDgtMTYgMTY6MDg6MjMuNzgyNjkyMzAwICswMjAwCkBAIC0y
MjIsNiArMjIyLDcgQEAgZmhhbmRsZXJfZGV2X2NsaXBib2FyZDo6cmVhZCAo
dm9pZCAqcHRyLAogICBVSU5UIGZvcm1hdGxpc3RbMl07CiAgIGludCBmb3Jt
YXQ7CiAgIExQVk9JRCBjYl9kYXRhOworICBpbnQgcmFjaDsKIAogICBpZiAo
IU9wZW5DbGlwYm9hcmQgKE5VTEwpKQogICAgIHsKQEAgLTI0MywxMiArMjQ0
LDI0IEBAIGZoYW5kbGVyX2Rldl9jbGlwYm9hcmQ6OnJlYWQgKHZvaWQgKnB0
ciwKICAgICAgIGN5Z2NiX3QgKmNsaXBidWYgPSAoY3lnY2JfdCAqKSBjYl9k
YXRhOwogCiAgICAgICBpZiAocG9zIDwgY2xpcGJ1Zi0+bGVuKQotICAgICAg
CXsKKwl7CiAJICByZXQgPSAoKGxlbiA+IChjbGlwYnVmLT5sZW4gLSBwb3Mp
KSA/IChjbGlwYnVmLT5sZW4gLSBwb3MpIDogbGVuKTsKIAkgIG1lbWNweSAo
cHRyLCBjbGlwYnVmLT5kYXRhICsgcG9zICwgcmV0KTsKIAkgIHBvcyArPSBy
ZXQ7CiAJfQogICAgIH0KKyAgZWxzZSBpZiAoKHJhY2ggPSBnZXRfcmVhZGFo
ZWFkICgpKSA+PSAwKQorICAgIHsKKyAgICAgIC8qIERlbGl2ZXIgZnJvbSBy
ZWFkLWFoZWFkIGJ1ZmZlci4gKi8KKyAgICAgIGNoYXIgKiBvdXRfcHRyID0g
KGNoYXIgKikgcHRyOworICAgICAgKiBvdXRfcHRyKysgPSByYWNoOworICAg
ICAgcmV0ID0gMTsKKyAgICAgIHdoaWxlIChyZXQgPCBsZW4gJiYgKHJhY2gg
PSBnZXRfcmVhZGFoZWFkICgpKSA+PSAwKQorCXsKKwkgICogb3V0X3B0cisr
ID0gcmFjaDsKKwkgIHJldCsrOworCX0KKyAgICB9CiAgIGVsc2UKICAgICB7
CiAgICAgICB3Y2hhcl90ICpidWYgPSAod2NoYXJfdCAqKSBjYl9kYXRhOwpA
QCAtMjU2LDI1ICsyNjksNTQgQEAgZmhhbmRsZXJfZGV2X2NsaXBib2FyZDo6
cmVhZCAodm9pZCAqcHRyLAogICAgICAgc2l6ZV90IGdsZW4gPSBHbG9iYWxT
aXplIChoZ2xiKSAvIHNpemVvZiAoV0NIQVIpIC0gMTsKICAgICAgIGlmIChw
b3MgPCBnbGVuKQogCXsKKwkgIC8qIElmIGNhbGxlcidzIGJ1ZmZlciBpcyB0
b28gc21hbGwgdG8gaG9sZCBhdCBsZWFzdCBvbmUgCisJICAgICBtYXgtc2l6
ZSBjaGFyYWN0ZXIsIHJlZGlyZWN0IGFsZ29yaXRobSB0byBsb2NhbCAKKwkg
ICAgIHJlYWQtYWhlYWQgYnVmZmVyLCBmaW5hbGx5IGZpbGwgY2xhc3MgcmVh
ZC1haGVhZCBidWZmZXIgCisJICAgICB3aXRoIHJlc3VsdCBhbmQgZmVlZCBj
YWxsZXIgZnJvbSB0aGVyZS4gKi8KKwkgIGNoYXIgKiBjb252X3B0ciA9IChj
aGFyICopIHB0cjsKKwkgIHNpemVfdCBjb252X2xlbiA9IGxlbjsKKyNkZWZp
bmUgY3ByYWJ1Zl9sZW4gX01CX0xFTl9NQVgJLyogbmV3bGliJ3MgbWF4IE1C
X0NVUl9NQVggb2YgYWxsIGVuY29kaW5ncyAqLworCSAgY2hhciBjcHJhYnVm
IFtjcHJhYnVmX2xlbl07CisJICBpZiAobGVuIDwgY3ByYWJ1Zl9sZW4pCisJ
ICAgIHsKKwkgICAgICBjb252X3B0ciA9IGNwcmFidWY7CisJICAgICAgY29u
dl9sZW4gPSBjcHJhYnVmX2xlbjsKKwkgICAgfQorCiAJICAvKiBDb21wYXJp
bmcgYXBwbGVzIGFuZCBvcmFuZ2VzIGhlcmUsIGJ1dCB0aGUgYmVsb3cgbG9v
cCBjb3VsZCBiZWNvbWUKIAkgICAgIGV4dHJlbWx5IHNsb3cgb3RoZXJ3aXNl
LiAgV2UgcmF0aGVyIHJldHVybiBhIGZldyBieXRlcyBsZXNzIHRoYW4KIAkg
ICAgIHBvc3NpYmxlIGluc3RlYWQgb2YgYmVpbmcgZXZlbiBtb3JlIHNsb3cg
dGhhbiB1c3VhbC4uLiAqLwotCSAgaWYgKGdsZW4gPiBwb3MgKyBsZW4pCi0J
ICAgIGdsZW4gPSBwb3MgKyBsZW47CisJICBpZiAoZ2xlbiA+IHBvcyArIGNv
bnZfbGVuKQorCSAgICBnbGVuID0gcG9zICsgY29udl9sZW47CiAJICAvKiBU
aGlzIGxvb3AgaXMgbmVjZXNzYXJ5IGJlY2F1c2UgdGhlIG51bWJlciBvZiBi
eXRlcyByZXR1cm5lZCBieQogCSAgICAgc3lzX3djc3RvbWJzIGRvZXMgbm90
IGluZGljYXRlIHRoZSBudW1iZXIgb2Ygd2lkZSBjaGFycyB1c2VkIGZvcgog
CSAgICAgaXQsIHNvIHdlIGNvdWxkIHBvdGVudGlhbGx5IGRyb3Agd2lkZSBj
aGFycy4gKi8KIAkgIHdoaWxlICgocmV0ID0gc3lzX3djc3RvbWJzIChOVUxM
LCAwLCBidWYgKyBwb3MsIGdsZW4gLSBwb3MpKQogCQkgICE9IChzaXplX3Qp
IC0xCi0JCSAmJiByZXQgPiBsZW4pCisJCSAmJiAocmV0ID4gY29udl9sZW4g
CisJCQkvKiBTa2lwIHNlcGFyYXRlZCBoaWdoIHN1cnJvZ2F0ZTogKi8KKwkJ
ICAgICB8fCAoKGJ1ZiBbcG9zICsgZ2xlbiAtIDFdICYgMHhGQzAwKSA9PSAw
eEQ4MDAgJiYgZ2xlbiAtIHBvcyA+IDEpKSkKIAkgICAgIC0tZ2xlbjsKIAkg
IGlmIChyZXQgPT0gKHNpemVfdCkgLTEpCiAJICAgIHJldCA9IDA7CiAJICBl
bHNlCiAJICAgIHsKLQkgICAgICByZXQgPSBzeXNfd2NzdG9tYnMgKChjaGFy
ICopIHB0ciwgKHNpemVfdCkgLTEsCisJICAgICAgcmV0ID0gc3lzX3djc3Rv
bWJzICgoY2hhciAqKSBjb252X3B0ciwgKHNpemVfdCkgLTEsCiAJCQkJICBi
dWYgKyBwb3MsIGdsZW4gLSBwb3MpOwogCSAgICAgIHBvcyA9IGdsZW47CisJ
ICAgICAgLyogSWYgdXNpbmcgcmVhZC1haGVhZCBidWZmZXIsIGNvcHkgdG8g
Y2xhc3MgcmVhZC1haGVhZCBidWZmZXIKKwkgICAgICAgICBhbmQgZGVsaXZl
ciBmaXJzdCBieXRlLiAqLworCSAgICAgIGlmIChjb252X3B0ciA9PSBjcHJh
YnVmKQorCQl7CisJCSAgcHV0c19yZWFkYWhlYWQgKGNwcmFidWYsIHJldCk7
CisJCSAgY2hhciAqIG91dF9wdHIgPSAoY2hhciAqKSBwdHI7CisJCSAgcmV0
ID0gMDsKKwkJICB3aGlsZSAocmV0IDwgbGVuICYmIChyYWNoID0gZ2V0X3Jl
YWRhaGVhZCAoKSkgPj0gMCkKKwkJICAgIHsKKwkJICAgICAgKiBvdXRfcHRy
KysgPSByYWNoOworCQkgICAgICByZXQrKzsKKwkJICAgIH0KKwkJfQogCSAg
ICB9CiAJfQogICAgIH0K

--------------020605070102040105030707--

Return-Path: <cygwin-patches-return-6940-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30385 invoked by alias); 1 Feb 2010 23:04:27 -0000
Received: (qmail 30371 invoked by uid 22791); 1 Feb 2010 23:04:26 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f221.google.com (HELO mail-ew0-f221.google.com) (209.85.219.221)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 01 Feb 2010 23:04:20 +0000
Received: by ewy21 with SMTP id 21so6277238ewy.2         for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2010 15:04:17 -0800 (PST)
Received: by 10.213.1.18 with SMTP id 18mr79961ebd.17.1265065456974;         Mon, 01 Feb 2010 15:04:16 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 5sm8480056eyf.0.2010.02.01.15.04.14         (version=SSLv3 cipher=RC4-MD5);         Mon, 01 Feb 2010 15:04:15 -0800 (PST)
Message-ID: <4B6761FE.6070107@gmail.com>
Date: Mon, 01 Feb 2010 23:04:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: Dave Korn <dave.korn.cygwin@googlemail.com>
CC: cygwin-patches@cygwin.com
Subject: Re: dlclose not calling destructors of static variables.
References: <4B62DDE6.5070106@gmail.com>  <4B62F118.8010305@gmail.com>  <20100129184514.GA9550@ednor.casa.cgf.cx>  <4B66BF2F.4060802@gmail.com>  <20100201162603.GB25374@ednor.casa.cgf.cx>  <4B6710CE.40300@gmail.com>  <20100201174611.GA26080@ednor.casa.cgf.cx>  <20100201175123.GB26080@ednor.casa.cgf.cx>  <4B672B74.4090808@gmail.com>  <4B6736C1.8030101@gmail.com> <20100201215919.GA29662@ednor.casa.cgf.cx> <4B675776.4020105@gmail.com>
In-Reply-To: <4B675776.4020105@gmail.com>
Content-Type: multipart/mixed;  boundary="------------020903090902060104080706"
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
X-SW-Source: 2010-q1/txt/msg00056.txt.bz2

This is a multi-part message in MIME format.
--------------020903090902060104080706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 659

On 01/02/2010 22:36, Dave Korn wrote:
> On 01/02/2010 21:59, Christopher Faylor wrote:
> 
>> Since the testcase (obviously?) worked for me it seems like this is pretty
>>  variable.  I'd like to understand why the MEMORY_BASIC_INFORMATION method
>>  doesn't work before trying other things.
> 
> 
>   Hmm, well first off, looks like RegionSize is indeed relative to
> BaseAddress, not AllocationBase after all:

  This is what I'm going to test next.  It avoids calling anything registered
with the cxa functions, i.e. only calls ordinary atexit hooks, and it handles
the case where extra atexit blocks have been chained on the end.

    cheers,
      DaveK


--------------020903090902060104080706
Content-Type: text/x-c;
 name="remove-dll-atexit.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="remove-dll-atexit.diff"
Content-length: 2095

SW5kZXg6IGRsbF9pbml0LmNjCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2RsbF9pbml0LmNj
LHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjY4CmRpZmYgLXAgLXUgLXIxLjY4
IGRsbF9pbml0LmNjCi0tLSBkbGxfaW5pdC5jYwkyOSBKYW4gMjAxMCAxODoz
NDowOSAtMDAwMAkxLjY4CisrKyBkbGxfaW5pdC5jYwkxIEZlYiAyMDEwIDIz
OjAxOjA4IC0wMDAwCkBAIC0xNTMsMTkgKzE1MywyNyBAQCBkbGxfbGlzdDo6
YWxsb2MgKEhJTlNUQU5DRSBoLCBwZXJfcHJvY2VzCiAgICByZWdpc3RlciBh
biBhdGV4aXQgZnVuY3Rpb24gb3V0c2lkZSBvZiB0aGUgRExMIGFuZCB0aGF0
IHNob3VsZCBiZQogICAgcnVuIHdoZW4gdGhlIERMTCBkZXRhY2hzLiAgKi8K
IHN0YXRpYyB2b2lkCi1yZW1vdmVfZGxsX2F0ZXhpdCAoTUVNT1JZX0JBU0lD
X0lORk9STUFUSU9OJiBtKQorcmVtb3ZlX2RsbF9hdGV4aXQgKGNvbnN0IE1F
TU9SWV9CQVNJQ19JTkZPUk1BVElPTiYgbSkKIHsKLSAgdW5zaWduZWQgY2hh
ciAqZGxsX2JlZyA9ICh1bnNpZ25lZCBjaGFyICopIG0uQWxsb2NhdGlvbkJh
c2U7Ci0gIHVuc2lnbmVkIGNoYXIgKmRsbF9lbmQgPSAodW5zaWduZWQgY2hh
ciAqKSBtLkFsbG9jYXRpb25CYXNlICsgbS5SZWdpb25TaXplOworICB1bnNp
Z25lZCBjaGFyICpkbGxfYmVnID0gKHVuc2lnbmVkIGNoYXIgKikgbS5CYXNl
QWRkcmVzczsKKyAgdW5zaWduZWQgY2hhciAqZGxsX2VuZCA9ICh1bnNpZ25l
ZCBjaGFyICopIG0uQmFzZUFkZHJlc3MgKyBtLlJlZ2lvblNpemU7CiAgIHN0
cnVjdCBfYXRleGl0ICpwID0gX0dMT0JBTF9SRUVOVC0+X2F0ZXhpdDsKLSAg
Zm9yIChpbnQgbiA9IHAtPl9pbmQgLSAxOyBuID49IDA7IG4tLSkKLSAgICB7
Ci0gICAgICB2b2lkICgqZm4pICh2b2lkKSA9IHAtPl9mbnNbbl07Ci0gICAg
ICBpZiAoKHVuc2lnbmVkIGNoYXIgKikgZm4gPj0gZGxsX2JlZyAmJiAodW5z
aWduZWQgY2hhciAqKSBmbiA8IGRsbF9lbmQpCisNCisgIHdoaWxlIChwKQ0K
KyAgICB7DQorICAgICAgZm9yIChpbnQgbiA9IHAtPl9pbmQgLSAxOyBuID49
IDA7IG4tLSkKIAl7Ci0JICBmbiAoKTsKLQkgIHAtPl9mbnNbbl0gPSBOVUxM
OwotCX0KKwkgIHZvaWQgKCpmbikgKHZvaWQpID0gcC0+X2Zuc1tuXTsKKwkg
IGlmICgocC0+X29uX2V4aXRfYXJncy5faXNfY3hhICYgKDEgPDwgbikpID09
IDANCisJICAgICAgJiYgKHVuc2lnbmVkIGNoYXIgKikgZm4gPj0gZGxsX2Jl
ZyAmJiAodW5zaWduZWQgY2hhciAqKSBmbiA8IGRsbF9lbmQpCisJICAgIHsK
KwkgICAgICAvKiBSZW1vdmUgdGhlIGZ1bmN0aW9uIG5vdyB0byBwcm90ZWN0
IGFnYWluc3QgdGhlDQorCQkgZnVuY3Rpb24gY2FsbGluZyBleGl0IHJlY3Vy
c2l2ZWx5LiAgKi8NCisJICAgICAgcC0+X2Zuc1tuXSA9IE5VTEw7DQorCSAg
ICAgIGZuICgpOworCSAgICB9CisJfQ0KKyAgICAgIHAgPSBwLT5fbmV4dDsN
CiAgICAgfQogfQogCg==

--------------020903090902060104080706--

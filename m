Return-Path: <cygwin-patches-return-8590-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22956 invoked by alias); 29 Jun 2016 14:18:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22911 invoked by uid 89); 29 Jun 2016 14:18:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=winsup, WOW64, wow64, HTo:U*cygwin-patches
X-HELO: out3-smtp.messagingengine.com
Received: from out3-smtp.messagingengine.com (HELO out3-smtp.messagingengine.com) (66.111.4.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 29 Jun 2016 14:18:07 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])	by mailout.nyi.internal (Postfix) with ESMTP id C1C842020F	for <cygwin-patches@cygwin.com>; Wed, 29 Jun 2016 10:18:05 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])  by compute6.internal (MEProxy); Wed, 29 Jun 2016 10:18:05 -0400
Received: from [192.168.1.102] (host86-160-189-61.range86-160.btcentralplus.com [86.160.189.61])	by mail.messagingengine.com (Postfix) with ESMTPA id 258B7F2A17	for <cygwin-patches@cygwin.com>; Wed, 29 Jun 2016 10:18:04 -0400 (EDT)
Subject: Re: [PATCH] Update FAQ listing required packages for building Cygwin
To: cygwin-patches@cygwin.com
References: <20160628123927.6904-1-jon.turney@dronecode.org.uk> <20160628132120.GE23625@calimero.vinschen.de> <20160629080418.GB981@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <baf48ab3-351c-65c3-893b-cd59fb8ae16e@dronecode.org.uk>
Date: Wed, 29 Jun 2016 14:18:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160629080418.GB981@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------16112309A502C0B143236CF6"
X-SW-Source: 2016-q2/txt/msg00065.txt.bz2

This is a multi-part message in MIME format.
--------------16112309A502C0B143236CF6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 932

On 29/06/2016 09:04, Corinna Vinschen wrote:
> Hi Jon,
>
> On Jun 28 15:21, Corinna Vinschen wrote:
>> On Jun 28 13:39, Jon Turney wrote:
>>> docbook2X is now required for building documentation
>>> libiconv differences between x86_64 and x86 no longer exist
>>
>> Please apply.
>
> Sorry, but that was not quite correct.  Apparently I only skimmed the
> log text, not the actual patch.  Doh.
>
> When building 32 bit Cygwin, you need the 64 bit Mingw compiler for
> cyglsa64.dll.  The reason is that 32 bit cyglsa.dll won't work on 64 bit
> systems, even if Cygwin itself is running under WOW64.  Since we don't
> know if the user runs Cygwin on 32 bit or under WOW64, we have to create
> *both* cyglsa DLLs for 32 bit Cygwin, while it's obviously sufficient to
> build only the 64 bit version for 64 bit Cygwin.

Yes, I somehow though it said mingw64-i686-gcc-core rather than 
mingw64-x86_64-gcc-core.

How about the attached?



--------------16112309A502C0B143236CF6
Content-Type: text/plain; charset=UTF-8;
 name="0001-Restore-mingw64-x86_64-gcc-core-in-FAQ-listing-requi.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Restore-mingw64-x86_64-gcc-core-in-FAQ-listing-requi.pa";
 filename*1="tch"
Content-length: 1680

RnJvbSBlMjdjZmE0NjMxZTlmZjdlYWQ3YjQxN2U4N2QxNjBjYzIwYzlkMDNl
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gVHVybmV5IDxq
b24udHVybmV5QGRyb25lY29kZS5vcmcudWs+CkRhdGU6IFdlZCwgMjkgSnVu
IDIwMTYgMTU6MDg6MTkgKzAxMDAKU3ViamVjdDogW1BBVENIXSBSZXN0b3Jl
IG1pbmd3NjQteDg2XzY0LWdjYy1jb3JlIGluIEZBUSBsaXN0aW5nIHJlcXVp
cmVkCiBwYWNrYWdlcwoKUmVzdG9yZSBtaW5ndzY0LXg4Nl82NC1nY2MtY29y
ZSB0byByZXF1aXJlbWVudHMgZm9yIDMyLWJpdCBidWlsZHMgaW4gRkFRCmxp
c3RpbmcgcmVxdWlyZWQgcGFja2FnZXMsIGFuZCBnaXZlIHJlYXNvbi4KClNp
Z25lZC1vZmYtYnk6IEpvbiBUdXJuZXkgPGpvbi50dXJuZXlAZHJvbmVjb2Rl
Lm9yZy51az4KLS0tCiB3aW5zdXAvZG9jL2ZhcS1wcm9ncmFtbWluZy54bWwg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAt
LWdpdCBhL3dpbnN1cC9kb2MvZmFxLXByb2dyYW1taW5nLnhtbCBiL3dpbnN1
cC9kb2MvZmFxLXByb2dyYW1taW5nLnhtbAppbmRleCAxZjU5NWY4Li5jNjRh
YjRhIDEwMDY0NAotLS0gYS93aW5zdXAvZG9jL2ZhcS1wcm9ncmFtbWluZy54
bWwKKysrIGIvd2luc3VwL2RvYy9mYXEtcHJvZ3JhbW1pbmcueG1sCkBAIC02
ODMsNiArNjgzLDcgQEAgaW5zdGFsbGVkOyB5b3UgYXQgbGVhc3QgbmVlZCA8
bGl0ZXJhbD5nY2MtZysrPC9saXRlcmFsPiwgPGxpdGVyYWw+bWFrZTwvbGl0
ZXJhbD4KIDxsaXRlcmFsPnBlcmw8L2xpdGVyYWw+LCA8bGl0ZXJhbD5jb2Nv
bTwvbGl0ZXJhbD4sIDxsaXRlcmFsPmdldHRleHQtZGV2ZWw8L2xpdGVyYWw+
LAogPGxpdGVyYWw+bGliaWNvbnYtZGV2ZWw8L2xpdGVyYWw+IGFuZCA8bGl0
ZXJhbD56bGliLWRldmVsPC9saXRlcmFsPi4KIEJ1aWxkaW5nIGZvciAzMi1i
aXQgQ3lnd2luIGFsc28gcmVxdWlyZXMKKzxsaXRlcmFsPm1pbmd3NjQteDg2
XzY0LWdjYy1jb3JlPC9saXRlcmFsPiAoZm9yIGJ1aWxkaW5nIHRoZSBjeWds
c2E2NCBETEwgZm9yIFdvVzY0KSwKIDxsaXRlcmFsPm1pbmd3NjQtaTY4Ni1n
Y2MtZysrPC9saXRlcmFsPiBhbmQgPGxpdGVyYWw+bWluZ3c2NC1pNjg2LXps
aWI8L2xpdGVyYWw+LgogQnVpbGRpbmcgZm9yIDY0LWJpdCBDeWd3aW4gYWxz
byByZXF1aXJlcwogPGxpdGVyYWw+bWluZ3c2NC14ODZfNjQtZ2NjLWcrKzwv
bGl0ZXJhbD4gYW5kCi0tIAoyLjguMwoK

--------------16112309A502C0B143236CF6--

Return-Path: <SRS0=bLpK=RT=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
	by sourceware.org (Postfix) with ESMTPS id C59B23858D21
	for <cygwin-patches@cygwin.com>; Wed, 23 Oct 2024 10:43:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C59B23858D21
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C59B23858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.83
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1729680219; cv=none;
	b=Db5gaPvBDNbujRj0W3i51Vf4nJrIW/B1RtjQWSMC2KpwGRpsgOfApOu63m7WWFtIWOO6bQhCBbTyC2uOaftSlsoydH5GMA9IvEbEif8TvqW9MIFk3imschgZY6b8nZxd5jA4DU0TOWOuAl6SaUUuswkNInnCW1Ebs6VRxT/W29M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1729680219; c=relaxed/simple;
	bh=unqo74fSHP7hTU2zhmwFNc9R2qBMTDzTz2cCx+dLsho=;
	h=From:Subject:To:Message-ID:Date:MIME-Version; b=Tq6lxg9cFUNnn9ASw/BzM/huJl2nDWX7H7q1i3XuzsEZ7y6mkDRCZBV3Sp0bamchcLId7K0YlcPjEWdH2G/P9mh73/AaXzoR4tEcgRl27MqoT7nrntbzlQItk6P4eULty+4TXTSHstcvHVVWHRBWU30/E3V0IPavf6tSg3QFXhQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd83.aul.t-online.de (fwd83.aul.t-online.de [10.223.144.109])
	by mailout07.t-online.de (Postfix) with SMTP id 35DC95014E
	for <cygwin-patches@cygwin.com>; Wed, 23 Oct 2024 12:43:35 +0200 (CEST)
Received: from [192.168.2.101] ([79.230.171.165]) by fwd83.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1t3Ypy-1Ms3tI0; Wed, 23 Oct 2024 12:43:34 +0200
From: Christian Franke <Christian.Franke@t-online.de>
Subject: Re: [PATCH] cygwin: timer_delete: Fix return value
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <fb690e19-367f-0741-fffe-90c30df16351@t-online.de>
 <Zxe_Zfp0BZL_bngZ@calimero.vinschen.de>
Message-ID: <5216f1fa-c489-ae20-6f68-be7c924d8691@t-online.de>
Date: Wed, 23 Oct 2024 12:43:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.18.2
MIME-Version: 1.0
In-Reply-To: <Zxe_Zfp0BZL_bngZ@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------A015D17FBB9B84E2FAAFCDCD"
X-TOI-EXPURGATEID: 150726::1729680214-6BFFD5DD-407FA202/0/0 CLEAN NORMAL
X-TOI-MSGID: bbc0ad9c-7029-4ed5-8d4a-e12d2750cee8
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------A015D17FBB9B84E2FAAFCDCD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> Hi Christian,
>
> On Oct 12 18:58, Christian Franke wrote:
>> Nobody checks the return value of functions which only free resources:
>> close(), ..., timer_delete(), ... :-)
> Sigh.  Apparently I broke it in 2019, see commit 229ea3f23c015.
>
>>  From 2d0c5b53bba2ded8d85ed725774498cffbb4f1de Mon Sep 17 00:00:00 2001
>> From: Christian Franke<christian.franke@t-online.de>
>> Date: Sat, 12 Oct 2024 18:47:00 +0200
>> Subject: [PATCH] cygwin: timer_delete: Fix return value
>>
>> timer_delete() always returned failure.  This issue has been
>> detected by 'stress-ng --hrtimers 1'.
>>
> Please add
>
>    Fixes: 229ea3f23c015 ("Cygwin: posix timers: reimplement using OS timer")
>
>> Signed-off-by: Christian Franke<christian.franke@t-online.de>
>> ---
>>   winsup/cygwin/posix_timer.cc | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/winsup/cygwin/posix_timer.cc b/winsup/cygwin/posix_timer.cc
>> index 9d832f201..a336b2bc2 100644
>> --- a/winsup/cygwin/posix_timer.cc
>> +++ b/winsup/cygwin/posix_timer.cc
>> @@ -530,6 +530,7 @@ timer_delete (timer_t timerid)
>>   	  __leave;
>>   	}
>>         delete in_tt;
>> +      ret = 0;
>>       }
>>     __except (EFAULT) {}
>>     __endtry
>> -- 
>> 2.45.1
>>
> Also add an entry for the release/3.5.5 file, please.

Attached.


--------------A015D17FBB9B84E2FAAFCDCD
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-timer_delete-Fix-return-value.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Cygwin-timer_delete-Fix-return-value.patch"

RnJvbSBlNDNkZjNmYjhlYmQxNDEzZTc0NTJmZjUyODRjYWMwZGRiMDJjYjliIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBXZWQsIDIzIE9jdCAyMDI0IDEyOjI0OjA2ICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiB0aW1lcl9kZWxldGU6IEZpeCByZXR1cm4gdmFs
dWUKCnRpbWVyX2RlbGV0ZSgpIGFsd2F5cyByZXR1cm5lZCBmYWlsdXJlLiAgVGhpcyBpc3N1
ZSBoYXMgYmVlbgpkZXRlY3RlZCBieSAnc3RyZXNzLW5nIC0taHJ0aW1lcnMgMScuCgpGaXhl
czogMjI5ZWEzZjIzYzAxNSAoIkN5Z3dpbjogcG9zaXggdGltZXJzOiByZWltcGxlbWVudCB1
c2luZyBPUyB0aW1lciIpClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBGcmFua2UgPGNocmlz
dGlhbi5mcmFua2VAdC1vbmxpbmUuZGU+Ci0tLQogd2luc3VwL2N5Z3dpbi9wb3NpeF90aW1l
ci5jYyB8IDEgKwogd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuNS41ICB8IDIgKysKIDIgZmls
ZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dp
bi9wb3NpeF90aW1lci5jYyBiL3dpbnN1cC9jeWd3aW4vcG9zaXhfdGltZXIuY2MKaW5kZXgg
OWQ4MzJmMjAxLi5hMzM2YjJiYzIgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vcG9zaXhf
dGltZXIuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9wb3NpeF90aW1lci5jYwpAQCAtNTMwLDYg
KzUzMCw3IEBAIHRpbWVyX2RlbGV0ZSAodGltZXJfdCB0aW1lcmlkKQogCSAgX19sZWF2ZTsK
IAl9CiAgICAgICBkZWxldGUgaW5fdHQ7CisgICAgICByZXQgPSAwOwogICAgIH0KICAgX19l
eGNlcHQgKEVGQVVMVCkge30KICAgX19lbmR0cnkKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3
aW4vcmVsZWFzZS8zLjUuNSBiL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjUuNQppbmRleCBk
MDFmMzFjNjAuLmJjYzJjNjYxYiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9yZWxlYXNl
LzMuNS41CisrKyBiL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjUuNQpAQCAtMTAsMyArMTAs
NSBAQCBGaXhlczoKIAogLSBGaXggcHJlYWQoKSBhbmQgcHdyaXRlKCkgRUJBREYgZXJyb3Ig
YWZ0ZXIgZm9yaygpLgogICBBZGRyZXNzZXM6IGh0dHBzOi8vc291cmNld2FyZS5vcmcvcGlw
ZXJtYWlsL2N5Z3dpbi8yMDI0LVNlcHRlbWJlci8yNTY0NjguaHRtbAorCistIEZpeCB0aW1l
cl9kZWxldGUoKSByZXR1cm4gdmFsdWUgd2hpY2ggYWx3YXlzIGluZGljYXRlZCBmYWlsdXJl
LgotLSAKMi40NS4xCgo=
--------------A015D17FBB9B84E2FAAFCDCD--

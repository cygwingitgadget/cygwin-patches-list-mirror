Return-Path: <SRS0=/tBt=TD=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
	by sourceware.org (Postfix) with ESMTPS id 1B7FD3858423
	for <cygwin-patches@cygwin.com>; Tue, 10 Dec 2024 14:16:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1B7FD3858423
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1B7FD3858423
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.82
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733840196; cv=none;
	b=xX+l9uqVWrLGs4PYdXmf+hi4iAp4kOhBeDfeWkBPRFDsGFyTdRuGkjZfkdq9aC+2qTU99rydn6jmLK8ZgTnkQ98HxS1LO9Rv1MgdaU8espJXanS/oe7fFzLqAODecuM6jeEonQGjaovrmSt33zMePBkNEl5pXAyDWqXmA4vx09Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733840196; c=relaxed/simple;
	bh=t+CS6mjAaQpKtX4E8D0TBrx5Yj90AxXLgexle3TfJVw=;
	h=Subject:From:To:Message-ID:Date:MIME-Version; b=Dq1W80yFQJDWs4jqnkfQNj8lS2HN8aUqH0BY9ME9XfTem+GLEQuEhR0vE0XIUyOhS+BcpNXET23NtIxGe4wHzurOd6DEf7MRRLs7m4tSiPjF1qqXqZMbomd06QC/ikueo5XH/fKUwRYpAe6IBaxMolj8M6sIMo3vLw9nocBTlkI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1B7FD3858423
Received: from fwd73.aul.t-online.de (fwd73.aul.t-online.de [10.223.144.99])
	by mailout05.t-online.de (Postfix) with SMTP id 3FA2D758
	for <cygwin-patches@cygwin.com>; Tue, 10 Dec 2024 15:16:34 +0100 (CET)
Received: from [192.168.2.103] ([91.57.250.70]) by fwd73.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tL12P-2mzxgG0; Tue, 10 Dec 2024 15:16:33 +0100
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_BATCH
From: Christian Franke <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
References: <3a052da3-f60e-1d7a-f741-956926af23da@t-online.de>
 <Z1bEgYIYR43Jn45A@calimero.vinschen.de>
 <9362a9a5-2ec9-0c89-9d2a-5b5f357857ad@t-online.de>
 <14b59939-ef50-60d8-ac6c-bf6c0afb8dac@t-online.de>
Message-ID: <8e7d7da6-bdca-7b36-fb7f-497b403a4fc1@t-online.de>
Date: Tue, 10 Dec 2024 15:16:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <14b59939-ef50-60d8-ac6c-bf6c0afb8dac@t-online.de>
Content-Type: multipart/mixed;
 boundary="------------BC29C0AC4A05742EA39C8AC7"
X-TOI-EXPURGATEID: 150726::1733840193-4F7FD9FE-BCE741A3/0/0 CLEAN NORMAL
X-TOI-MSGID: 3cc2dc98-47ff-4aff-96a8-617bb9449eb5
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,BODY_8BITS,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------BC29C0AC4A05742EA39C8AC7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Christian Franke wrote:
> Christian Franke wrote:
>> Corinna Vinschen wrote:
>>> Hi Christian,
>>>
>>> On Dec  6 17:52, Christian Franke wrote:
>>>> A first attempt to add SCHED_BATCH.
>>>>
>>>> Still TODO:
>>>> - Add SCHED_IDLE/BATCH to winsup/doc/posix.xml
>>>> - Provide correct values in (18) and (19) of /proc/PID/stat for 
>>>> SCHED_BATCH.
>>>> - Provide correct value in (18) of /proc/PID/stat for SCHED_FIFO/RR.
>>>>
>>>> -- 
>>>> Regards,
>>>> Christian
>>>>
>>>>  From 0822917252fdade3edc240b4fbfd3c0f47ef1deb Mon Sep 17 00:00:00 
>>>> 2001
>>>> From: Christian Franke <christian.franke@t-online.de>
>>>> Date: Fri, 6 Dec 2024 17:32:29 +0100
>>>> Subject: [PATCH] Cygwin: sched_setscheduler: accept SCHED_BATCH
>>>>
>>>> Add SCHED_BATCH to <sys/sched.h>.  SCHED_BATCH is similar to 
>>>> SCHED_OTHER,
>>>> except that the nice value is mapped to a one step lower Windows 
>>>> priority.
>>>> Rework the mapping functions to ease the addition of this 
>>>> functionality.
>>>>
>>>> Signed-off-by: Christian Franke <christian.franke@t-online.de>
>>>> ---
>>>>   newlib/libc/include/sys/sched.h          |   8 ++
>>>>   winsup/cygwin/local_includes/miscfuncs.h |   4 +-
>>>>   winsup/cygwin/miscfuncs.cc               | 155 
>>>> +++++++++++++----------
>>>>   winsup/cygwin/release/3.6.0              |  11 +-
>>>>   winsup/cygwin/sched.cc                   |  15 ++-
>>>>   winsup/cygwin/syscalls.cc                |  20 +--
>>>>   6 files changed, 129 insertions(+), 84 deletions(-)
>>>>
>>>> diff --git a/newlib/libc/include/sys/sched.h 
>>>> b/newlib/libc/include/sys/sched.h
>>>> index c96355c24..265215211 100644
>>>> --- a/newlib/libc/include/sys/sched.h
>>>> +++ b/newlib/libc/include/sys/sched.h
>>>> @@ -38,6 +38,14 @@ extern "C" {
>>>>   #define SCHED_FIFO     1
>>>>   #define SCHED_RR       2
>>>>   +#if __GNU_VISIBLE
>>>> +#if defined(__CYGWIN__)
>>>> +#define SCHED_BATCH    0
>>>> +#else
>>>> +#define SCHED_BATCH    3
>>>> +#endif
>>>> +#endif
>>> I would prefer that SCHED_BATCH gets its own, single value.
>>> There's no good reason to add another ifdef for that.  Why
>>> not just #define SCHED_BATCH 6?
>>
>> The idea was to keep the non-Cygwin value in sync with Linux.
>> https://github.com/torvalds/linux/blob/fac04ef/include/uapi/linux/sched.h#L111 
>>
>> Of course we could drop this idea and use 6.
>>
>
> Attached, no other changes.
>
>

The next (and possibly last) SCHED_* feature addition on top of the 
SCHED_BATCH (6) patch.


--------------BC29C0AC4A05742EA39C8AC7
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-sched_setscheduler-accept-SCHED_RESET_ON_FORK.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-sched_setscheduler-accept-SCHED_RESET_ON_FORK.pa";
 filename*1="tch"

RnJvbSA1NmU0MDZjNWFiMjcwYjJlZjNjYTMxY2I4ZmFiZmFjYTkyN2Y0ZDI5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUdWUsIDEwIERlYyAyMDI0IDE1OjA5OjQyICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBzY2hlZF9zZXRzY2hlZHVsZXI6IGFjY2VwdCBT
Q0hFRF9SRVNFVF9PTl9GT1JLIGZsYWcKCkFkZCBTQ0hFRF9SRVNFVF9PTl9GT1JLIHRvIDxz
eXMvc2NoZWQuaD4uICBJZiB0aGlzIGZsYWcgaXMgc2V0LCBTQ0hFRF9GSUZPCmFuZCBTQ0hF
RF9SUiBhcmUgcmVzZXQgdG8gU0NIRURfT1RIRVIgYW5kIG5lZ2F0aXZlIG5pY2UgdmFsdWVz
IGFyZSByZXNldCB0bwp6ZXJvIGluIGVhY2ggY2hpbGQgcHJvY2VzcyBjcmVhdGVkIHdpdGgg
Zm9yaygyKS4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBGcmFua2UgPGNocmlzdGlhbi5m
cmFua2VAdC1vbmxpbmUuZGU+Ci0tLQogbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvc2NoZWQu
aCAgICAgIHwgIDMgKysrCiB3aW5zdXAvY3lnd2luL2ZvcmsuY2MgICAgICAgICAgICAgICAg
fCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB3aW5zdXAvY3lnd2luL2xvY2Fs
X2luY2x1ZGVzL3BpbmZvLmggfCAgNSArKystLQogd2luc3VwL2N5Z3dpbi9waW5mby5jYyAg
ICAgICAgICAgICAgIHwgIDEgKwogd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuNi4wICAgICAg
ICAgIHwgIDMgKysrCiB3aW5zdXAvY3lnd2luL3NjaGVkLmNjICAgICAgICAgICAgICAgfCAx
MSArKysrKystLS0tCiB3aW5zdXAvY3lnd2luL3NwYXduLmNjICAgICAgICAgICAgICAgfCAg
MSArCiA3IGZpbGVzIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvc2NoZWQuaCBiL25ld2xp
Yi9saWJjL2luY2x1ZGUvc3lzL3NjaGVkLmgKaW5kZXggNjk3N2QzZDRhLi45NTUwOWRiZjAg
MTAwNjQ0Ci0tLSBhL25ld2xpYi9saWJjL2luY2x1ZGUvc3lzL3NjaGVkLmgKKysrIGIvbmV3
bGliL2xpYmMvaW5jbHVkZS9zeXMvc2NoZWQuaApAQCAtNDUsNiArNDUsOSBAQCBleHRlcm4g
IkMiIHsKICNpZiBfX0dOVV9WSVNJQkxFCiAjZGVmaW5lIFNDSEVEX0lETEUgICAgIDUKICNk
ZWZpbmUgU0NIRURfQkFUQ0ggICAgNgorCisvKiBGbGFnIHRvIGRyb3AgcmVhbHRpbWUgcG9s
aWNpZXMgYW5kIG5lZ2F0aXZlIG5pY2UgdmFsdWVzIG9uIGZvcmsoKS4gKi8KKyNkZWZpbmUg
U0NIRURfUkVTRVRfT05fRk9SSyAgICAgMHg0MDAwMDAwMAogI2VuZGlmCiAKIC8qIFNjaGVk
dWxpbmcgUGFyYW1ldGVycyAqLwpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9mb3JrLmNj
IGIvd2luc3VwL2N5Z3dpbi9mb3JrLmNjCmluZGV4IDdkOTc2ZTg4Mi4uOTI1Zjk4OGJmIDEw
MDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2ZvcmsuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9m
b3JrLmNjCkBAIC00MDQsNiArNDA0LDM5IEBAIGZyb2s6OnBhcmVudCAodm9sYXRpbGUgY2hh
ciAqIHZvbGF0aWxlIHN0YWNrX2hlcmUpCiAgIGNoaWxkLT5uaWNlID0gbXlzZWxmLT5uaWNl
OwogICBjaGlsZC0+c2NoZWRfcG9saWN5ID0gbXlzZWxmLT5zY2hlZF9wb2xpY3k7CiAKKyAg
LyogSGFuZGxlIFNDSEVEX1JFU0VUX09OX0ZPUksgZmxhZy4gKi8KKyAgaWYgKG15c2VsZi0+
c2NoZWRfcmVzZXRfb25fZm9yaykKKyAgICB7CisgICAgICBib29sIGJhdGNoID0gKG15c2Vs
Zi0+c2NoZWRfcG9saWN5ID09IFNDSEVEX0JBVENIKTsKKyAgICAgIGJvb2wgaWRsZSA9ICht
eXNlbGYtPnNjaGVkX3BvbGljeSA9PSBTQ0hFRF9JRExFKTsKKyAgICAgIGJvb2wgc2V0X3By
aW8gPSBmYWxzZTsKKyAgICAgIC8qIFJlc2V0IG5lZ2F0aXZlIG5pY2UgdmFsdWVzIHRvIHpl
cm8uICovCisgICAgICBpZiAobXlzZWxmLT5uaWNlIDwgMCkKKwl7CisJICBjaGlsZC0+bmlj
ZSA9IDA7CisJICBzZXRfcHJpbyA9ICFpZGxlOworCX0KKyAgICAgIC8qIFJlc2V0IHJlYWx0
aW1lIHBvbGljaWVzIHRvIFNDSEVEX09USEVSLiAqLworICAgICAgaWYgKCEobXlzZWxmLT5z
Y2hlZF9wb2xpY3kgPT0gU0NIRURfT1RIRVIgfHwgYmF0Y2ggfHwgaWRsZSkpCisJeworCSAg
Y2hpbGQtPnNjaGVkX3BvbGljeSA9IFNDSEVEX09USEVSOworCSAgc2V0X3ByaW8gPSB0cnVl
OworCX0KKyAgICAgIC8qIEFkanVzdCBXaW5kb3dzIHByaW9yaXR5IGlmIHJlcXVpcmVkLiAq
LworICAgICAgaWYgKHNldF9wcmlvKQorCXsKKwkgIEhBTkRMRSBwcm9jID0gT3BlblByb2Nl
c3MoUFJPQ0VTU19TRVRfSU5GT1JNQVRJT04gfAorCQkJCSAgICBQUk9DRVNTX1FVRVJZX0xJ
TUlURURfSU5GT1JNQVRJT04sCisJCQkJICAgIEZBTFNFLCBjaGlsZC0+ZHdQcm9jZXNzSWQp
OworCSAgaWYgKHByb2MpCisJICAgIHsKKwkgICAgICBzZXRfYW5kX2NoZWNrX3dpbnByaW8o
cHJvYywgbmljZV90b193aW5wcmlvKGNoaWxkLT5uaWNlLCBiYXRjaCkpOworCSAgICAgIENs
b3NlSGFuZGxlKHByb2MpOworCSAgICB9CisJfQorICAgIH0KKyAgY2hpbGQtPnNjaGVkX3Jl
c2V0X29uX2ZvcmsgPSBmYWxzZTsKKwogICAvKiBJbml0aWFsaXplIHRoaW5ncyB0aGF0IGFy
ZSBkb25lIGxhdGVyIGluIGRsbF9jcnQwXzEgdGhhdCBhcmVuJ3QgZG9uZQogICAgICBmb3Ig
dGhlIGZvcmtlZS4gICovCiAgIHdjc2NweSAoY2hpbGQtPnByb2duYW1lLCBteXNlbGYtPnBy
b2duYW1lKTsKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvcGlu
Zm8uaCBiL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvcGluZm8uaAppbmRleCAwM2Uw
YzRkNjAuLmJlNWQ1MzAyMSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNs
dWRlcy9waW5mby5oCisrKyBiL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMvcGluZm8u
aApAQCAtOTMsOCArOTMsOSBAQCBwdWJsaWM6CiAgIHN0cnVjdCBydXNhZ2UgcnVzYWdlX3Nl
bGY7CiAgIHN0cnVjdCBydXNhZ2UgcnVzYWdlX2NoaWxkcmVuOwogCi0gIGludCBuaWNlOyAg
ICAgICAgICAvKiBuaWNlIHZhbHVlIGZvciBTQ0hFRF9PVEhFUi4gKi8KLSAgaW50IHNjaGVk
X3BvbGljeTsgIC8qIFNDSEVEX09USEVSLCBTQ0hFRF9GSUZPIG9yIFNDSEVEX1JSLiAqLwor
ICBpbnQgbmljZTsgICAgICAgICAgLyogbmljZSB2YWx1ZSBmb3IgU0NIRURfT1RIRVIgYW5k
IFNDSEVEX0JBVENILiAqLworICBpbnQgc2NoZWRfcG9saWN5OyAgLyogU0NIRURfT1RIRVIv
QkFUQ0gvSURMRS9GSUZPL1JSICovCisgIGJvb2wgc2NoZWRfcmVzZXRfb25fZm9yazsgIC8q
IHRydWUgaWYgU0NIRURfUkVTRVRfT05fRk9SSyBmbGFnIHdhcyBzZXQuICovCiAKICAgLyog
Tm9uLXplcm8gaWYgcHJvY2VzcyB3YXMgc3RvcHBlZCBieSBhIHNpZ25hbC4gKi8KICAgY2hh
ciBzdG9wc2lnOwpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9waW5mby5jYyBiL3dpbnN1
cC9jeWd3aW4vcGluZm8uY2MKaW5kZXggMDZjOTY2ZjFlLi5mZWNmNzZlYjYgMTAwNjQ0Ci0t
LSBhL3dpbnN1cC9jeWd3aW4vcGluZm8uY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9waW5mby5j
YwpAQCAtMTAzLDYgKzEwMyw3IEBAIHBpbmZvX2luaXQgKGNoYXIgKiplbnZwLCBpbnQgZW52
YykKICAgICAgIGVudmlyb25faW5pdCAoTlVMTCwgMCk7CS8qIGNhbGwgYWZ0ZXIgbXlzZWxm
IGhhcyBiZWVuIHNldCB1cCAqLwogICAgICAgbXlzZWxmLT5uaWNlID0gd2lucHJpb190b19u
aWNlIChHZXRQcmlvcml0eUNsYXNzIChHZXRDdXJyZW50UHJvY2VzcyAoKSkpOwogICAgICAg
bXlzZWxmLT5zY2hlZF9wb2xpY3kgPSBTQ0hFRF9PVEhFUjsKKyAgICAgIG15c2VsZi0+c2No
ZWRfcmVzZXRfb25fZm9yayA9IGZhbHNlOwogICAgICAgbXlzZWxmLT5wcGlkID0gMTsJCS8q
IGFsd2F5cyBzZXQgbGFzdCAqLwogICAgICAgZGVidWdfcHJpbnRmICgiU2V0IG5pY2UgdG8g
JWQiLCBteXNlbGYtPm5pY2UpOwogICAgIH0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4v
cmVsZWFzZS8zLjYuMCBiL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjYuMAppbmRleCAxMWY3
NDViMjMuLmQzNWFhMzAzNiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMu
Ni4wCisrKyBiL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjYuMApAQCAtNjEsNSArNjEsOCBA
QCBXaGF0IGNoYW5nZWQ6CiAgIHByaW9yaXR5IGlzIHNldCB0byBJRExFX1BSSU9SSVRZX0NM
QVNTLiAgSWYgU0NIRURfRklGTyBvciBTQ0hFRF9SUiBpcwogICBzZWxlY3RlZCwgdGhlIG5p
Y2UgdmFsdWUgaXMgcHJlc2VydmVkIGFuZCB0aGUgV2luZG93cyBwcmlvcml0eSBpcyBzZXQK
ICAgYWNjb3JkaW5nIHRvIHRoZSByZWFsdGltZSBwcmlvcml0eS4KKyAgSWYgdGhlIFNDSEVE
X1JFU0VUX09OX0ZPUksgZmxhZyBpcyBzZXQsIFNDSEVEX0ZJRk8gYW5kIFNDSEVEX1JSIGFy
ZQorICByZXNldCB0byBTQ0hFRF9PVEhFUiBhbmQgbmVnYXRpdmUgbmljZSB2YWx1ZXMgYXJl
IHJlc2V0IHRvIHplcm8gaW4KKyAgZWFjaCBjaGlsZCBwcm9jZXNzIGNyZWF0ZWQgd2l0aCBm
b3JrKDIpLgogICBOb3RlOiBXaW5kb3dzIGRvZXMgbm90IG9mZmVyIGFsdGVybmF0aXZlIHNj
aGVkdWxpbmcgcG9saWNpZXMgc28KICAgdGhpcyBjb3VsZCBvbmx5IGVtdWxhdGUgQVBJIGJl
aGF2aW9yLgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zY2hlZC5jYyBiL3dpbnN1cC9j
eWd3aW4vc2NoZWQuY2MKaW5kZXggZWM2MmVhODNjLi5kNzVhMzQwNGYgMTAwNjQ0Ci0tLSBh
L3dpbnN1cC9jeWd3aW4vc2NoZWQuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9zY2hlZC5jYwpA
QCAtMTYyLDcgKzE2Miw3IEBAIHNjaGVkX2dldHNjaGVkdWxlciAocGlkX3QgcGlkKQogICAg
ICAgc2V0X2Vycm5vIChFU1JDSCk7CiAgICAgICByZXR1cm4gLTE7CiAgICAgfQotICByZXR1
cm4gcC0+c2NoZWRfcG9saWN5OworICByZXR1cm4gcC0+c2NoZWRfcG9saWN5IHwgKHAtPnNj
aGVkX3Jlc2V0X29uX2ZvcmsgPyBTQ0hFRF9SRVNFVF9PTl9GT1JLIDogMCk7CiB9CiAKIC8q
IGdldCB0aGUgdGltZSBxdWFudHVtIGZvciBwaWQgKi8KQEAgLTQyNSw5ICs0MjUsMTEgQEAg
aW50CiBzY2hlZF9zZXRzY2hlZHVsZXIgKHBpZF90IHBpZCwgaW50IHBvbGljeSwKIAkJICAg
IGNvbnN0IHN0cnVjdCBzY2hlZF9wYXJhbSAqcGFyYW0pCiB7CisgIGludCBuZXdfcG9saWN5
ID0gcG9saWN5ICYgflNDSEVEX1JFU0VUX09OX0ZPUks7CiAgIGlmICghKHBpZCA+PSAwICYm
IHBhcmFtICYmCi0gICAgICAoKChwb2xpY3kgPT0gU0NIRURfT1RIRVIgfHwgcG9saWN5ID09
IFNDSEVEX0JBVENIIHx8IHBvbGljeSA9PSBTQ0hFRF9JRExFKQotICAgICAgJiYgcGFyYW0t
PnNjaGVkX3ByaW9yaXR5ID09IDApIHx8ICgocG9saWN5ID09IFNDSEVEX0ZJRk8gfHwgcG9s
aWN5ID09IFNDSEVEX1JSKQorICAgICAgKCgobmV3X3BvbGljeSA9PSBTQ0hFRF9PVEhFUiB8
fCBuZXdfcG9saWN5ID09IFNDSEVEX0JBVENICisgICAgICB8fCBuZXdfcG9saWN5ID09IFND
SEVEX0lETEUpICYmIHBhcmFtLT5zY2hlZF9wcmlvcml0eSA9PSAwKQorICAgICAgfHwgKChu
ZXdfcG9saWN5ID09IFNDSEVEX0ZJRk8gfHwgbmV3X3BvbGljeSA9PSBTQ0hFRF9SUikKICAg
ICAgICYmIHZhbGlkX3NjaGVkX3BhcmFtZXRlcnMocGFyYW0pKSkpKQogICAgIHsKICAgICAg
IHNldF9lcnJubyAoRUlOVkFMKTsKQEAgLTQ0MiwxMyArNDQ0LDE0IEBAIHNjaGVkX3NldHNj
aGVkdWxlciAocGlkX3QgcGlkLCBpbnQgcG9saWN5LAogICAgIH0KIAogICBpbnQgcHJldl9w
b2xpY3kgPSBwLT5zY2hlZF9wb2xpY3k7Ci0gIHAtPnNjaGVkX3BvbGljeSA9IHBvbGljeTsK
KyAgcC0+c2NoZWRfcG9saWN5ID0gbmV3X3BvbGljeTsKICAgaWYgKHNjaGVkX3NldHBhcmFt
X3BpbmZvIChwLCBwYXJhbSkpCiAgICAgewogICAgICAgcC0+c2NoZWRfcG9saWN5ID0gcHJl
dl9wb2xpY3k7CiAgICAgICByZXR1cm4gLTE7CiAgICAgfQogCisgIHAtPnNjaGVkX3Jlc2V0
X29uX2ZvcmsgPSAhIShwb2xpY3kgJiBTQ0hFRF9SRVNFVF9PTl9GT1JLKTsKICAgcmV0dXJu
IDA7CiB9CiAKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vc3Bhd24uY2MgYi93aW5zdXAv
Y3lnd2luL3NwYXduLmNjCmluZGV4IDdmOWYyZGY2NC4uODAxNmYwODY0IDEwMDY0NAotLS0g
YS93aW5zdXAvY3lnd2luL3NwYXduLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vc3Bhd24uY2MK
QEAgLTgwMCw2ICs4MDAsNyBAQCBjaGlsZF9pbmZvX3NwYXduOjp3b3JrZXIgKGNvbnN0IGNo
YXIgKnByb2dfYXJnLCBjb25zdCBjaGFyICpjb25zdCAqYXJndiwKIAkgIGNoaWxkLT5zdGFy
dF90aW1lID0gdGltZSAoTlVMTCk7IC8qIFJlZ2lzdGVyIGNoaWxkJ3Mgc3RhcnRpbmcgdGlt
ZS4gKi8KIAkgIGNoaWxkLT5uaWNlID0gbXlzZWxmLT5uaWNlOwogCSAgY2hpbGQtPnNjaGVk
X3BvbGljeSA9IG15c2VsZi0+c2NoZWRfcG9saWN5OworCSAgY2hpbGQtPnNjaGVkX3Jlc2V0
X29uX2ZvcmsgPSBmYWxzZTsKIAkgIHBvc3Rmb3JrIChjaGlsZCk7CiAJICBpZiAobW9kZSAh
PSBfUF9ERVRBQ0gKIAkgICAgICAmJiAoIWNoaWxkLnJlbWVtYmVyICgpIHx8ICFjaGlsZC5h
dHRhY2ggKCkpKQotLSAKMi40NS4xCgo=
--------------BC29C0AC4A05742EA39C8AC7--

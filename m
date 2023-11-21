Return-Path: <SRS0=UMF9=HC=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
	by sourceware.org (Postfix) with ESMTPS id 100D03858CDA
	for <cygwin-patches@cygwin.com>; Tue, 21 Nov 2023 18:32:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 100D03858CDA
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 100D03858CDA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.82
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1700591532; cv=none;
	b=Z6FLU4p1vpFPDXqvUgKsB0zbXE0IR32RY1FPBdy0I14vHxqmX41n/jeXlpZ/uPVLpooHcQOh0RxoUBeCkr52i2fn9Bzr6XSWWVO33YSP8I06RpX/N+ReZhOFRSYDG4FqxHjyDIBkXOsRCE9F/AxhZApGUzyIQ+s1mtmzI1Xagpg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1700591532; c=relaxed/simple;
	bh=vlO2HyeyDV8r51IG53ZnN8lmwhj12m8P0+Tsq7u7i9k=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=Ax3QvSMStVhsIk7rlCePJi+6M6LFiLfynYKrp3OFcneoi0kAtTpxk1h5+9ZC3GFoDCWa9z/vfJVktFoGZ2yBIuxAMqwbsbn+jjwUya6zQEd6FzuYf0SXWqyMEYm0Y4QRA73fZGXgwhIy232Xoo51/QB058dfJc4Lh+p+35XTeOE=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd74.aul.t-online.de (fwd74.aul.t-online.de [10.223.144.100])
	by mailout05.t-online.de (Postfix) with SMTP id 5B0222BB3
	for <cygwin-patches@cygwin.com>; Tue, 21 Nov 2023 19:31:42 +0100 (CET)
Received: from [192.168.2.101] ([91.57.240.134]) by fwd74.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1r5VXA-1P5HIO0; Tue, 21 Nov 2023 19:31:41 +0100
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-label and /dev/disk/by-uuid
 symlinks
To: cygwin-patches@cygwin.com
References: <ZVeTfEHgbgLJKFpU@calimero.vinschen.de>
 <57fb24ee-cd4c-0b54-6613-40f817e12571@t-online.de>
 <ZVeZhRmrMlbK7qkz@calimero.vinschen.de>
 <d74801f8-45fb-6a66-cc92-8f021f58c53b@t-online.de>
 <ZVfBmQiTGOjx14lW@calimero.vinschen.de>
 <b924c0f6-7ac1-9fa8-f828-0482f1ea5d36@t-online.de>
 <ZVsppVEdC+HW2NE5@calimero.vinschen.de>
 <ZVsrDfTnL6Fy3BfM@calimero.vinschen.de>
 <0f8c8b7e-8a67-bc0a-24c3-91d28e2f0972@t-online.de>
 <0ba1c78e-15e6-65a2-eb4d-16ac2495c356@t-online.de>
 <ZVzLnADL0i2X3orL@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <7d24b7f1-0dae-ad23-6bde-3502716edbad@t-online.de>
Date: Tue, 21 Nov 2023 19:31:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZVzLnADL0i2X3orL@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------20635E244EE048985D054108"
X-TOI-EXPURGATEID: 150726::1700591501-E5E0A93F-A744476B/0/0 CLEAN NORMAL
X-TOI-MSGID: 368cbf6d-9725-4909-9a5e-3c193d9b5ff2
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------20635E244EE048985D054108
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> Hi Christian,
>
> Looks good, but I just realized that I was already wondering about the
> sanitization and forgot to talk about it:
>
> On Nov 21 12:24, Christian Franke wrote:
>> diff --git a/winsup/cygwin/fhandler/dev_disk.cc b/winsup/cygwin/fhandler/dev_disk.cc
>> index c5d72816f..d12ac52fa 100644
>> --- a/winsup/cygwin/fhandler/dev_disk.cc
>> +++ b/winsup/cygwin/fhandler/dev_disk.cc
>> @@ -64,10 +64,12 @@ sanitize_label_string (WCHAR *s)
>>     /* Linux does not skip leading spaces. */
>>     return sanitize_string (s, L'\0', L' ', L'_', [] (WCHAR c) -> bool
>>       {
>> -      /* Labels may contain characters not allowed in filenames.
>> -	 Linux replaces spaces with \x20 which is not an option here. */
>> +      /* Labels may contain characters not allowed in filenames.  Also
> Apart from slash and backslash, we don't have this problem in Cygwin,
> usually.  Even control characters are no problem.  All chars not allowed
> in filenames are just transposed into the Unicode private use area, as
> per strfuncs.cc, line 20ff on the way to storage, and back when reading
> the names from storage.  This, and especially in a virtual filesystem
> like /proc, there's no reason to avoid these characters.

Thanks for clarification.


>
>> +         replace '#' to avoid that duplicate markers introduce new
>> +	 duplicates.  Linux replaces spaces with \x20 which is not an
>> +	 option here. */
>>         return !((0 <= c && c <= L' ') || c == L':' || c == L'/' || c == L'\\'
>> -	      || c == L'"');
>> +	      || c == L'#' || c == L'"');
> If you really want to avoid chars not allowed in DOS filenames, the
> list seems incomplete, missing '<', '>', '?', '*', '|'.
>
> But as I said, there's really no reason for that.  I simply reduced the
> above expression to
>
>    return !(c == L'/' || c == L'\\' || c == L'#');
>
> and created a disk label
>
>    test"foo*bar?baz:"
>
> It works nicely, including stuff like
>
>    $ ls *\"*
>    $ ls *\**
>
> So, I can push it as is, or we just allow everything and the kitchen sink
> as per the reduced filter expression.  What do you prefer?

The latter - patch attached.

Christian


--------------20635E244EE048985D054108
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-dev-disk-Append-N-if-the-same-name-appears-mo.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-dev-disk-Append-N-if-the-same-name-appears-mo.pa";
 filename*1="tch"

RnJvbSBlY2M1NDM1NmFkYmU3NzY4YmQ1ZmQ1NTYxYzc4YzY3Y2Q1NzI1MTgzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUdWUsIDIxIE5vdiAyMDIzIDE5OjI4OjAyICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiAvZGV2L2Rpc2s6IEFwcGVuZCAnI04nIGlmIHRo
ZSBzYW1lIG5hbWUgYXBwZWFycyBtb3JlCiB0aGFuIG9uY2UKCk5vIGxvbmdlciBkcm9wIHJh
bmdlcyBvZiBpZGVudGljYWwgbGluayBuYW1lcy4gIEFwcGVuZCAnIzAsICMxLCAuLi4nCnRv
IGVhY2ggbmFtZSBpbnN0ZWFkLiAgRW5oYW5jZSBjaGFyc2V0IGFsbG93ZWQgaW4gbGFiZWwg
bmFtZXMuCk5vIGxvbmdlciBpZ25vcmUgbnVsbCB2b2x1bWUgc2VyaWFsIG51bWJlcnMuCgpT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJhbmtlQHQtb25s
aW5lLmRlPgotLS0KIHdpbnN1cC9jeWd3aW4vZmhhbmRsZXIvZGV2X2Rpc2suY2MgfCA1NCAr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNl
cnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2lu
L2ZoYW5kbGVyL2Rldl9kaXNrLmNjIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlci9kZXZfZGlz
ay5jYwppbmRleCBjNWQ3MjgxNmYuLjI5YWY5ZGU5NSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5
Z3dpbi9maGFuZGxlci9kZXZfZGlzay5jYworKysgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVy
L2Rldl9kaXNrLmNjCkBAIC02NCwxMCArNjQsMTEgQEAgc2FuaXRpemVfbGFiZWxfc3RyaW5n
IChXQ0hBUiAqcykKICAgLyogTGludXggZG9lcyBub3Qgc2tpcCBsZWFkaW5nIHNwYWNlcy4g
Ki8KICAgcmV0dXJuIHNhbml0aXplX3N0cmluZyAocywgTCdcMCcsIEwnICcsIEwnXycsIFtd
IChXQ0hBUiBjKSAtPiBib29sCiAgICAgewotICAgICAgLyogTGFiZWxzIG1heSBjb250YWlu
IGNoYXJhY3RlcnMgbm90IGFsbG93ZWQgaW4gZmlsZW5hbWVzLgotCSBMaW51eCByZXBsYWNl
cyBzcGFjZXMgd2l0aCBceDIwIHdoaWNoIGlzIG5vdCBhbiBvcHRpb24gaGVyZS4gKi8KLSAg
ICAgIHJldHVybiAhKCgwIDw9IGMgJiYgYyA8PSBMJyAnKSB8fCBjID09IEwnOicgfHwgYyA9
PSBMJy8nIHx8IGMgPT0gTCdcXCcKLQkgICAgICB8fCBjID09IEwnIicpOworICAgICAgLyog
TGFiZWxzIG1heSBjb250YWluIGNoYXJhY3RlcnMgbm90IGFsbG93ZWQgaW4gZmlsZW5hbWVz
LiAgQWxzbworICAgICAgICAgcmVwbGFjZSAnIycgdG8gYXZvaWQgdGhhdCBkdXBsaWNhdGUg
bWFya2VycyBpbnRyb2R1Y2UgbmV3CisJIGR1cGxpY2F0ZXMuICBMaW51eCByZXBsYWNlcyBz
cGFjZXMgd2l0aCBceDIwIHdoaWNoIGlzIG5vdCBhbgorCSBvcHRpb24gaGVyZS4gKi8KKyAg
ICAgIHJldHVybiAhKGMgPT0gTCcvJyB8fCBjID09IEwnXFwnIHx8IGMgPT0gTCcjJyk7CiAg
ICAgfQogICApOwogfQpAQCAtMzA0LDggKzMwNSw3IEBAIHBhcnRpdGlvbl90b19sYWJlbF9v
cl91dWlkKGJvb2wgdXVpZCwgY29uc3QgVU5JQ09ERV9TVFJJTkcgKmRyaXZlX3VuYW1lLAog
ICBjb25zdCBOVEZTX1ZPTFVNRV9EQVRBX0JVRkZFUiAqbnZkYiA9CiAgICAgcmVpbnRlcnBy
ZXRfY2FzdDxjb25zdCBOVEZTX1ZPTFVNRV9EQVRBX0JVRkZFUiAqPihpb2N0bF9idWYpOwog
ICBpZiAodXVpZCAmJiBEZXZpY2VJb0NvbnRyb2wgKHZvbGhkbCwgRlNDVExfR0VUX05URlNf
Vk9MVU1FX0RBVEEsIG51bGxwdHIsIDAsCi0JCQkgICAgICAgaW9jdGxfYnVmLCBOVF9NQVhf
UEFUSCwgJmJ5dGVzX3JlYWQsIG51bGxwdHIpCi0gICAgICAmJiBudmRiLT5Wb2x1bWVTZXJp
YWxOdW1iZXIuUXVhZFBhcnQpCisJCQkgICAgICAgaW9jdGxfYnVmLCBOVF9NQVhfUEFUSCwg
JmJ5dGVzX3JlYWQsIG51bGxwdHIpKQogICAgIHsKICAgICAgIC8qIFByaW50IHdpdGhvdXQg
YW55IHNlcGFyYXRvciBhcyBvbiBMaW51eC4gKi8KICAgICAgIF9fc21hbGxfc3ByaW50ZiAo
bmFtZSwgIiUwMTZYIiwgbnZkYi0+Vm9sdW1lU2VyaWFsTnVtYmVyLlF1YWRQYXJ0KTsKQEAg
LTMyNywxMyArMzI3LDkgQEAgcGFydGl0aW9uX3RvX2xhYmVsX29yX3V1aWQoYm9vbCB1dWlk
LCBjb25zdCBVTklDT0RFX1NUUklORyAqZHJpdmVfdW5hbWUsCiAgIEZJTEVfRlNfVk9MVU1F
X0lORk9STUFUSU9OICpmZnZpID0KICAgICByZWludGVycHJldF9jYXN0PEZJTEVfRlNfVk9M
VU1FX0lORk9STUFUSU9OICo+KGlvY3RsX2J1Zik7CiAgIGlmICh1dWlkKQotICAgIHsKLSAg
ICAgIGlmICghZmZ2aS0+Vm9sdW1lU2VyaWFsTnVtYmVyKQotCXJldHVybiBmYWxzZTsKLSAg
ICAgIC8qIFByaW50IHdpdGggc2VwYXJhdG9yIGFzIG9uIExpbnV4LiAqLwotICAgICAgX19z
bWFsbF9zcHJpbnRmIChuYW1lLCAiJTA0eC0lMDR4IiwgZmZ2aS0+Vm9sdW1lU2VyaWFsTnVt
YmVyID4+IDE2LAotCQkgICAgICAgZmZ2aS0+Vm9sdW1lU2VyaWFsTnVtYmVyICYgMHhmZmZm
KTsKLSAgICB9CisgICAgLyogUHJpbnQgd2l0aCBzZXBhcmF0b3IgYXMgb24gTGludXguICov
CisgICAgX19zbWFsbF9zcHJpbnRmIChuYW1lLCAiJTA0eC0lMDR4IiwgZmZ2aS0+Vm9sdW1l
U2VyaWFsTnVtYmVyID4+IDE2LAorCQkgICAgIGZmdmktPlZvbHVtZVNlcmlhbE51bWJlciAm
IDB4ZmZmZik7CiAgIGVsc2UKICAgICB7CiAgICAgICAvKiBMYWJlbCBpcyBub3QgbnVsbCB0
ZXJtaW5hdGVkLiAqLwpAQCAtMzYxLDYgKzM1NywyMCBAQCBieV9pZF9jb21wYXJlX25hbWUg
KGNvbnN0IHZvaWQgKmEsIGNvbnN0IHZvaWQgKmIpCiAgIHJldHVybiBzdHJjbXAgKGFwLT5u
YW1lLCBicC0+bmFtZSk7CiB9CiAKK3N0YXRpYyBpbnQKK2J5X2lkX2NvbXBhcmVfbmFtZV9k
cml2ZV9wYXJ0IChjb25zdCB2b2lkICphLCBjb25zdCB2b2lkICpiKQoreworICBjb25zdCBi
eV9pZF9lbnRyeSAqYXAgPSByZWludGVycHJldF9jYXN0PGNvbnN0IGJ5X2lkX2VudHJ5ICo+
KGEpOworICBjb25zdCBieV9pZF9lbnRyeSAqYnAgPSByZWludGVycHJldF9jYXN0PGNvbnN0
IGJ5X2lkX2VudHJ5ICo+KGIpOworICBpbnQgY21wID0gc3RyY21wIChhcC0+bmFtZSwgYnAt
Pm5hbWUpOworICBpZiAoY21wKQorICAgIHJldHVybiBjbXA7CisgIGNtcCA9IGFwLT5kcml2
ZSAtIGJwLT5kcml2ZTsKKyAgaWYgKGNtcCkKKyAgICByZXR1cm4gY21wOworICByZXR1cm4g
YXAtPnBhcnQgLSBicC0+cGFydDsKK30KKwogc3RhdGljIGJ5X2lkX2VudHJ5ICoKIGJ5X2lk
X3JlYWxsb2MgKGJ5X2lkX2VudHJ5ICpwLCBzaXplX3QgbikKIHsKQEAgLTYxMCw4ICs2MjAs
OSBAQCBnZXRfYnlfaWRfdGFibGUgKGJ5X2lkX2VudHJ5ICogJnRhYmxlLCBmaGFuZGxlcl9k
ZXZfZGlzazo6ZGV2X2Rpc2tfbG9jYXRpb24gbG9jKQogICBpZiAoIXRhYmxlKQogICAgIHJl
dHVybiAoZXJybm9fc2V0ID8gLTEgOiAwKTsKIAotICAvKiBTb3J0IGJ5IG5hbWUgYW5kIHJl
bW92ZSBkdXBsaWNhdGVzLiAqLwotICBxc29ydCAodGFibGUsIHRhYmxlX3NpemUsIHNpemVv
ZiAoKnRhYmxlKSwgYnlfaWRfY29tcGFyZV9uYW1lKTsKKyAgLyogU29ydCBieSB7bmFtZSwg
ZHJpdmUsIHBhcnR9IHRvIGVuc3VyZSBzdGFibGUgc29ydCBvcmRlci4gKi8KKyAgcXNvcnQg
KHRhYmxlLCB0YWJsZV9zaXplLCBzaXplb2YgKCp0YWJsZSksIGJ5X2lkX2NvbXBhcmVfbmFt
ZV9kcml2ZV9wYXJ0KTsKKyAgLyogTWFyayBkdXBsaWNhdGUgbmFtZXMuICovCiAgIGZvciAo
dW5zaWduZWQgaSA9IDA7IGkgPCB0YWJsZV9zaXplOyBpKyspCiAgICAgewogICAgICAgdW5z
aWduZWQgaiA9IGkgKyAxOwpAQCAtNjE5LDEyICs2MzAsMTMgQEAgZ2V0X2J5X2lkX3RhYmxl
IChieV9pZF9lbnRyeSAqICZ0YWJsZSwgZmhhbmRsZXJfZGV2X2Rpc2s6OmRldl9kaXNrX2xv
Y2F0aW9uIGxvYykKIAlqKys7CiAgICAgICBpZiAoaiA9PSBpICsgMSkKIAljb250aW51ZTsK
LSAgICAgIC8qIER1cGxpY2F0ZShzKSBmb3VuZCwgcmVtb3ZlIGFsbCBlbnRyaWVzIHdpdGgg
dGhpcyBuYW1lLiAqLwotICAgICAgZGVidWdfcHJpbnRmICgicmVtb3ZpbmcgZHVwbGljYXRl
cyAlZC0lZDogJyVzJyIsIGksIGogLSAxLCB0YWJsZVtpXS5uYW1lKTsKLSAgICAgIGlmIChq
IDwgdGFibGVfc2l6ZSkKLQltZW1tb3ZlICh0YWJsZSArIGksIHRhYmxlICsgaiwgKHRhYmxl
X3NpemUgLSBqKSAqIHNpemVvZiAoKnRhYmxlKSk7Ci0gICAgICB0YWJsZV9zaXplIC09IGog
LSBpOwotICAgICAgaS0tOworICAgICAgLyogRHVwbGljYXRlKHMpIGZvdW5kLCBhcHBlbmQg
IiNOIiB0byBhbGwgZW50cmllcy4gIFRoaXMgbmV2ZXIKKwkgaW50cm9kdWNlcyBuZXcgZHVw
bGljYXRlcyBiZWNhdXNlICcjJyBuZXZlciBvY2N1cnMgaW4gdGhlCisJIG9yaWdpbmFsIG5h
bWVzLiAqLworICAgICAgZGVidWdfcHJpbnRmICgibWFyayBkdXBsaWNhdGVzICV1LSV1IG9m
ICclcyciLCBpLCBqIC0gMSwgdGFibGVbaV0ubmFtZSk7CisgICAgICBzaXplX3QgbGVuID0g
c3RybGVuICh0YWJsZVtpXS5uYW1lKTsKKyAgICAgIGZvciAodW5zaWduZWQgayA9IGk7IGsg
PCBqOyBrKyspCisJX19zbWFsbF9zcHJpbnRmICh0YWJsZVtrXS5uYW1lICsgbGVuLCAiIyV1
IiwgayAtIGkpOwogICAgIH0KIAogICBkZWJ1Z19wcmludGYgKCJ0YWJsZV9zaXplOiAlZCIs
IHRhYmxlX3NpemUpOwotLSAKMi40Mi4xCgo=
--------------20635E244EE048985D054108--

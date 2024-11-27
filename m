Return-Path: <SRS0=B7qI=SW=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
	by sourceware.org (Postfix) with ESMTPS id 12CA63858C41
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 15:44:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 12CA63858C41
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 12CA63858C41
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732722271; cv=none;
	b=sNEpDqXUOj1i2FaC8AHuBYis02av1KI7FUz2pv0gdKEaJblOn9JjmndZZfVXj0eyIPhPnt2kJEqamy2UTZT/Atp7xR3AII/uir+oNTcvQ/rxR35CXPewrWyq6iH05Y7B1lUewcTW2XzwAaBCCNQblFLmNim5wc92f7GriyuX39k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732722271; c=relaxed/simple;
	bh=n2SUsmRDcd4wP7FFe9MH/hLE1QGQ7PUZhAxKBe6YKH0=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=Li1CVBGfcOi/kQsmn8dPFyLbCBqBVQDw3TcgIX+iSt1DOehPuC01iPuKc5CzU/45hKqv5oA0ddqqhfn5E+n2GRz1uPa3x5jC/kDcmrhYajGv+0ii38qK/GKeDUbf8A/zGBa/OIgWN6W/TmDw48EoanCz9LaRqHoJlh9TTG0n96I=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 12CA63858C41
Received: from fwd76.aul.t-online.de (fwd76.aul.t-online.de [10.223.144.102])
	by mailout02.t-online.de (Postfix) with SMTP id 85FF44F3
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 16:44:27 +0100 (CET)
Received: from [192.168.2.101] ([91.57.241.70]) by fwd76.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tGKDI-0Us9RY0; Wed, 27 Nov 2024 16:44:24 +0100
Subject: Re: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
To: cygwin-patches@cygwin.com
References: <4df78487-fdbd-7b63-d7ab-92377d44b213@t-online.de>
 <Z0RgpZA35z9S-ksG@calimero.vinschen.de>
 <42b59f14-19bf-c7c6-4acc-b5b91921af52@t-online.de>
 <Z0TM0zIpjWHTRpsq@calimero.vinschen.de>
 <5d40600d-8929-ebc4-d417-6e8b3221d09e@t-online.de>
 <Z0XFU636aT986Vtn@calimero.vinschen.de>
 <a4acc9e3-8363-b9af-e92e-b3a865b18d20@t-online.de>
 <Z0cu7Dzbq9RMSmrD@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Reply-To: cygwin-patches@cygwin.com
Message-ID: <36947dfd-fa1b-0845-7017-c4f162926e16@t-online.de>
Date: Wed, 27 Nov 2024 16:44:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <Z0cu7Dzbq9RMSmrD@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------199AD4CC1E25CDBA389C2530"
X-TOI-EXPURGATEID: 150726::1732722264-E17E390D-7C0B3E96/0/0 CLEAN NORMAL
X-TOI-MSGID: 47a1e58c-5160-4a16-b4cd-6d7450ecc491
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_SHORT,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------199AD4CC1E25CDBA389C2530
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> On Nov 27 10:14, Christian Franke wrote:
>> Corinna Vinschen wrote:
>>> On Nov 25 21:20, Christian Franke wrote:
>>>> Corinna Vinschen wrote:
>>>>> - Isn't returning SCHED_FIFO sched_getscheduler() just as wrong?
>>>> Definitly. SCHED_FIFO is a non-preemptive(!) real-time policy. Windows does
>>>> not offer anything like that to userland (AFAIK).
>>>>
>>>> https://man7.org/linux/man-pages/man7/sched.7.html
>>>>
>>>> I wonder whether there was a use case for this emulation when this module
>>>> was introduced in 2001.
>>> Just guessing here, but using one of the RT schedulers was the only way
>>> to enable changing the priority from user space and using SCHED_FIFO was
>>> maybe in error.
>>>
>>>>>      Shouldn't that be SCHED_OTHER, and sched_setscheduler() should check
>>>>>      for that instead?  Cygwin in a real-time scenario sounds a bit
>>>>>      far-fetched...
>>>> Agree.
>>>>
>>>> Note that SCHED_OTHER requires sched_priority == 0, so most of the
>>>> sched_get/set*() priority related code would no longer make sense then.
>>> This is the other problem. Changing this to SCHED_OTHER sounds like
>>> dropping potentially used functionality.  Maybe we should just switch to
>>> SCHED_RR?
>> Yes, it at least would be closer to what windows does. It is still
>> non-preemptive from the point of view of lower priorities. I don't know what
>> the Win32 *_PRIORITY_CLASSes actually do.
> Who does? :}
>
>> As far as I understand the related documentation, a more sophisticated
>> emulation (aka fake) of SCHED_* would be:
>>
>> - Allow to switch between SCHED_OTHER (default) and SCHED_RR with
>> sched_setscheduler().
>>
>> - If SCHED_OTHER is selected, change PRIORITY_CLASS with setpriority() and
>> ignore (or fail on?) attempts to change sched_priority with
>> sched_setparam().
>>
>> - If SCHED_RR is selected, ignore setpriority() and change PRIORITY_CLASS
>> with sched_setparam().
>>
>> Possibly not worth the effort...
> Why not?  It should probably also allow SCHED_FIFO for backward compat,
> since, in a way, it doesn't really matter anyway.  This would be nice
> for 3.6.

OK, I'll try to provide a patch.


> And I think your patch here should go in as is, just with the release
> message in release/3.5.5 so we can cherry-pick it to the 3.5 branch.

Attached. Message moved to 3.5.5 and "Fixes:" changed as suggested.


--------------199AD4CC1E25CDBA389C2530
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-sched_setscheduler-allow-changes-of-the-prior.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-sched_setscheduler-allow-changes-of-the-prior.pa";
 filename*1="tch"

RnJvbSA4NjI2NmI2NzMzNGQ0M2FjNTJhOWI3YWMxZWU4NzlhOGQzNGYwYzYyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBXZWQsIDI3IE5vdiAyMDI0IDE2OjM5OjM3ICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBzY2hlZF9zZXRzY2hlZHVsZXI6IGFsbG93IGNo
YW5nZXMgb2YgdGhlIHByaW9yaXR5CgpCZWhhdmUgbGlrZSBzY2hlZF9zZXRwYXJhbSgpIGlm
IHRoZSByZXF1ZXN0ZWQgcG9saWN5IGlzIGlkZW50aWNhbAp0byB0aGUgZml4ZWQgdmFsdWUg
KFNDSEVEX0ZJRk8pIHJldHVybmVkIGJ5IHNjaGVkX2dldHNjaGVkdWxlcigpLgoKRml4ZXM6
IDlhMDhiMmMwMmVlYSAoIiogc2NoZWQuY2M6IE5ldyBmaWxlLiAgSW1wbGVtZW50IHNjaGVk
Ki4iKQpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJhbmtl
QHQtb25saW5lLmRlPgotLS0KIHdpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjUuNSB8IDMgKysr
CiB3aW5zdXAvY3lnd2luL3NjaGVkLmNjICAgICAgfCA1ICsrKystCiAyIGZpbGVzIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3dpbnN1
cC9jeWd3aW4vcmVsZWFzZS8zLjUuNSBiL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjUuNQpp
bmRleCBkOTFmMmI5MmMuLmQ0MWQxNjhjNiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9y
ZWxlYXNlLzMuNS41CisrKyBiL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjUuNQpAQCAtNDUs
MyArNDUsNiBAQCBGaXhlczoKIAogLSBGaXggc2VnZmF1bHQgaW4gc2lndGltZWR3YWl0KCkg
d2hlbiB1c2luZyB0aW1lb3V0LgogICBBZGRyZXNzZXM6IGh0dHBzOi8vY3lnd2luLmNvbS9w
aXBlcm1haWwvY3lnd2luLzIwMjQtTm92ZW1iZXIvMjU2NzYyLmh0bWwKKworLSBzY2hlZF9z
ZXRzY2hlZHVsZXIoMikgYWxsb3dzIHRvIGNoYW5nZSB0aGUgcHJpb3JpdHkgaWYgdGhlIHBv
bGljeSBpcworICBlcXVhbCB0byB0aGUgdmFsdWUgcmV0dXJuZWQgYnkgc2NoZWRfZ2V0c2No
ZWR1bGVyKDIpLgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zY2hlZC5jYyBiL3dpbnN1
cC9jeWd3aW4vc2NoZWQuY2MKaW5kZXggNzFhMWU4NjhmLi4zMzM3ODZmNDQgMTAwNjQ0Ci0t
LSBhL3dpbnN1cC9jeWd3aW4vc2NoZWQuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9zY2hlZC5j
YwpAQCAtMzk5LDggKzM5OSwxMSBAQCBpbnQKIHNjaGVkX3NldHNjaGVkdWxlciAocGlkX3Qg
cGlkLCBpbnQgcG9saWN5LAogCQkgICAgY29uc3Qgc3RydWN0IHNjaGVkX3BhcmFtICpwYXJh
bSkKIHsKKyAgaWYgKHBvbGljeSA9PSBTQ0hFRF9GSUZPKSAvKiByZXR1cm5lZCBieSBzY2hl
ZF9nZXRzY2hlZHVsZXIuICovCisgICAgcmV0dXJuIHNjaGVkX3NldHBhcmFtIChwaWQsIHBh
cmFtKTsKKwogICAvKiBvbiB3aW4zMiwgeW91IGNhbid0IGNoYW5nZSB0aGUgc2NoZWR1bGVy
LiBEb2ghICovCi0gIHNldF9lcnJubyAoRU5PU1lTKTsKKyAgc2V0X2Vycm5vIChFSU5WQUwp
OwogICByZXR1cm4gLTE7CiB9CiAKLS0gCjIuNDUuMQoK
--------------199AD4CC1E25CDBA389C2530--

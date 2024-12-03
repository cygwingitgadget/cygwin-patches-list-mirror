Return-Path: <SRS0=14y1=S4=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
	by sourceware.org (Postfix) with ESMTPS id F0E0D3858D33
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 14:51:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F0E0D3858D33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F0E0D3858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733237478; cv=none;
	b=fjhX3hESsA3Z2rQ4D1J1KNL/aghv5QMnltP4NFQWGxRROhbx0ykjDukbWEXIbVqdcI7BKSN2pUVKXQIsTLuPESkJKh+oHNn439xfijihUBtSG2y1jZ0LH81Q+7W0rTodpXAiKBeB+cltMxtAs40Kav8oNvzpUMBnq9sxwwPaPaY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733237478; c=relaxed/simple;
	bh=HEg3aMiFWY/dyz1/Cy+gYmHCgrDGMCgVSr4KeU+dqCg=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=MuNG6H+EQbNeOauTStIYQR792je/0GWOJMuzlThHsGGhOTUTvDPzakv8K+xpQibWuIX8QnBSyL72v+P3yEPhDe3hDArKpTLB7PiXRlM3PxmHZquJjHblk6vHHujgJ+/HMruGY1pr7RR+n6m1LmtWRmkCp5pCLyXA8gpvQC2nNno=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F0E0D3858D33
Received: from fwd81.aul.t-online.de (fwd81.aul.t-online.de [10.223.144.107])
	by mailout01.t-online.de (Postfix) with SMTP id 3DF1912C6
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 15:51:16 +0100 (CET)
Received: from [192.168.2.103] ([91.57.250.70]) by fwd81.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tIUF9-3UQaa80; Tue, 3 Dec 2024 15:51:15 +0100
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_OTHER,
 SCHED_FIFO and SCHED_RR
To: cygwin-patches@cygwin.com
References: <eabbcf15-1605-8b77-bf77-ec5fde2d6001@t-online.de>
 <Z03Tik1rbM4sMpKl@calimero.vinschen.de>
 <e79eb78a-c8a1-d2c6-4a8d-9c21415b15e9@t-online.de>
 <8734j6q6qk.fsf@Gerda.invalid>
 <c6f21ed2-679d-4a89-a8a3-b0b1e9d1714f@SystematicSW.ab.ca>
 <80e1716d-d268-e5cd-b9ff-484aa5dcc344@t-online.de>
 <Z08EFs_LTnjKL6xr@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <2049af58-b346-721e-0f2c-7201b2f5e1d1@t-online.de>
Date: Tue, 3 Dec 2024 15:51:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <Z08EFs_LTnjKL6xr@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------F365D19CE08CA0C2A67706E8"
X-TOI-EXPURGATEID: 150726::1733237475-07FE5D18-DDBAEB69/0/0 CLEAN NORMAL
X-TOI-MSGID: 2ae2e838-16ed-4393-961d-b491b29dbad3
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,BODY_8BITS,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------F365D19CE08CA0C2A67706E8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Corinna Vinschen wrote:
> On Dec  3 10:20, Christian Franke wrote:
>> Brian Inglis wrote:
>>> On 2024-12-02 11:28, ASSI wrote:
>>>> Christian Franke writes:
>>>>> +    nice value   sched_priority Windows priority class
>>>>> +     12...19      1....6          IDLE_PRIORITY_CLASS
>>>>> +      4...11      7...12          BELOW_NORMAL_PRIORITY_CLASS
>>>>> +     -4....3     13...18          NORMAL_PRIORITY_CLASS
>>>>> +    -12...-5     19...24          ABOVE_NORMAL_PRIORITY_CLASS
>>>>> +    -13..-19     25...30          HIGH_PRIORITY_CLASS
>>>>> +         -20     31...32          REALTIME_PRIORITY_CLASS
>>>> That mapping looks odd… care to explain why the number of nice values
>>>> and sched_priorities doesn't match up for each priority class? 39
>>>> possible values for one can't match to 32 for the other of course, but
>>>> which ones are skipped and why?
>>> See also miscfuncs.cc which maps nice<->winprio with a 40 entry table,
>>> and cygwin-doc proc(5) or cygwin-ug-net/proc.html which explains the
>>> mapping to scheduler priorities and policies.
>> No *_PRIORITY_CLASS is mentioned in current newlib-cygwin/winsup/doc/*.
>>
>>
>>> Also relevant may be man-pages-posix sched.h(0p), man-pages-linux
>>> sched(7) and proc_pid_stat(5).
>>>
>>> You may also wish to consider whether SCHED_SPORADIC should be somewhat
>>> supported for POSIX compatibility, and SCHED_IDLE, SCHED_BATCH,
>>> SCHED_DEADLINE for Linux compatibility?
>> SCHED_IDLE: Ignore nice value and set IDLE_PRIORITY_CLASS ?
> Would make sense, I guess.

Patch on top of original patch attached.


>
>> SCHED_BATCH: Reduced mapping, e.g. nice=0 -> BELOW_NORMAL_PRIORITY_CLASS ?
> Sounds good.

More complex, topic suggests to do some rework of the nice<->winprio 
mapping functions first.


>
>> SCHED_SPORADIC, SCHED_DEADLINE: ?
> We can't model SCHED_DEADLINE in Windows.
>
>> The current newlib/libc/include/sys/sched.h only defines SCHED_OTHER,
>> SCHED_FIFO, SCHED_RR and SCHED_SPORADIC. The latter is guarded by
>> _POSIX_SPORADIC_SERVER which is only set for RTEMS (#ifdef __rtems__) in
>> features.h.
> SCHED_SPORADIC is a bit of a problem.  It requires extension of the
> sched_param struct with values we're not able to handle.
>
> Also, SCHED_SPORADIC doesn't exist in Linux either, so why bother.

Let's forget these.


--------------F365D19CE08CA0C2A67706E8
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-sched_setscheduler-accept-SCHED_IDLE.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Cygwin-sched_setscheduler-accept-SCHED_IDLE.patch"

RnJvbSAwZmZhMGJlYjJkNGY4NDViOWMzYWM2YTViZTg0MjE0NzE2M2QyNmEyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUdWUsIDMgRGVjIDIwMjQgMTU6NDI6NTAgKzAxMDAK
U3ViamVjdDogW1BBVENIXSBDeWd3aW46IHNjaGVkX3NldHNjaGVkdWxlcjogYWNjZXB0IFND
SEVEX0lETEUKCkFkZCBTQ0hFRF9JRExFIHRvIDxzeXMvc2NoZWQuaD4uICBJZiBTQ0hFRF9J
RExFIGlzIHNlbGVjdGVkLCBwcmVzZXJ2ZQp0aGUgbmljZSB2YWx1ZSBhbmQgc2V0IHRoZSBX
aW5kb3dzIHByaW9yaXR5IHRvIElETEVfUFJJT1JJVFlfQ0xBU1MuCgpTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJhbmtlQHQtb25saW5lLmRlPgotLS0K
IG5ld2xpYi9saWJjL2luY2x1ZGUvc3lzL3NjaGVkLmggfCAgNCArKysrCiB3aW5zdXAvY3ln
d2luL3JlbGVhc2UvMy42LjAgICAgIHwgMTAgKysrKysrLS0tLQogd2luc3VwL2N5Z3dpbi9z
Y2hlZC5jYyAgICAgICAgICB8ICA5ICsrKysrKystLQogMyBmaWxlcyBjaGFuZ2VkLCAxNyBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ld2xpYi9saWJj
L2luY2x1ZGUvc3lzL3NjaGVkLmggYi9uZXdsaWIvbGliYy9pbmNsdWRlL3N5cy9zY2hlZC5o
CmluZGV4IDRhZGI2ZTJkNi4uYzk2MzU1YzI0IDEwMDY0NAotLS0gYS9uZXdsaWIvbGliYy9p
bmNsdWRlL3N5cy9zY2hlZC5oCisrKyBiL25ld2xpYi9saWJjL2luY2x1ZGUvc3lzL3NjaGVk
LmgKQEAgLTQyLDYgKzQyLDEwIEBAIGV4dGVybiAiQyIgewogI2RlZmluZSBTQ0hFRF9TUE9S
QURJQyA0CiAjZW5kaWYKIAorI2lmIF9fR05VX1ZJU0lCTEUKKyNkZWZpbmUgU0NIRURfSURM
RSAgICAgNQorI2VuZGlmCisKIC8qIFNjaGVkdWxpbmcgUGFyYW1ldGVycyAqLwogLyogT3Bl
biBHcm91cCBTcGVjaWZpY2F0aW9ucyBJc3N1ZSA2ICovCiAKZGlmZiAtLWdpdCBhL3dpbnN1
cC9jeWd3aW4vcmVsZWFzZS8zLjYuMCBiL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjYuMApp
bmRleCA5ZTkyNGRhYmIuLjhjYTkxZjBjOSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9y
ZWxlYXNlLzMuNi4wCisrKyBiL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjYuMApAQCAtNTQs
OSArNTQsMTEgQEAgV2hhdCBjaGFuZ2VkOgogICB0byBQT1NJWCBhbmQgTGludXggKGdsaWJj
ID49IDIuMi40KSBiZWhhdmlvci4KIAogLSBzY2hlZF9zZXRzY2hlZHVsZXIoMikgbm93IGVt
dWxhdGVzIGNoYW5nZXMgYmV0d2VlbiBTQ0hFRF9PVEhFUiwKLSAgU0NIRURfRklGTyBhbmQg
U0NIRURfUlIuICBJZiBTQ0hFRF9PVEhFUiBpcyBzZWxlY3RlZCwgdGhlIFdpbmRvd3MKLSAg
cHJpb3JpdHkgaXMgc2V0IGFjY29yZGluZyB0byB0aGUgbmljZSB2YWx1ZS4gIElmIFNDSEVE
X0ZJRk8gb3IKLSAgU0NIRURfUlIgaXMgc2VsZWN0ZWQsIHRoZSBuaWNlIHZhbHVlIGlzIHBy
ZXNlcnZlZCBhbmQgdGhlIFdpbmRvd3MKLSAgcHJpb3JpdHkgaXMgc2V0IGFjY29yZGluZyB0
byB0aGUgcmVhbHRpbWUgcHJpb3JpdHkuCisgIFNDSEVEX0lETEUsIFNDSEVEX0ZJRk8gYW5k
IFNDSEVEX1JSLiAgSWYgU0NIRURfT1RIRVIgaXMgc2VsZWN0ZWQsIHRoZQorICBXaW5kb3dz
IHByaW9yaXR5IGlzIHNldCBhY2NvcmRpbmcgdG8gdGhlIG5pY2UgdmFsdWUuIElmIFNDSEVE
X0lETEUgaXMKKyAgc2VsZWN0ZWQsIHRoZSBuaWNlIHZhbHVlIGlzIHByZXNlcnZlZCBhbmQg
dGhlIFdpbmRvd3MgcHJpb3JpdHkgaXMgc2V0CisgIHRvIElETEVfUFJJT1JJVFlfQ0xBU1Mu
ICBJZiBTQ0hFRF9GSUZPIG9yIFNDSEVEX1JSIGlzIHNlbGVjdGVkLCB0aGUKKyAgbmljZSB2
YWx1ZSBpcyBwcmVzZXJ2ZWQgYW5kIHRoZSBXaW5kb3dzIHByaW9yaXR5IGlzIHNldCBhY2Nv
cmRpbmcgdG8KKyAgdGhlIHJlYWx0aW1lIHByaW9yaXR5LgogICBOb3RlOiBXaW5kb3dzIGRv
ZXMgbm90IG9mZmVyIGFsdGVybmF0aXZlIHNjaGVkdWxpbmcgcG9saWNpZXMgc28KICAgdGhp
cyBjb3VsZCBvbmx5IGVtdWxhdGUgQVBJIGJlaGF2aW9yLgpkaWZmIC0tZ2l0IGEvd2luc3Vw
L2N5Z3dpbi9zY2hlZC5jYyBiL3dpbnN1cC9jeWd3aW4vc2NoZWQuY2MKaW5kZXggYzQ4YzQz
M2Q3Li44YjRlN2VmYzQgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vc2NoZWQuY2MKKysr
IGIvd2luc3VwL2N5Z3dpbi9zY2hlZC5jYwpAQCAtMzQsNiArMzQsNyBAQCBzY2hlZF9nZXRf
cHJpb3JpdHlfbWF4IChpbnQgcG9saWN5KQogICBzd2l0Y2ggKHBvbGljeSkKICAgICB7CiAg
ICAgY2FzZSBTQ0hFRF9PVEhFUjoKKyAgICBjYXNlIFNDSEVEX0lETEU6CiAgICAgICByZXR1
cm4gMDsKICAgICBjYXNlIFNDSEVEX0ZJRk86CiAgICAgY2FzZSBTQ0hFRF9SUjoKQEAgLTUw
LDYgKzUxLDcgQEAgc2NoZWRfZ2V0X3ByaW9yaXR5X21pbiAoaW50IHBvbGljeSkKICAgc3dp
dGNoIChwb2xpY3kpCiAgICAgewogICAgIGNhc2UgU0NIRURfT1RIRVI6CisgICAgY2FzZSBT
Q0hFRF9JRExFOgogICAgICAgcmV0dXJuIDA7CiAgICAgY2FzZSBTQ0hFRF9GSUZPOgogICAg
IGNhc2UgU0NIRURfUlI6CkBAIC05Myw3ICs5NSw3IEBAIHNjaGVkX2dldHBhcmFtIChwaWRf
dCBwaWQsIHN0cnVjdCBzY2hlZF9wYXJhbSAqcGFyYW0pCiAgICAgICByZXR1cm4gLTE7CiAg
ICAgfQogCi0gIGlmIChwLT5zY2hlZF9wb2xpY3kgPT0gU0NIRURfT1RIRVIpCisgIGlmIChw
LT5zY2hlZF9wb2xpY3kgPT0gU0NIRURfT1RIRVIgfHwgcC0+c2NoZWRfcG9saWN5ID09IFND
SEVEX0lETEUpCiAgICAgewogICAgICAgLyogTm8gcmVhbHRpbWUgcG9saWN5LiAqLwogICAg
ICAgcGFyYW0tPnNjaGVkX3ByaW9yaXR5ID0gMDsKQEAgLTIzNSw2ICsyMzcsOSBAQCBzY2hl
ZF9zZXRwYXJhbV9waW5mbyAocGluZm8gJiBwLCBjb25zdCBzdHJ1Y3Qgc2NoZWRfcGFyYW0g
KnBhcmFtKQogICBpZiAocC0+c2NoZWRfcG9saWN5ID09IFNDSEVEX09USEVSICYmIHByaSA9
PSAwKQogICAgIC8qIE5vIHJlYWx0aW1lIHBvbGljeSwgcmVhcHBseSB0aGUgbmljZSB2YWx1
ZS4gKi8KICAgICBwY2xhc3MgPSBuaWNlX3RvX3dpbnByaW8gKHAtPm5pY2UpOworICBlbHNl
IGlmIChwLT5zY2hlZF9wb2xpY3kgPT0gU0NIRURfSURMRSAmJiBwcmkgPT0gMCkKKyAgICAv
KiBJZGxlIHBvbGljeSwgaWdub3JlIHRoZSBuaWNlIHZhbHVlLiAqLworICAgIHBjbGFzcyA9
IElETEVfUFJJT1JJVFlfQ0xBU1M7CiAgIGVsc2UgaWYgKDEgPD0gcHJpICYmIHByaSA8PSA2
KQogICAgIHBjbGFzcyA9IElETEVfUFJJT1JJVFlfQ0xBU1M7CiAgIGVsc2UgaWYgKHByaSA8
PSAxMikKQEAgLTQxNyw3ICs0MjIsNyBAQCBzY2hlZF9zZXRzY2hlZHVsZXIgKHBpZF90IHBp
ZCwgaW50IHBvbGljeSwKIAkJICAgIGNvbnN0IHN0cnVjdCBzY2hlZF9wYXJhbSAqcGFyYW0p
CiB7CiAgIGlmICghKHBpZCA+PSAwICYmIHBhcmFtICYmCi0gICAgICAoKHBvbGljeSA9PSBT
Q0hFRF9PVEhFUiAmJiBwYXJhbS0+c2NoZWRfcHJpb3JpdHkgPT0gMCkgfHwKKyAgICAgICgo
KHBvbGljeSA9PSBTQ0hFRF9PVEhFUiB8fCBwb2xpY3kgPT0gU0NIRURfSURMRSkgJiYgcGFy
YW0tPnNjaGVkX3ByaW9yaXR5ID09IDApIHx8CiAgICAgICAoKHBvbGljeSA9PSBTQ0hFRF9G
SUZPIHx8IHBvbGljeSA9PSBTQ0hFRF9SUikgJiYgdmFsaWRfc2NoZWRfcGFyYW1ldGVycyhw
YXJhbSkpKSkpCiAgICAgewogICAgICAgc2V0X2Vycm5vIChFSU5WQUwpOwotLSAKMi40NS4x
Cgo=
--------------F365D19CE08CA0C2A67706E8--

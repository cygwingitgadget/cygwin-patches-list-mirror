Return-Path: <SRS0=arxq=IZ=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
	by sourceware.org (Postfix) with ESMTPS id 47CB13858C41
	for <cygwin-patches@cygwin.com>; Mon, 15 Jan 2024 12:41:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 47CB13858C41
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 47CB13858C41
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1705322469; cv=none;
	b=l5zPKGLFH96FWI3rpU1Cjk6tiXXuBbCcKrnT/be/3GSnNsIJzGAOcj55aTdH7BHV+o4yVlCjM/PZxfF5m0ZHOy1eZ5KT9zrlmRcp7KGZNRzQ0eL3BC0qe1c5KSmQfw85I6URQavYpDnHMRd3tQgzvcxgjfSpESjq/RWy5XxvxrY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1705322469; c=relaxed/simple;
	bh=vVnMtgtI+XfPBZ9g5qZ6cyYIouF0S1iz34AlNsuH0uE=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=UecgY44kheX7d1EgKYIGP7l1FPnKu4itNX+64YQaPLuHoBDY6l8nESb32zuuE4rfRGUeAxXLLzVwRbAd99+9ZxWNd8h/wecXPPLpo4NCNaq28BYFWM3bCMLWP805RtbsrEOd5oM7f1rsTeIk/giE8FoZ8YqyRR6QVoa+fnw1V8I=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd71.aul.t-online.de (fwd71.aul.t-online.de [10.223.144.97])
	by mailout04.t-online.de (Postfix) with SMTP id 1899C16D2E
	for <cygwin-patches@cygwin.com>; Mon, 15 Jan 2024 13:41:06 +0100 (CET)
Received: from [192.168.2.104] ([79.230.174.55]) by fwd71.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1rPMH3-4O2apc0; Mon, 15 Jan 2024 13:41:05 +0100
Subject: Re: [PATCH] Cygwin: introduce close_range
To: cygwin-patches@cygwin.com
References: <83cfd6b3-6824-fd9f-794b-7fc428f8c80d@t-online.de>
 <3ab13e94-fd3a-41c8-8392-fcd72042d0e9@dronecode.org.uk>
 <6b1723b1-12b1-a240-ff22-1f0f5ba73214@t-online.de>
 <2443ab23-4c2f-bf99-c38e-8410e642fe1f@t-online.de>
 <ZaUMpz2oUXpokdAk@calimero.vinschen.de>
 <7e7efac7-95fe-6d2c-db78-6dd892f93030@t-online.de>
 <ZaUgFoxmOliv6Cok@calimero.vinschen.de>
 <ZaUgT0rfS8syRRyP@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <e656f83b-52df-4054-b746-6a38b99b7b16@t-online.de>
Date: Mon, 15 Jan 2024 13:41:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZaUgT0rfS8syRRyP@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------9D2AE67DCA6DF62013D7C88B"
X-TOI-EXPURGATEID: 150726::1705322465-CCFF6957-0A59C6F6/0/0 CLEAN NORMAL
X-TOI-MSGID: 8204f384-6713-4ae0-a1f0-f502957d73fd
X-Spam-Status: No, score=-13.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------9D2AE67DCA6DF62013D7C88B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> On Jan 15 13:07, Corinna Vinschen wrote:
>> Sorry Christian, but..
>>
>> I was just going to push this patch when I realized that we now have
>> two lines of debug output per affected file descriptor:
>>
>> On Jan 15 12:19, Christian Franke wrote:
>>> +  for (unsigned int i = firstfd; i < size; i++)
>>> +    {
>>> +      cygheap_fdget cfd ((int) i, false, false);
>>> +      if (cfd < 0)
>>> +	continue;
>>> +
>>> +      if (flags & CLOSE_RANGE_CLOEXEC)
>>> +	{
>>> +	  syscall_printf ("set FD_CLOEXEC on fd %u", i);
>>> +	  cfd->fcntl (F_SETFD, FD_CLOEXEC);
>> fhandler::set_close_on_exec() already prints this:
>>
>>    debug_printf ("set close_on_exec for %s to %d", get_name (), val);
>>
>>> +	}
>>> +      else
>>> +	{
>>> +	  syscall_printf ("closing fd %u", i);
>>> +	  cfd->close_with_arch ();
>> fhandler::close() already prints this:
>>
>>    syscall_printf ("closing '%s' handle %p", get_name (), get_handle ());

I've also seen this duplication, but the drawback of the above messages 
is that the FD itself is not printed. So I decided to keep the 
syscall_printf().


>>
>> Shan't we drop the syscall calls from close_range()?
>                       ^^^^^^^
>                     syscall_printf

Attached.


--------------9D2AE67DCA6DF62013D7C88B
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-introduce-close_range-2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Cygwin-introduce-close_range-2.patch"

RnJvbSBjYTk3YmIzMDIxMGQzYzkwYWU5NGY1ZmYyOWRkZDc1YTEyYThhOGIxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBNb24sIDE1IEphbiAyMDI0IDEzOjM2OjMwICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBpbnRyb2R1Y2UgY2xvc2VfcmFuZ2UoMikKClRo
aXMgZnVuY3Rpb24gY2xvc2VzIG9yIHNldHMgdGhlIGNsb3NlLW9uLWV4ZWMgZmxhZyBmb3Ig
YSBzcGVjaWZpZWQKcmFuZ2Ugb2YgZmlsZSBkZXNjcmlwdG9ycy4gIEl0IGlzIGF2YWlsYWJs
ZSBvbiBGcmVlQlNEIGFuZCBMaW51eC4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBGcmFu
a2UgPGNocmlzdGlhbi5mcmFua2VAdC1vbmxpbmUuZGU+Ci0tLQogbmV3bGliL2xpYmMvaW5j
bHVkZS9zeXMvdW5pc3RkLmggICAgICAgfCAgNiArKysrCiB3aW5zdXAvY3lnd2luL2N5Z3dp
bi5kaW4gICAgICAgICAgICAgICB8ICAxICsKIHdpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3
aW4vdmVyc2lvbi5oIHwgIDMgKy0KIHdpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjUuMCAgICAg
ICAgICAgIHwgIDIgKysKIHdpbnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MgICAgICAgICAgICAg
IHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysKIHdpbnN1cC9kb2MvbmV3LWZlYXR1
cmVzLnhtbCAgICAgICAgICAgIHwgIDQgKysrCiB3aW5zdXAvZG9jL3Bvc2l4LnhtbCAgICAg
ICAgICAgICAgICAgICB8ICA1ICsrKysKIDcgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL25ld2xpYi9saWJjL2luY2x1ZGUv
c3lzL3VuaXN0ZC5oIGIvbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvdW5pc3RkLmgKaW5kZXgg
MjU1MzIyNTFjLi4wMDkwMTU0MGYgMTAwNjQ0Ci0tLSBhL25ld2xpYi9saWJjL2luY2x1ZGUv
c3lzL3VuaXN0ZC5oCisrKyBiL25ld2xpYi9saWJjL2luY2x1ZGUvc3lzL3VuaXN0ZC5oCkBA
IC0yNiw2ICsyNiwxMiBAQCBpbnQgICAgIGNob3duIChjb25zdCBjaGFyICpfX3BhdGgsIHVp
ZF90IF9fb3duZXIsIGdpZF90IF9fZ3JvdXApOwogaW50ICAgICBjaHJvb3QgKGNvbnN0IGNo
YXIgKl9fcGF0aCk7CiAjZW5kaWYKIGludCAgICAgY2xvc2UgKGludCBfX2ZpbGRlcyk7Cisj
aWYgZGVmaW5lZChfX0NZR1dJTl9fKSAmJiAoX19CU0RfVklTSUJMRSB8fCBfX0dOVV9WSVNJ
QkxFKQorLyogQXZhaWxhYmxlIG9uIEZyZWVCU0QgKF9fQlNEX1ZJU0lCTEUpIGFuZCBMaW51
eCAoX19HTlVfVklTSUJMRSkuICovCitpbnQgICAgIGNsb3NlX3JhbmdlICh1bnNpZ25lZCBp
bnQgX19maXJzdGZkLCB1bnNpZ25lZCBpbnQgX19sYXN0ZmQsIGludCBfX2ZsYWdzKTsKKy8q
ICAgICAgQ0xPU0VfUkFOR0VfVU5TSEFSRSAoMSA8PCAxKSAqLyAvKiBMaW51eC1zcGVjaWZp
Yywgbm90IHN1cHBvcnRlZC4gKi8KKyNkZWZpbmUgQ0xPU0VfUkFOR0VfQ0xPRVhFQyAoMSA8
PCAyKQorI2VuZGlmCiAjaWYgX19QT1NJWF9WSVNJQkxFID49IDE5OTIwOQogc2l6ZV90CWNv
bmZzdHIgKGludCBfX25hbWUsIGNoYXIgKl9fYnVmLCBzaXplX3QgX19sZW4pOwogI2VuZGlm
CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2N5Z3dpbi5kaW4gYi93aW5zdXAvY3lnd2lu
L2N5Z3dpbi5kaW4KaW5kZXggOWI3NmNlNjdhLi45ZTM1NGFjYzYgMTAwNjQ0Ci0tLSBhL3dp
bnN1cC9jeWd3aW4vY3lnd2luLmRpbgorKysgYi93aW5zdXAvY3lnd2luL2N5Z3dpbi5kaW4K
QEAgLTM0Nyw2ICszNDcsNyBAQCBjbG9nMTBsIE5PU0lHRkUKIGNsb2dmIE5PU0lHRkUKIGNs
b2dsIE5PU0lHRkUKIGNsb3NlIFNJR0ZFCitjbG9zZV9yYW5nZSBTSUdGRQogY2xvc2VkaXIg
U0lHRkUKIGNsb3NlbG9nIFNJR0ZFCiBjbmRfYnJvYWRjYXN0IFNJR0ZFCmRpZmYgLS1naXQg
YS93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3ZlcnNpb24uaCBiL3dpbnN1cC9jeWd3
aW4vaW5jbHVkZS9jeWd3aW4vdmVyc2lvbi5oCmluZGV4IGM4MTc3YzJiMS4uMzAzNjg3OGM0
IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3ZlcnNpb24uaAor
KysgYi93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3ZlcnNpb24uaApAQCAtNDg0LDEy
ICs0ODQsMTMgQEAgZGV0YWlscy4gKi8KICAgMzQ3OiBBZGQgYzE2cnRvbWIsIGMzMnJ0b21i
LCBtYnJ0b2MxNiwgbWJydG9jMzIuCiAgIDM0ODogQWRkIGM4cnRvbWIsIG1icnRvYy4KICAg
MzQ5OiBBZGQgZmFsbG9jYXRlLgorICAzNTA6IEFkZCBjbG9zZV9yYW5nZS4KIAogICBOb3Rl
IHRoYXQgd2UgZm9yZ290IHRvIGJ1bXAgdGhlIGFwaSBmb3IgdWFsYXJtLCBzdHJ0b2xsLCBz
dHJ0b3VsbCwKICAgc2lnYWx0c3RhY2ssIHNldGhvc3RuYW1lLiAqLwogCiAjZGVmaW5lIENZ
R1dJTl9WRVJTSU9OX0FQSV9NQUpPUiAwCi0jZGVmaW5lIENZR1dJTl9WRVJTSU9OX0FQSV9N
SU5PUiAzNDkKKyNkZWZpbmUgQ1lHV0lOX1ZFUlNJT05fQVBJX01JTk9SIDM1MAogCiAvKiBU
aGVyZSBpcyBhbHNvIGEgY29tcGF0aWJpdHkgdmVyc2lvbiBudW1iZXIgYXNzb2NpYXRlZCB3
aXRoIHRoZSBzaGFyZWQgbWVtb3J5CiAgICByZWdpb25zLiAgSXQgaXMgaW5jcmVtZW50ZWQg
d2hlbiBpbmNvbXBhdGlibGUgY2hhbmdlcyBhcmUgbWFkZSB0byB0aGUgc2hhcmVkCmRpZmYg
LS1naXQgYS93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy41LjAgYi93aW5zdXAvY3lnd2luL3Jl
bGVhc2UvMy41LjAKaW5kZXggZDBhNmMyZmM4Li42MjA5MDY0YTYgMTAwNjQ0Ci0tLSBhL3dp
bnN1cC9jeWd3aW4vcmVsZWFzZS8zLjUuMAorKysgYi93aW5zdXAvY3lnd2luL3JlbGVhc2Uv
My41LjAKQEAgLTQzLDYgKzQzLDggQEAgV2hhdCdzIG5ldzoKIAogLSBOZXcgQVBJIGNhbGxz
OiBjOHJ0b21iLCBjMTZydG9tYiwgYzMycnRvbWIsIG1icnRvYzgsIG1icnRvYzE2LCBtYnJ0
b2MzMi4KIAorLSBOZXcgQVBJIGNhbGw6IGNsb3NlX3JhbmdlIChhdmFpbGFibGUgb24gRnJl
ZUJTRCBhbmQgTGludXgpLgorCiAtIE5ldyBBUEkgY2FsbDogZmFsbG9jYXRlIChMaW51eC1z
cGVjaWZpYykuCiAKIC0gSW1wbGVtZW50IE9TUy1iYXNlZCBzb3VuZCBtaXhlciBkZXZpY2Ug
KC9kZXYvbWl4ZXIpLgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYyBi
L3dpbnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MKaW5kZXggNDg2ZGIxZGI2Li5lYjA0MDY3ZmQg
MTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MKKysrIGIvd2luc3VwL2N5
Z3dpbi9zeXNjYWxscy5jYwpAQCAtODUsNiArODUsNDQgQEAgY2xvc2VfYWxsX2ZpbGVzIChi
b29sIG5vcmVsZWFzZSkKICAgY3lnaGVhcC0+ZmR0YWIudW5sb2NrICgpOwogfQogCisvKiBD
bG9zZSBvciBzZXQgdGhlIGNsb3NlLW9uLWV4ZWMgZmxhZyBmb3IgYWxsIG9wZW4gZmlsZSBk
ZXNjcmlwdG9ycworICAgZnJvbSBmaXJzdGZkIHRvIGxhc3RmZC4gIENMT1NFX1JBTkdFX1VO
U0hBUkUgaXMgbm90IHN1cHBvcnRlZC4KKyAgIEF2YWlsYWJsZSBvbiBGcmVlQlNEIHNpbmNl
IDEzIGFuZCBMaW51eCBzaW5jZSA1LjkgKi8KK2V4dGVybiAiQyIgaW50CitjbG9zZV9yYW5n
ZSAodW5zaWduZWQgaW50IGZpcnN0ZmQsIHVuc2lnbmVkIGludCBsYXN0ZmQsIGludCBmbGFn
cykKK3sKKyAgcHRocmVhZF90ZXN0Y2FuY2VsICgpOworCisgIGlmICghKGZpcnN0ZmQgPD0g
bGFzdGZkICYmICEoZmxhZ3MgJiB+Q0xPU0VfUkFOR0VfQ0xPRVhFQykpKQorICAgIHsKKyAg
ICAgIHNldF9lcnJubyAoRUlOVkFMKTsKKyAgICAgIHJldHVybiAtMTsKKyAgICB9CisKKyAg
Y3lnaGVhcC0+ZmR0YWIubG9jayAoKTsKKworICB1bnNpZ25lZCBpbnQgc2l6ZSA9IChsYXN0
ZmQgPCBjeWdoZWFwLT5mZHRhYi5zaXplID8gbGFzdGZkICsgMSA6CisJCSAgICAgIGN5Z2hl
YXAtPmZkdGFiLnNpemUpOworCisgIGZvciAodW5zaWduZWQgaW50IGkgPSBmaXJzdGZkOyBp
IDwgc2l6ZTsgaSsrKQorICAgIHsKKyAgICAgIGN5Z2hlYXBfZmRnZXQgY2ZkICgoaW50KSBp
LCBmYWxzZSwgZmFsc2UpOworICAgICAgaWYgKGNmZCA8IDApCisJY29udGludWU7CisKKyAg
ICAgIGlmIChmbGFncyAmIENMT1NFX1JBTkdFX0NMT0VYRUMpCisJY2ZkLT5mY250bCAoRl9T
RVRGRCwgRkRfQ0xPRVhFQyk7CisgICAgICBlbHNlCisJeworCSAgY2ZkLT5jbG9zZV93aXRo
X2FyY2ggKCk7CisJICBjZmQucmVsZWFzZSAoKTsKKwl9CisgICAgfQorCisgIGN5Z2hlYXAt
PmZkdGFiLnVubG9jayAoKTsKKyAgcmV0dXJuIDA7Cit9CisKIGV4dGVybiAiQyIgaW50CiBk
dXAgKGludCBmZCkKIHsKZGlmZiAtLWdpdCBhL3dpbnN1cC9kb2MvbmV3LWZlYXR1cmVzLnht
bCBiL3dpbnN1cC9kb2MvbmV3LWZlYXR1cmVzLnhtbAppbmRleCA2YWU0MjAwMzEuLjBhYmUx
YzQxYyAxMDA2NDQKLS0tIGEvd2luc3VwL2RvYy9uZXctZmVhdHVyZXMueG1sCisrKyBiL3dp
bnN1cC9kb2MvbmV3LWZlYXR1cmVzLnhtbApAQCAtNzQsNiArNzQsMTAgQEAgcG9zaXhfc3Bh
d25fZmlsZV9hY3Rpb25zX2FkZGZjaGRpcl9ucC4KIE5ldyBBUEkgY2FsbHM6IGM4cnRvbWIs
IGMxNnJ0b21iLCBjMzJydG9tYiwgbWJydG9jOCwgbWJydG9jMTYsIG1icnRvYzMyLgogPC9w
YXJhPjwvbGlzdGl0ZW0+CiAKKzxsaXN0aXRlbT48cGFyYT4KK05ldyBBUEkgY2FsbDogY2xv
c2VfcmFuZ2UgKGF2YWlsYWJsZSBvbiBGcmVlQlNEIGFuZCBMaW51eCkuCis8L3BhcmE+PC9s
aXN0aXRlbT4KKwogPGxpc3RpdGVtPjxwYXJhPgogTmV3IEFQSSBjYWxsOiBmYWxsb2NhdGUg
KExpbnV4LXNwZWNpZmljKS4KIDwvcGFyYT48L2xpc3RpdGVtPgpkaWZmIC0tZ2l0IGEvd2lu
c3VwL2RvYy9wb3NpeC54bWwgYi93aW5zdXAvZG9jL3Bvc2l4LnhtbAppbmRleCAxYTRlZWUx
YWIuLjg5MDU2OTE1YiAxMDA2NDQKLS0tIGEvd2luc3VwL2RvYy9wb3NpeC54bWwKKysrIGIv
d2luc3VwL2RvYy9wb3NpeC54bWwKQEAgLTExNDMsNiArMTE0Myw3IEBAIGFsc28gSUVFRSBT
dGQgMTAwMy4xLTIwMTcgKFBPU0lYLjEtMjAxNykuPC9wYXJhPgogICAgIGNmbWFrZXJhdwog
ICAgIGNmc2V0c3BlZWQKICAgICBjbGVhcmVycl91bmxvY2tlZAorICAgIGNsb3NlX3Jhbmdl
CiAgICAgZGFlbW9uCiAgICAgZG5fY29tcAogICAgIGRuX2V4cGFuZApAQCAtMTI5Nyw2ICsx
Mjk4LDcgQEAgYWxzbyBJRUVFIFN0ZCAxMDAzLjEtMjAxNyAoUE9TSVguMS0yMDE3KS48L3Bh
cmE+CiAgICAgY2xvZzEwCiAgICAgY2xvZzEwZgogICAgIGNsb2cxMGwKKyAgICBjbG9zZV9y
YW5nZQkJCShzZWUgPHhyZWYgbGlua2VuZD0ic3RkLW5vdGVzIj5jaGFwdGVyICJJbXBsZW1l
bnRhdGlvbiBOb3RlcyI8L3hyZWY+KQogICAgIGNyeXB0X3IJCQkoYXZhaWxhYmxlIGluIGV4
dGVybmFsICJjcnlwdCIgbGlicmFyeSkKICAgICBkbGFkZHIJCQkoc2VlIDx4cmVmIGxpbmtl
bmQ9InN0ZC1ub3RlcyI+Y2hhcHRlciAiSW1wbGVtZW50YXRpb24gTm90ZXMiPC94cmVmPikK
ICAgICBkcmVtZgpAQCAtMTY1Niw2ICsxNjU4LDkgQEAgQ0xPQ0tfUkVBTFRJTUUgYW5kIENM
T0NLX01PTk9UT05JQy4gIDxmdW5jdGlvbj5jbG9ja19zZXRyZXM8L2Z1bmN0aW9uPiwKIDxm
dW5jdGlvbj5jbG9ja19zZXR0aW1lPC9mdW5jdGlvbj4sIGFuZCA8ZnVuY3Rpb24+dGltZXJf
Y3JlYXRlPC9mdW5jdGlvbj4KIGN1cnJlbnRseSBzdXBwb3J0IG9ubHkgQ0xPQ0tfUkVBTFRJ
TUUuPC9wYXJhPgogCis8cGFyYT48ZnVuY3Rpb24+Y2xvc2VfcmFuZ2U8L2Z1bmN0aW9uPiBk
b2VzIG5vdCBzdXBwb3J0IHRoZSBMaW51eC1zcGVjaWZpYworZmxhZyBDTE9TRV9SQU5HRV9V
TlNIQVJFLjwvcGFyYT4KKwogPHBhcmE+UE9TSVggZmlsZSBsb2NrcyB2aWEgPGZ1bmN0aW9u
PmZjbnRsPC9mdW5jdGlvbj4gb3IKIDxmdW5jdGlvbj5sb2NrZjwvZnVuY3Rpb24+LCBhcyB3
ZWxsIGFzIEJTRCA8ZnVuY3Rpb24+ZmxvY2s8L2Z1bmN0aW9uPiBsb2NrcwogYXJlIGFkdmlz
b3J5IGxvY2tzLiAgVGhleSBkb24ndCBpbnRlcmFjdCB3aXRoIFdpbmRvd3MgbWFuZGF0b3J5
IGxvY2tzLCBub3IKLS0gCjIuNDIuMQoK
--------------9D2AE67DCA6DF62013D7C88B--

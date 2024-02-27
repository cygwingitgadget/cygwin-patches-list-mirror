Return-Path: <SRS0=seNy=KE=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
	by sourceware.org (Postfix) with ESMTPS id A4AE33858D20
	for <cygwin-patches@cygwin.com>; Tue, 27 Feb 2024 16:28:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A4AE33858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A4AE33858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709051306; cv=none;
	b=G0EUTYzK3wASD07wkcvJkZZ4YoRdVKOqZHOaMdpNzGjBoD/rsNb/TrNXAY/+kWpD1BU3MUDljw8sA65cOcksvQd9FuAPZO8xojyIneo4hP10er4imaYr4btCI2xx6Y20Z807mMkO2D58ZO0ZyU8tVKBTuVZ3XCr4+kAs3Xsmi0I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709051306; c=relaxed/simple;
	bh=pvHxVwfItG9MMOxhxeK1gjbuPvz62zFdogRkZU0A2Js=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=umozrtE2IiOx63GsQQW5RsgFvHJZ+5PgzlcZf8eMJEN1EVYiT0jv/Bf0Hu5vu8IuXo8F4V+vzeAzlfTDNzoswWrcckQXQyr70PKLjwYvzjw5Zg0KvjjxptcMoQrsxnKYTjrYIDNMow47YqIlDzhdOuwXD0pegcLA0acDQFHkWdI=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd87.aul.t-online.de (fwd87.aul.t-online.de [10.223.144.113])
	by mailout08.t-online.de (Postfix) with SMTP id 73A285DC3
	for <cygwin-patches@cygwin.com>; Tue, 27 Feb 2024 17:26:36 +0100 (CET)
Received: from [192.168.2.102] ([87.187.47.57]) by fwd87.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1rf0Ho-217Fg00; Tue, 27 Feb 2024 17:26:32 +0100
Subject: Re: [PATCH 2/2] Cygwin: remove ENOSHARE and ECASECLASH from
 _sys_errlist[]
To: cygwin-patches@cygwin.com
References: <f0c37daf-4086-d5b9-9812-8b15916ad987@t-online.de>
 <ede12d4d-3401-5d68-cfd1-f3aafa6a3394@t-online.de>
 <Zd3457LfikTibhEm@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <584bf6ac-4954-7075-8712-801d4bbda41d@t-online.de>
Date: Tue, 27 Feb 2024 17:26:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <Zd3457LfikTibhEm@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------60C0B7C8E236DAAF72FE4878"
X-TOI-EXPURGATEID: 150726::1709051192-867FB968-ACB96854/0/0 CLEAN NORMAL
X-TOI-MSGID: c31433a3-28d5-4be3-9357-db2d805dbd13
X-Spam-Status: No, score=-12.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------60C0B7C8E236DAAF72FE4878
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Corinna,

Corinna Vinschen wrote:
> On Feb 27 13:18, Christian Franke wrote:
>> ...
>>
>> diff --git a/winsup/cygwin/errno.cc b/winsup/cygwin/errno.cc
>> index 7d58e62ec..d8c057e51 100644
>> --- a/winsup/cygwin/errno.cc
>> +++ b/winsup/cygwin/errno.cc
>> @@ -167,8 +167,8 @@ const char *_sys_errlist[] =
>>   /* ESTALE 133 */	  "Stale NFS file handle",
>>   /* ENOTSUP 134 */	  "Not supported",
>>   /* ENOMEDIUM 135 */	  "No medium found",
>> -/* ENOSHARE 136 */	  "No such host or network path",
>> -/* ECASECLASH 137 */	  "Filename exists with different case",
>> +			  NULL, /* Was ENOSHARE 136, no longer used. */
>> +			  NULL, /* Was ECASECLASH 137, no longer used. */
> In terms of politenness, wouldn't it be better to define them as
> empty strings?  This may be one crash less in already existing
> binaries...

Indeed, I missed that case. Patch attached.

Christian


--------------60C0B7C8E236DAAF72FE4878
Content-Type: text/plain; charset=UTF-8;
 name="0002-Cygwin-set-ENOSHARE-and-ECASECLASH-_sys_errlist-entr.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0002-Cygwin-set-ENOSHARE-and-ECASECLASH-_sys_errlist-entr.pa";
 filename*1="tch"

RnJvbSAxNTFkYTRlZjc2Zjg0Y2QwMzQzZTZmNDlhYTIzZGUzOThjYTczZDFjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUdWUsIDI3IEZlYiAyMDI0IDE3OjIxOjQ1ICswMTAw
ClN1YmplY3Q6IFtQQVRDSCAyLzJdIEN5Z3dpbjogc2V0IEVOT1NIQVJFIGFuZCBFQ0FTRUNM
QVNIIF9zeXNfZXJybGlzdFtdCiBlbnRyaWVzIHRvIGVtcHR5CgpUaGVzZSBlcnJubyB2YWx1
ZXMgYXJlIG5vIGxvbmdlciB1c2VkIGJ5IEN5Z3dpbi4gIENoYW5nZSB0aGUgZW50cmllcwp0
byBlbXB0eSBzdHJpbmdzIGluc3RlYWQgb2YgTlVMTCB0byBhdm9pZCBjcmFzaGVzIGluIGV4
aXN0aW5nCmJpbmFyaWVzIGRpcmVjdGx5IGFjY2Vzc2luZyB0aGUgdGFibGUuICBFbmhhbmNl
IHN0cmVycm9yX3dvcmtlcigpCnN1Y2ggdGhhdCBlbXB0eSBzdHJpbmdzIGFsc28gcmVzdWx0
IGluICJVbmtub3duIGVycm9yIC4uLiIgbWVzc2FnZXMuCkFsc28gYWRkIGEgc3RhdGljX2Fz
c2VydCBjaGVjayBmb3IgdGhlIF9zeXNfZXJybGlzdFtdIHNpemUuCgpTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJhbmtlQHQtb25saW5lLmRlPgotLS0K
IHdpbnN1cC9jeWd3aW4vZXJybm8uY2MgfCAxMiArKysrKysrKystLS0KIDEgZmlsZSBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2lu
c3VwL2N5Z3dpbi9lcnJuby5jYyBiL3dpbnN1cC9jeWd3aW4vZXJybm8uY2MKaW5kZXggN2Q1
OGU2MmVjLi4wMDRhNDAyMWUgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vZXJybm8uY2MK
KysrIGIvd2luc3VwL2N5Z3dpbi9lcnJuby5jYwpAQCAtMTY3LDggKzE2Nyw4IEBAIGNvbnN0
IGNoYXIgKl9zeXNfZXJybGlzdFtdID0KIC8qIEVTVEFMRSAxMzMgKi8JICAiU3RhbGUgTkZT
IGZpbGUgaGFuZGxlIiwKIC8qIEVOT1RTVVAgMTM0ICovCSAgIk5vdCBzdXBwb3J0ZWQiLAog
LyogRU5PTUVESVVNIDEzNSAqLwkgICJObyBtZWRpdW0gZm91bmQiLAotLyogRU5PU0hBUkUg
MTM2ICovCSAgIk5vIHN1Y2ggaG9zdCBvciBuZXR3b3JrIHBhdGgiLAotLyogRUNBU0VDTEFT
SCAxMzcgKi8JICAiRmlsZW5hbWUgZXhpc3RzIHdpdGggZGlmZmVyZW50IGNhc2UiLAorCQkJ
ICAiIiwgLyogV2FzIEVOT1NIQVJFIDEzNiwgbm8gbG9uZ2VyIHVzZWQuICovCisJCQkgICIi
LCAvKiBXYXMgRUNBU0VDTEFTSCAxMzcsIG5vIGxvbmdlciB1c2VkLiAqLwogLyogRUlMU0VR
IDEzOCAqLwkgICJJbnZhbGlkIG9yIGluY29tcGxldGUgbXVsdGlieXRlIG9yIHdpZGUgY2hh
cmFjdGVyIiwKIC8qIEVPVkVSRkxPVyAxMzkgKi8JICAiVmFsdWUgdG9vIGxhcmdlIGZvciBk
ZWZpbmVkIGRhdGEgdHlwZSIsCiAvKiBFQ0FOQ0VMRUQgMTQwICovCSAgIk9wZXJhdGlvbiBj
YW5jZWxlZCIsCkBAIC0xNzcsNiArMTc3LDggQEAgY29uc3QgY2hhciAqX3N5c19lcnJsaXN0
W10gPQogLyogRVNUUlBJUEUgMTQzICovCSAgIlN0cmVhbXMgcGlwZSBlcnJvciIKIH07CiAK
K3N0YXRpY19hc3NlcnQoMTQzICsgMSA9PSBzaXplb2YgKF9zeXNfZXJybGlzdCkgLyBzaXpl
b2YgKF9zeXNfZXJybGlzdFswXSkpOworCiBpbnQgTk9fQ09QWV9JTklUIF9zeXNfbmVyciA9
IHNpemVvZiAoX3N5c19lcnJsaXN0KSAvIHNpemVvZiAoX3N5c19lcnJsaXN0WzBdKTsKIH07
CiAKQEAgLTIyOCw3ICsyMzAsMTEgQEAgc3RyZXJyb3Jfd29ya2VyIChpbnQgZXJybnVtKQog
ewogICBjaGFyICpyZXM7CiAgIGlmIChlcnJudW0gPj0gMCAmJiBlcnJudW0gPCBfc3lzX25l
cnIpCi0gICAgcmVzID0gKGNoYXIgKikgX3N5c19lcnJsaXN0IFtlcnJudW1dOworICAgIHsK
KyAgICAgIHJlcyA9IChjaGFyICopIF9zeXNfZXJybGlzdCBbZXJybnVtXTsKKyAgICAgIGlm
IChyZXMgJiYgISpyZXMpCisJcmVzID0gTlVMTDsKKyAgICB9CiAgIGVsc2UKICAgICByZXMg
PSBOVUxMOwogICByZXR1cm4gcmVzOwotLSAKMi40My4wCgo=
--------------60C0B7C8E236DAAF72FE4878--

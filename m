Return-Path: <SRS0=l6Rb=V2=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
	by sourceware.org (Postfix) with ESMTPS id 0B1A13858D20
	for <cygwin-patches@cygwin.com>; Fri,  7 Mar 2025 16:35:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0B1A13858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0B1A13858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741365326; cv=none;
	b=oZL5EPwCSCJoVkUoY3PwgMbYUHw42NbYn4V0XZOboalP8wTELeV9q7nbmPhkbAoLub7xy3cyBobTVVjGhy2KR69eAMqmBs+Fsv8OAOavJAMSErvrBemSdmelNMRhmtDk9RXezHpdzemXk6pKgWJmvZOw1eXs5I+5QjGBaCuiMJM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741365326; c=relaxed/simple;
	bh=YE1xeN7VdcKulXoJmypW92h+7RT6jG+Pnkfwo8cukfQ=;
	h=Subject:From:To:Message-ID:Date:MIME-Version; b=OVEzYPZPMZaAzwgTZt6t6Pv1J8dyUIkmSLCtdtfSZ++tlwVahJaFNbFhVrY+e9dKaBYyAHszpaOuUX5OeRKj8yvTAKa0TAudxqRK8kdu8GLcMfqq+uuXihmilboi5LaxMoon0+bDCaRjIKvrqN7xE6GaIGVvlDuyBEV03Wib9d4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0B1A13858D20
Received: from fwd88.aul.t-online.de (fwd88.aul.t-online.de [10.223.144.114])
	by mailout04.t-online.de (Postfix) with SMTP id 0E492BD8
	for <cygwin-patches@cygwin.com>; Fri,  7 Mar 2025 17:35:24 +0100 (CET)
Received: from [192.168.2.102] ([91.57.253.229]) by fwd88.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tqafT-3HMlY80; Fri, 7 Mar 2025 17:35:23 +0100
Subject: Re: [PATCH] Cygwin: signa: Redesign signal queue handling
From: Christian Franke <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
References: <20250307121626.1365055-1-takashi.yano@nifty.ne.jp>
 <44b53668-4b2d-df88-e536-cac008c8cfb2@t-online.de>
Message-ID: <1afdf7b2-df25-af17-76aa-d92fa914a65a@t-online.de>
Date: Fri, 7 Mar 2025 17:35:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <44b53668-4b2d-df88-e536-cac008c8cfb2@t-online.de>
Content-Type: multipart/mixed;
 boundary="------------63B2B80F24056A105B47CA0E"
X-TOI-EXPURGATEID: 150726::1741365323-88FF6963-D1023EEF/0/0 CLEAN NORMAL
X-TOI-MSGID: 5aaabb64-61f8-4e18-8fc6-89652efb7ed1
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------63B2B80F24056A105B47CA0E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Christian Franke wrote:
> Takashi Yano wrote:
>> The previous implementation of the signal queue behaves as:
>> 1) Signals in the queue are processed in a disordered manner.
>> 2) If the same signal is already in the queue, new signal is discarded.
>>
>> Strictly speaking, these behaviours do not violate POSIX. However,
>> these could be a cause of unexpected behaviour in some software. In
>> Linux, some important signals such as SIGSTOP/SIGCONT do not seem to
>> behave like that.
>>
>> With this patch prevents all signals from that issues by redesigning
>> the signal queue, Only the exception is the case that the process is
>> in the PID_STOPPED state. In this case, SIGCONT/SIGKILL should be
>> processed prior to the other signals in the queue.
>>
>> Addresses:https://cygwin.com/pipermail/cygwin/2025-March/257582.html
>> ...
>
> A quick test with many runs of 'lostsig' testcase with or without 
> 'taskset 0x1' no longer shows any problems. No SIGALRM were lost (not 
> required), [SIGTERM] is always printed after all [SIGALRM] (not 
> required), SIGCONT is never lost. The previous 'timersig' testcase 
> also still succeeds.
>
>

Unfortunately with another testcase (attached) without SIGSTOP/CONT but 
two different signals sent in a loop it does not work:

$ ./swapsigs
remaining 5
1891: fork()=1892
SIGALRM 0
remaining 4
SIGTERM 0
SIGALRM 1
SIGTERM 1
SIGALRM 2
[ALRM]
SIGTERM 2
SIGALRM 3
SIGTERM 3
SIGALRM 4
[TERM]
SIGTERM 4
[ALRM]
SIGALRM 5
SIGTERM 5
SIGALRM 6
SIGTERM 6
[TERM]
[ALRM]
SIGALRM 7
... both processes hang ...

Could not be reproduced with 'taskset 0x1' or with original 
3.6.0-0.423.ga3863bfeb73f.x86_64.

-- 
Regards,
Christian




--------------63B2B80F24056A105B47CA0E
Content-Type: text/plain; charset=UTF-8;
 name="swapsigs.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="swapsigs.c"

I2luY2x1ZGUgPHNjaGVkLmg+DQojaW5jbHVkZSA8c2lnbmFsLmg+DQojaW5jbHVkZSA8c3Rk
aW8uaD4NCiNpbmNsdWRlIDxzdGRsaWIuaD4NCiNpbmNsdWRlIDx0aW1lLmg+DQojaW5jbHVk
ZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8c3lzL3dhaXQuaD4NCg0Kc3RhdGljIHZvbGF0aWxl
IHNpZ19hdG9taWNfdCBzaWdjbnQxLCBzaWdjbnQyOw0KDQpzdGF0aWMgdm9pZCBzaWdoYW5k
bGVyMShpbnQgc2lnKQ0Kew0KICAodm9pZClzaWc7DQogICsrc2lnY250MTsNCiAgd3JpdGUo
MSwgIltBTFJNXVxuIiwgNyk7DQp9DQoNCnN0YXRpYyB2b2lkIHNpZ2hhbmRsZXIyKGludCBz
aWcpDQp7DQogICh2b2lkKXNpZzsNCiAgKytzaWdjbnQyOw0KICB3cml0ZSgxLCAiW1RFUk1d
XG4iLCA3KTsNCn0NCg0KaW50IG1haW4oKQ0Kew0KICBwaWRfdCBwaWQgPSBmb3JrKCk7DQog
IGlmIChwaWQgPT0gKHBpZF90KS0xKSB7DQogICAgcGVycm9yKCJmb3JrIik7IHJldHVybiAx
Ow0KICB9DQoNCiAgaWYgKCFwaWQpIHsNCiAgICBzaWduYWwoU0lHQUxSTSwgc2lnaGFuZGxl
cjEpOw0KICAgIHNpZ25hbChTSUdURVJNLCBzaWdoYW5kbGVyMik7DQoNCiAgICB0aW1lX3Qg
c3RhcnQgPSB0aW1lKE5VTEwpLCB0ID0gNTsNCiAgICBkbyB7DQogICAgICBwcmludGYoInJl
bWFpbmluZyAlZFxuIiwgdCk7IGZmbHVzaChzdGRvdXQpOw0KICAgICAgc2xlZXAoMSk7DQog
ICAgICB0IC09IHRpbWUoTlVMTCkgLSBzdGFydDsNCiAgICB9IHdoaWxlICh0ID4gMCk7DQoN
CiAgICBwcmludGYoIiVkOiAlZCBTSUdBTFJNICVkIFNJR1RFUk0gcmVjZWl2ZWQsIGV4aXQo
NDIpXG4iLA0KICAgICAgKGludClnZXRwaWQoKSwgc2lnY250MSwgc2lnY250Mik7DQogICAg
ZmZsdXNoKHN0ZG91dCk7DQogICAgX2V4aXQoNDIpOw0KICB9DQoNCiAgcHJpbnRmKCIlZDog
Zm9yaygpPSVkXG4iLCAoaW50KWdldHBpZCgpLCAoaW50KXBpZCk7DQogIHNsZWVwKDEpOw0K
DQogIGNvbnN0IGludCBuID0gMTA7DQogIGZvciAoaW50IGkgPSAwOyBpIDwgbjsgaSsrKSB7
DQogICAgY29uc3QgdW5pb24gc2lndmFsIHN2ID0gezB9Ow0KICAgIHByaW50ZigiU0lHQUxS
TSAlZFxuIiwgaSk7IGZmbHVzaChzdGRvdXQpOw0KICAgIGlmIChzaWdxdWV1ZShwaWQsIFNJ
R0FMUk0sIHN2KSkNCiAgICAgIHBlcnJvcigiU0lHQUxSTSIpOw0KICAgIHByaW50ZigiU0lH
VEVSTSAlZFxuIiwgaSk7IGZmbHVzaChzdGRvdXQpOw0KICAgIGlmIChzaWdxdWV1ZShwaWQs
IFNJR1RFUk0sIHN2KSkNCiAgICAgIHBlcnJvcigiU0lHVEVSTSIpOw0KICB9DQoNCiAgcHJp
bnRmKCJ3YWl0cGlkKCkuLi5cbiIpOyBmZmx1c2goc3Rkb3V0KTsNCiAgaW50IHN0YXR1cyA9
IC0xOw0KICBpbnQgd3AgPSB3YWl0cGlkKHBpZCwgJnN0YXR1cywgMCk7DQogIHByaW50Zigi
d2FpZHBpZCgpPSVkLCBzdGF0dXM9MHglMDR4XG4iLCB3cCwgc3RhdHVzKTsNCiAgcmV0dXJu
IDA7DQp9DQo=
--------------63B2B80F24056A105B47CA0E--

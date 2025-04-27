Return-Path: <SRS0=9WkO=XN=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
	by sourceware.org (Postfix) with ESMTPS id 98E693858D1E
	for <cygwin-patches@cygwin.com>; Sun, 27 Apr 2025 20:43:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 98E693858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 98E693858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745786615; cv=none;
	b=aDbl9TftbxfLcHQL+Xnt09gxA6Y4pDlJxNb2ZscF+5EHkd4778pxnS0sOBgWZVcgF56KMVyEF6DOvEFG6jVCJ0yHPERL8vqdTZMt/roLFCapJ/2NOv2DTmPvlGlrrvXyLjLgqChyw+mBWiLM35SjFQAVwWCFiRItrMK2VfyHdUY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745786615; c=relaxed/simple;
	bh=INDrDDy6JgDS1Pk5Xfa0YkWZDI0x5CGR0WvETy5vds8=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=r0UUp5rGUo+BOwmnveIhJR2ohZjLZLGDzO3cMIsLZ+sCzfGH4JcRz7MfgBE1plJOc4N6guQ+kQliAznTgy58y926MCWMU41EtyHEs3T4u1WBy02Ls9oJAuVaEnyciqdzwM6cqaYmslKt4jQGVerTxWp7lE4Sps4bZyL/Rt+EV6E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 98E693858D1E
Received: from fwd82.aul.t-online.de (fwd82.aul.t-online.de [10.223.144.108])
	by mailout01.t-online.de (Postfix) with SMTP id 126E7424
	for <cygwin-patches@cygwin.com>; Sun, 27 Apr 2025 22:43:34 +0200 (CEST)
Received: from [192.168.2.101] ([91.57.247.175]) by fwd82.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1u98qZ-0IYng00; Sun, 27 Apr 2025 22:43:31 +0200
Subject: Re: [PATCH] Cygwin: kill(1): skip kill(2) call if '-f -s -' is used
To: cygwin-patches@cygwin.com
References: <16c95bad-2310-e66c-d538-403321033d2c@t-online.de>
 <20250415164029.c118309bc33c25f4b404b48d@nifty.ne.jp>
 <4356587f-51ed-302d-03f1-7415590813f6@t-online.de>
 <ac9d481c-00f0-46fd-a28f-c6938418e5d1@dronecode.org.uk>
 <804e3202-54d4-4604-a962-0e15360e1a09@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <0ed53f3d-e08b-ae5f-1400-350c707f0191@t-online.de>
Date: Sun, 27 Apr 2025 22:43:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <804e3202-54d4-4604-a962-0e15360e1a09@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1745786611-DD7F9ABE-D42CA371/0/0 CLEAN NORMAL
X-TOI-MSGID: 136b923f-570c-4dab-b798-bc8ffa56cc59
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Brian Inglis wrote:
> On 2025-04-27 12:22, Jon Turney wrote:
>> On 15/04/2025 10:02, Christian Franke wrote:
>>> Hi Takashi,
>>>
>>> Takashi Yano wrote:
>>>> Hi Christian,
>>>>
>>>> On Fri, 11 Apr 2025 16:46:07 +0200
>>>> Christian Franke wrote:
>>>>> In rare cases, '/bin/kill -f PID' hangs because kill(2) is always 
>>>>> tried
>>>>> first. With this patch, this could be prevented with '/bin/kill -f 
>>>>> -s -
>>>>> PID'.
>>
>> As it currently stands, the -f flag to kill seems a bit misdesigned, 
>> i.e. if the signal isn't SIGKILL, -f shouldn't be accepted?
>
> Docs say -f uses Win32 interface so SIG... is irrelevant?
>

No, the current logic is:
If -f is specified, Win32 TerminateProcess() is called after 'kill(pid, 
SIG...)' failed or if the process does not terminate within 200ms after 
kill() succeeded.

-- 
Regards,
Christian


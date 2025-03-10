Return-Path: <SRS0=TY1X=V5=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
	by sourceware.org (Postfix) with ESMTPS id CECD33858D28
	for <cygwin-patches@cygwin.com>; Mon, 10 Mar 2025 12:47:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CECD33858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CECD33858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.82
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741610842; cv=none;
	b=u/07BWCaP1L8gJNMuP5lsBOodE6NGAawhqnt5XDOE9B0OY4N6POPAJP5lBJgbcOyVXpf9eMu4YdB15eYmGc9QDVtEUFKGfU11v+vwuNRBm7w4iDrmNSgU4ViNL3wuxKwrIfIz+3TR7uF6Ga8lb9+C204UrSHX2go7grhmWMBJgQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741610842; c=relaxed/simple;
	bh=oP+CcV1qozKUEOzwqNuyKPvxVG3NsoTChDZGdpJd/SQ=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=upgfqex8bm3TOVS6LYj0ICc50Cygvz3mwM5BIb6s7ucDto6IzbthyiS8/f0lbkn2bPL9pbwmNJIAHR+lxq5k8CsHODDhRkwTOKn75gFzY/gVVtTdvRghHGc/YC6KtudBuJVqGHg4B9u9rTZjMH9Tdl+JdOfGZo4ha+O4cpjjBT0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CECD33858D28
Received: from fwd79.aul.t-online.de (fwd79.aul.t-online.de [10.223.144.105])
	by mailout05.t-online.de (Postfix) with SMTP id 2B4B9A7B
	for <cygwin-patches@cygwin.com>; Mon, 10 Mar 2025 13:47:18 +0100 (CET)
Received: from [192.168.2.102] ([91.57.253.229]) by fwd79.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1trcXJ-1meoEq0; Mon, 10 Mar 2025 13:47:13 +0100
Subject: Re: [PATCH] Cygwin: sched_setaffinity: fix EACCES if pid of other
 process is used
To: cygwin-patches@cygwin.com
References: <7a77c9b6-20e4-538f-4b8d-e91be879988f@t-online.de>
 <Z867JCGV3NeaSqcl@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <1f697dc3-003d-42d5-5a09-8095f3824446@t-online.de>
Date: Mon, 10 Mar 2025 13:47:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <Z867JCGV3NeaSqcl@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1741610833-F1FF897D-7FBF3AF3/0/0 CLEAN NORMAL
X-TOI-MSGID: 1cefc128-0ca4-466e-a165-9b59026bf98a
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Mar  8 14:24, Christian Franke wrote:
>> This fixes:
>>
>> $ taskset -p 0x1 1234
>> pid 1234's current affinity mask: fffffff
>> taskset: failed to set pid 1234's affinity: Permission denied
>>
>> Perhaps older Windows versions were more relaxed if PROCESS_SET_INFORMATION
>> is granted.
>>
>> -- 
>> Regards,
>> Christian
>>
> LGTM.  Btw., do you have push permissions?  From what I can tell,
> you already have an account on sourceware and it looks like you have
> push perms.  Is your .ssh key up to date?

I got push permissions to (at least) Cygwin setup repo in August 2022, 
but apparently the ssh login no longer works. The debug output shows 
that the correct (3072 RSA) pubkey is passed.


> Wouldn't you like to join our cygwin-developers IRC channel as well?
> https://cygwin.com/irc.html

Possibly, but need to refresh my knowledge first as it's been a long 
time that I used IRC - IIRC 20+ years :-)

-- 
Thanks,
Christian


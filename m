Return-Path: <SRS0=cZ2+=S3=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 871203858D34
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 20:32:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 871203858D34
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 871203858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733171543; cv=none;
	b=P3rPR2JE4sRTRRpjJMpGLzxvkMMyIn7fUgO+N00Fa46VSWHLd/sgvVmSc3bZMoUV3RFKGfFkf+FB24XucCGA+119fbWME6dfnYyyHhsR3KsI/f01rJcJN0eIYuEDgYbcWlu60QQ6eAHqYgjEUCu2/a2g5Fxbnd0MCdjZzdG117Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733171543; c=relaxed/simple;
	bh=EomfsDZzURHthvKsrXi4Vi4SjZhiCnH/4PL5WIItrkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:DKIM-Signature; b=flB33yka1MafywcSuwQiHaRAsd5pUOEIg6zOJzkq+JbKsk9teAAg9j6NIxcOJ/Jp7+lL0ijXOsA48VGkCw97oO6USvLBHkFtclFAReuyYWxp5xEkB9hW2lS6xGdVYAtpTmd89gxH2VKUPuJTLreHdEsDRY9ZP+vLzqE4BlSrKD0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 871203858D34
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=TKtVK2ke
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 2D5AE1A0307
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 20:32:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf20.hostedemail.com (Postfix) with ESMTPA id 5D3F220026
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 20:32:16 +0000 (UTC)
Message-ID: <c6f21ed2-679d-4a89-a8a3-b0b1e9d1714f@SystematicSW.ab.ca>
Date: Mon, 2 Dec 2024 13:32:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_OTHER,
 SCHED_FIFO and SCHED_RR
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <eabbcf15-1605-8b77-bf77-ec5fde2d6001@t-online.de>
 <Z03Tik1rbM4sMpKl@calimero.vinschen.de>
 <e79eb78a-c8a1-d2c6-4a8d-9c21415b15e9@t-online.de>
 <8734j6q6qk.fsf@Gerda.invalid>
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Autocrypt: addr=Brian.Inglis@Shaw.ca; keydata=
 xjMEXopx9BYJKwYBBAHaRw8BAQdAPq8FIaW+Bz7xnfyJ1gHQyf2EZo5sAwSPy/bRAcLeWl/N
 I0JyaWFuIEluZ2xpcyA8QnJpYW4uSW5nbGlzQFNoYXcuY2E+wpYEExYIAD4WIQTG63sbl+cr
 2nyOuZiKvQKcH1E27wUCXopx9AIbAwUJCWYBgAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
 CRCKvQKcH1E276DmAP91Bt8kfJhKHYb9b2sao2fxwJFsl1GlRi516WKI0OkphQEA+ULITsPs
 blfzSq+GgI7q4LPfRfTLy4Oo3gorlnhnfgnOOAReinH0EgorBgEEAZdVAQUBAQdAepgIsLwm
 GQicfoIBaB9xHp63MQJqVCPbgPzESTg7EEwDAQgHwn0EGBYIACYWIQTG63sbl+cr2nyOuZiK
 vQKcH1E27wUCXopx9AIbDAUJCWYBgAAKCRCKvQKcH1E27+zoAP4u2ivMQBAqaMeLOilqRWgy
 nV2ATImz1p2v1H5P4kBiDwD3caPK1cxU5lijzuSDCjgtIpgF/avHbjA32fxJdIRwAA==
Organization: Systematic Software
In-Reply-To: <8734j6q6qk.fsf@Gerda.invalid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: e6uxqn5dpxzdtfoak3fr6cnuy49h1dpo
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 5D3F220026
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1944u6P0WkcH3UwrjdwqY3k+AQIJz8k7ws=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:reply-to:subject:to:references:from:in-reply-to:content-type:content-transfer-encoding; s=he; bh=5Mytw06a4RhZ+MKab2BwVGrcavtUBkkYjl4OBTAqOHM=; b=TKtVK2keXyjp2jTRpbTSz23VsTnp9Zx9teO6Ko6uMiyqtLfwpqIjfUek4UZyQNP54W4TeyxeAHHt1mP+zZ/LyOW8Qnqu5ibaFx1Vj69GEjmw6z0fo2HC8XH027zjXp2Rro/JKy4q1bcaUfK3DOILJQjYLoQDuSSwkmZALXUIrOIxTbb09kudNC0yPm0isA+E9a4VC/cZyZGR3Mppy/CIiGSgelUBq9LnIYszE3LfRfgKuxzqSvLGdoP1dAGUxIn2WE/8Zpv09gCGNhpDuMqzx4+ZceH9YsoNI2lGWCtoAhapt8Vl5wUjGh3LcVMHi3ASJBdjqPjZc9UgTonDm/LeaA==
X-HE-Tag: 1733171536-502139
X-HE-Meta: U2FsdGVkX1+K+NXhrG3Lr/nxaZF2u1bWogkOrIzbdr1Ix6K44NZr+ydctwwq0kjLq05HzjC6lyTNwdOTY3W06PDhqX2WgZgGZGqVoVYjpSyF/Q1loKfnPH1i4PKxkaGF1XpdNYcx2+nmXpvY3S5XFINIoAJQnTIuyI+k1tqSmbtEr/0x7sudij2m8rTMPcjZ3jQUois9ecNpHndyd0Ri8vnF9TWcyOUYuOoKqTggsE8NxKKfpVSRalZSVq5Ct4SzFuMJoOx+tuNqaw+tGXGf/W2IyL63hIjWtM2zskjp13yFdG+p8b+wpM+zu+YVaNAxushwzZnABp9BKv5+Ap2h6sB69fXErfRC
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2024-12-02 11:28, ASSI wrote:
> Christian Franke writes:
>> +    nice value   sched_priority   Windows priority class
>> +     12...19      1....6          IDLE_PRIORITY_CLASS
>> +      4...11      7...12          BELOW_NORMAL_PRIORITY_CLASS
>> +     -4....3     13...18          NORMAL_PRIORITY_CLASS
>> +    -12...-5     19...24          ABOVE_NORMAL_PRIORITY_CLASS
>> +    -13..-19     25...30          HIGH_PRIORITY_CLASS
>> +         -20     31...32          REALTIME_PRIORITY_CLASS
> 
> That mapping looks odd… care to explain why the number of nice values
> and sched_priorities doesn't match up for each priority class?  39
> possible values for one can't match to 32 for the other of course, but
> which ones are skipped and why?

See also miscfuncs.cc which maps nice<->winprio with a 40 entry table, and 
cygwin-doc proc(5) or cygwin-ug-net/proc.html which explains the mapping to 
scheduler priorities and policies.

Also relevant may be man-pages-posix sched.h(0p), man-pages-linux sched(7) and 
proc_pid_stat(5).

You may also wish to consider whether SCHED_SPORADIC should be somewhat 
supported for POSIX compatibility, and SCHED_IDLE, SCHED_BATCH, SCHED_DEADLINE 
for Linux compatibility?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

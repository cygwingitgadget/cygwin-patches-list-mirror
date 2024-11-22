Return-Path: <SRS0=C+DP=SR=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout03.t-online.de (mailout03.t-online.de [194.25.134.81])
	by sourceware.org (Postfix) with ESMTPS id A2AA23858402
	for <cygwin-patches@cygwin.com>; Fri, 22 Nov 2024 13:37:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A2AA23858402
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A2AA23858402
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.81
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732282674; cv=none;
	b=IQCp4y1C1LUJy4bsAIlLO685fN6SwVhnGBAKIxQ++TIX8YPKTbnH8sAhrfK9e1b+BLkvAr/IquvUcoN7gmQ9VzL967LMGolGcD5ehB6iJVJGLy5KUuUvQaKL91ZPDORYmsMO6BLHcMY+qcwipaoOJOhPa2Meux08zmvNJUQUzY8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732282674; c=relaxed/simple;
	bh=ncCjhAQsDUUPJEZJroojT1twXtZSQsrI61nL7gXi4Ew=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=cn3NaKmL18xlpdkcYe7pEMSKQwQucRo0A4Ig4i0C3bOS0CalcI7wNSo0cgILwXkGBj6gDHJ0xpdPmsCCyPNibL+JxlnaRREgyAPyKyiwsN7//s2MxNyIN+68VHTBGzg3RDtctlnp2p7jbjU9mFRI6ROsarHYXfe8aC7zWu98or0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A2AA23858402
Received: from fwd70.aul.t-online.de (fwd70.aul.t-online.de [10.223.144.96])
	by mailout03.t-online.de (Postfix) with SMTP id B99BA281
	for <cygwin-patches@cygwin.com>; Fri, 22 Nov 2024 14:37:24 +0100 (CET)
Received: from [192.168.2.101] ([91.57.241.70]) by fwd70.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tETqe-0GPi0O0; Fri, 22 Nov 2024 14:37:24 +0100
Subject: Re: [PATCH v2] Cygwin: sigtimedwait: Fix segfault when timeout is
 used
To: cygwin-patches@cygwin.com
References: <20241119084057.945-1-takashi.yano@nifty.ne.jp>
 <ZzxtpcNi85kNQX2g@calimero.vinschen.de>
 <20241120220024.dd039419f2523a6bc3339e26@nifty.ne.jp>
 <Zz4AgZCApEQEwb-w@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <287bd7f8-8a86-f269-25e7-521ee09f6348@t-online.de>
Date: Fri, 22 Nov 2024 14:37:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <Zz4AgZCApEQEwb-w@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1732282644-BAFEFCFB-477E4E7F/0/0 CLEAN NORMAL
X-TOI-MSGID: 0389c779-31e0-4119-a490-cc71b07538a2
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Nov 20 22:00, Takashi Yano wrote:
>> On Tue, 19 Nov 2024 11:51:17 +0100
>> Corinna Vinschen wrote:
>>> Maybe we can utilize WaitOnAddress, kind of like this?
>>>
>>> sigwait_common, just the fallthrough snippet:
>>>
>>>    +       /* sigpacket::process() already started.
>>>    +          Go through to WAIT_SIGNALED case. */
>>>    +       _my_tls.unlock ();
>>>    +       sigset_t compare = 0;
>>>    +       WaitOnAddress (&_my_tls.sigwait_mask, &compare,
>>>    +                      sizeof (sigset_t), INFINITE);
>>>    +       _my_tls.sigwait_mask = 0;
>>>    +       fallthrough;
>>>
>>> sigpacket::process():
>>>
>>> @@ -1457,6 +1457,7 @@ sigpacket::process ()
>>>     bool issig_wait = false;
>>>     struct sigaction& thissig = global_sigs[si.si_signo];
>>>     void *handler = have_execed ? NULL : (void *) thissig.sa_handler;
>>> +  sigset_t orig_wait_mask = 0;
>>>   
>>>     threadlist_t *tl_entry = NULL;
>>>     _cygtls *tls = NULL;
>>> @@ -1527,11 +1528,15 @@ sigpacket::process ()
>>>     if ((HANDLE) *tls)
>>>       tls->signal_debugger (si);
>>>   
>>> -  if (issig_wait)
>>> +  tls->lock ();
>>> +  if (issig_wait && tls->sigwait_mask != 0)
>>>       {
>>> +      orig_wait_mask = tls->sigwait_mask;
>>>         tls->sigwait_mask = 0;
>>> +      tls->unlock ();
>>>         goto dosig;
>>>       }
>>> +  tls->unlock ();
>>>   
>>>     if (handler == SIG_IGN)
>>>       {
>>> @@ -1606,6 +1611,11 @@ dosig:
>>>     /* Dispatch to the appropriate function. */
>>>     sigproc_printf ("signal %d, signal handler %p", si.si_signo, handler);
>>>     rc = setup_handler (handler, thissig, tls);
>>> +  if (orig_wait_mask)
>>> +    {
>>> +      tls->sigwait_mask = orig_wait_mask;
>>> +      WakeByAddressAll (&tls->sigwait_mask);
>>> +    }
>>>   
>>>   done:
>>>     cygheap->unlock_tls (tl_entry);
>>>
>>> Mind, that's just an idea.  There may be a simpler way to do this.
>>>
>>> Alternatively we can just fallback to your version 1.
>> Using WaitOnAddress() may be nice idea, however, I prefer my v1 patch.
>> It's simpler and the intent of the code is clearer, isn't it?
> And somehow an iteration of the above code doesn't actually fix the
> problem, your original patch does.  So please push.

Stress-ng upstream recently re-enabled usage of 
pthread_sigqueue+sigtimedwait on Cygwin. If such a build is used with 
cygwin1.dll 26144e40, 'stress-ng --pthread' does no longer report any 
SIGSEGV errors.

-- 
Thanks,
Christian


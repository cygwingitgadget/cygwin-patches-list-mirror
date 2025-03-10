Return-Path: <SRS0=TY1X=V5=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout11.t-online.de (mailout11.t-online.de [194.25.134.85])
	by sourceware.org (Postfix) with ESMTPS id 35CDF3858D28
	for <cygwin-patches@cygwin.com>; Mon, 10 Mar 2025 16:19:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 35CDF3858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 35CDF3858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.85
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741623547; cv=none;
	b=rRrs9z74tmLDfwdMNX6LtIarCBd/7a+RjIq++BgUF3fJ1u2FNMG4bbEEBuYjZPM4pXvqvhCaSPIC7ZOcWq+rpL1jc5nVDg+1LV8Vtag8Y/TZ0WtpVEwDIeydCxYcuP1+pmN9gaCfbfp5yibS0/EJHXgNiOQQP95LA15z/GGTsg8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741623547; c=relaxed/simple;
	bh=MvYQyyncvjq0rf+HMRuIZsbgQsl9YG3giYdhqOr/yzA=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=EzcBMkTrVrmm4Y1g/V6/bptmLhII4iKOFqit4zdpSuISKHsoIjFGVsnOBgE/czJf81j4lU37Gatr/Ow2hc77wHCHnoBcUBAEZaXWCpJGZ8zDHaxc3JNSeZNzB40fG2HxFPKgzQeIhRgyENYGzRLorW1AGLAhp0Tn2F9cKrl8B90=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 35CDF3858D28
Received: from fwd85.aul.t-online.de (fwd85.aul.t-online.de [10.223.144.111])
	by mailout11.t-online.de (Postfix) with SMTP id 64895572
	for <cygwin-patches@cygwin.com>; Mon, 10 Mar 2025 17:19:05 +0100 (CET)
Received: from [192.168.2.102] ([91.57.253.229]) by fwd85.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1trfqK-4A9Lea0; Mon, 10 Mar 2025 17:19:04 +0100
Subject: Re: [PATCH] Cygwin: sched_setaffinity: fix EACCES if pid of other
 process is used
To: cygwin-patches@cygwin.com
References: <7a77c9b6-20e4-538f-4b8d-e91be879988f@t-online.de>
 <Z867JCGV3NeaSqcl@calimero.vinschen.de>
 <1f697dc3-003d-42d5-5a09-8095f3824446@t-online.de>
 <Z87vs2ZjpkjGSScg@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <313cde7f-c12c-9015-adca-9b4d9accc7d6@t-online.de>
Date: Mon, 10 Mar 2025 17:19:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <Z87vs2ZjpkjGSScg@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1741623544-167FB93D-20DF296D/0/0 CLEAN NORMAL
X-TOI-MSGID: 27c8f28e-a8d0-4e6c-8f24-bfad307487a4
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Mar 10 13:47, Christian Franke wrote:
>> Corinna Vinschen wrote:
>>> On Mar  8 14:24, Christian Franke wrote:
>>>> ...
>>>>
>>> LGTM.  Btw., do you have push permissions?  From what I can tell,
>>> you already have an account on sourceware and it looks like you have
>>> push perms.  Is your .ssh key up to date?
>> I got push permissions to (at least) Cygwin setup repo in August 2022, but
>> apparently the ssh login no longer works. The debug output shows that the
>> correct (3072 RSA) pubkey is passed.
> You were moved to an inactive state due to, well, inactivity.
>
> I just asked the sware overseers to move you back to active.  You should
> be able to push your patch now.

Pushed.

Thanks,
Christian


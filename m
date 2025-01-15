Return-Path: <SRS0=lqhc=UH=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
	by sourceware.org (Postfix) with ESMTPS id DC9EB3858CD1
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 11:29:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DC9EB3858CD1
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DC9EB3858CD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736940543; cv=none;
	b=uy0ohcsrZJiQBdIH+6EHnQBxWt5ORYENZ+en9IGdW8bWrvoUBgEvCGqODGaIJBiMZY4As5TAtSeDLIjQtbU4TWc+D2JHZtsnmKWIuOx2o4hnGGvkQXEYvANzJL0S9FIdbZFYISIZo7q3TnubNi9+kgbwKEWVLCLWw7jzNkoIkJw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736940543; c=relaxed/simple;
	bh=LSHhKN7JcFSNZ3B9QGJxfAuBrnNkaRB/43tIyB3wf5o=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=thAO4nDeozxDl1WNhhvCogaTNEMjxB3bmjCHK74wAK33dTxk151QKb+Ka+TkFTDYQG/N62a2GpOhBfi28+ZkTH7D+ft60nBovRMwsJ76OEZhL+eDkD9p4h3cpHDOwaCNsaZvuFmKa6nISGyR/gpv01cRkIcQXelIcSlCC1HpEhA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DC9EB3858CD1
Received: from fwd73.aul.t-online.de (fwd73.aul.t-online.de [10.223.144.99])
	by mailout02.t-online.de (Postfix) with SMTP id 7D2668CC
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 12:29:01 +0100 (CET)
Received: from [192.168.2.105] ([91.57.246.116]) by fwd73.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tY1a1-0QsfQW0; Wed, 15 Jan 2025 12:29:01 +0100
Subject: Re: [PATCH] Cygwin: add fd validation to mq_* functions
To: cygwin-patches@cygwin.com
References: <20250115105006.471-1-mark@maxrnd.com>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <2d113b48-752b-fe90-cce7-cf826c341f49@t-online.de>
Date: Wed, 15 Jan 2025 12:28:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <20250115105006.471-1-mark@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1736940541-06FFA9FE-E11F996F/0/0 CLEAN NORMAL
X-TOI-MSGID: 51158c83-8866-49dd-8318-30c8e3771131
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Mark Geisert wrote:
> Validate the fd returned by cygheap_getfd operating on given mqd.
>
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Addresses: https://cygwin.com/pipermail/cygwin/2025-January/257090.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: 46f3b0ce85a9 (Cygwin: POSIX msg queues: move all mq_* functionality into fhandler_mqueue)
>
> ---
>   winsup/cygwin/posix_ipc.cc | 88 +++++++++++++++++++++++---------------
>   1 file changed, 53 insertions(+), 35 deletions(-)
>
> diff --git a/winsup/cygwin/posix_ipc.cc b/winsup/cygwin/posix_ipc.cc
> index 34fd2ba34..3ce1ecda6 100644
> --- a/winsup/cygwin/posix_ipc.cc
> +++ b/winsup/cygwin/posix_ipc.cc
> @@ -225,11 +225,14 @@ mq_getattr (mqd_t mqd, struct mq_attr *mqstat)
>     int ret = -1;
>   
>     cygheap_fdget fd ((int) mqd, true);
> -  fhandler_mqueue *fh = fd->is_mqueue ();
> -  if (!fh)
> -    set_errno (EBADF);
> -  else
> -    ret = fh->mq_getattr (mqstat);
> +  if (fd >= 0)
> +    {
> +      fhandler_mqueue *fh = fd->is_mqueue ();
> +      if (!fh)
> +        set_errno (EBADF);
> +      else
> +        ret = fh->mq_getattr (mqstat);
> +    }

Sorry, I forgot to mention that the testcase also "works" (segfaults) if 
a positive but nonexistent fd is used. I'm not sure whether the (fd >= 
0) check is sufficient.


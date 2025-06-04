Return-Path: <SRS0=MGRW=YT=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C7600385702B
	for <cygwin-patches@cygwin.com>; Wed,  4 Jun 2025 18:17:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C7600385702B
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C7600385702B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749061075; cv=none;
	b=hnj17zzlyNSMHWGz5SZCqd9rarNGaWOTmfwxuc2otlBrzy9tsDhh6I6q/p5oyw6V+km99hXWKp+4NvOwiClhl+BibDDbgXDaz2iL0+uT3kJaaZKcUUf2rukcrolJzNN65gLFZxCByThBUH/3BmBtO3Om7/6pEHezO964+fRW6LE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749061075; c=relaxed/simple;
	bh=aCulLp8XxcV7YipAbGAWz3arQKHzcrYjgVH1YH9FPPw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Ff5HJf0cKGBnJplNRBB4LGRIshTk1HKMC8USWtIn7xMjAEzRffG1HauzK3USPS5uY0AR3ZBI8eHq6kx/ALDkaPqnL8udJ0IQ1sk1ZXR0q3B45m71dbicDvqfZlfmHwU7Qnk8jvH/DR/c5rXw+pI/GG7Xx5Ye4poiLi8gaJxd9/A=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 0507F45CE5;
	Wed, 04 Jun 2025 14:17:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=krApOLT7chxu8YVGYgwFMDlpa7o=; b=ULM+M
	mJbsWBtV8Vj2hSuNS3fLUiJ9fLD8KFP3x8jXyVf9Qrz7j9n+fzE2qkF5kPEbZgcZ
	cu6pCmw/t3R4bAgViKOBFyR1M7Ed5ZotQIUy7U0J0xlWoahIPlvMMDhmKYQDPPYF
	IZ4FU+RvwV75yvSALEsJE6pktWIMyPHkJT4i7c=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id E0CEE45CE4;
	Wed, 04 Jun 2025 14:17:54 -0400 (EDT)
Date: Wed, 4 Jun 2025 11:17:54 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
cc: cygwin-patches@cygwin.com, Robert Fensterman <minnmass@gmail.com>
Subject: Re: [PATCH] Cygwin: do retrieve AzureAD users' information again
In-Reply-To: <d8fb04d38a45dc3fab500a2cd3ea151b8bf62c9c.1748935646.git.johannes.schindelin@gmx.de>
Message-ID: <56afe7aa-60de-7f8c-eab9-4f5d57e0ab6a@jdrake.com>
References: <d8fb04d38a45dc3fab500a2cd3ea151b8bf62c9c.1748935646.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 3 Jun 2025, Johannes Schindelin wrote:

> In e04891d67a (Cygwin: fetch_account_from_windows: skip LookupAccountSid
> for SIDs known to fail, 2025-04-10), several SIDs acquired a shortcut
> where a potentially expensive `LookupAccountSid()` call is avoided for
> SIDs that "cannot be resolved".

> The most likely reason why AzureAD SIDs were included in above-mentioned
> commit is that special AzureAD _group_ SIDs are not recognized by
> `LookupAccountSid()`, as per the code comment for the `azure_grp_sid`
> variable. It is plausible that this fact was mistaken to extend to all
> AzureAD SIDs, a notion disproved by the counter example of my personal
> experience with my own AzureAD user account. Unfortunately, the only way
> to find out whether `LookupAccountSid()` works with a given AzureAD SID
> or not is to call that function.
>
> To make regular AzureAD user accounts work again, let's just drop the
> AzureAD part from that special shortcut.
>


> diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> index 83883f9f65..ffe71ee072 100644
> --- a/winsup/cygwin/uinfo.cc
> +++ b/winsup/cygwin/uinfo.cc
> @@ -1996,10 +1996,6 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_t &arg, cyg_ldap *pldap)
>        if (sid_id_auth (sid) == 5 /* SECURITY_NT_AUTHORITY */
>  	  && sid_sub_auth (sid, 0) == SECURITY_APPPOOL_ID_BASE_RID)
>  	break;
> -      /* AzureAD SIDs */
> -      if (sid_id_auth (sid) == 12 /* AzureAD ID */
> -	  && sid_sub_auth (sid, 0) == 1 /* Azure ID base RID */)
> -	break;
>        /* Samba user/group SIDs */
>        if (sid_id_auth (sid) == 22)
>  	break;
>

This LGTM, I'd like to push it to main and get a test/snapshot build of
cygwin out there for users experiencing these issues to test.

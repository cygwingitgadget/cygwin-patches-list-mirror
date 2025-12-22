Return-Path: <SRS0=d9R/=64=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.113])
	by sourceware.org (Postfix) with ESMTPS id C38D24BA2E04
	for <cygwin-patches@cygwin.com>; Mon, 22 Dec 2025 06:07:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C38D24BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C38D24BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.113
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766383639; cv=none;
	b=GuiTSrl8CWg6qX6di8vnSYOQkIae3LYMoyC7/TywSdTnAwvzfFLA70cH166NtgnMaEaFI9L2k31oAVsJ50gwuV2S1KJDm4xqwfbMj2cLWYywZqWlWCoIFURPm4kJ7Rd6KAWHfOCqEaqactYGSI2sZ58Rw1B3HkCNS1Kf5Hue+KI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766383639; c=relaxed/simple;
	bh=WnvPKybkviidh2CZ1ksehea7lfG7HMYwRKnNyBzBcOM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=WR/Og5iMOelcnF+6fkrXXw7dVCM2CkrKVPtBOdwbwTMzFTxhG5vD2Klfi7uJDFVxFOD4vCcK79kTx6abOUgcH7/nS1KEoM2JqS97Rzy+VH7rB1fj9Vs95VBQ4EsfaQ7WXZWJjtL8iOnCcmz5yHNKS6pkwfgfC+hf/FbIKtbW/h4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C38D24BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=pHINNrz4
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20251222060717048.FGOD.62593.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 22 Dec 2025 15:07:17 +0900
Date: Mon, 22 Dec 2025 15:07:15 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/4] Cygwin: uinfo: allow to override user account as
 primary group
Message-Id: <20251222150715.1a927b6963b98a34b172d7a9@nifty.ne.jp>
In-Reply-To: <20251218112308.1004395-3-corinna-cygwin@cygwin.com>
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
	<20251218112308.1004395-3-corinna-cygwin@cygwin.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766383637;
 bh=i4pZ4gL95toD64SK9DI53vwBNl7tLK87Tix/RC43H7E=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=pHINNrz4dXOjzBFrYHpr+XirqWoTlUl4pKOPFjUOAlisVHCYDsNOQelvdb+6LFDOqU6jSnYt
 1EcvaoAcoPhlZ66vzSYXuTDA9xcm1bH95GjjA50dQqwFLl0VW55mW/IMAbrKToxoW21nhxzLx6
 pZg582gPWMyyqA/Jgq3p52LenirpME0aqvopGOANmgfQqKDmpU1MH9wC3fsRCWb2+Tal7Kk+ep
 Ex+YKFkPMx4Udk+t9oNHIHqIE6dhvMxoFFhYBq/0Ru2xCaXzLRxWz+03Xw+LsBvf5mxdbXoqLV
 2kM1Av/zSwrdlXNYN/cAzsp2zvz7c+CPmYiujJ4P40oJZWPQ==
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 18 Dec 2025 12:23:06 +0100
Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> Do not only allow to override the (localized) group "None" as primary
> group, but also the user account.  The user account is used as primary
> group in the user token, if the user account is a Microsoft Account or
> an AzureAD account.

Is there any evidence of:
"The user account is used as primary group in the user token, "

> 
> Fixes: dc7b67316d01 ("Cygwin: uinfo: prefer token primary group")
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/cygwin/uinfo.cc | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> index 8e9b9e07de9d..fb4618b8a19e 100644
> --- a/winsup/cygwin/uinfo.cc
> +++ b/winsup/cygwin/uinfo.cc
> @@ -170,13 +170,17 @@ internal_getlogin (cygheap_user &user)
>  	 group of a local user ("None", localized), we have to find the SID
>  	 of that group and try to override the token primary group.  Also
>  	 makes sure we're not on a domain controller, where account_sid ()
> -	 == primary_sid (). */
> +	 == primary_sid ().
> +	 CV 2025-12-05: Microsoft Accounts as well as AzureAD accounts have
> +	 the primary group SID in their user token set to their own user SID.
> +	 Allow to override them as well. */
>        gsid = cygheap->dom.account_sid ();
>        gsid.append (DOMAIN_GROUP_RID_USERS);
>        if (!pgrp
>  	  || (pwd->pw_gid != pgrp->gr_gid
>  	      && cygheap->dom.account_sid () != cygheap->dom.primary_sid ()
> -	      && RtlEqualSid (gsid, user.groups.pgsid)))
> +	      && (gsid == user.groups.pgsid
> +		  || user.sid () == user.groups.pgsid)))
>  	{
>  	  if (gsid.getfromgr (grp = internal_getgrgid (pwd->pw_gid, &cldap)))
>  	    {
> -- 
> 2.52.0

Other than that LGTM.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

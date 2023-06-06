Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CB6E03858D33; Tue,  6 Jun 2023 13:33:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CB6E03858D33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1686058397;
	bh=eTRJ+TFPw/TFVICy6ndZFIi7FjxPcv5WLpDMnEEbSO4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=G2ltQ3zAqZD+m1NNyMtGmpcSdkJCt5T73CVKJ/JOH1iPw1Qo4uH9Ka3mpVwMPtYQ2
	 9H73Hh1+hKELPILRPj+2w1rvT/7KvCls17OxtGbqfrzs5EBSeysPK0l3RTCi445Nq6
	 IsRN7MbosoFk7FL5yYZAB3RDSn9ykanqH/URCuE0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 20C96A80BDA; Tue,  6 Jun 2023 15:33:16 +0200 (CEST)
Date: Tue, 6 Jun 2023 15:33:16 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 0/4] Support deriving the current user's home
 directory via HOME
Message-ID: <ZH81nBXKrkD6xC3H@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1680620830.git.johannes.schindelin@gmx.de>
 <cover.1684753872.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1684753872.git.johannes.schindelin@gmx.de>
List-Id: <cygwin-patches.cygwin.com>

On May 22 13:12, Johannes Schindelin wrote:
> NOTE! This iteration presents patches 1 & 2 only for completeness' sake
> and for backporting, as they have been applied to Cygwin's main branch
> already.
> 
> This patch series supports Git for Windows' default strategy to
> determine the current user's home directory by looking at the
> environment variable HOME, falling back to HOMEDRIVE and HOMEPATH, and
> if these variables are also unset, to USERPROFILE.
> 
> This strategy is a quick method to determine the home directory,
> certainly quicker than looking at LDAP, even more so when a domain
> controller is unreachable and causes long hangs in Cygwin's startup.
> 
> This strategy also allows users to override the home directory easily
> (e.g. in case that their real home directory is a network share that is
> not all that well handled by some commands such as cmd.exe's cd
> command).
> 
> Changes since v6:
> 
> - Fixed a typo in the last commit's message.
> 
> - Support UNC paths as `HOME` values, too. (Tested, works beautifully, I
>   can now share my WSL home directory with Cygwin.)

Pushed.


Thanks,
Corinna

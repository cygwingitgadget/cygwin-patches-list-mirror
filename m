Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 06564385842C; Tue, 10 Dec 2024 19:20:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 06564385842C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733858426;
	bh=gKWIqyyPiCs7BPam2wOHADExlyJqgSOPZhUezm1rLbU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=iXLJkw335aSvSNxZMV5SWfMvUJd1Ip+b34kkSRbJfyw+7L+xQz3pypwKD1M6ifym/
	 9goPLH6CVyHjB88WuNFIECq11Jk1FYjlA2aDp2OnKcPGBJ45CZKvyzuvNGOEP7e8sM
	 sk3vceHIP6CA0F3d2qZhZdxdwbl/jcCF6azlBS5s=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B2630A80B6E; Tue, 10 Dec 2024 20:20:08 +0100 (CET)
Date: Tue, 10 Dec 2024 20:20:08 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: access: Correction for samba/SMB share
Message-ID: <Z1iUaOiVhAmCTbAO@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241210134559.640-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210134559.640-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec 10 22:45, Takashi Yano wrote:
> Previously, access() and eaccess() does not determine the permissions
> for files on samba/SMB share correctly. Even if the user logs-in as
> the owner of the file, access() and eaccess() referes to others'
> permissions. With this patch, to determine the permissions correctly,
> NtOpenFile() with desired access mask is used.
> 
> Fixes: cf762b08cfb0 ("* security.cc (check_file_access): Create.")
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/sec/base.cc | 119 +++++++-------------------------------
>  1 file changed, 20 insertions(+), 99 deletions(-)

LGTM.

Thanks,
Corinna

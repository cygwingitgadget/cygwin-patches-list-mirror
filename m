Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 590033858D20; Tue,  5 Mar 2024 16:16:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 590033858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1709655413;
	bh=akglxYJbaCYUcWGNq8XuUc+JBRhsB2vZlyfg3hFppbI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=FJMIBSCcWhLwxG6QvxAWmWMmhbM3agVgGTdj33rTUVxhYZZj+lHXiQLs3PA8YnHFp
	 Njj7tBWQB6IiwlVgcFA0LseCtIs7KTbMsVySo0mM2qOwT300vUMMLRKlrvUxA8AGVk
	 IEoLANDzJJgV1veTM1yHWM8DJa2lIF4IE8Jsx+PE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 30A06A80CF5; Tue,  5 Mar 2024 17:16:51 +0100 (CET)
Date: Tue, 5 Mar 2024 17:16:51 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
Message-ID: <ZedFcxBkM3UO54_4@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240305144836.1675-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240305144836.1675-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar  5 23:48, Takashi Yano wrote:
> Non-cygwin app may call ReadFile() for empty pipe, which makes
> NtQueryObject() for ObjectNameInformation block in fhandler_pipe::
> get_query_hdl_per_process. Therefore, do not to try to get query_hdl
> for non-cygwin apps.
> 
> Addresses: https://github.com/msys2/msys2-runtime/issues/202
> 
> Fixes: b531d6b06eeb ("Cygwin: pipe: Introduce temporary query_hdl.")
> Reported-by: Alisa Sireneva, Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pipe.cc | 57 ++++++++--------------------------
>  winsup/cygwin/release/3.5.2    |  4 +++
>  2 files changed, 17 insertions(+), 44 deletions(-)

Looks good, thanks!


Corinna

Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id F26354B9DB52; Fri, 13 Feb 2026 19:29:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F26354B9DB52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1771010985;
	bh=4aVynAiA0uKi/2z0kkhEiw9du2AZolB/DHT7Zz4wS0o=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=oyQ7uj1jUNFGIZn7aMjJXCCsH+GfLLlxTJqwMBQ/XDg/1FolcL2VYXIOmOUTAZ8AF
	 rVmPssIEXlGWghsyGgv6mcVrClVLRTRUMBjD882quczTvkp5ZkqXwjLvs/tMLkEBY0
	 oEk3W2hJk3x80Ys9jRHlOR4iABDmScZh+WHWAsvs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2764CA81C4F; Fri, 13 Feb 2026 20:29:43 +0100 (CET)
Date: Fri, 13 Feb 2026 20:29:43 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: setrlimit: Allow raising hard limit to admin
 users
Message-ID: <aY97p-m_rhZ_zyRc@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260126102908.382993-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126102908.382993-1-corinna-cygwin@cygwin.com>
List-Id: <cygwin-patches.cygwin.com>

On Jan 26 11:29, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/cygwin/resource.cc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Pushed.

Corinna

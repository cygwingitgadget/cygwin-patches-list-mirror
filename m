Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0A5AD3858D32; Fri, 24 Nov 2023 18:31:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0A5AD3858D32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1700850708;
	bh=+hscROGDPEO3p8QYnwcJO9TNquFUiD43mmHuItHXQ5M=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=WrPlkTuKhudmNqnNeIKpuVaolrPctijslPBVhVAZ3gL3jsuXHu0+GfOiCQUVI+MGK
	 dWe42q13U5ltaKSoFDb2THG4R0c5oQAI1kVo0GkJnQxBm5z5sfkui2WkV7faiGuXC4
	 aTPCGAVna0UbVh3L9RL7aLi+CAoCpYAOBNSB73YY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3D00AA80C98; Fri, 24 Nov 2023 19:31:46 +0100 (CET)
Date: Fri, 24 Nov 2023 19:31:46 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add '--names-only' flag to cygcheck
Message-ID: <ZWDsEt2Rfmm4T_f4@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20231124170657.28490-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124170657.28490-1-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Nov 24 17:06, Jon Turney wrote:
> Add '--names-only' flag to cygcheck, to output just the bare package
> names.

Push it!

> ---
> 
> Notes:
>     Rather than more hacky aftermarket solutions, let's make cygcheck output
>     something more useful for feeding into setup.
>     
>     Next step would be to adjust setup's argument parsing so 'setup -P
>     "$(cygcheck -n)"' works as expected.

Or cygcheck could just create a comma-separated list?  Either way is fine.


Thanks,
Corinna

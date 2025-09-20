Return-Path: <SRS0=+GwH=37=m.gmane-mx.org=gocp-cygwin-patches@sourceware.org>
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	by sourceware.org (Postfix) with ESMTPS id F26283858C51
	for <cygwin-patches@cygwin.com>; Sat, 20 Sep 2025 17:25:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F26283858C51
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=m.gmane-mx.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F26283858C51
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=116.202.254.214
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1758389103; cv=none;
	b=Q0cDQpUDT//y9JaoPCYeKUFrmE0NJp1cniumcIgZdh0igCUH8JqTtLy1GoAOFqrkTm2jVN56H7qG3qil6UB4dQGMvsRoZpq0SvTLCG5r3XujTXdvA3y1vCmag70ZxSI/p6/Lkz9wvdlRYxLc8P+7c0vOmZruIQK5wbwPCyY8KRI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1758389103; c=relaxed/simple;
	bh=cMMuySG73TdoIDe4TPl/92StqrACdK97Hu/8JtSTJ2E=;
	h=To:From:Subject:Date:Message-ID:Mime-Version; b=X4qbHstTQFTpFs43JQwl+jHY8KlR9+RKGbse3P+zIlUXE63ggRY8OOzWzxCeepGBoxlYTrcdFaUCSEr5UgsPf7OKfnHTmmlWZDtDvHewBgwXzyT0u74jwWDp5rS+o5Ky2J9+34wdAdfcxmZdYmqlpc2Ji/+JdCdapTwvwrQJTvg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F26283858C51
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gocp-cygwin-patches@m.gmane-mx.org>)
	id 1v01KY-0006ZN-1V
	for cygwin-patches@cygwin.com; Sat, 20 Sep 2025 19:25:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: cygwin-patches@cygwin.com
From: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Cygwin: math: Add AArch64 support for sqrt()
Date: Sat, 20 Sep 2025 17:19:49 +0100
Message-ID: <040f4e8d-3fd8-4c61-b0bc-8a8d3683785f@dronecode.org.uk>
References: <MA0P287MB308276F1ACA00942D9BEAE6D9F22A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <4335043f-7b4c-4147-65e6-de0199da413f@jdrake.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Content-Language: en-US
In-Reply-To: <4335043f-7b4c-4147-65e6-de0199da413f@jdrake.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HEADER_FROM_DIFFERENT_DOMAINS,KAM_DMARC_STATUS,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>
Message-ID: <20250920161949.85T7nfcRfwRjm0tV1XwIhFWn31PfYy3uQEqVRtJS2qY@z>

On 13/08/2025 18:33, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 5 Aug 2025, Thirumalai Nagalingam wrote:
> 
>> Hi all,
>>
>> This patch adds support for the `fsqrt` instruction on AArch64 platforms
>> in the `__FLT_ABI(sqrt)` implementation.
> 
> This looks OK as far as it goes, but I have a few thoughts.
> 
> From the comments, it appears this code originally came from mingw-w64.
> Their current version of this code has aarch64 implementations.  The
> difference with this one is they have a version for float as well as
> double.  The versions here seem to only be used for long double (which on
> aarch64 is the same as double).
> 
> Given that long double is the same as double on aarch64, might it make
> sense to redirect/alias the long double names to the double
> implementations in the def file (cygwin.din) on aarch64, rather than
> providing two different implementations (one in newlib for double and one
> in this cygwin/math directory for long double)?  It seems like that's
> asking for subtle discrepancies between the implementations.  I'm not
> seeing any obvious preprocesor-like operations in gendef (mingw-w64 uses
> cpp to preprocess .def.in => .def files for arch-specific #ifdefs) so
> maybe this would be more complicated.

Sorry about the long delay looking into this.

So, I was about to apply Thiru's v2 patch, since that all seems 
reasonable to me. But now I'm not so sure...

I think that a good goal is to keep this file aligned with the mingw-w64 
version, if possible.

If I'm understanding correctly, if we do that, this problem goes away, 
but at the cost that fsqrtd and fsqrtl are potentially different 
(although surely since it all boils down to a single instruction, that's 
never going to happen :) )?



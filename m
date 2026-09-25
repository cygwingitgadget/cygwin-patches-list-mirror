Return-Path: <SRS0=X1Yk=HR=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id A735C4BB58C6
	for <cygwin-patches@cygwin.com>; Fri, 25 Sep 2026 00:29:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A735C4BB58C6
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A735C4BB58C6
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790296161; cv=none;
	b=FJHEGDxvew6Y7MgGQhwvBp/urXfkk7vRdYCNOGD5wJnS5q+tXRY8syjz0rEW9EMWik/N6Oiq8uiaWD0iNNKWBr4vM66Qm5X/u2RqpaRqSvqfvHnEE75w8bs9ps1RcIXbtnwsY/p7tURf7M1C3Vnw9ZSwGAGHC7M+R2xIAWgnvHI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790296161; c=relaxed/simple;
	bh=YHPTC28F1X8tDamOlM58FvDuay3aInduvMoEGgCiTSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=oUg2S1WYwae1U+FTl3ojMzVAav/gPSme92g9vuSY34HUZrDtrmjQqJ5tn4pT412YzB5ruBy++NgzDL9YzoPXEuVBQODb9BzNWrQQn4wbb+YK7LpkQqra1VKzYRAKiFarhbnInzdCmaYUomMsQo5fkB/rL6fZJ9IwRaRRuFdlnQQ=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A735C4BB58C6
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 68P0h7tD009347
	for <cygwin-patches@cygwin.com>; Thu, 24 Sep 2026 17:43:07 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdKrZEgC; Thu Sep 24 17:42:58 2026
Message-ID: <c251f9bf-1881-47bd-a4a4-3a14b6f542f0@maxrnd.com>
Date: Thu, 24 Sep 2026 17:29:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cygwin: define IPTOS_DSCP_VA in netinet/ip.h
To: cygwin-patches@cygwin.com
References: <20260920043247.4589-1-omikorin@disroot.org>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260920043247.4589-1-omikorin@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello Michał,

On 9/19/2026 9:32 PM, Michał Korczak via Cygwin-patches wrote:
> Define IPTOS_DSCP_VA (0xb0) according to RFC 5865 to complete the DSCP
> code point definitions in <netinet/ip.h>. This fixes compilation for
> utilities like openbsd-netcat.
> 
> I provide this patch to the Cygwin sources under the 2-clause BSD license.
> 
> Signed-off-by: Michał Korczak <omikorin@disroot.org>
> ---
> v2: Fix whitespace formatting to match surrounding code style.
> 
>   winsup/cygwin/include/netinet/ip.h | 1 +
>   1 file changed, 1 insertion(+)
>   
>   winsup/cygwin/include/netinet/ip.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/include/netinet/ip.h b/winsup/cygwin/include/netinet/ip.h
> index 5db1bd9ce..8b67a5c6e 100644
> --- a/winsup/cygwin/include/netinet/ip.h
> +++ b/winsup/cygwin/include/netinet/ip.h
> @@ -83,7 +83,7 @@ struct ip {
>   #define IP_MAXPACKET	65535	/* maximum packet size */
>   
>   /*
> - * Definitions for DiffServ Codepoints as per RFC2474
> + * Definitions for DiffServ Codepoints as per RFC2474 and RFC5865.
>    */
>   #define IPTOS_DSCP_CS0		0x00
>   #define IPTOS_DSCP_CS1		0x20
> @@ -103,6 +103,7 @@ struct ip {
>   #define IPTOS_DSCP_AF42		0x90
>   #define IPTOS_DSCP_AF43		0x98
>   #define IPTOS_DSCP_CS5		0xa0
> +#define IPTOS_DSCP_VA		0xb0
>   #define IPTOS_DSCP_EF		0xb8
>   #define IPTOS_DSCP_CS6		0xc0
>   #define IPTOS_DSCP_CS7		0xe0

Thank you for the v2 patch.  It looks good to me and will shortly be 
added to the queue for 3.7.0.

..mark


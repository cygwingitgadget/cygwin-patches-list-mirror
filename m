Return-Path: <SRS0=3eZc=GX=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id 8B3DD3858D1E
	for <cygwin-patches@cygwin.com>; Fri, 10 Nov 2023 06:17:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8B3DD3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8B3DD3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=3.97.99.32
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699597038; cv=none;
	b=SVCVCvtEv6h06LBLZVKmLotpkycr7N8iQ9gdzyDcD7OU13g52i3ohNi2e48tuwtoUJ+jGIWPCD7SJYW+5tpWEm/82aJr7rUj68k32WD98wVxKcWt+l4Y8j6cSR2+XAL26ZSiwnzbC4WTI+0AGVH8WVDZJ1NpeFZ6GAWX1hiiOgw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699597038; c=relaxed/simple;
	bh=ZmLpqfH27Hb2xOOAM61JeAjc1sF4aermeeOJjmzq/N8=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From; b=QHOeo7Mqz7vcIg6NBpX8+DrAcGkK92tx4lSL3OAzjAvh4UgbZHAFe0pXB5fqbYhVrDf2/jpoXFSEINTJ5L0vzs3KOMLuSWGoNTkf04LV4uh8jeaSR8O4z2U7z1n4XCHDq03LIQML/I5J7qxSfjOQmdYZfi318aUt7umhUyrC2uo=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTPS
	id 1DU2rahSU8jpT1KpPrPgJb; Fri, 10 Nov 2023 06:17:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1699597035; bh=ZmLpqfH27Hb2xOOAM61JeAjc1sF4aermeeOJjmzq/N8=;
	h=Date:Reply-To:Subject:To:References:Cc:From:In-Reply-To;
	b=NDA7ZlXsvR82W8Rc/XJLs50f4soETDVivdLve7s+np4yRWuyCgNmIdAZjwlZCXNJt
	 lbBbnbq92LTeQ3o2h7/wxfBNkUZIzsxqcaOKiCp6r1SPVNaVDxdhG0ajXWy3kTjIDh
	 GKF+0nF8IP6avlCLyzIGOQ7YCUHo9NNVXFER15RPBMgO9U3SdAHmBpWKI1J7MSmsy4
	 yT6PvkQ5kV7GA9qLhCnf1BjQGBpljSeJYfzWVKtWdpvSquu197ru52mkz0joGkn3SM
	 xFN8SSs387rPzNahYx4ijXHjD0zTF/q35vcGC0qYf0X9Ug3CC1p8R5jTZIo+KGC2iO
	 QE2ApZ1anahxQ==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id 1KpPrHeR6nCF01KpPrQjRj; Fri, 10 Nov 2023 06:17:15 +0000
X-Authority-Analysis: v=2.4 cv=MPFzJeVl c=1 sm=1 tr=0 ts=654dcaeb
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=NYT1OYH1IqJ5UZa0yygA:9 a=QEXdDO2ut3YA:10
Message-ID: <4801ab90-2958-4fa2-87f2-21efdb41bbf4@Shaw.ca>
Date: Thu, 9 Nov 2023 23:17:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix(libc): Fix handle of %E & %O modifiers at end of
 format string
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20231109190441.2826-1-pedroluis.castedo@upm.es>
Cc: Pedro Luis Castedo Cepeda <pedroluis.castedo@upm.es>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <20231109190441.2826-1-pedroluis.castedo@upm.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIiWHoKZC0rb1imZV5ZxUHhXUPs8mmAxizLKJzOxyffVetCMrkJKgKZUb2YPrFR+2MyySnrUNdmWKSuqSBCcRSioqQ/I8OqQDe71E1WEOfywkMzy0/ux
 +YfuF2e+0iqBE0eOm1vHkFVltxJ8p/4hbjzk6GNGwKZJ9L8M4VLgAQk8bHJnMEAIiXbAsItN3wd0IHEpZ8Po8Ly7fhGaKruFNPovsln8xrqY8rI+opUBMJK7
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-11-09 12:04, Pedro Luis Castedo Cepeda wrote:
> - Prevent strftime to parsing format string beyond its end when
>    it finish with "%E" or "%O".
> ---
>   newlib/libc/time/strftime.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/newlib/libc/time/strftime.c b/newlib/libc/time/strftime.c
> index 56f227c5f..c4e9e45a9 100644
> --- a/newlib/libc/time/strftime.c
> +++ b/newlib/libc/time/strftime.c
> @@ -754,6 +754,8 @@ __strftime (CHAR *s, size_t maxsize, const CHAR *format,
>   
>         switch (*format)
>   	{
> +	case CQ('\0'):
> +	  break;
>   	case CQ('a'):
>   	  _ctloc (wday[tim_p->tm_wday]);
>   	  for (i = 0; i < ctloclen; i++)

These cases appear to already be taken care of by setting and using (depending 
on the config parameters) the "alt" variable for those modifiers, and the 
default: return 0; for the format *character* (possibly wide) not matching 
following any modifiers.

Patches to newlib should go to the newlib mailing list at sourceware dot org.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

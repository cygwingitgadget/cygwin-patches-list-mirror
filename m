Return-Path: <SRS0=gsD5=CR=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by sourceware.org (Postfix) with ESMTPS id C805E4BA23DE
	for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 07:29:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C805E4BA23DE
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C805E4BA23DE
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776497373; cv=none;
	b=NEnvUoCsbDkQlYU9bgWd6QbCIUJIXK8pb14Kclz7nTCdLJf9KTMVcG1rKjymiLEagpSNR40L9CEHcEAs4bm1m3XNnLViRu9Dj3QM08Io/SqSofZwLzAHqwQucmpTGmVFcb1SjfqA6cO6i7qGqT5Odq+NGz0YEjAkBtjUzY+uAr8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776497373; c=relaxed/simple;
	bh=be9DMcGl6cJ8tZ5L0GT8XuTxtYOx5WAyGS9nhptpcyI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=mbME14iMq86iimy2BauSm8zrcpk5FjNHCbDMttD/iDOWkcyOcHdAuA4ZKrjJlzTU0/Syj2wygzU+WEw+6zag1PW/HuKe5EDoBC2yWZoWh9Qy0OZTb2X7cU/IEpJT4GYAy4+zjnbf3VELICnWzFHC4KHfUG4noADmqEB1wCJpmoM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C805E4BA23DE
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=kYrPex+R
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 1CE36E43F8
	for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 07:29:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id 79DDD20034
	for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 07:29:30 +0000 (UTC)
Message-ID: <1d28c50c-1a25-498d-a556-858e3c1dc052@SystematicSW.ab.ca>
Date: Sat, 18 Apr 2026 01:29:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: cygwin-htdocs: website fresh coat of paint
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <69e1cbb2.530a0220.249b6f.22da@mx.google.com>
Organization: Systematic Software
In-Reply-To: <69e1cbb2.530a0220.249b6f.22da@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: hq59rojt9u3eikkz3p88wonbwjyhofur
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 79DDD20034
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_SHORT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+urwpT5IwVv3MykyYIDvjV7hSrXMRG/s0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=UaIrcoghv+Wbv+9ZJxXEekNXoJpKBE0plbHnUDphD8c=; b=kYrPex+RjYptEtsUV0c/hDLNeSyjLnyJ244zrG6ykKPmQj9qECtngRozeBIt1yufRJEq44d5q6xXdh8drfqbY+aFO8M/g/ah8SIZtukZm0hXrNa2DPUcsQPW9t8U4T/D3xhZ4kjFvS0PdpEBsBXN6oTH2gI+5R1yMIxxihMfd0kCNeMDrBRTvlTVn3FH86Dshoxk231xtf+IrGWJIMp4tAEQOrV+9VoztasJCfJqNybaVwTCksSt3ixIoDS3YiKY1DU4+DlTRZZNfz7cnWLRIFU8EO4DQGbTaooWny3W/O/JHGT3U2EkveqRVchfXlbPQbEP12C+UZKD8fBPebf8hQ==
X-HE-Tag: 1776497370-508959
X-HE-Meta: U2FsdGVkX18FhJpajiwBO40eRQcYvWxJFXhmd8+no9NvBi5c2Yl6AN33WTpdicTrbHqUx7rOy0yan23L4Vrezd608jVncPpU4tMN9CgOpg503zWi3Nqw4ZCiMW0a4XOkpcRQQzUiWf92XWVsOF1MJZeVC3I4e5ZKgU6hZDQM7qyel5+pidn+KsUQVIE1yhrFu14ONHMMNt9rHA1C42cF1mTSPVFj0Ee+WmGRtSfnOBOJF/y/9gkSrgpHtiY/gdMZxC2G0rycVxtZWUqP0oYvsOD9xbPJNq6X86CyvUjZSn6INlD64wK44ZBoggtDi9D+Hywxs1USbcHiRcqykfu1wu4g2K1dW8loGGcCwp6E4ba4DwQ1l6GL/MDkVWuztOPgh5pNhPrCK3JjQR/ShsQ4F6mC7dLxEHNejqOlB8G/P57qYUR5U0afKq1BKFt6jsFE09I5bUNZlEjBX9SrutcemZTn3wwGthKOJCmGKFiD8aVnZzGPfqQAlIw7ukwmGDQF720BRtdaJ9eS95mzTAS7yLx6MDQnCFtJE0NztXQifuonZXmLpqPWUwdKhltNcPmNWuCF1pJwU0G4DZrxIcu9vm2rt1ztz+s2D4xULQndbA4=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi John,

While all this work and rationale sounds like it should improve the site, could 
you please add more documentation details within each change to explain the 
content of each change and its visual impact, for example:
   content: "\2B50"; /* U+2B50 WHITE MEDIUM STAR */

The image below looks like the Wikipedia article logo, which has an unknown 
author and licence, but could do with a text description, and mentions after the 
paths, for example:

/* Black shaded squarish C with triangular points and grey outline */
<path 
d='M94,19l-28-9h-39c-9,0-19,9-19,19v47c0,9,10,19,19,19h39l28-10l-28-9h-26c-9,0-13-3-13-13v-22c0-10,4-13,13-13h26z' 
fill='#000' stroke='#000'/>
/* Green shaded Arrow Head within bowl of Black C */
+<path d='M94,52l-41-11h-13v3c10,0,10,16,0,16v3h13z' fill='#0F0' stroke='#0F0'/>

and not as nice as the apps/setup/cygwin.ico Copyright 2011-08/9 Warren Young, 
licensed under some GPL I believe, as no other license is attached on the lists 
or in the repo? Mentioned were FAL, CC0, and PD.

Then could you please include those details under your description below as the 
log message in each patch consisting of a patch summary line, a blank line, then 
the details, then put all those in a cover letter [PATCH 0 of #] as the zeroth 
attachment or post, generated by git format-patch then send-email, including a 
Signed-off-by (-s) header.

It would also be useful to see the visual impact on an updated web site built 
using the provided scripts, allowing an A/B comparison of the effect.


On 2026-04-16 23:57, johnhaugabook@gmail.com wrote:
> Attached are several patches that update the site's UI/UX. As a whole, this is a fresh coat of paint for the website. For a full demonstration of all the patches applied to the site, see this support repo:
> 
> https://github.com/jhauga/cygwin-htdocs
> 
> For the debatably controversial patches, I added nested links to UX/UI research in support of the "whys".
> This mostly consists of links to UX/UI studies, and the research takeaways.
> 
> Apart from that the nestetd list items are the corresponding patch name, or additional info.
> 
> Changes include:
> 
> - Clean style.css, making consitent formatting
>    - clean-style.css.patch
> - Fixed menu position
>    - fixed-menu-position.patch
> - Logo added to top.html
>    - add-logo-to-top.html.patch
>    - Gets better user recall - https://www.nngroup.com/articles/logo-placement-brand-recall/
>    - NOTE - logo downloaded from `https://commons.wikimedia.org/wiki/File:Cygwin_logo.svg`
> - Menu font weight applied hierarchically per menu section
>    - font-weight-applied-hierarchically-per-menu-section.patch
>    - Differentiate text levels - https://medium.com/@oluwanifemiajayi61/typography-hierarchy-3ed06c206ea7#:~:text=Using%20weight%20strategically%20prevents%20visual%20clutter
> - Prepend a HTML star entity the "Gold Stars" menu item
>    - add-html-star-entity-for-the-Gold-Stars-menu-item.patch
>    - Draw attention to item and clearly labels it as not the current page - https://www.netwaveinteractive.com/blog/visual-hierarchy-in-ui-ux-design-principles-strategies-and-best-practices/#:~:text=enhance%20hierarchy%20by%20breaking%20up%20text
> - Change HTML `h1` header's font family to system-ui
>    - h1-header-s-font-family-to-sans-serif.patch
>    - Keeping other text as serif makes for good visual contrast
>    - Sans serif is best for digital:
>      - https://ixdf.org/literature/topics/typography#:~:text=preferable%20for%20digital%20interfaces
>      - https://medium.com/the-interaction-design-foundation/the-ux-designers-guide-to-typography-7ddf87288123#:~:text=preferred%20for%20digital%20interfaces
> - Style `code` HTML elements
>    - style-code-HTML-elements.patch
>    - I mean - I'd ballpark it at 90% of website that have software documentation apply background color to code blocks
> - Style `pre` code-blocks
>    - style-pre-code-blocks.patch
>    - Same for `pre` tags that hold code examples; at least 90% of software docs, blogs, articles, etc. use a differentiating background color for code-blocks
> - Link hover UX effect
>    - link-hover-UX-effect.patch
>    - Users expect hover effects, and essentailly a web standard - https://www.nngroup.com/articles/guidelines-for-visualizing-links/#:~:text=hover%20states%20have%20become%20a%20standard%20and%20expected%20interaction%20pattern
> - Responsive styling
>    - responsive-styling.patch
> - Use CSS variables for colors to keep DRY (Do not Repeat Yourself)
>    - css-variables-for-colors-to-keep-DRY.patch


-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

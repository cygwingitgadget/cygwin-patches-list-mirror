Return-Path: <SRS0=puQu=DB=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.159])
	by sourceware.org (Postfix) with ESMTP id C0C424BA23C1
	for <cygwin-patches@cygwin.com>; Mon,  4 May 2026 18:52:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C0C424BA23C1
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C0C424BA23C1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.159
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1777920772; cv=none;
	b=UIpfaLx7g+34TUODM9qsiVrBk7G1+qagAZ5Ih2xOp51jb8cdrNbP+M1bGIcS0FiEN2trKZNPnVjQeZMfsoxdNzNB6Mdr04toAg5uALCqctDPmAezPOdYYHkKweK7PVT+rCSe+7q8rPlMgC2d9PZ67Cn/SKBekNa9abgq+n9TKqs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1777920772; c=relaxed/simple;
	bh=a9ALgzpC9FXb2eBeGsKibmbT4T2klU4QK3civr7iv1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=VSSkcoS7prnBuPQsQ2N32/lCJL+7FXzdMiZNHetGljqtjuSngUH9olo5oRmlnpNOMrZRL62riBt3PairIZFzB4FZHiaHHMjjtkuALYPM+kwrbVHbHJemaZUI5NfqOjBWDb+TjTKo/k01oq2TNr22oeEmXYp1yk+6OE6rdKKgJJg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C0C424BA23C1
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69E78BF201114F7C
X-Originating-IP: [90.249.142.63]
X-OWM-Source-IP: 90.249.142.63
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTGiT+Kb/0oY7pQCPigXu1YnoQHrlPhBiVneRFvjQjUzHA5kePxz8szxzNAZALTP5WRbjv2AdI+Z9oZQc8NRwB6XmA7dp/XgrMUvCSb3SwA0LoNmHZCY3y+i18hpkljIejwgd9D1F0a2R+70h/L4S1QSdKapGYzc6FJ6VD0QMfeTT3XmmvffI+xBGki7jLbpE6cXlPSigAuJnf03SH0rZ4pffbA235fxH/uqHXIN0fRehCAz/1IbGkkCWxw21R8n1+6ICYqPACZGyMnttiMDFM0u/QoftnSKlQauumjflpFiueA8nOercGCTSRky7HZgO8fU7DC9+Q2U6fWUmu4nykQlsPxhTh6FBGdxu876BNCTPGcz1lUELA2MsXlOIt1pGpD9pbgjR8Z+varjrOWka9dsdrX3Px3tMlwRSFfzECKNo2TKMn/wRwlZ6SUz5bcHJ5DrmXrvMQvtYJ2MniQgnNItAar2fn7EieRLgHH/GeeKXGMoGcVBrlX+ZCxUbwY1m1wVK8QUEJE+AQ64hYumBN6IvB/3lKRPmc7JMJdErns/IHbpPCse8iHc+jZqgR56P7oMrsGP1Iw0hiZxJSnrUf6HQbadwWnIWm0SNg58LGpfMJ9Ifmd1xD1GdIESsEW9eXCG+Pxf9ozOtBIqX6qad5EtnsCiQguT7Xzwo2wfG+iiGQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (90.249.142.63) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69E78BF201114F7C; Mon, 4 May 2026 19:52:45 +0100
Message-ID: <3fad00d1-a511-464e-afa7-8ba2957f6f40@dronecode.org.uk>
Date: Mon, 4 May 2026 19:52:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] cygwin-htdocs: website fresh coat of paint
To: John Haugabook <johnhaugabook@gmail.com>
References: <20260419052701.513-1-johnhaugabook@gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20260419052701.513-1-johnhaugabook@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 19/04/2026 06:26, John Haugabook wrote:
> This is an updated, duplicate of a recent PR. It consist of 11 small patches that
> when put together as a whole give the website a fresh look. A fresh coat of paint
> so to speak.
> 
> Sorry for so many patches, but each is specific, making it easier to pick and
> choose which to apply. The changes (for the most part) are also very small. And
> since they are in regards to visual aspects, GitHub Pages (thanks Johannes!) is
> used in order to demonstrate and compare the proposed changes to the current site.
> To toggle the changes quickly press "cc" on the keyboard. The link is:
> 
> https://jhauga.github.io/cygwin-htdocs/index.html

Thanks very much for working on this!

Sorry it took so long for me to get around to looking at these patches.

I've applied several of these, but I have a few comments on the rest.

>> On Sat, Apr 18, 2026 at 3:29 AM Brian Inglis <Brian.Inglis@systematicsw.ab.ca> wrote:
>> Subject: cygwin-htdocs: website fresh coat of paint
>>
>>> The image below looks like the Wikipedia article logo, which has an unknown
>>> author and licence ...
> 
> I created a new SVG for "0003-add-logo-to-top". I'm waiving any licensing rights I
> might have to it, so - whatever license you want to apply; it's yours.
> 
> It is very similar to Warren Young's icon/logo `apps/setup/cygwin.ico`.
> The differences are:
> 
> - The 3D bevel effect is flatter as the website has a flat layout
> - The light pixelated outline is removed, which matches the background better
> 
> Below are the details of each patch in this pull request:
> 
> - 0001-clean-style.css.patch
>    - Add consistant indentation and formatting to `style.css`
> 
> - 0002-fixed-menu-position.patch
>    - Keep the side menu in a fixed position for better UX
>    - 100% of 40 users in a study preferred fixed menu:
>      https://usabilitygeek.com/how-to-fix-your-fixed-navigation/#:~:text=one%20hundred%20per%20cent%20of%20them%20preferred%20a%20fixed%20navigation
> 
> - 0003-add-logo-to-top.html.patch
>    - A new media file "logo.svg"
>    - Add the Cygwin logo/icon to the "top.html" fragment
>    - Update "style.css" to position and size "logo.svg"
>    - Gets better user recall:
>      https://www.nngroup.com/articles/logo-placement-brand-recall/

This seems like a really good idea!

I have a couple of questions though:

Sizing the logo in pixels doesn't seem like a great idea? Would it not 
make more sense to size it relative to the font height?

I'm not sure how you generated this svg (and I don't have the original 
file immediately to hand), but it just contains an embedded png image. 
Is it possible to do this in a vector form, instead?

> - 0004-font-weight-applied-hierarchically-per-menu-section.patch
>    - Makes visual scanning the menu easier, applying font weight and size to infer
>      categorical hierarchy
>    - Differentiate text levels:
>      https://medium.com/@oluwanifemiajayi61/typography-hierarchy-3ed06c206ea7#:~:text=Using%20weight%20strategically%20prevents%20visual%20clutter
> 
> - 0005-add-html-star-entity-for-the-Gold-Stars-menu-item.patch
>    - Use HTML encoding to add a start icon the the menu item "Gold Stars"
>    - Draw attention to item and clearly labels it as not the current page:
>      https://www.netwaveinteractive.com/blog/visual-hierarchy-in-ui-ux-design-principles-strategies-and-best-practices/#:~:text=enhance%20hierarchy%20by%20breaking%20up%20text

This is one I'm not sure about.

This page isn't that important. It's only due to an accident of "design 
by developer" that it's distinguished by colour at all.

Maybe we ought to just drop that?

> - 0006-h1-header-s-font-family-to-sans-serif.patch
>    - Set the font family to sans serif for `h1` tags
>    - Keeping other text as serif makes for good visual contrast
>    - Sans serif is best for digital:
>      https://ixdf.org/literature/topics/typography#:~:text=preferable%20for%20digital%20interfaces
>      https://medium.com/the-interaction-design-foundation/the-ux-designers-guide-to-typography-7ddf87288123#:~:text=preferred%20for%20digital%20interfaces

I wonder if we should just switch to sans-serif throughout? or just stop 
specifying the font-family altogether?

> - 0007-style-code-HTML-elements.patch
>    - Adds a background color to all `code` tags, using the menu color at
>      20% opacity
>    - I mean - I'd ballpark it at 90% of website that have software documentation
>      apply background color to code blocks
> 
> - 0008-style-pre-code-blocks.patch
>    - Adds a background color to all code-blocks, using the menu color at 20% opacity
>    - Same for `pre` tags that hold code examples; at least 90% of software docs,
>      blogs, articles, etc. use a differentiating background color for code-blocks

I'm sure this is fine, but I'd be interested to know where we're using 
<pre> without a class.

It's might be a good idea to add a class in those places to indicate how 
we're using it?

> - 0009-link-hover-UX-effect.patch
>    - I hover effect for all `a` tags
>    - Users expect hover effects, and it is essentailly a web standard (cursor: pointer):
>      https://www.nngroup.com/articles/guidelines-for-visualizing-links/#:~:text=hover%20states%20have%20become%20a%20standard%20and%20expected%20interaction%20pattern
> 
> - 0010-responsive-styling.patch
>    - Really simple responsive CSS added to style.css
>    - A new fragment file; "head.html" - adds the required `meta` tag for responsive HTML

Uh, not sure what the benefit of this is.

On phone sized screens, most of the space is taken up by the navigation bar?

(although making it look better on screens of that size is something I'd 
very much like to fix, but I think that probably involves a lot more 
restructuring?)

> - 0011-css-variables-for-colors-to-keep-DRY.patch
>    - This adds CSS variables to colors that were used in the current style.css 2 or more
>      times, keeping the CSS DRY (Do not Repeat Yourself)
Good idea! But this is kind of hard to apply after the others. Perhaps 
you can provide a rebased version?


Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 857524BA23FD; Sun, 19 Apr 2026 10:25:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 857524BA23FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1776594331;
	bh=LkroA2Y4hKhfYbbTpK9RUxmxk6Tm6fsL7gHaYthWzmw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vDiYAJvGu4+kIgQ164m9in0MOScGfBoOyj0RWdhdafKx5xo3Daqm+cuww1KweM25z
	 X3R/+UEb/xCX2oDoTAHf0lwdQk8OisffNlb578HWxPqO0MoR7hpHk4by19AKykobeY
	 8dsNvRbBBgUQZaRUFdd4B4mLGWcfxmFS0+JQNMX8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5EFCFA8096D; Sun, 19 Apr 2026 12:25:29 +0200 (CEST)
Date: Sun, 19 Apr 2026 12:25:29 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH 00/11] cygwin-htdocs: website fresh coat of paint
Message-ID: <aeStmeiBYWp4iVKM@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Jon Turney <jon.turney@dronecode.org.uk>
References: <20260419052701.513-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260419052701.513-1-johnhaugabook@gmail.com>
List-Id: <cygwin-patches.cygwin.com>

Hi John,

Thanks for this!

I guess it really doesn't hurt to update the look of this site, which is
kinda stuck in the early 2000s.

Jon, would you mind to review this patchset?


Thanks,
Corinna

On Apr 19 01:26, John Haugabook wrote:
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
> 
> > On Sat, Apr 18, 2026 at 3:29 AM Brian Inglis <Brian.Inglis@systematicsw.ab.ca> wrote:
> > Subject: cygwin-htdocs: website fresh coat of paint
> >
> > > The image below looks like the Wikipedia article logo, which has an unknown
> > > author and licence ...
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
>   - Add consistant indentation and formatting to `style.css`
> 
> - 0002-fixed-menu-position.patch
>   - Keep the side menu in a fixed position for better UX
>   - 100% of 40 users in a study preferred fixed menu:
>     https://usabilitygeek.com/how-to-fix-your-fixed-navigation/#:~:text=one%20hundred%20per%20cent%20of%20them%20preferred%20a%20fixed%20navigation
> 
> - 0003-add-logo-to-top.html.patch
>   - A new media file "logo.svg"
>   - Add the Cygwin logo/icon to the "top.html" fragment
>   - Update "style.css" to position and size "logo.svg"
>   - Gets better user recall:
>     https://www.nngroup.com/articles/logo-placement-brand-recall/
> 
> - 0004-font-weight-applied-hierarchically-per-menu-section.patch
>   - Makes visual scanning the menu easier, applying font weight and size to infer
>     categorical hierarchy
>   - Differentiate text levels:
>     https://medium.com/@oluwanifemiajayi61/typography-hierarchy-3ed06c206ea7#:~:text=Using%20weight%20strategically%20prevents%20visual%20clutter
> 
> - 0005-add-html-star-entity-for-the-Gold-Stars-menu-item.patch
>   - Use HTML encoding to add a start icon the the menu item "Gold Stars"
>   - Draw attention to item and clearly labels it as not the current page:
>     https://www.netwaveinteractive.com/blog/visual-hierarchy-in-ui-ux-design-principles-strategies-and-best-practices/#:~:text=enhance%20hierarchy%20by%20breaking%20up%20text
> 
> - 0006-h1-header-s-font-family-to-sans-serif.patch
>   - Set the font family to sans serif for `h1` tags
>   - Keeping other text as serif makes for good visual contrast
>   - Sans serif is best for digital:
>     https://ixdf.org/literature/topics/typography#:~:text=preferable%20for%20digital%20interfaces
>     https://medium.com/the-interaction-design-foundation/the-ux-designers-guide-to-typography-7ddf87288123#:~:text=preferred%20for%20digital%20interfaces
> 
> - 0007-style-code-HTML-elements.patch
>   - Adds a background color to all `code` tags, using the menu color at
>     20% opacity
>   - I mean - I'd ballpark it at 90% of website that have software documentation
>     apply background color to code blocks
> 
> - 0008-style-pre-code-blocks.patch
>   - Adds a background color to all code-blocks, using the menu color at 20% opacity
>   - Same for `pre` tags that hold code examples; at least 90% of software docs,
>     blogs, articles, etc. use a differentiating background color for code-blocks
> 
> - 0009-link-hover-UX-effect.patch
>   - I hover effect for all `a` tags
>   - Users expect hover effects, and it is essentailly a web standard (cursor: pointer):
>     https://www.nngroup.com/articles/guidelines-for-visualizing-links/#:~:text=hover%20states%20have%20become%20a%20standard%20and%20expected%20interaction%20pattern
> 
> - 0010-responsive-styling.patch
>   - Really simple responsive CSS added to style.css
>   - A new fragment file; "head.html" - adds the required `meta` tag for responsive HTML
> 
> - 0011-css-variables-for-colors-to-keep-DRY.patch
>   - This adds CSS variables to colors that were used in the current style.css 2 or more
>     times, keeping the CSS DRY (Do not Repeat Yourself)
> 
> John Haugabook (11):
>   clean style.css
>   fixed menu position
>   add logo to top.html
>   font weight applied hierarchically per menu section
>   add html star entity for the 'Gold Stars' menu item
>   `h1` header's font family to sans-serif
>   style `code` HTML elements
>   style `pre` code-blocks
>   link hover UX effect
>   responsive styling
>   css variables for colors to keep DRY
> 
> -- 
> 2.46.0.windows.1

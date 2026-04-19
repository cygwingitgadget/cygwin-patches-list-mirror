Return-Path: <SRS0=C0l8=CS=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by sourceware.org (Postfix) with ESMTPS id 2415B4BA9009
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 05:27:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2415B4BA9009
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2415B4BA9009
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::112b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776576436; cv=none;
	b=ctSgIjEfZ+w2OE4o1wh2LswKAxnJpzIW2E8gMSqry6Eir4j3AFsuROe1EH0z3aXUtYv5LNwsJ16a81DeFwyIFwLcL+DGxwlg2K3vHjw0sRHjPOqRkBTdZ6LLr1iw6/5TNkscvn5lM+WkN2ftIu+lMoyyfE0zLLaVxUEhi4LDl7U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776576436; c=relaxed/simple;
	bh=TMIA2s+weUbdT0IncPQ1gu5MeKQZM3+BWhXP0IdlA9w=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=X8MWGaRycrLoapNmk32xsEmHoRjRcfk2brPYtCxRwWUOXGo1OJK5m6fjDJGqV3WUYTCv05Yx4/iygG1TZtR7IHFw6crodkEo7OvQJJkjvHexUXai2+npR2FWLZyBZ8gI/GYkTMMLvNOPLJ9WfjY6DGd3dLS0FHSK+6f+ARPxkqs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2415B4BA9009
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ilJ4sj8A
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-7986e538decso17471467b3.1
        for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 22:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776576435; x=1777181235; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FF5A907MRYsoJt1zYkemYYVi2NSq4GCw78aOqoxt+ig=;
        b=ilJ4sj8Au4/pGpsT1+jpUPdxux13FdbDRIRyEJEaXYU/0ILQE5MGTMrI5HSDShjeiL
         LaS28GcpjzNyh/7qcyP/x7oo7WPQyiVMt4WijJ+wT4iVx0OXFnKgqWL6CcKRYhAgwd7a
         F1HTbtuEBGvXt4ZRh6yc3GKJ/V5tDLTtJcFsmMDG3B0K6A7Y8334NnD9MXaleJKrwW8A
         BA2DZ2jO+WpaUiknVZRiELxZ3Fs275Gd+6lga1AJAMhxAI7JAXj2Vlhq8ke4s8AeNYVl
         UYOr1Mu2oRp7VynvuiOjI20ruXNZ4k7iO9w9OXPo2e6Uz9rp60muAfKzen2LtJpd7mYg
         HzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776576435; x=1777181235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FF5A907MRYsoJt1zYkemYYVi2NSq4GCw78aOqoxt+ig=;
        b=IrI0VVXxY/Nb56TRd90g+3mtaSFGyCGWnEo6gde9jbCvAixV11bBBMBrw/+gU6u0Pc
         Ry/+/aWSB9K53X164O8Bqp99VkmSjzSXfM3sm/IYbUmhtcjZdO49ao7DxkRLNWvMIi+B
         BPIaEXWwgCk6SDOhrOAbCCM6wJUNqYT5cCfAX1V5WY4uQETkSjF+gGSvoYrG2quOszWz
         m27D3iBf+rDF01AFVKw/XoglQLVds4BW+3drVBAjR2o/9mQEJDebvCov3r0RUL4q6//Q
         LsfFLx8MOrQawZ5FNyALPP9/ZHCbI428xTncG3XKZe7f02wn0L7laJaqbRyIXX09pJQV
         58jw==
X-Gm-Message-State: AOJu0YyF3Gnp2QFXFH8cHQ8kDwfgbQLqCmedebpPo9ixQv30/b41PCBX
	JukpaOEBS4HgLwX33bo9GeSTv8AHUp2eJYwkFFtW7156gZfALr6pNyr+0M4dgA==
X-Gm-Gg: AeBDievX02Ks0Du60ZOAkSDXn/31/wjHgGG6Qvptxwr8v7zdrSz15b/y01YvrlRzrvt
	yBox0l4oHR3aD4VOttQXIopnF+HuLLxz47a2A07iDwcxk6+WPTcph1l6shUw9K21lR//DTOvM0t
	N4xpm1+2KGi5MVNGtfVxzPSAtoURfawkOAekdaK1pvKv6zKMSEiuhEp0J7a8MddPguMVEJ+6JKe
	n6U+EOKROW8VyQ2xYXu5PZ/Dj7Xj09Y0Het1QMo8IFQPbFn2bH7cyv+BYF7Q0oUNQIW6ILCdIp9
	0hkt0x71PCOVH1BKztcNUgoSlYrqwLpzxDtbNYpjqhYLU2yRsete68e65/hhFVOHRMhMfdKzbdq
	n0h2/SHuK1K4Fyop6mfXwcO8wWH1t23Nfg6RP1TvMUC0wWSDqxejCylMmKsGBDULDveszSXiZkj
	GGQsSS6jqW4jp+b9cRFOtTkoqYlPsyMvxGRvDi7QHyYSfFz/kC+XLBZ86ukjE4iOZbzALNmbLzO
	s6JHWWLsmInYwNTeKbcLmvfr0KCaqFflvm2Jw==
X-Received: by 2002:a05:690c:c50e:b0:7b8:926e:3ef1 with SMTP id 00721157ae682-7b9ece7715cmr88320967b3.9.1776576434995;
        Sat, 18 Apr 2026 22:27:14 -0700 (PDT)
Received: from localhost.localdomain (h174.204.88.75.dynamic.ip.windstream.net. [75.88.204.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bc3bsm27777047b3.27.2026.04.18.22.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 22:27:13 -0700 (PDT)
From: John Haugabook <johnhaugabook@gmail.com>
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 00/11] cygwin-htdocs: website fresh coat of paint
Date: Sun, 19 Apr 2026 01:26:48 -0400
Message-ID: <20260419052701.513-1-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,KAM_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is an updated, duplicate of a recent PR. It consist of 11 small patches that
when put together as a whole give the website a fresh look. A fresh coat of paint
so to speak.

Sorry for so many patches, but each is specific, making it easier to pick and
choose which to apply. The changes (for the most part) are also very small. And
since they are in regards to visual aspects, GitHub Pages (thanks Johannes!) is
used in order to demonstrate and compare the proposed changes to the current site.
To toggle the changes quickly press "cc" on the keyboard. The link is:

https://jhauga.github.io/cygwin-htdocs/index.html

> On Sat, Apr 18, 2026 at 3:29 AM Brian Inglis <Brian.Inglis@systematicsw.ab.ca> wrote:
> Subject: cygwin-htdocs: website fresh coat of paint
>
> > The image below looks like the Wikipedia article logo, which has an unknown
> > author and licence ...

I created a new SVG for "0003-add-logo-to-top". I'm waiving any licensing rights I
might have to it, so - whatever license you want to apply; it's yours.

It is very similar to Warren Young's icon/logo `apps/setup/cygwin.ico`.
The differences are:

- The 3D bevel effect is flatter as the website has a flat layout
- The light pixelated outline is removed, which matches the background better

Below are the details of each patch in this pull request:

- 0001-clean-style.css.patch
  - Add consistant indentation and formatting to `style.css`

- 0002-fixed-menu-position.patch
  - Keep the side menu in a fixed position for better UX
  - 100% of 40 users in a study preferred fixed menu:
    https://usabilitygeek.com/how-to-fix-your-fixed-navigation/#:~:text=one%20hundred%20per%20cent%20of%20them%20preferred%20a%20fixed%20navigation

- 0003-add-logo-to-top.html.patch
  - A new media file "logo.svg"
  - Add the Cygwin logo/icon to the "top.html" fragment
  - Update "style.css" to position and size "logo.svg"
  - Gets better user recall:
    https://www.nngroup.com/articles/logo-placement-brand-recall/

- 0004-font-weight-applied-hierarchically-per-menu-section.patch
  - Makes visual scanning the menu easier, applying font weight and size to infer
    categorical hierarchy
  - Differentiate text levels:
    https://medium.com/@oluwanifemiajayi61/typography-hierarchy-3ed06c206ea7#:~:text=Using%20weight%20strategically%20prevents%20visual%20clutter

- 0005-add-html-star-entity-for-the-Gold-Stars-menu-item.patch
  - Use HTML encoding to add a start icon the the menu item "Gold Stars"
  - Draw attention to item and clearly labels it as not the current page:
    https://www.netwaveinteractive.com/blog/visual-hierarchy-in-ui-ux-design-principles-strategies-and-best-practices/#:~:text=enhance%20hierarchy%20by%20breaking%20up%20text

- 0006-h1-header-s-font-family-to-sans-serif.patch
  - Set the font family to sans serif for `h1` tags
  - Keeping other text as serif makes for good visual contrast
  - Sans serif is best for digital:
    https://ixdf.org/literature/topics/typography#:~:text=preferable%20for%20digital%20interfaces
    https://medium.com/the-interaction-design-foundation/the-ux-designers-guide-to-typography-7ddf87288123#:~:text=preferred%20for%20digital%20interfaces

- 0007-style-code-HTML-elements.patch
  - Adds a background color to all `code` tags, using the menu color at
    20% opacity
  - I mean - I'd ballpark it at 90% of website that have software documentation
    apply background color to code blocks

- 0008-style-pre-code-blocks.patch
  - Adds a background color to all code-blocks, using the menu color at 20% opacity
  - Same for `pre` tags that hold code examples; at least 90% of software docs,
    blogs, articles, etc. use a differentiating background color for code-blocks

- 0009-link-hover-UX-effect.patch
  - I hover effect for all `a` tags
  - Users expect hover effects, and it is essentailly a web standard (cursor: pointer):
    https://www.nngroup.com/articles/guidelines-for-visualizing-links/#:~:text=hover%20states%20have%20become%20a%20standard%20and%20expected%20interaction%20pattern

- 0010-responsive-styling.patch
  - Really simple responsive CSS added to style.css
  - A new fragment file; "head.html" - adds the required `meta` tag for responsive HTML

- 0011-css-variables-for-colors-to-keep-DRY.patch
  - This adds CSS variables to colors that were used in the current style.css 2 or more
    times, keeping the CSS DRY (Do not Repeat Yourself)

John Haugabook (11):
  clean style.css
  fixed menu position
  add logo to top.html
  font weight applied hierarchically per menu section
  add html star entity for the 'Gold Stars' menu item
  `h1` header's font family to sans-serif
  style `code` HTML elements
  style `pre` code-blocks
  link hover UX effect
  responsive styling
  css variables for colors to keep DRY

-- 
2.46.0.windows.1


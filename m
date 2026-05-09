Return-Path: <SRS0=xB0n=DG=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by sourceware.org (Postfix) with ESMTPS id DF1684BA2E09
	for <cygwin-patches@cygwin.com>; Sat,  9 May 2026 01:28:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DF1684BA2E09
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DF1684BA2E09
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1136
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778290109; cv=none;
	b=w6ukkMWnLCJYpzfPJ2TkeVXKYcDL+s9pI/zo6rcdLYHSMfyAdBhQtlP5n19bwSRzh4DKIa4DzTxTXNdD7pWtKrDGRRlBnr7+5zql1fzGQbaO4RLSp8eoroV2bwKfCGurXbpPCR6NRaiwWIx+2lQq9+BLbvteUTa7UiIj9JHoEHQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778290109; c=relaxed/simple;
	bh=CEAZ3YZEMQDj4Jdg79IkkncyhMSZhpqRHJ3Lr6lyQjc=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Qiu8ZjfI9NDz9JM56faXHyXPpQheguSfXEVqzvx0eWDmyqtbGJ5HNDdzeL3qC1jVkMevWnYM0J8Gy2VL1qc15HtkLX6UGh9LIzycqfgWox+c7uWFph7j2yxbLtOMgw5Ss8DbC9N9tq+rjiWKzmwrqAM1FvP2OV6qhvLdK6Lzmrw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=peHqokVZ
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DF1684BA2E09
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=peHqokVZ
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-7c04749d739so8123287b3.3
        for <cygwin-patches@cygwin.com>; Fri, 08 May 2026 18:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778290108; x=1778894908; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sb63nkwSSWWpd/gEITzRIEPVE4SZ7HNjgbKG0BpJj08=;
        b=peHqokVZoDEInjYfXj6G4M43tlxfjdOCo+DLmsnNs0jSSiB0NnogBcnNjjdwToDCAo
         mDeVYQwxVylHCkb4ry7JyvC/5pK5VK14LS/OeETp9EVlGwnL1Bu9GbV7mSmviw8WnPBp
         RAQ4o+l9/WPO5Xwxy+QosDWEIW036AFJjksdKb4FqhhfAtd5BBMdoV7cMH12nheKLyyK
         GWGLOlLtcYDaLIu4m7jYwEdVQH8Cpwbn7TuRj1XYXjuW1KA4Z5C4LjL39+s6LjlHPRBT
         HMnwirS+8yd/QUOFAEZEomsqaQzpBFE/t03fh5EDj9o+xFI5aN8vrFITMa8aTTI/nvCu
         YfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778290108; x=1778894908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sb63nkwSSWWpd/gEITzRIEPVE4SZ7HNjgbKG0BpJj08=;
        b=hrAPL5t23as1LtUyZ6cuPossMqJrYH4k0ZRSoqPHFFkjRN9lfcMtPf0XS37MDibO0F
         r123vxIPrxaA6mwAQOKTnW57ath7Jwu2jTvf4rqBWOQlq2AnvzJs7FVWMbvJkjKtjqTR
         G7OdrFETnTqdndcsSzCkYtugstktWJ8Smzf36SgRpm+/OhBTWyXUFiqCaBgdPgDzROxq
         /B2UDj7iIUtd1cW4MGKNhZjOTqEo97sTHNnb4QmM8qLcuHD8ZgrxfwM8qAdFyTv1SwfI
         bZe297LgvnnXHGriHKZIuGPLO4i6tjmdLJ6FLO3v6vAggeis+xC6QHZBeq3MppoJm4ie
         vG7Q==
X-Gm-Message-State: AOJu0YyMDuOkmhq0VDxKPPfNkIeesSmD0JxhOgvY1hZrrGpXf/co3Pqf
	P/OZhY6iq5OgM849eOQbzeQzF1P2OJmuh3Rce65evaeR4s21HcKNMAUqNUAaZA==
X-Gm-Gg: Acq92OEFAmD9Mf7f8Uiml6qrbgBYobU5uKalPEHbtbNtPONCZu8dCQEJ362dYa6kwVs
	Iz1iEiIxEPo5cD3tqf4iXubNTZsOOb7K6Q/FUHwpw8d4njPtSG4WAkxVY9dMo1zVnXX/+FunJTg
	K8fVC7G9yh+Ixovb4TmLRLQesZ3K3mUFuBhxq37cKCqtXLFkDrb9PQZFFn+UrssWlp0Hw5VK4Oi
	AxSYnpmINhZjYFUfZN3khCGXiNFltWxXHXxIxS65IZl2Kubmfz00NF5SRRMLhZclMXYhxUaiDOs
	E/5BFnnZc07+Q2IOVREGafT1lWznTmMUtC38LVabT4rzPD8fRmP13+1mhHHghvgVqjMu6HsAJjR
	/g16odsp7K/flDuwfszswcMptzOKxcD8LvMiaYrfEf7JNQkwm6HXAFE0jziDvrBGH9DNi0YS47g
	Ax2qc21l98dR9hCaZbGtGIKcZbt/V/blLMvZd8z1GMUFNQn3xJXi2ZDbMLW4NOi878Hr7Fe3w/F
	Wrw+0Xhb7kwyv7Mux1M4aObHcY=
X-Received: by 2002:a05:690c:891:b0:7ba:fdc5:17e4 with SMTP id 00721157ae682-7bdf5dfb114mr161269127b3.22.1778290107666;
        Fri, 08 May 2026 18:28:27 -0700 (PDT)
Received: from localhost.localdomain (h231.205.88.75.dynamic.ip.windstream.net. [75.88.205.231])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66888cc7sm113210917b3.44.2026.05.08.18.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 18:28:27 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 0/7] cygwin-htdocs: website fresh coat of paint
Date: Fri,  8 May 2026 21:27:42 -0400
Message-ID: <20260509012815.1157-1-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>

Attached are several patches that continue the site's UI/UX refresh, picking
up on feedback from the previous round. Together this is another fresh coat
of paint for the website. For a full demonstration of all the patches applied
to the site, see this support repo:

https://github.com/jhauga/cygwin-htdocs

Below are the details of each patch in this pull request:

- 0001-access.patch
  - Set a global font-size of 1em and line-height of 1.35 for better
    readability/accessibility (preserves pre/code sizing)

- 0002-add-pre-class.patch
  - Apply class="screen" to bare <pre> tags so they pick up existing
    pre.screen styling already defined in style.css

- 0003-font.patch
  - Apply font-family: sans-serif globally except for pre and code tags

- 0004-gold-stars.patch
  - Remove the special menu coloring for the Gold Stars item so it
    matches the rest of the navbar

- 0005-top-logo.patch
  - Add logo.svg (pure SVG elements only) and reference it from top.html

- 0006-responsive-styling.patch
  - Add a responsive style section to style.css and switch the HTML
    files over to a shared head.html include for the meta/stylesheet
    boilerplate

- 0007-css-variables.patch
  - Refactor style.css to use CSS custom properties (:root variables)
    for colors used 2+ times, keeping the CSS DRY

Response To Prior Emails

> On 2026-05-04 12:52, Jon Turney wrote:
>    I'm sure this is fine, but I'd be interested to know where we're using
>    <pre> without a class.

>   It's might be a good idea to add a class in those places to indicate how
>   we're using it?

See patch `0002-add-pre-class.patch`. For the most part it is a find
replace all "<pre>" with "<pre class=\"screen\">". Which seemed fitting
according to the AI's rule

NOTE - Claudes Class Rules of Application:

START-Class Rule Applied --
Existing classes observed in the codebase (left untouched):
- Class: screen
  - Used For: Shell commands, terminal output, config snippets (DocBook + handwritten)
- Class: programlisting
  - Used For: C/C++ source-code listings (DocBook generated)
- Class: funcsynopsisinfo
  - Used For: Function signature synopses (inside <div class="funcsynopsis">)
- Class: prewrap
  - Used For: Word-wrapping preformatted blocks inside table cells (e.g. hint-file examples)
- Class: sample-preformat
  - Used For: Sample preformatted text in contributors guide

Rule used for tags missing a class (per --when-in-doubt-apply-class screen
and --create-new-class=false):

All bare <pre> (and <PRE>) tags receive class="screen".

Justification: every unclassed instance was in handwritten pages
(git.html, install.html, etc...), and contained shell commands, build/git
invocations, setup.ini/.hint config samples, or man-page output — all of
which match the established semantics of screen in the existing codebase.
No new CSS class was created (pre.screen already exists in style.css), and
no tag with a pre-existing class was modified.
END-Class Rule Applied --

> On 2026-05-04 12:52, Jon Turney wrote:
> Uh, not sure what the benefit of this is.
> 
> On phone sized screens, most of the space is taken up by the navigation
> bar?
> 
> (although making it look better on screens of that size is something I'd
> very much like to fix, but I think that probably involves a lot more
> restructuring?)

With that being the case see `0006-responsive-styling.patch`. It is a
more verbose approach to making the site responsive.

> On 2026-05-04 12:52, Jon Turney wrote:

>> I wonder if we should just switch to sans-serif throughout? or just stop
>> specifying the font-family altogether?

See `0003-font.patch`. Change all except the `code` and `pre` tag to use
sans-serif.

> On Wed, May 6, 2026 at 6:32 AM Brian Inglis <Brian.Inglis@systematicsw.ab.ca> wrote:

> Serif fonts tend to be harder to read on LCDs especially mobile with one
> narrow direction where you have to optimize content vs font size.
> In general I have always kept sizes to a minimum of 10pt to preserve my
> eyesight

See patch `0001-access.patch`. It starts style.css with setting the
font-size to `1em`. Essentially `12pt` but a better unit.

John Haugabook (7):
  style.css: apply global font size and line-height, better
    accessibility
  html: add class screen to pre tag without class
  style.css: apply font-family sans-serif to all but pre and code
  style.css: remove gold star menu color
  logo.svg: use only svg elements, add to top.html
  responsive: add responsive style section, update html to `head.html`
    template
  style.css: css variables for colors to keep DRY

 acronyms/index.html                           |   3 +-
 contrib.html                                  |   3 +-
 contrib/dll.html                              |   7 +-
 cygwin-api.html                               |   3 +-
 cygwin-api/index.html                         |   3 +-
 cygwin-ug-net.html                            |   3 +-
 docs.html                                     |   3 +-
 donations.html                                |   3 +-
 faq.html                                      |   3 +-
 git.html                                      |   7 +-
 goldstars/index.html                          |   3 +-
 goldstars/src/index.html.tpl                  |   3 +-
 head.html                                     |   3 +
 index.html                                    |   3 +-
 install.html                                  |   5 +-
 irc.html                                      |   3 +-
 licensing.html                                |   3 +-
 links.html                                    |   3 +-
 lists.html                                    |   3 +-
 logo.svg                                      | 170 ++++++++
 mirrors-report.html                           |   3 +-
 mirrors.html                                  |   3 +-
 navbar.html                                   |   7 +
 news.html                                     |   3 +-
 package-server.html                           |  13 +-
 package-upload.html                           |  13 +-
 packages.html                                 |   3 +-
 packages/index.html                           |   3 +-
 packages/package_docs.html                    |   3 +-
 packages/package_list.html                    |   3 +-
 packages/src_package_list.html                |   3 +-
 packaging-contributors-guide.html             |   5 +-
 packaging-hint-files.html                     |  17 +-
 packaging-package-files.html                  |  11 +-
 packaging/build.html                          |   5 +-
 packaging/cygport_tips.html                   |  11 +-
 packaging/key.html                            |   9 +-
 packaging/repos.html                          |   3 +-
 .../trusted-maintainer-policy-manual.html     |   3 +-
 problems.html                                 |   3 +-
 profiling/index.html                          |   5 +-
 setup-packaging-historical.html               |  19 +-
 snapshots/index.html                          |   3 +-
 style.css                                     | 385 +++++++++++++++---
 top.html                                      |   3 +
 who.html                                      |   3 +-
 xfree/docs/man1/Xserver.1.html                |   6 +-
 xfree/docs/man1/startxwin.1.html              |   2 +-
 xfree/docs/xlaunch/finish.html                |   4 +-
 xfree/docs/xlaunch/program.html               |  16 +-
 xfree/docs/xlaunch/xdmcp.html                 |   6 +-
 51 files changed, 619 insertions(+), 194 deletions(-)
 create mode 100644 head.html
 create mode 100644 logo.svg

-- 
2.49.0.windows.1


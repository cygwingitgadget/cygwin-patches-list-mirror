Return-Path: <cygwin-patches-return-7551-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11520 invoked by alias); 4 Dec 2011 21:07:41 -0000
Received: (qmail 11506 invoked by uid 22791); 4 Dec 2011 21:07:39 -0000
X-SWARE-Spam-Status: No, hits=2.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-ww0-f41.google.com (HELO mail-ww0-f41.google.com) (74.125.82.41)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 04 Dec 2011 21:07:21 +0000
Received: by wgbdt12 with SMTP id dt12so4995978wgb.2        for <cygwin-patches@cygwin.com>; Sun, 04 Dec 2011 13:07:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.180.104.2 with SMTP id ga2mr11753661wib.33.1323032840421; Sun, 04 Dec 2011 13:07:20 -0800 (PST)
Received: by 10.227.57.82 with HTTP; Sun, 4 Dec 2011 13:07:20 -0800 (PST)
In-Reply-To: <CAHWeT-a0uH9_qvE9jPWVq7GJ_g2gm8_-JDeQRZ2Nhp3C5iSpAA@mail.gmail.com>
References: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com>	<CAHWeT-a0uH9_qvE9jPWVq7GJ_g2gm8_-JDeQRZ2Nhp3C5iSpAA@mail.gmail.com>
Date: Sun, 04 Dec 2011 21:07:00 -0000
Message-ID: <CAL-4N9tUqVa1PTp+nD3+ff5qJsJJX6A5U95nPeRsvF_zABsSAA@mail.gmail.com>
Subject: Re: Add support for creating native windows symlinks
From: Russell Davis <russell.davis@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00041.txt.bz2

Hi Andy, thanks for the response.

> - Native links can't point to special Cygwin paths such as /proc and
> /dev, although I guess that could be fudged.

They can, they just won't work when non-cygwin apps try to use them
(perhaps what you're eluding to with the fudging). This is no worse
than the status quo with cygwin's non-native symlinks -- non-cygwin
apps can't follow those either. Verified as working with the original
patch.

> - If the meaning of the POSIX path changes due to Cygwin mount point
> changes, native symlinks won't reflect that and point to the wrong
> thing.

Good point, but surely this must already be the case with
shortcut-style symlinks (via CYGWIN=winsymlinks) as well? For a lot of
users I think this will never be an issue, for the rest it can be
documented as a known limitation.

> - Native relative links can't cross drive boundaries, whereas relative
> POSIX paths can reach the whole filesystem.

As with the first point, they can still do this, it just won't work
outside of cygwin.

In summary, this approach does have limitations, but I don't think any
of them are worse than the status quo. In addition, it would be a an
optional feature that would be disabled by default, just like
winsymlinks. Seems like a net benefit for users who understand it and
want to use it.


-Russell

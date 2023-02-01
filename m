Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	by sourceware.org (Postfix) with ESMTPS id CF8293858407
	for <cygwin-patches@cygwin.com>; Wed,  1 Feb 2023 19:03:31 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M26n9-1pLNW43ooz-002UyD for <cygwin-patches@cygwin.com>; Wed, 01 Feb 2023
 20:03:29 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 63A31A80407; Wed,  1 Feb 2023 20:03:29 +0100 (CET)
Date: Wed, 1 Feb 2023 20:03:29 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] dumper: avoid linker problem when `libbfd` depends on
 `libsframe`
Message-ID: <Y9q3gY4rN9NbF/PZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <50ed771a961112edb5c4b69421d9ad8cecf7a7cb.1675260460.git.johannes.schindelin@gmx.de>
 <Y9qiVIHEaUFPrztO@calimero.vinschen.de>
 <6aa67503-30af-cf66-0b3a-1c4d9ba9c396@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6aa67503-30af-cf66-0b3a-1c4d9ba9c396@dronecode.org.uk>
X-Provags-ID: V03:K1:WmluSDxkz67qpAVOFAf8QzLell//TpCgiLuVDVuYktnOTn7foG9
 l3kLu+QXtVyTLo5IRtGyffloKbU+179lGrUpuVAmGQBqR1TN3X2G5ifTEO35S5BMQ0IIjqF
 NCbzNaRPNujCQpRawTEKJ1TeXaOwo6Y3eX1rRF0qwB+ex2Cst9hWUlHDZL9ok0xW6gW7+Fu
 zhjPGlFf0VbzMNq2qtouw==
UI-OutboundReport: notjunk:1;M01:P0:FHqVr1X8lbY=;Cc1A0CtOviWNfGoJpDywBAU236o
 M3E+Ukb1aujY6WLnUAhtcIv8QF8gO8XOWraJc6Ok5SLlVkBLq3ul3YTX9b571XBTvmqT6jtdj
 E3ZpsOB2w6jN9jOh0O8VQDiR7OYQpiKTfJpEcUEFsBZfqEqA87fj/LVKfeKVJG2DmEvwi8f0v
 e6/Ch3hffZYLzAIJlm/UhhFXdnBJsdk2sfz2wdQZ3Oqy0bk3WU14rNJDuLxzhJX6Zns7hYCkT
 7AvgBYKzB1MO47cZ0ue5zBUbaCJObGtkiriDDOk/JQpV2ln97NXPGgug5/VWo2RZd7JR8RmKM
 LrQU4x4C1QNmstNb7ZLNc9cD6zfNP91nXxmCq5hQWeomrNCxwWn6FjzaBxx8wUZjqrv8fmPkD
 B7fSOxkNMvp6ELbwawuFhm2p6/B3UaINlLPYOLvLsPJiKXZJpEq08Y80cUCrymzf+6r613zFK
 IyOi7JvlOO8Z4kD6o3ho5CKnxH80YchbeDOMRIz8cKNgsIFgJ0SiVru6orFWCpvT6rRXzC01F
 cZIGkynxoFi1aAh64ZO3O7P20HQhGaUwsQVmOBs4HtDqvR+8YRurwg93PUwXFaNRw8Xdf6FkU
 dld5pF+yzsQ+dc70aWhbZrni1uah39LmTIvmL+iHkPselMvM0fKZFNb2cmnh7cF1rWp7bwk3w
 I8trA5j9Se3DUbbEbNye+/xWrBZyNhZ2FVx+EpcSzw==
X-Spam-Status: No, score=-97.2 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Feb  1 18:04, Jon Turney wrote:
> On 01/02/2023 17:33, Corinna Vinschen wrote:
> > On Feb  1 15:08, Johannes Schindelin wrote:
> > > A recent binutils version introduced `libsframe` and made it a
> > > dependency of `libbfd`. This caused a linker problem in the MSYS2
> > > project, and once Cygwin upgrades to that binutils version it would
> > > cause the same problems there.
> > > 
> > > Let's preemptively detect the presence of `libsframe` and if detected,
> > > link to it in addition to `libbfd`.
> > > 
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > > Published-As: https://github.com/dscho/msys2-runtime/releases/tag/do-link-libsframe-if-available-v1
> > > Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime do-link-libsframe-if-available-v1
> > > 
> > >   winsup/configure.ac      | 5 +++++
> > >   winsup/utils/Makefile.am | 4 ++++
> > >   2 files changed, 9 insertions(+)
> > 
> > LGTM.  Jon, what do you think?
> 
> Well, the real solution here is for binutils to stop pretending that no-one
> links with libbfd and provide a .pc file for it, because we'll just be in
> the same situation the next time it grows another dependency.
> 
> Until that happens :),

As in "never"?  The binutils cygport package could provide it in
a kind of sneaky handcrafted way, couldn't it?

> this seems fine.

I pushed the patch.


Thanks,
Corinna

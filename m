Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	by sourceware.org (Postfix) with ESMTPS id 7FC9A3858421
	for <cygwin-patches@cygwin.com>; Tue, 20 Dec 2022 21:48:08 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MryGj-1oVdlS0QgX-00nuzf for <cygwin-patches@cygwin.com>; Tue, 20 Dec 2022
 22:48:07 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 98DF5A80D74; Tue, 20 Dec 2022 22:48:06 +0100 (CET)
Date: Tue, 20 Dec 2022 22:48:06 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Make the console accessible from other
 terminals.
Message-ID: <Y6ItllXJ8J20cEbp@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221220124521.499-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221220124521.499-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:5qVFJWFvdSHFjQ5/0bSrQxJ2jdQ7lNBRFD/6ydJMVVCTO+jk3UB
 Hi/tXnFP9j3ACUrjLrQbQ9sFVGry+pKv9KsgvxoJ4EqgvZpVCTwmRbZun3Ndl8HxwG+vhgC
 AdpRpDEdzlq9qJ0Q74l65JrESXwSgMpg6POmeWkKOuhBMs/am+vCqdZSZje85H6oNVr+otK
 jiNAOaeSJIPFoxgyoQfnQ==
UI-OutboundReport: notjunk:1;M01:P0:l9iNOXYdYKg=;rEqKDvwTl/NdrL60uGBCKLJyzMF
 48R7Ev6KsHIigcSbAFB/KIEJiILvGBEv0g/VNkrRAgtg9Lsf6K7nPX6opmCI2YBfHxm4KRG7Q
 HLWQCssmLDGIuoPm/wfIxwdu4RdcvS2/5wiqXKouGf0A72GEIS9NrL8e9okJOM1GlJWLwY8L9
 AF1aSUKUiW2H9CSSPnKIo598kx9jBLK7WzF21+oX9ZblFhYZx2nT0uESwFnAdqye59PtjD9ea
 Dy9gGlzf6pZ7KV0aXYZhqLvuKiqItmgijPIJ4bfGhzULdpPNwRDXG9wzWoXYBbCHr8MgUG7D9
 P3NT5O9qH43w2o7/BspY+FHHpfSqv4GjI6sNMh6/qpLO/AE+cmVScDoTZBEAS5z+riJGFsWIO
 z0mXZA4XFVrYBhbZ2C2INyuJtf8MsR+PkIPiH33thMXbnMj+k23q8fuRYd5nnOZOp3lzoNhoz
 jeTfp800gtN8ncfMqWBvW0q5zaYJ4vlbsd/T08i3U5mtPgwafKx+kU1gPnHSbVV98COFVsjKn
 wcElsYe4Fecp2pl9++KulF2AwV/+XB2d+F9c/o0Xj5X2s+VMbnnScPPzalNFg2wbHGW5crhcC
 0pmMf4TJgaNQshdmnIO4FNbdm3SyOrfQLS7xmlMSyJLgCqCpQdCkQ1AJ2MDcGJ1DUCSy49hS7
 EOwZLFRFUmg3aEFqxupd3W5RVjpqgkMC9pwLsf9BwA==
X-Spam-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Dec 20 21:45, Takashi Yano wrote:
> Previously, the console device could not be accessed from other terminals.
> Due to this limitation, GNU screen and tmux cannot be opened in console.
> With this patch, console device can be accessed from other TTYs, such as
> other consoles or ptys. Thanks to this patch, screen and tmux get working
> in console.
> 
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/devices.cc                |  24 +-
>  winsup/cygwin/devices.in                |  24 +-
>  winsup/cygwin/fhandler/console.cc       | 438 +++++++++++++++++-------
>  winsup/cygwin/fhandler/pty.cc           |   4 +-
>  winsup/cygwin/local_includes/fhandler.h |  26 +-
>  winsup/cygwin/local_includes/winsup.h   |   1 -
>  winsup/cygwin/select.cc                 |   2 +
>  7 files changed, 382 insertions(+), 137 deletions(-)

I just toyed around with screen and this looks really great.

Just one question: What about security?  If we now can share
consoles, don't we need fchmod/fchown calls, too?


Thanks,
Corinna

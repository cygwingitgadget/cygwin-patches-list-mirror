Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 73E7F385703D
 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020 12:14:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 73E7F385703D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N9Md2-1kMlKY0oPU-015FvV for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020
 14:14:42 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id BBA39A80303; Tue, 13 Oct 2020 14:14:41 +0200 (CEST)
Date: Tue, 13 Oct 2020 14:14:41 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Re: [PATCH v4 1/3] Cygwin: rewrite and make public cmdline parser
Message-ID: <20201013121441.GN26704@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200905052711.13008-1-arthur2e5@aosc.io>
 <20200907093943.GJ4127@calimero.vinschen.de>
 <33c7b23a-5f59-bcaa-3b0a-6e6d4bc4f30b@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33c7b23a-5f59-bcaa-3b0a-6e6d4bc4f30b@aosc.io>
X-Provags-ID: V03:K1:5l6Xrry6Cd7eHB5NsxUludWLp6P7pYsVFlNpH1vZXBtUZzrXbGv
 MTx9X5q3Me5MWiMW9Fxk79QfPf3IWxKPR3CyoBPvxnUSypQLpOjs/GKf+Y0mJxdTD0WSWbz
 wuOmH9U+AqztObc9h1+gaxYd0YYrSzApC96QCEguAIcVXYgVF2k5Fyr9fkkza++L1yRHE3R
 USSasr/q+maqnS4PQcZhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qVCHI4caWoI=:NRsIURHHL1ueGNPLUfMUVb
 69ZLQYMGIxwHL+t1ZMMm7EQJUYP8KyQt8GoJzyaeDw96qPrpgwUhGgpnnKMc11mI291HQfUXz
 cKZz2C/Q7Qnb5IG3GG1NDloiQJ9l6XsTbK1FZp7pbR3fzMzxoXFf37/T8tMQ7Kycdx7TqUP6e
 Y1XhVei5IGIpGf7RBzM09o5YGol75NLeYJwUq0rRprKqHAetVNbLriOyDyB9xWWYSwkFGJoQh
 WDPanqKl+XC2VvUqKoUKXxU9i9EuJGxFamqb4ZgdQTO4SJ0xE6WqTUYOL4utE67TTeWm95tgj
 hQjyuP3wJ1lnaM0EzfnIAjCZy4FTFmu2kDE+0fML4iBMyw2cx+D254nAUCuw+huHv5DCMPjmy
 zpboKoDaR+cuwnaAso1YoTzP4MYg1vpDeq6kAtP3vg6V1LNXaOifPTL5oPa71r2O6M5Fs6vVM
 DlT9n92Ed2kL/wzu7WMkESI0JCheXbkFui/Qo4eykCNc8/nAfkgzKPTcidv4zA49RbRd7HZq8
 FKbhIJlx+0gis8y5hyERxJS3J5vaKwbI0xxUL+fCJkHYHhIa1i34Ehpn17VWxq7/4/Va4HScT
 WdT0af/dWyjEnTy7A/SgtDtk/Y15524otbDTyIcnmCwdT13RzyD5LXuybhbmQFTiUhihIUn0d
 KwcNO2bJ5+u6I/TgWNtFBbB3CNZrFNyraTZohVssFFgHs7SnFLMdScxNYVHiR1IL7YViCCDVe
 QuWgUVCpP8omEyG7fgeiY2VGrpIPNrALYLGEoS8mlBspwuckbQWPAM5s25GgsDh3WmUa47LEk
 /MhTRn2KMnIdCDrLKOyzw7Mb7uB7cVFJ6t0kuzeTZz82mCaBBprchWl/CYEMbXySHFEg5nmGc
 gYE1qMKCfLtBWgpIJZCQ==
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 13 Oct 2020 12:14:44 -0000

On Sep 24 16:39, Mingye Wang (Artoria2e5) wrote:
> On 2020/9/7 17:39, Corinna Vinschen wrote:
> > 
> > Nope, we won't do that.  The command line parsing is an internal
> > thing, and we won't export arbitrary internal functions using
> > their own symbol.  *If* we should export this stuff at all, which
> > I highly doubt as necessary, it should use the cygwin_internal API.
> 
> The idea is that the sort of thing get reimplemented incorrectly a lot, and
> since we have the extra @file feature and the Unix glob it would be nice to
> allow other people to use it. Win32 has CommandLineToArgvW, so I figured it
> wouldn't be too strange to have.

In contrast to stock Windows executables we already have a valid argv.


Corinna


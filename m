Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	by sourceware.org (Postfix) with ESMTPS id 4DB353858CDA
	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023 10:35:22 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MK3eC-1pU5va0554-00LY60 for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023
 11:35:20 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B269CA80A3A; Tue, 10 Jan 2023 11:35:18 +0100 (CET)
Date: Tue, 10 Jan 2023 11:35:18 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pinfo: Additional fix for CTTY behavior.
Message-ID: <Y70/Zk3ZOk6CCmGH@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221228083516.1226-1-takashi.yano@nifty.ne.jp>
 <Y7vdjTREYWiLAJ9N@calimero.vinschen.de>
 <20230110185257.8f316240e5d9f2d2fb78f21a@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230110185257.8f316240e5d9f2d2fb78f21a@nifty.ne.jp>
X-Provags-ID: V03:K1:L+n57Ps3rSW3sKXZYtpEJY2ulzeDcafhRZ9EUkwU+uBV+extSAh
 PbwxU+vqHz49mQw3/DvORNSqxY+pOP8x22D4DWD0CteU2LfebKgGexedsg0g0VZauR7/or2
 mQ9T2raQ70VxrLxBb2yOwjzNUsR+CjVtHRWoVly2WCHCTRgU7aR7YqYzhiAoQzAQwjZHRhx
 Xu4cwUCJ7G0DB8uSzGSfw==
UI-OutboundReport: notjunk:1;M01:P0:4LfvGhWSErg=;+aAOb6zqnTVurfs0krX+KvOOhEx
 5krEa3c32YhV2esgZGmAO0xxxLH4nThGmNH7BRd5qLCqaNeV63Y4V5q5ZnPOF6wVn2ubbevej
 trRprkvAxymrvVtMSCugi7fm7IGcVwbSLF3Vh+Te9qC0RL13hVKN5+1eZScTzTUhrLbB3ZqzE
 B3EJVXh9Z4UlIpDgCBReTzR6KhZMSA2T7qPXfHoNWYfi74K+IjB8Q0p+WX9zfdzqhkCLCnmwx
 I8mWF2E88jNq5Dh0bXwb5aFqTGOUaKoBHBUXorL66xez4V0Qfi8KwpUMDWV3BI2bpBE3H0ufy
 XKcCLzFkzxjJ+dbp6NzTRFbC7VQFTTJ2BMq/LWfdUM4vQ6WzfI+ARY/egrxqG8l/7mKtIsfkr
 XY4GRTDFCJnw+7oglyQKIuddqJ6eAksb3D9SIxd31hPA6W32kPLA3z6EOhcBie1AE/o77uxFQ
 7QgJfPeJca2/UCv8Twx27z5bhyEIMcm930whlYCeNTk9G6NJ/PuTfCcK2pDKwPWIFawhZxgIN
 WgZ0ifrU6i0Z1eM+zftb8bCVTWK2QPdbeWvftv8TUGy4XRcro79TCTENFqlFu0LqMNuLKbCKK
 X1c4R3mT9e39k7MDDGekXKkyaquom9SJ+OAHSFg+eVY3+lOMrxwIHkkytocX33kNg/6k7ssFk
 AUi4E2B2OkeLouq85VjlSJEPQ37oehKB0szXY3pDOw==
X-Spam-Status: No, score=-96.7 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Jan 10 18:52, Takashi Yano wrote:
> On Mon, 9 Jan 2023 10:25:33 +0100
> Corinna Vinschen wrote:
> > On Dec 28 17:35, Takashi Yano wrote:
> > > The commit 25c4ad6ea52f did not fix the CTTY behavior enough. For
> > > example, in the following test case, TTY will be associated as
> > > a CTTY on the second open() call even though the TTY is already
> > > CTTY of another session. This patch fixes the issue.
> > 
> > The patch is ok, thanks.
> > 
> > But while looking into this patch, I realized how confusing the old code
> > is.  An unsuspecting reader will have a really hard time to figure out
> > what ctty values of -1 or -2 actually mean.  The CVS log entry from 2012
> > isn't enlightening either:
> > 
> >   On second thought, in the spirit of keeping things kludgy, set ctty to
> >   -2 here as a special flag ...
> > 
> > Would you mind to introduce speaking symbolic values for them and add
> > some comments to make them more transparent?
> 
> Ok. Do you mean, first push this CTTY patch, then,
> add comment for ctty values -1 and -2 in another patch?

Sure, that would be fine.

> 
> > Also, given this was a "kludge" from 10 years ago, is it really still
> > needed?
> > 
> > As I said, it's confusing :}
> 
> Currently, the special values mean:
> -1: CTTY is not initialized yet. Can associate with the TTY
>     which is associated with the own session.
> -2: CTTY has been released by setsid(). Can associate with
>     a new TTY as CTTY, but cannot associate with the TTYs
>     already associated with other sessions.
> 
> So, I think the two different values are necessary. 

Ok, good to know.


Thanks,
Corinna

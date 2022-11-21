Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	by sourceware.org (Postfix) with ESMTPS id BB4583858413
	for <cygwin-patches@cygwin.com>; Mon, 21 Nov 2022 11:47:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BB4583858413
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7auL-1orKVj1m9t-0086PW for <cygwin-patches@cygwin.com>; Mon, 21 Nov 2022
 12:47:22 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EE59CA80974; Mon, 21 Nov 2022 12:47:21 +0100 (CET)
Date: Mon, 21 Nov 2022 12:47:21 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix 'Bad address' error when running
 'cmd.exe /c dir'
Message-ID: <Y3tlSXz6UBGPXaeu@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221022053420.1842-1-takashi.yano@nifty.ne.jp>
 <6EED0655-71E5-43B4-988D-B5935AED8EC0@gmx.de>
 <20221022151247.1b1cf1e3fc13d4c3dabc2191@nifty.ne.jp>
 <n4on0p20-970q-8693-7n50-4q22370s7rr5@tzk.qr>
 <Y1ZazH6objN99mSz@calimero.vinschen.de>
 <s1268p66-18rs-9q3r-07oo-11o128pp06po@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <s1268p66-18rs-9q3r-07oo-11o128pp06po@tzk.qr>
X-Provags-ID: V03:K1:5HM6fJ89dPr3JgUZ72RzL1an0MsD3dVcMfkt60USqRvVZlF/aPH
 fvZcTy738qf7e5MX/fGAy6BwRGF7/wauNT//pmuCLvRYoKpRLgr2pmPP5iWEWKtSAnlPqNp
 ue4CjkOkuBf+QAPW6FVXRwfYJKiPcR0LaNOVN599HXPmeZ9BNsGSI9RcEP2Z9csBQON5G+X
 1TtUA2MY5XyDNhSQmt8Sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p86h13V4DEg=:Ov0wu3x2s9kOBcNvMUQSRn
 oSb67NFtcxjTQgXcUepHdBUhe/D/qFs7NMiqEZtHNh+aUDA2GYBDKdw7QxPUx38+LS4mnXKQ0
 fghiySnd4eYQ4ZQMpASoegcMkA/Q5ECjtodALq4qvFguffwWL/UpqDGWfLqC3j32zEmBvIZoT
 JJsgrEXZdGaHFQJlOFBEqnHGSFHgr3xr5hKttg9CDdGHoV+EUzP37Us1Oa/IJg3DOBotPOMPe
 sQbbAiZeUMGHegOl0IvYeQolhhqFnVxIFIg1FCz7Poc5AX3nksjzrOs/Z6DMcwLwis3z4sB6a
 y/ZagaGDVleb79pFbm421ADsQQVbPdyUK4nNQUGQR0WhSMBrvjo/Twa42PN8mSTH8lpcUX91H
 ajEeNuUfvXgGOVEycK1rzwSFK0Zc1GLB+I/zQ76GqacAeqTIYpHnYXLxCIO7rfw0Ho5AVbjYZ
 j8oRYp9Iz/PXFaJAkM1Cg6ogf7cHLam0y1ReGfSuyrifG34jgEOR2i69NrzEmi1fUId3+Gy+R
 pyOYle+6lwArwFszW8BIqDm0PwrBElx6lhowkKzGSANGek/l4s5P1GKtmiE8mc1N3057/YXTr
 vn+ptJHguPh0IFE0KuHvwwqZ+sNqrIoIKNfGHiUMnZpmkuWwONLFjDSMD/9dWS+lMt/NW+nli
 n+is8EFPFm1Uba2cH32FyIuGHYKe48HONKyfBrBV5lQoHVt3m8Xrhb8U8Kdg5+dce396ldB4b
 PFmIvQGP4wk8DDzmYZ+qGXEvCfUT+o8mWezkJM7sRm9gZ6adaAvS/wRaYdpqJHjW6xR+FOBkX
 EPyjTzF/AB7mASutOTffIVMqoknLQ==
X-Spam-Status: No, score=-96.0 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Nov 18 09:23, Johannes Schindelin wrote:
> Hi Corinna,
> 
> On Mon, 24 Oct 2022, Corinna Vinschen wrote:
> 
> > However, two points:
> >
> > - I'm wondering if the patch (both of yours) doesn't actually just cover
> >   a problem in child_info_spawn::worker().  Different runpath values,
> >   depending on the app path being "cmd" or "cmd.exe"?  That sounds like
> >   worker() is doing weird stuff.  And it does in line 400ff.
> >
> >   So, if the else branch of this code is apparently working fine for
> >   "cmd" per Takashi's observation in
> >   https://cygwin.com/pipermail/cygwin-patches/2022q4/012032.html, how
> >   much sense is in the if branch handling "command.com" and "cmd.exe"
> >   specially?  Wouldn't a better patch get rid of this extra if and
> >   the null_app_name variable instead?
> 
> I never understood why the pcon code was allowed to be so Hydra-like as to
> sprawl into corners far, far beyond `winsup/cygwin/fhandler*`.
> 
> FWIW I would be in favor of getting rid of this special handling (unless
> it causes a regression).

I'm a bit surprised to read that, you should already have seen that.
I did so end of October:

https://sourceware.org/git/gitweb.cgi?p=newlib-cygwin.git;h=f33635ae6076
https://sourceware.org/git/gitweb.cgi?p=newlib-cygwin.git;h=213b53ed3557


Corinna

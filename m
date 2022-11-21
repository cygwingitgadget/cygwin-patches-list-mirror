Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	by sourceware.org (Postfix) with ESMTPS id 0B4BF385840C
	for <cygwin-patches@cygwin.com>; Mon, 21 Nov 2022 11:41:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0B4BF385840C
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRSdf-1obrOh0ZS1-00NPFa for <cygwin-patches@cygwin.com>; Mon, 21 Nov 2022
 12:41:38 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id F3881A80884; Mon, 21 Nov 2022 12:41:36 +0100 (CET)
Date: Mon, 21 Nov 2022 12:41:36 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Allow deriving the current user's home directory
 via the HOME variable
Message-ID: <Y3tj8Os0p2a43rhx@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1450375424.git.johannes.schindelin@gmx.de>
 <047fe1d78c365afca7edfdf169fff5e1940c3837.1450375424.git.johannes.schindelin@gmx.de>
 <20151217202023.GA3507@calimero.vinschen.de>
 <1r1pq0r7-o3s3-so08-o426-296542797q94@tzk.qr>
 <Y07cOhhwu4ExRDzb@calimero.vinschen.de>
 <0q096627-r8pr-rno5-0863-s6n90psosq07@tzk.qr>
 <Y1Z48Mdk79/Qtwc9@calimero.vinschen.de>
 <66o0nq89-4599-np26-625n-2n8oon6p558q@tzk.qr>
 <Y20XK4VybCriMmn/@calimero.vinschen.de>
 <qn135110-43r6-o86o-887o-1rn29574s263@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <qn135110-43r6-o86o-887o-1rn29574s263@tzk.qr>
X-Provags-ID: V03:K1:+WFRQyIA5Z9I4a0g+U/ewR6SOKgVb5DjQWTTVRU8iJvvrumJFa0
 StbfnLWZA2qQuos5TuDRmkRR+YF4y7hxBAooIBH4yrVzSxBKdxtuqi+DP3EdZv6S+FnxTO3
 5L0AhsULL0iKjUSssAGEEZXc3g/l/tTLYQwmtHjvatroboxbZ3C7VnTJNbV6fBe7uPBqYPi
 WPZ4U/zl6ed6U6tCVvuQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CneSKlZScOo=:EsCdB9RWs3aINdVIF/kZBR
 7GEeOUW9pX1elxHHGZQBuo0kozy0H3DDQB9JFgwQh/6peZBIUJGX7TJGIG2FkgTrDya32F6YW
 s4tEnWUPT/FqsAvSsAmfPrGni09LViGBEpZwvJLMM7n/y4olpXEBl7AbWfdGQgoAs1Uzhhyk/
 1WMhEPRn/0yqmcWI6zgiSMl2rEmbYzQxcGaz0Kyyid6FwLadwBMSakJsBmESeLpuHdSRI+7f0
 5c3QaURpOBylAwDT6TT1dS4z3EKXo7UUJ5arOavnBnM8wAdzu+OZpWJcwdSUyckFGLmm5lIce
 TOHKJGfTz4lpz6/gXXgoiKe8fe/vQrlVn8UKyvEPOvQOJV/2J9AQaPuokmuqlAFp2cTunYPBa
 htktpCw3TBX8tz+NMFAU9hKwdsMYpNpilvJpkI6dlpyl9eH7CtE1iMRw9oeA9/8/kcnonshMD
 NUYHdtow+68mHIzIFXR9l7yoai5GqNSx4tx9czKpww+mSnKxUY/WC15MMFAKBuuUAwzoMQna9
 X0ne12b5ZKF9iOIQG6WTiCfUqpA1uThYkrMNjcfsc72GGP1is8K+4yEuh2TgWSwTPpGEvb0VH
 iFpaEA3gd4jfDKxrb89j5TwWP7qXMNNXf6/8D7WCj5l4zOzKJ9y5xIgKYpkiTGbc2xK90U5nl
 syn5O8yEjLZhJY28bkblCEF9a+jLQXRM573wWAvyd4mJlpelQZ2ioAHEom6nylConT97TkoPM
 nAp4nd55Rd3xxSrfvgcdyUARPE3hPhusnQLVWQNBx5fB1MzjblAkN+A3aZ8K86/1UgNtkqsGz
 80eiHNYr1gUEoF/lAfctKBRRDjP/w==
X-Spam-Status: No, score=-96.0 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Nov 18 09:18, Johannes Schindelin wrote:
> Hi Corinna,
> 
> On Thu, 10 Nov 2022, Corinna Vinschen wrote:
> > On Nov 10 16:16, Johannes Schindelin wrote:
> > > With this context in mind, I would like to ask to integrate the patch
> > > as-is, including the HOMEDRIVE/HOMEPATH and USERPROFILE fall-backs.
> >
> > Can't do that, sorry.  Two replies before I sent a necessary change,
> > which needs inclusion first.
> 
> I am a bit confused. Do you need anything from me to move this along, i.e.
> are those two replies you mention some emails I failed to address yet?

I didn't mean two different replies, but my second-last reply before
that one, i. e.
https://cygwin.com/pipermail/cygwin-patches/2022q4/012025.html

Sorry if that wasn't clear.  Basically your handling of $HOME was
wrong and I suggested a fix.


Corinna

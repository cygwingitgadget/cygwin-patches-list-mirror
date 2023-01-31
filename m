Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	by sourceware.org (Postfix) with ESMTPS id AD1F13858D28
	for <cygwin-patches@cygwin.com>; Tue, 31 Jan 2023 11:30:22 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M26j1-1pKstg1K37-002Ug5 for <cygwin-patches@cygwin.com>; Tue, 31 Jan 2023
 12:30:21 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C54D6A81B7B; Tue, 31 Jan 2023 12:30:20 +0100 (CET)
Date: Tue, 31 Jan 2023 12:30:20 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dsp: Implement SNDCTL_DSP_SETFRAGMENT ioctl().
Message-ID: <Y9j7zHN1hi4Sm22d@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230130130916.47489-1-takashi.yano@nifty.ne.jp>
 <Y9jfSM8nB6Z+eT3O@calimero.vinschen.de>
 <20230131201830.e558ac83a4b0ab3f5cdd4914@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230131201830.e558ac83a4b0ab3f5cdd4914@nifty.ne.jp>
X-Provags-ID: V03:K1:VCIyzvDd9HI1gcC0YPTOYGChr87wpsz7rHzxZffDRMrksupNbY9
 m5J40o14VSMH1IHfeiExhkA71Tt+CcXgQ8okt/ddbKB8YkkvrXRlhVVvl7+/qXPJDIm97N2
 Gj36H9Sdhbz5CORFf3b30HPIehXPf+ju5HkJHBERRfL+RBut0megc6FIKzl94Om3d2b4vlc
 bp/I/9V3/ZLrOK6vf1VCg==
UI-OutboundReport: notjunk:1;M01:P0:MVeSo3zwXW4=;FUHTJok0ckLQKItqMZMvd82+PzH
 EzNuCja4gAXGfzjlBPp6FNs/B/B9uxJcDmZdAzGaZDW1XYFY51YKi1wEoJeq6EPKgzIa/bCJh
 Ohtq/p+rn1mPzbdrWFi/d917kTq9kdGo4OYKX79qtJF3whUexv0SR8QodQLPacUFCAdZa45Uh
 1Tkk4rMTWtU2AFxuh+pd6cZPHVlvzkuZOrrMmM4zLKNx3IliI/lbQs2l845iSy20YKJ+P4Nx1
 rQ9uPFGto/6jKrhRgb/vwzLfULb9WJze9s+ZXsCOGL44I+7jduLAqGlL8rnItRpG08U/sjZUq
 wwB1/FMWt2O0EGHUdkcP6iy/5u7pCTockvi8jz4uD4nOkI1smorFj1DzERh4ClXP8PxHNZ3Si
 DzV+0ThlnJHWjCTebne+Lgg+AXtbR/jQdswePZXu39YqULuY9uGOFiLVK1TKw050pojbJsFZx
 P7QKOrP3Pxzf3y4KI6G5COHgq/GnrNvrM4Jre7Wv/szHYi/JZV6NWDGEbccmHSBouPOUrlHHB
 tsmUg3h3M0Cp2TiooPhHXmXPGIg2cqalznyZGjjK9xnxVNAh5H0rEpSoe+eXsIeSXANjx/f4S
 ZBNl/SGidjlJsQDPExPLIRJNPZFmM5dM7kFXIx3c/jEkAJDrB+CT1xK7+50gMCP4fJYpvp3nk
 ByJclGL6Sryys10ghsAB3R6vlzG52OgvdjCjAvOMLA==
X-Spam-Status: No, score=-97.1 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Jan 31 20:18, Takashi Yano wrote:
> On Tue, 31 Jan 2023 10:28:40 +0100
> Corinna Vinschen wrote:
> > LGTM.  Given how much I *don't* use the audio stuff in Cygwin,
> > would you just like to take over maintainership for this code?
> 
> Thanks. I could take care of it if you don't mind?

Not at all!


Thanks,
Corinna

Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 40B21385701F
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 12:44:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 40B21385701F
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M2gt5-1lNrz61zo7-004BJO for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021
 13:44:39 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 174CCA80DBA; Tue, 23 Mar 2021 13:44:39 +0100 (CET)
Date: Tue, 23 Mar 2021 13:44:39 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Message-ID: <YFnit7OtFJeflMQT@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
 <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
 <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
 <20210323205717.bf5c3a41695871ec70bf1229@nifty.ne.jp>
 <YFncTItWHhMlNH5Y@calimero.vinschen.de>
 <20210323213212.d2c5a9e7db7a508260693998@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323213212.d2c5a9e7db7a508260693998@nifty.ne.jp>
X-Provags-ID: V03:K1:TUVo5/2B3/AU9W+VScJChVATYdUJXB2Epm0VXYWh4zw4484C5x7
 cnrgbHenUjUwUILl9hHkeLOPWDRZUdEx86rKJFykwzjeilpOIyMYvP3W2nkTqtqNwZCU6wd
 WLke5GGr4vy99hhfqKYXbPlDYJ4yA6TdqOvUbplzuD1my6NTpgo9d/pzEpPhCJkgiOy7Mav
 LatGunVo198FvaLYJqiZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Ymq+O9WTIA=:1pr7UUhUWGFNOLHcBoyysF
 nYQcIv54dVvXDlIrgMdg0uEORfTPPu/49mhOy7Ab4R1wdCfZ+e0J483L4hrUzqSYg0/x2cFr6
 ePyhplMHuoQ0oe3bQzlZ798Bw+SOba+syh/Xdfrw9Y5YnFYrtaGoNhOaAawiigYA4P9xui2to
 dqakJKuJvp3Ld/UOLwuJWVyWDdFrmMSoTMM4CPuXet82JJcEOIcKMOMvRdaJLdQKdfhh0IcNR
 5g1BR2A8f0MCmINBrBsB7Lm1rkpZNzsZfpoWPvoYVm4PFukN4cY2hoPz+vrr3V/v+ehpEWqzT
 QUWLNHBEb25TSfJ41F9MisS3J+G640tElWc0v8hbsE7cE4WuzeJrOjaQJ/8PHi/vKOurSofNt
 ddp6E8eE8RSiJW/YWPJQugXV0Yn8Fh5lA7pyUBTu6wjB8xlxK299kjyz61nDXToLRMa9WgJ0p
 AX8WPSF8Vg==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 23 Mar 2021 12:44:42 -0000

On Mar 23 21:32, Takashi Yano via Cygwin-patches wrote:
> On Tue, 23 Mar 2021 13:17:16 +0100
> Corinna Vinschen wrote:
> > On Mar 23 20:57, Takashi Yano via Cygwin-patches wrote:
> > > Corinna Vinschen wrote:
> > > > > > On Mar 22 08:07, Takashi Yano via Cygwin-patches wrote:
> > > > > > > > And also, following cygwin apps/dlls call GetStdHandle():
> > > > > > > > ccmake.exe
> > > > > > > > cmake.exe
> > > > > > > > cpack.exe
> > > > > > > > ctest.exe
> > > > > > > > run.exe
> > > > 
> > > > run creates its own conin/conout handles to create a hidden console.
> > > > The code calling GetStdHandle() is only for debug purposes and never
> > > > built into the executable.
> > 
> > Sorry, but this was utterly wrong.  run calls GetStdHandle, then
> > overwrites the handles, but only if it doesn't already is attached to a
> > console.
> > 
> > > > Looks right to me.  If we patch cmake to do the right thing, do we still
> > > > need this patch, Takashi?
> > > 
> > > I don't think so. If all is well with current code, nothing to be fixed.
> > 
> > How do you evaluate this in light of the run behaviour above?
> 
> I try to check run.exe behaviour and noticed that
> run cmd.exe
> and
> run cat.exe
> does not work with cygwin 3.0.7 and 3.2.0 (TEST) while these
> work in 3.1.7.
> 
> Is this expected behaviour?

The problem is that I never used run.  I can't actually tell what
exactly is expected.  I *think* run was intended to start Cygwin
applications without console window in the first place, not
native Windows apps, but I could be wrong.

I don't even know if anybody is actually, seriously using it.
The biggest problem with run is probably that it's unmaintained for
a long time, and seeing code comments like

  /* Note: we do it this way instead of using GetConsoleWindow()
   * because we want it to work on < w2k.
   */

doesn't actually make me confident in its viability for any purpose...


Corinna

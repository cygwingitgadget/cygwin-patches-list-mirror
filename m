Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 235583848031
 for <cygwin-patches@cygwin.com>; Tue, 20 Apr 2021 08:47:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 235583848031
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MI59b-1lKDJh1hyB-00FFhe for <cygwin-patches@cygwin.com>; Tue, 20 Apr 2021
 10:47:26 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id F26CFA80EDA; Tue, 20 Apr 2021 10:47:25 +0200 (CEST)
Date: Tue, 20 Apr 2021 10:47:25 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Make rlwrap work with cmd.exe.
Message-ID: <YH6VHTxT4Vn+BcAQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210419115153.1983-1-takashi.yano@nifty.ne.jp>
 <YH2RXQG9RT0V5WNG@calimero.vinschen.de>
 <20210420055113.b03868929391b157c69dc807@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210420055113.b03868929391b157c69dc807@nifty.ne.jp>
X-Provags-ID: V03:K1:8Mh3VBrfqXnlpiugfnql5gxosBO//ZzLLfkGuxQrtYysQCegCcs
 mcmRxUISjDGAG1lGFuyUFHYeouwESIlI1uTnuOmAKKiYFk+Vkel+0JrGJDk0Xw2BY7CdUCj
 EUeeXE+tgm351zVkJFBuYh+TdddWphQDf8FNUIqkkvze/7rF/QudB159vZjUhPkGW6BCifh
 /p10z49YL/qGWHromUSHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PzKndfoWkG0=:69bMWY4iAJLvXPROJ6oJT3
 YxuKE73ItlqTwzUdQCZBJEHNJ6AnSqbbRh/CPsYeTTzD+b5ogr8bhXCc/4ceE5zI3RGkAIHMN
 5UZH/Ag4DWAy4YrGKrSOSjaBcF7WA4dX9rMPLNO5q5i2h9anpXQ5PGIobr2nZRjtg18tEVtk1
 Lhl1aNiR+7f3d/85SRpRuDPcpp6uaae/4j9EEKYAB0K8aOGUmaLgaKt6eL0HaO4LSXmKeKDqK
 Ixp5q0IoraPQbiRPslxwlBU/zTv78FrJLYUuCezHoUliPaz2el8Sjz1YSNziViQ44o/X/LD1F
 TVjnoawxQM4WMi+GWY8hIPP2iL5d9DawKB7pnL/88cTazfBqGIY2Fimu9Cm7ibuZwkDJHsqjN
 nlHjhSbrRJzOqip0+wt3w4wDaVNsmRmbrTHjhzMiRCEYCEXJn6rjRX2yO3FVKhKMq4HEGb0vV
 TtaOCnWsgSnQAhQBGxihXPG93/g0YCIVqozcC5MnBelFQXOsVeGUXjudk574zKfola/PodigG
 FIJ607oT8YXXfOMIEAHDWs=
X-Spam-Status: No, score=-106.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 20 Apr 2021 08:47:33 -0000

On Apr 20 05:51, Takashi Yano wrote:
> On Mon, 19 Apr 2021 16:19:09 +0200
> Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > On Apr 19 20:51, Takashi Yano wrote:
> > > - After the commit 919dea66, "rlwrap cmd" fails to start pseudo
> > >   console. This patch fixes the issue.
> > > ---
> > >  winsup/cygwin/fhandler_tty.cc | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> > > index ba9f4117f..d44728795 100644
> > > --- a/winsup/cygwin/fhandler_tty.cc
> > > +++ b/winsup/cygwin/fhandler_tty.cc
> > > @@ -1170,6 +1170,8 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
> > >      }
> > >    if (isHybrid)
> > >      return;
> > > +  if (get_ttyp ()->pcon_start)
> > > +    return;
> > >    WaitForSingleObject (pcon_mutex, INFINITE);
> > >    if (!pcon_pid_self (get_ttyp ()->pcon_pid)
> > >        && pcon_pid_alive (get_ttyp ()->pcon_pid))
> > > -- 
> > > 2.31.1
> > 
> > this patch doesn't apply.  Does it depend on the race issue fixes?
> 
> Yes. This depends on the race issue patches.
> Please apply this patch after the race issue patches.
> 
> Thanks.

Pushed.


Thanks,
Corinna

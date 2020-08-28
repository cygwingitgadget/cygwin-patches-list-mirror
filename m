Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id E1DF93857023
 for <cygwin-patches@cygwin.com>; Fri, 28 Aug 2020 19:26:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E1DF93857023
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 07SJPpuM028385
 for <cygwin-patches@cygwin.com>; Sat, 29 Aug 2020 04:25:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 07SJPpuM028385
X-Nifty-SrcIP: [124.155.38.192]
Date: Sat, 29 Aug 2020 04:25:54 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable pseudo console if TERM is dumb or
 not set.
Message-Id: <20200829042554.e18de504a93bb80da347e858@nifty.ne.jp>
In-Reply-To: <20200828134503.GL3272@calimero.vinschen.de>
References: <20200826120015.1188-1-takashi.yano@nifty.ne.jp>
 <20200828134503.GL3272@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Fri, 28 Aug 2020 19:26:09 -0000

Hi Corinna,

On Fri, 28 Aug 2020 15:45:03 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Aug 26 21:00, Takashi Yano via Cygwin-patches wrote:
> > Pseudo console generates escape sequences on execution of non-cygwin
> > apps.  If the terminal does not support escape sequence, output will
> > be garbled. This patch prevents garbled output in dumb terminal by
> > disabling pseudo console.
> > ---
> >  winsup/cygwin/spawn.cc | 36 +++++++++++++++++++++++++++++-------
> >  1 file changed, 29 insertions(+), 7 deletions(-)
> > 
> > diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> > index 8308bccf3..b6d58e97a 100644
> > --- a/winsup/cygwin/spawn.cc
> > +++ b/winsup/cygwin/spawn.cc
> > @@ -647,13 +647,35 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >        ZeroMemory (&si_pcon, sizeof (si_pcon));
> >        STARTUPINFOW *si_tmp = &si;
> >        if (!iscygwin () && ptys_primary && is_console_app (runpath))
> > -	if (ptys_primary->setup_pseudoconsole (&si_pcon,
> > -			     mode != _P_OVERLAY && mode != _P_WAIT))
> > -	  {
> > -	    c_flags |= EXTENDED_STARTUPINFO_PRESENT;
> > -	    si_tmp = &si_pcon.StartupInfo;
> > -	    enable_pcon = true;
> > -	  }
> > +	{
> > +	  bool nopcon = mode != _P_OVERLAY && mode != _P_WAIT;
> > +	  /* If TERM is "dumb" or not set, disable pseudo console */
> > +	  if (envblock)
> > +	    {
> > +	      bool term_is_set = false;
> > +	      for (PWCHAR p = envblock; *p != L'\0'; p += wcslen (p) + 1)
> > +		{
> > +		  if (wcscmp (p, L"TERM=dumb") == 0)
> > +		    nopcon = true;
> > +		  if (wcsncmp (p, L"TERM=", 5) == 0)
> > +		    term_is_set = true;
> > +		}
> > +	      if (!term_is_set)
> > +		nopcon = true;
> > +	    }
> > +	  else
> > +	    {
> > +	      const char *term = getenv ("TERM");
> > +	      if (!term || strcmp (term, "dumb") == 0)
> > +		nopcon = true;
> > +	    }
> > +	  if (ptys_primary->setup_pseudoconsole (&si_pcon, nopcon))
> > +	    {
> > +	      c_flags |= EXTENDED_STARTUPINFO_PRESENT;
> > +	      si_tmp = &si_pcon.StartupInfo;
> > +	      enable_pcon = true;
> > +	    }
> > +	}
> >  
> >      loop:
> >        /* When ruid != euid we create the new process under the current original
> > -- 
> > 2.28.0
> 
> Would you mind to encapsulate the TERM checks into a fhandler_pty_slave
> method so the TERM specific stuff is done in the fhandler code, not
> in spawn.cc?

Thansk for the suggestion. I will submit v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

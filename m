Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 385473951415
 for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2020 19:16:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 385473951415
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N3sRi-1kfx8R3i1A-00zkRm for <cygwin-patches@cygwin.com>; Tue, 08 Sep 2020
 21:16:31 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8169BA83A8D; Tue,  8 Sep 2020 21:16:31 +0200 (CEST)
Date: Tue, 8 Sep 2020 21:16:31 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200908191631.GT4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200904192235.GW4127@calimero.vinschen.de>
 <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
 <20200905201506.8bbca09f51a2b2b06135affa@nifty.ne.jp>
 <20200905231516.c799225e61b2b96bf05f65a6@nifty.ne.jp>
 <20200906175703.5875d4dd6140d9f6812cf2a9@nifty.ne.jp>
 <20200906191530.32230a99bf23d3c6f21beb41@nifty.ne.jp>
 <20200907010413.53ef9a9b727e8f971ca6b2ea@nifty.ne.jp>
 <20200907134558.3e1cd8bd4070991b856f58bb@nifty.ne.jp>
 <20200908084034.GO4127@calimero.vinschen.de>
 <20200908184536.3670324a2026ef0394de3821@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908184536.3670324a2026ef0394de3821@nifty.ne.jp>
X-Provags-ID: V03:K1:E3uXXIBDxNTQLBTkAZOc9KvtDIRbxMQSNi/SdBD1Gv+yifaxZml
 1nHVVc10KqUdZ4ld5PjRYkrvyb7COd4b3bO9pz8NHiqkfjUb1h/Zllu7aM0c+oRU12wlh+X
 jIlKFJ79IAFlR8dZSyuNPaP2wOzb1ahdMa9KdU1h+Zi+g+5KYsXHxsmYfz6TKCVut4YVHrh
 VdUmPfWKoSdDV+b25tYBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wBJEayvgu+M=:LDj53O3zYx1zP/Nq1eTGGu
 huFV69erTz9pNBWLMNOjqOv+4EaChlyRiKL2/9UypHd4Hb2nVBD53vkRyJSqK/O3j4x40Qyeo
 G1KrcGhU7a8xVAeQGtbiJa3ovKK6yeOVHVXs5ecSchApUtI2ni3GCFKeUszL6iXs5NtszU/EK
 wfMsebLTZlKH4aUCtSmyrYMvTXozhoddGPA8e33BzZbTUyTZL1lTLAJSpKIl6YrXJrR+As7V0
 CWXP1oYLBwZbscYRMFkIPMqQyFYirDAUsvkWTeYLtSJWAsMIKedKZDdn8ZQMoYjuSd4hDuFFq
 pUqb5C/KbtoI/bEbpni5GVsQPXUJwHH1llAB6PgGnE5Zh/8Cw0SJpT6A1Ij2p0NAmkTKM8fk8
 ex6MmbsTdGjxO4GxkAMDROlCap0r/H61DdNpRgPwsrJ/PlZxfD396JdN1F9bQDOkBPMGB4mSx
 risZKlNuIWz5QFwsmu01W7euLZIXqJSxWy0P7k/Aw7UWDIjwZt+DdoJ+t8hPTKkAWz6xsXkWF
 yiABkP9FuOnEZ1wm12GEYshtGT9e17P8R1mcF3SFEFMKs3i/UCLtnAsbKigVUAba6hgtOHhuQ
 g50ef0TPUhupWBbleopsoQ9dZQYZWpa4RbufM3NIR2g4MZy5NR0oGrYweMdgbqeY79qdL523z
 SAOrLkzjuyfqkIxcOgnK0GtXDtOxcc+QKvAlV9H0j5ORAnuTJYSb5oaS+lpKd6FbbnwH5GTiL
 1cyfYPX7GmWetog63Mp9yDlWg3jp2FvSLAcbz8vJK7Ve+v5yv8cUPjbMRrHGM3h+uZFugqSDb
 +2cPlujpD58xH6upY4hwi2BkigW3J8MFEpRoW8fh8vPcAj+egVMYZBL+tfdXlOYzjzoS1UszT
 1kWyTol8kuwNSRwW7wTw==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Tue, 08 Sep 2020 19:16:34 -0000

On Sep  8 18:45, Takashi Yano via Cygwin-patches wrote:
> Hi Corinna,
> 
> On Tue, 8 Sep 2020 10:40:34 +0200
> Corinna Vinschen wrote:
> > On Sep  7 13:45, Takashi Yano via Cygwin-patches wrote:
> > > On Mon, 7 Sep 2020 01:04:13 +0900
> > > > > Chages:
> > > > > - If global locale is set, it takes precedence.
> > > > 
> > > > Changes:
> > > > - Use __get_current_locale() instead of __get_global_locale().
> > > > - Fix a bug for ISO-8859-* charset.
> > > 
> > > Changes:
> > > - Use envblock if it is passed to CreateProcess in spawn.cc.
> > 
> > For the time being and to make at least *some* progress and with my
> > upcoming "away from keyboard"-time , I pushed the gist of my patch,
> > replacing the locale evaluating code in fhandler_tty with the function
> > __eval_codepage_from_internal_charset in its most simple form.
> > I didn't touch anything else, given that this discussion is still
> > ongoing.
> 
> Your patch pushed does the magic!
> 
> Even cygterm works even though the code does not check environment.
> 
> The point is here.
> 
> @@ -1977,9 +1807,6 @@ fhandler_pty_slave::fixup_after_exec ()
>    if (!close_on_exec ())
>      fixup_after_fork (NULL);   /* No parent handle required. */
> 
> -  /* Set locale */
> -  setup_locale ();
> -
>    /* Hook Console API */
>  #define DO_HOOK(module, name) \
>    if (!name##_Orig) \
> 
> Without this deletion, term_code_page is determined when
> cygwin shell is executed. Since it is in fixup_after_exec(),
> setlocale() does not called yet in the shell. As a result,
> term_code_page cannot be determined correctly.
> 
> In your new patch, term_code_page is determined when the first
> non-cygwin program is execed in the shell. The shell process
> already calls setlocale(), so term_code_page can be determined
> using global locale.
> 
> Thanks for the excellent idea!
> 
> Only the problem I noticed is that cygterm does not work if the
> shell does not call setlocale(). This happens if the shell is
> non-cygwin program, for example, cmd.exe, however, it is unusual
> case.

This is unexpected, but I'm glad this could be much simplfied.


Thanks,
Corinna

Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 0339F3857807
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 15:27:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0339F3857807
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MfYHQ-1lhBqW32Vc-00g0Pv for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 16:27:00 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 12F87A80988; Mon, 18 Jan 2021 16:27:00 +0100 (CET)
Date: Mon, 18 Jan 2021 16:27:00 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Set input_available_event only for cygwin
 pipe.
Message-ID: <20210118152700.GJ59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115092631.748-1-takashi.yano@nifty.ne.jp>
 <20210119000031.4eab2786d24768f405b6bfdf@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119000031.4eab2786d24768f405b6bfdf@nifty.ne.jp>
X-Provags-ID: V03:K1:ybDHMrLlGKGSv8vzZE+sxtYQK87ynvzl2uYlB2hjN6jpGIvHxZL
 kNisvHVhuYbAiKsyPgF/dcyCIzwrMiD2JDVNAAeSO8IRWyn3NaRmpfBpob8MrlDklfQ+86V
 lltNUhcrDCJIEgS3G6cAnN5FBEZTsxBvSIs/eX5MW3m9sHZ2B00bQi/zQ+yXfC6VU1L3KhH
 fUnkgN9KiJXY6l+uSPPpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VlafKFW+xWs=:0spDXjKhLqgQdBuNcuSeko
 HXl/c1fpz+UhLuzMLiCTABRQxdBvzG4IUpdP/hgbNw/4kkiGg9AwQZLwXFAiDcVIZB4bLw4eZ
 4CJL1jAlq7xE9M5yLKa1tmhyPCHmZLHe/W0UVrdICkfMa3IkjgVIJfEzz07SDFFBv+QthFIkZ
 naH+iGLvDQ4sPNWs3OpkzsgIJ08q0QCfw2oDzpWRvxKgQTu68Cfx5SxuROv9YdkWeaoyjLvcl
 O493uNbXxQBR/d+8n0WNZyPC3zXbDPoEmrhEd0jk04E6dje/mpp/uZsDKjdGwmRaUTSpAp2K7
 IpZvQT9a7EOpFUQA3B7hrxCQa/tQEoHRFj8hGp26siFZqD7/P8yOBRwaQXYv0OObfM/6H+bjR
 CXOQx/y75KKTNxeOXx8HUGDlpo6xpGlqk2RtBInE82MaFQ1D9bax7UxkMezHYfH4VIUia0FBH
 a8GmH1dKRw==
X-Spam-Status: No, score=-107.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 18 Jan 2021 15:27:03 -0000

On Jan 19 00:00, Takashi Yano via Cygwin-patches wrote:
> Hi Corinna,
> 
> On Fri, 15 Jan 2021 18:26:31 +0900
> Takashi Yano wrote:
> > - cat exits immediately in the following senario.
> >     1) Execute env CYGWIN=disable_pcon script
> >     2) Execute cmd.exe
> >     3) Execute cat in cmd.exe.
> >   This is caused by setting input_available_event for the pipe for
> >   non-cygwin app. This patch fixes the issue.
> > ---
> >  winsup/cygwin/fhandler_tty.cc | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> > index e4993bf31..0b9901974 100644
> > --- a/winsup/cygwin/fhandler_tty.cc
> > +++ b/winsup/cygwin/fhandler_tty.cc
> > @@ -394,7 +394,8 @@ fhandler_pty_master::accept_input ()
> >  	}
> >      }
> >  
> > -  SetEvent (input_available_event);
> > +  if (write_to == get_output_handle ())
> > +    SetEvent (input_available_event);
> >    ReleaseMutex (input_mutex);
> >    return ret;
> >  }
> > -- 
> > 2.30.0
> > 
> 
> I would be happy if you could review this patch as well.

Sorry, I missed that one!  Pushed.


Thanks,
Corinna

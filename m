Return-Path: <SRS0=JFVn=EN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0010.nifty.com (mta-snd00002.nifty.com [106.153.226.34])
	by sourceware.org (Postfix) with ESMTPS id AD5E23858D28
	for <cygwin-patches@cygwin.com>; Mon, 28 Aug 2023 12:14:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AD5E23858D28
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 by dmta0010.nifty.com with ESMTP
          id <20230828121436566.NFIG.103955.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 28 Aug 2023 21:14:36 +0900
Date: Mon, 28 Aug 2023 21:14:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: spawn: Fix segfalt when too many command
 line args are specified.
Message-Id: <20230828211436.5268a64fd69768f80f3e43ff@nifty.ne.jp>
In-Reply-To: <ZOyAXmWkAH1BBCh2@calimero.vinschen.de>
References: <20230828094605.2405-1-takashi.yano@nifty.ne.jp>
	<ZOx9j/YRr3UX88wV@calimero.vinschen.de>
	<ZOyAXmWkAH1BBCh2@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 28 Aug 2023 13:09:18 +0200
Corinna Vinschen wrote:
> On Aug 28 12:57, Corinna Vinschen wrote:
> > On Aug 28 18:46, Takashi Yano wrote:
> > > Previously, the number of command line args was not checked for
> > > cygwin process. Due to this, segmentation fault was caused if too
> > > many command line args are specified.
> > > https://cygwin.com/pipermail/cygwin/2023-August/254333.html
> > > 
> > > Since char *argv[argc + 1] is placed on the stack in dll_crt0_1(),
> > > STATUS_STACK_OVERFLOW occurs if the stack does not have enough
> > > space.
> > > 
> > > With this patch, the total length of the arguments and the size of
> > > argv[] is restricted to 1/4 of total stack size for the process, and
> > > spawnve() returns E2BIG if the size exceeds the limit.
> > > [...]
> > I tried this simple patch:
> > 
> > diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> > index 49b7a44aeb15..961dea4ab993 100644
> > --- a/winsup/cygwin/dcrt0.cc
> > +++ b/winsup/cygwin/dcrt0.cc
> > @@ -978,11 +978,8 @@ dll_crt0_1 (void *)
> >  	 a change to an element of argv[] it does not affect Cygwin's argv.
> >  	 Changing the the contents of what argv[n] points to will still
> >  	 affect Cygwin.  This is similar (but not exactly like) Linux. */
> > -      char *newargv[__argc + 1];
> > -      char **nav = newargv;
> > -      char **oav = __argv;
> > -      while ((*nav++ = *oav++) != NULL)
> > -	continue;
> > +      char **newargv = (char **) malloc ((__argc + 1) * sizeof (char **));
> > +      memcpy (newargv, __argv, (__argc + 1) * sizeof (char **));
> >        /* Handle any signals which may have arrived */
> >        sig_dispatch_pending (false);
> >        _my_tls.call_signal_handler ();
> > 
> > and the testcase `LC_ALL=C sed 's/x/y/' $(seq 1000000)' simply ran
> > as desired.  Combined with a bit of error checking...
> 
> We may also get away with storing it in the Windows heap, but I didn't
> test this .
> 
> > Along these lines, there's no reason to couple SC_ARG_MAX to the
> > size of the stack.  I'd propose to return the value 2097152.  It's
> > the default value returned by getconf ARG_MAX on LInx as well.
> 
> Oh, and we can carefully check in child_info_spawn::worker that
> the args are not taking more space than the value returned by
> SC_ARG_MAX and return E2BIG if so.  We do this when checking the
> args for non-Cygwin apps anyway.

As for non-cygwin apps, the check seems to be done in linebuf::fromargv()
in winf.cc. Further, dcr0.cc code does not affect to non-cygwin app.
So my patch check only for cygwin apps case.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

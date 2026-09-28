Return-Path: <SRS0=yklb=HU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.121])
	by sourceware.org (Postfix) with ESMTPS id 75B1E4BA23EA
	for <cygwin-patches@cygwin.com>; Mon, 28 Sep 2026 11:53:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 75B1E4BA23EA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 75B1E4BA23EA
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.121
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790596390; cv=none;
	b=wGRpfuqMbw7Wri67JMQhLK1dbt8fHJll6DVw/S0pFC7JlKHLWFn3Kb+siL1qMDC4UanRoZSMRUTwx9juYrIBRLzWhhxU1ourVyQxFS/GmbIrP41LPdLNXemP8+zBtr8g2qrsMGMq9WvAkyEj0onpZgkdZmP9ZUoaq92YU0JkaNo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790596390; c=relaxed/simple;
	bh=mh1oEArrplBxyWvG1OEO0sCu5dy4lhmwyQXxYLYg1qQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=siCEhf0JMz4PRcoWe+Fvgia+RhAV/Mk1KfDy4NatcUuyI6YTkp4TNaJWPZiWNnYpCcn7JjK7C8IfhmCM8wASxhZsQZAKE46Fx3/K1nhZILNjaC3GBMEx/dPWTWN+qDrPY8+Thou6o3lK1tdtn8+iYKfQY/h3dLYx7fXZcLbNrVs=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=izwlpHOP
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 75B1E4BA23EA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=izwlpHOP
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260928115305196.XXTO.60338.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 28 Sep 2026 20:53:05 +0900
Date: Mon, 28 Sep 2026 20:53:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: preserve terminal replies after PTY
 adoption
Message-Id: <20260928205303.4d9215defd8a403bbc994e23@nifty.ne.jp>
In-Reply-To: <20260917201943.dbe64d19e53c7d18eafb31e3@nifty.ne.jp>
References: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com>
	<20260915213259.fd24c38cac2c2adafdd2b097@nifty.ne.jp>
	<20260917201943.dbe64d19e53c7d18eafb31e3@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790596385;
 bh=P6qKSNEim9xFaqbJHufkskrTqp/PJt2sxSB/9GMSJk4=;
 h=Date:From:To:Subject:In-Reply-To;
 b=izwlpHOPLu9d/0WRl/0ayin0flskTCxwE4pBrbvUxVBUAYBdv8yYRFR+8GBEv6Rn8O0vtSFJ
 TwOEkAABj7pkk6rEuUM58oPAYLXb7qFHXVPvDU7ZhTp/Q7+rggTUcWdfWWm4Zxo2E+Q9IztFv/
 1LGQfJ2GXgYB6yidEPy3UmScNDGSfzm7Z/oyY4PZBMbyMI2WlX04yPaAVqp8hps+EbMgX5LuCZ
 VTzwnuGV0DU2f6qyok8ck6CmLTI2+6qcIHqEkPsjq6XskkD05qwc2rHsRPgJVSDENIHRL5EmJY
 BY1iUbS6WTYuRsHNDf4e2oBxP+n9rW4uydRciEtKBmqvRTlg==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Ping? > Johannes,

On Thu, 17 Sep 2026 20:19:43 +0900
Takashi Yano wrote:
> On Tue, 15 Sep 2026 21:32:59 +0900
> Takashi Yano wrote:
> > Hi Johannes,
> > 
> > Thanks for the patch.
> > 
> > On Sun, 13 Sep 2026 12:30:05 +0000
> > "Johannes Schindelin wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > 
> > > This fixes an issue reported about MSYS2/Win32 interaction, but applies
> > > to regular Cygwin as well. In the following, the original scenario is
> > > described.
> > > 
> > > MSYS Vim launched by native Git from Bash in MinTTY can delete the first
> > > line, enter Insert mode or insert RGB text at startup. PTY adoption sends
> > > Vim's output directly to MinTTY, but input stays with ConHost until the
> > > first Cygwin read/select. Vim inherits Git's foreground process group, so
> > > the process-group callback does not trigger an earlier handoff.
> > > 
> > > Vim sends terminal queries before reading. ConHost interprets cursor
> > > position reports as function keys, which the later input transfer delivers
> > > to Vim as keystrokes. A color reply split across the handoff reaches Vim
> > > without its introducer. Fragmented writes are valid; inconsistent routing
> > > corrupts their contents.
> > > 
> > > Requesting noncanonical input with tcsetattr() provides a control point
> > > before these queries. Handing input to the Cygwin PTY there aligns both
> > > directions before replies can be misdirected, rather than waiting for
> > > consumption. Only the foreground process on an active pseudoconsole takes
> > > this path; canonical, background and pcon-disabled calls are unaffected.
> > > 
> > > The existing synchronized transfer preserves queued input and line
> > > discipline. Balancing the temporary reader registration without transferring
> > > back keeps input on the Cygwin pipe without a permanent reader claim or
> > > changes to native-owner cleanup. Releasing the output mutex first avoids
> > > holding it across the input-transfer path.
> > > 
> > > Addresses: https://github.com/git-for-windows/git/issues/6403
> > > Fixes: 6eed1ef74869 ("Cygwin: pty: detect pcon-backed pty for non-Cygwin-spawned children")
> > > Assisted-by: GPT-6
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >     Cygwin: pty: preserve terminal replies after PTY adoption
> > >     
> > >     I just merged this into Git for Windows' fork of the MSYS2 runtime, as
> > >     it is a somewhat pressing problem due to Git for Windows v2.56.0-rc0
> > >     already being overdue.
> > >     
> > >     This patch is based on cygwin-3_6-branch, but is easily cherry-picked
> > >     onto master, too.
> > > 
> > > Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-10%2Fdscho%2Ffix-vim-terminal-replies-v1
> > > Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-10/dscho/fix-vim-terminal-replies-v1
> > > Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/10
> > > 
> > >  winsup/cygwin/fhandler/pty.cc | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > > index c5081bcaf..f6e051b9e 100644
> > > --- a/winsup/cygwin/fhandler/pty.cc
> > > +++ b/winsup/cygwin/fhandler/pty.cc
> > > @@ -1637,6 +1637,15 @@ fhandler_pty_slave::tcsetattr (int, const struct termios *t)
> > >    acquire_output_mutex (mutex_timeout);
> > >    get_ttyp ()->ti = *t;
> > >    release_output_mutex ();
> > > +
> > > +  /* Terminal queries can precede the first read/select after entering
> > > +     noncanonical mode.  Their replies must bypass the native console. */
> > > +  if (!(t->c_lflag & ICANON) && get_ttyp ()->pcon_activated
> > > +      && get_ttyp ()->getpgid () == myself->pgid)
> > > +    {
> > > +      mask_switch_to_nat_pipe (true, true);
> > > +      mask_switch_to_nat_pipe (false, false);
> > > +    }
> > >    return 0;
> > >  }
> > >  
> > > 
> > > base-commit: c19c1e6ad9d8abad640ffcb95996642cc35955ec
> > > -- 
> > > cygwingitgadget
> > 
> > To me, the root cause and the proposed fix seem out of alignment.
> > If "input stays with ConHost until the first Cygwin read/select",
> > the solution is calling transfer_input() in the slave::open(),
> > say, around here:
> > 
> >   if (get_ttyp ()->pcon_activated)
> >     {
> >       HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> >                                        get_ttyp ()->nat_pipe_owner_pid);
> >       if (pcon_owner)
> >         {
> >           HANDLE new_in = NULL, new_out = NULL;
> >           bool ok_in = DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> >                                        GetCurrentProcess (), &new_in,
> >                                        0, TRUE, DUPLICATE_SAME_ACCESS);
> >           bool ok_out = DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
> >                                         GetCurrentProcess (), &new_out,
> >                                         0, TRUE, DUPLICATE_SAME_ACCESS);
> >           if (ok_in && ok_out)
> >             {
> >               /* Replace these before open_with_arch() copies them into the
> >                  archetype shared by all pty slave fhandlers. */
> >               CloseHandle (get_handle_nat ());
> >               CloseHandle (get_output_handle_nat ());
> >               set_handle_nat (new_in);
> >               set_output_handle_nat (new_out);
> >             }
> >           else
> >             {
> >               if (new_in)
> >                 CloseHandle (new_in);
> >               if (new_out)
> >                 CloseHandle (new_out);
> >             }
> >           CloseHandle (pcon_owner);
> >         }
> >     }
> > 
> > What do you think?
> 
> No. Not here. Too early perhaps. May be in slave::init().
> 
> I also noticed that the same problem occurs if vim is
> started with non-cygwin program running in background.
> This also affects cygwin-3_6-brancy.
> 
> Therefore, I think we need transfer_input also in
> slave::fixup_after_exec().

I confirmed that the following patch works as expected.
What do you think?

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index fb49c02b3..e56b9f55f 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1362,6 +1362,8 @@ fhandler_pty_slave::init (HANDLE h, DWORD a, mode_t, int64_t dummy)
   if (h != INVALID_HANDLE_VALUE)
     CloseHandle (h);	/* Reopened by open */
 
+  fixup_input_state_for_cygwin_app ();
+
   return ret;
 }
 
@@ -1407,18 +1409,7 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 	  mutex_timeout = INFINITE;
 	  if (isHybrid)
 	    {
-	      WaitForSingleObject (input_mutex, mutex_timeout);
-	      if (get_ttyp ()->getpgid () == myself->pgid
-		  && GetStdHandle (STD_INPUT_HANDLE) == get_handle ()
-		  && get_ttyp ()->pty_input_state_eq (tty::to_nat))
-		{
-		  acquire_attach_mutex (mutex_timeout);
-		  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
-				  input_available_event,
-				  input_transferred_to_cyg);
-		  release_attach_mutex ();
-		}
-	      ReleaseMutex (input_mutex);
+	      fixup_input_state_for_cygwin_app ();
 	      if (get_ttyp ()->master_is_running_as_service
 		  && get_ttyp ()->pcon_activated)
 		/* If the master is running as service, re-attaching to
@@ -2939,6 +2930,8 @@ fhandler_pty_slave::fixup_after_fork (HANDLE parent)
 void
 fhandler_pty_slave::fixup_after_exec ()
 {
+  fixup_input_state_for_cygwin_app ();
+
   if (!close_on_exec ())
     fixup_after_fork (NULL);	/* No parent handle required. */
 
@@ -4945,3 +4938,20 @@ fhandler_pty_slave::replace_nat_handles (HANDLE new_input, HANDLE new_output)
   CloseHandle (orig_input_handle_nat);
   CloseHandle (orig_output_handle_nat);
 }
+
+void
+fhandler_pty_slave::fixup_input_state_for_cygwin_app ()
+{
+  WaitForSingleObject (input_mutex, mutex_timeout);
+  if (get_ttyp ()->getpgid () == myself->pgid
+      && GetStdHandle (STD_INPUT_HANDLE) == get_handle ()
+      && get_ttyp ()->pty_input_state_eq (tty::to_nat))
+    {
+      acquire_attach_mutex (mutex_timeout);
+      transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
+		      input_available_event,
+		      input_transferred_to_cyg);
+      release_attach_mutex ();
+    }
+  ReleaseMutex (input_mutex);
+}
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 341a326a6..9fc615291 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2544,6 +2544,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   static void release_ownership_of_nat_pipe (tty *ttyp, fhandler_termios *fh);
   void replace_nat_handles (HANDLE new_input, HANDLE new_output);
   void req_fixup_pcon_state (void);
+  void fixup_input_state_for_cygwin_app (void);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

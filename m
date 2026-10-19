Return-Path: <SRS0=3tSx=IJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 267764BA2E3F
	for <cygwin-patches@cygwin.com>; Mon, 19 Oct 2026 11:24:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 267764BA2E3F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 267764BA2E3F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792409083; cv=none;
	b=VMafh8TWoQzE+S0msoFFyDP12ufxOeP/ImgdLVg0t7mZVpK0ZEqCaf1wtQEPnJnCqADEKly4j+GpJcu2x0gANw5BS5L3UlkvRUuZ7Kv+S3+BDDtO1oG9vWVpsdOCyL+tk5RfoJw8b0azk/bG5yZHiHLm2Rxy6P3qBUXGb0S6iks=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792409083; c=relaxed/simple;
	bh=4KIt3+5jlt+2SZnyCwjANHd0tDnFyEqnD5SSZIY+270=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=nepAk4gHCEx3NFbWrlAOAEu/AEpcYi+7J6AZ5rmKe7Lnec0sEk613J1aluCZutm7y+haFPkddBjZH7580Nb3tGOgZUgx4F/qKpLOAStWhsEN2zOLAeLJEXLsE0Kriq880uF2xFUj4/oNpuN8hgLcWge37fyDy7bXBLJ8zVIEy9I=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=AiuYHZfl
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 267764BA2E3F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=AiuYHZfl
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20261019112438564.TTOG.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 19 Oct 2026 20:24:38 +0900
Date: Mon, 19 Oct 2026 20:24:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/5] Cygwin: pty: preserve terminal replies after PTY
 adoption
Message-Id: <20261019202436.b4be6f5be0398ce887f9d757@nifty.ne.jp>
In-Reply-To: <a7e10148-e530-5218-4978-a02b61e47eb1@gmx.de>
References: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com>
	<pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
	<20261017152213.9394289b21159f4c56815788@nifty.ne.jp>
	<a7e10148-e530-5218-4978-a02b61e47eb1@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1792409078;
 bh=q5dsnxWFxK0zRLtf0v82fsd/XFcJ4T2OCcjXe7aN5uo=;
 h=Date:From:To:Subject:In-Reply-To;
 b=AiuYHZfl+0x2QDPaHhkZi356umrWDcL7En5T6+6ws5rEr1laT2kpfkmQxWA/MUT/cAIL6Eu5
 OcmuUvN9KefDWVBE6oadJLLVzJ4XuFJUU0SYsKUK46YzlyjmTuZrueHESOBKfeXeD9os61R5rW
 wQ6qNFp4mq0r9yt1iwkSoX9nhS+9TNPqs5LYgPU7Hf8QZvRRt5SKsjAtroMtX3o9xiEoOiwQG8
 90oyHmkxORW3Brc+W+mu3UTOInipKl/SGOTjMzCf00K8LKF3q3CaH4E5bc219HBumIP1F9AAKR
 se0/G0fVsKxtI7qvwlKccpap7bVQpHOpZJx5zP77UvaYSSHA==
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Sun, 18 Oct 2026 17:08:25 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> thank you for the review!
> 
> On Sat, 17 Oct 2026, Takashi Yano wrote:
> 
> > Two things.
> > (1) This patch series cannot be applied git master cleanly.
> 
> Right. Those are only mechanical merge conflicts, though. I pushed a
> rebased version of v3 to
> https://github.com/dscho/cygwin/pull/new/fix-vim-terminal-replies-for-cygmaster,
> and here is the range-diff:
> 
> -- snip --
> 1:  8a6255016b ! 1:  1e8ff0df6b Cygwin: pty: restore foreground input routing after exec
>     @@ winsup/cygwin/fhandler/pty.cc: fhandler_pty_slave::replace_nat_handles (HANDLE n
>      
>       ## winsup/cygwin/local_includes/fhandler.h ##
>      @@ winsup/cygwin/local_includes/fhandler.h: class fhandler_pty_slave: public fhandler_pty_common
>     -   void setpgid_aux (pid_t pid);
>         static void release_ownership_of_nat_pipe (tty *ttyp, fhandler_termios *fh);
>         void replace_nat_handles (HANDLE new_input, HANDLE new_output);
>     +   void req_fixup_pcon_state (void);
>      +  void fixup_input_state_for_cygwin_app (void);
>       };
>       
> 2:  ebf384575c ! 2:  9cd61e3529 Cygwin: testsuite: allow cygrun without the testing namespace
>     @@ winsup/testsuite/cygrun.c: main (int argc, char **argv)
>       ## winsup/testsuite/cygrun.sh ##
>      @@ winsup/testsuite/cygrun.sh: then
>           windows_runtime_root=$(cygpath -m $runtime_root)
>     -     $cygrun "$exe -v -cygwin $windows_runtime_root/cygwin1.dll"
>     +     $mingwtestdir/cygrun "$exe -v -cygwin $windows_runtime_root/cygwin1.dll"
>       else
>     --    cygdrop $cygrun $exe
>     +-    cygdrop $mingwtestdir/cygrun $exe
>      +    # Executables beside their private DLL need no extra testing namespace.
>      +    case "$exe" in
>      +        testinst/bin/*|./testinst/bin/*) set -- -notesting "$exe" ;;
>      +        *) set -- "$exe" ;;
>      +    esac
>     -+    cygdrop "$cygrun" "$@"
>     ++    cygdrop "$mingwtestdir/cygrun" "$@"
>       fi
> 3:  cceb823afd ! 3:  ddc225f60e Cygwin: testsuite: cover foreground PTY input recovery after exec
>     @@ winsup/testsuite/.gitattributes (new)
>       ## winsup/testsuite/Makefile.am ##
>      @@ winsup/testsuite/Makefile.am: clean-local:
>       
>     - if CROSS_BOOTSTRAP
>     + if MINGW_PROGS
>       SUBDIRS = mingw
>      +check_PROGRAMS += testinst/bin/pty-background-native
>      +testinst_bin_pty_background_native_SOURCES = \
>     @@ winsup/testsuite/mingw/Makefile.am: override CC = @MINGW_CC@
>       override CXX = @MINGW_CXX@
>       AM_CPPFLAGS =
>       
>     --noinst_PROGRAMS = cygrun cygload
>     -+noinst_PROGRAMS = cygrun cygload pty-native-input
>     +-noinst_PROGRAMS = cygrun cygload winchild
>     ++noinst_PROGRAMS = cygrun cygload winchild pty-native-input
>       
>       cygrun_SOURCES = \
>       	../cygrun.c
>     -@@ winsup/testsuite/mingw/Makefile.am: cygrun_SOURCES = \
>     - cygload_SOURCES = \
>     - 	../winsup.api/cygload.cc
>     - cygload_LDFLAGS=-static -Wl,-e,cygloadCRTStartup
>     +@@ winsup/testsuite/mingw/Makefile.am: winchild_SOURCES = \
>     + 	../winsup.api/posix_spawn/winchild.c
>     + winchild_LDFLAGS=-municode
>     + winchild_LDADD=-lntdll
>      +
>      +pty_native_input_SOURCES = \
>      +	pty-native-input.c
> 4:  2b13ec62fc = 4:  09e7bbe46c Cygwin: pty: recover input for children of native programs
> 5:  cdd3d9ce99 = 5:  f193c4cd45 Cygwin: testsuite: cover PTY input recovery with a native parent
> 6:  4469693b51 = 6:  d89eb54766 Cygwin: testsuite: cover queued native input with pcon disabled
> -- snap --
> 
> > (2) Typeahead input is broken without pseudo console enabled
> >     with this patch series.
> >       1. Run `env CYGWIN=disable_pcn script`
> >       2. Run `cmd`
> >       3. Run `sleep 10`
> >       4. Type ps<enter>ps<enter> while sleeping.
> >     The the second `ps` will not be executed in cmd.
> > 
> > Regarding (2), I think we have two options.
> > 
> > (a) Add an extra fix such as:
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 294bf8007..8f3b14327 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -1286,8 +1286,23 @@ fhandler_pty_slave::cleanup ()
> >    while (arch->num_reader)
> >      mask_switch_to_nat_pipe (false, false);
> >  
> > -  if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () == myself->pgid)
> > -    req_fixup_pcon_state ();
> > +  if (get_ttyp ()->getpgid () == myself->pgid)
> > +    {
> > +      if (get_ttyp ()->pcon_activated)
> > +	req_fixup_pcon_state ();
> > +      else if (get_ttyp ()->switch_to_nat_pipe)
> > +	{
> > +	  WaitForSingleObject (input_mutex, mutex_timeout);
> > +	  if (get_ttyp ()->pty_input_state_eq (tty::to_cyg))
> > +	    {
> > +	      acquire_attach_mutex (mutex_timeout);
> > +	      transfer_input (tty::to_nat, get_handle (), get_ttyp (),
> > +			      input_available_event, input_transferred_to_cyg);
> > +	      release_attach_mutex ();
> > +	    }
> > +	  ReleaseMutex (input_mutex);
> > +	}
> > +    }
> >  
> >    /* This used to always call fhandler_pty_common::close when we were execing
> >       but that caused multiple closes of the handles associated with this pty.
> > 
> > (b) Call fixup_input_state_for_cygwin_app() only when pcon_activated
> >     in fixup_after_exi() and post_open_setup().
> > 
> > What do you think?
> 
> Excellent feedback, I had completely missed that. I went for option (b),
> and extended the test cases to cover this scenario, too.

v3 patch LGTM. Pushed.
Thank you.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

Return-Path: <SRS0=/csx=B4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:29])
	by sourceware.org (Postfix) with ESMTPS id 5FCF14BA23F9
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 10:33:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5FCF14BA23F9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5FCF14BA23F9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774694027; cv=none;
	b=ScnMaizgyTWpW2hw+nEaxO9CLSoRdDXc+PO01gy14/rq6YnRMcfr5LYrWfQF+b+caungVd1vAawAD4iuUhCSeD4wJmMGv7ZcPKYMvlK081wk2MGlDpLhO3TadOpNe3kWNGbziRKqjnNRcx7pbedkRDpzFK5WtV/BJA4C2LIwUGE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774694027; c=relaxed/simple;
	bh=bauSaiFO6gliNOR0A1srXu4IIac6hNPu8byjrwA9ItY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=fgI48jL5ntRFXyDc8FpN3h79DYpqMlRP38ogKaqmB0FezMegy6vH3PjemnGutwnE41L0D/y9/BOMjdFEfigakrI8vEdhJJeRWNFCp/rl6bMwiDW3EEraUxswc0oo8otYyOYelenFHj7Ot/It08nZ2JXo9/W1P+Eezf3MwMwhGA0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5FCF14BA23F9
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Yd3ck/cm
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260328103343790.LPLG.116672.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 19:33:43 +0900
Date: Sat, 28 Mar 2026 19:33:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 4/7] Cygwin: pty: Apply line_edit() for transferred
 input to to_cyg
Message-Id: <20260328193341.9f39433f2345a558baed53c1@nifty.ne.jp>
In-Reply-To: <7735090b-32d2-66c3-e4f4-10b49641c020@gmx.de>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
	<20260325130453.62246-1-takashi.yano@nifty.ne.jp>
	<20260325130453.62246-5-takashi.yano@nifty.ne.jp>
	<7735090b-32d2-66c3-e4f4-10b49641c020@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774694023;
 bh=xmpo4lEy5Ma1zLu99kHshvNmxQ7apKrDw6hUGJoDD5M=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Yd3ck/cm9HSJW1j/soXsxPeeoiQw+yAQHSzRuP5isv3S8z+2k1ebwrWZePUZZ41XfSL+nhu9
 hTmxMufc58Eplc69x3Bc9kM+o9bUiI6MCrB9gCnpTA5M3VWmeMDoImZgWz9vCTouKW5iRfYXj0
 NYf/LMURIalPaNo8cQbOzcKLHhKJy5MT4cT7NGh8pD++EZ1VpjZx4iWt6Z1syhnatJkblKQ/l9
 nPsVc7ax4nZCDr8C261ILhmnyH4hHpPqq4/29eOEF5dlsGJfOqg5spfVSSgICb6xEzCxx2zWxV
 dAO/C1rZHHgxaW9Ah627TD5LQPXRQim9ZC0pBu70YfkmpNtQ==
X-Spam-Status: No, score=-12.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Fri, 27 Mar 2026 15:50:06 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> This is a nice fix for a subtle problem. I have a few observations,
> mostly about the commit message and one edge case.
> 
> On Wed, 25 Mar 2026, Takashi Yano wrote:
> 
> > The typeahead input while non-cygwin app is running is put into
> > the pipe directly by transfer_input(). So, if the shell sets the
> > terminal canonical mode, erase char (such as backspace) fails to
> > erase chars transferred by transfer_input(). With this patch,
> > transferred input in the pipe is read and passed to line_edit()
> > to handle erase chars such as VERASE, VKILL, etc.
> 
> The commit message is too terse for a change of this complexity. It
> describes _what_ is broken but not _why_ the fix has to look the way
> it does, nor the synchronization protocol you are introducing.
> 
> I think the message should cover at least these three things:
> 
> (a) Why the transferred bytes need `line_edit()` processing: when
> keystrokes travel through the nat pipe (during a native process
> session), they bypass POSIX line discipline entirely. When they are
> transferred back to the cyg pipe at cleanup, they arrive as raw bytes.
> If the terminal is in canonical mode at that point, VERASE/VKILL
> characters in those raw bytes will not erase anything because
> `line_edit()` was never applied to them.
> 
> (b) Why the forward thread is the right place to call `line_edit()`:
> it runs in the master process alongside `master::write()`, sharing
> access to the readahead buffer and `line_edit()` state. Calling
> `line_edit()` from the slave side (where `transfer_input()` runs)
> would not work because `line_edit()` state belongs to the master.
> 
> (c) The synchronization protocol: `transfer_input()` signals the
> event, then spin-waits for the forward thread to clear it, then
> proceeds.
> 
> Something like this might work:
> 
>     When keystrokes travel through the nat pipe during a native process
>     session, they bypass POSIX line discipline entirely. When they are
>     transferred back to the cyg pipe at cleanup (via
>     `transfer_input(to_cyg)`), they arrive as raw bytes. If the
>     terminal is in canonical mode at that point, VERASE and VKILL
>     characters in those raw bytes have no effect because `line_edit()`
>     was never applied to them. The result: backspace typed while a
>     native process was running fails to erase the preceding character
>     once the input reaches bash's readline.
> 
>     The fix applies `line_edit()` to the transferred bytes before they
>     reach the reading process. The right place to do this is the
>     master's forward thread (`pty_master_fwd_thread()`), because it
>     runs in the master process alongside `fhandler_pty_master::write()`
>     and shares access to the readahead buffer and `line_edit()` state.
>     Calling `line_edit()` from the slave (where `transfer_input()` runs)
>     would not work because that state belongs to the master.
> 
>     To coordinate: `transfer_input(to_cyg)` writes the raw bytes to
>     the cyg pipe's slave end (`to_slave`), then signals a new
>     cross-process event (`input_transferred_to_cyg`) and spin-waits
>     for the forward thread to clear it. The forward thread is converted
>     from synchronous to overlapped I/O so it can wait on both the
>     `from_slave_nat` read completion and the transfer event
>     simultaneously. When the event fires, it reads the transferred
>     bytes from the cyg pipe's master end (`from_master`), processes
>     them through `line_edit()`, and clears the event.
> 
>     The spin-wait in `transfer_input()` holds `input_mutex` (from its
>     caller), which blocks `fhandler_pty_master::write()` from injecting
>     new keystrokes until the forward thread has finished applying
>     `line_edit()` to the transferred bytes.
> 
> Note: _You_ are the domain expert on this, and I am quite far, still from
> understanding the ins and outs of your design, as demonstrated by my
> original patch series that started this thread. So I can only depend on
> you to fix any mistakes my lack of understanding introduced in that
> suggested commit message.
> 
> > 
> > Fixes: 10d083c745dd ("Cygwin: pty: Inherit typeahead data between two input pipes.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/fhandler/pty.cc           | 135 +++++++++++++++++-------
> >  winsup/cygwin/local_includes/fhandler.h |  10 +-
> >  winsup/cygwin/local_includes/tty.h      |   1 +
> >  3 files changed, 105 insertions(+), 41 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 72a8ba140..2a0e0d2f7 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -210,6 +210,7 @@ atexit_func (void)
> >  	      {
> >  		ptys->get_handle_nat (),
> >  		ptys->get_input_available_event (),
> > +		ptys->input_transferred_to_cyg,
> >  		ptys->input_mutex,
> >  		ptys->pipe_sw_mutex
> >  	      };
> > @@ -739,7 +740,7 @@ fhandler_pty_slave::open (int flags, mode_t)
> >    {
> >      &from_master_nat_local, &input_available_event, &input_mutex, &inuse,
> >      &output_mutex, &to_master_nat_local, &pty_owner, &to_master_local,
> > -    &from_master_local, &pipe_sw_mutex,
> > +    &from_master_local, &pipe_sw_mutex, &input_transferred_to_cyg,
> >      NULL
> >    };
> >  
> > @@ -779,6 +780,12 @@ fhandler_pty_slave::open (int flags, mode_t)
> >        errmsg = "open input event failed, %E";
> >        goto err;
> >      }
> > +  shared_name (buf, INPUT_TRANSFERRED_EVENT, get_minor ());
> > +  if (!(input_transferred_to_cyg = OpenEvent (MAXIMUM_ALLOWED, TRUE, buf)))
> > +    {
> > +      errmsg = "open input transferred event failed, %E";
> > +      goto err;
> > +    }
> >  
> >    /* FIXME: Needs a method to eliminate tty races */
> >    {
> > @@ -993,6 +1000,8 @@ fhandler_pty_slave::close (int flag)
> >      termios_printf ("CloseHandle (inuse), %E");
> >    if (!ForceCloseHandle (input_available_event))
> >      termios_printf ("CloseHandle (input_available_event<%p>), %E", input_available_event);
> > +  if (!ForceCloseHandle (input_transferred_to_cyg))
> > +    termios_printf ("CloseHandle (input_transferred_to_cyg<%p>), %E", input_transferred_to_cyg);
> >    if (!ForceCloseHandle (get_output_handle_nat ()))
> >      termios_printf ("CloseHandle (get_output_handle_nat ()<%p>), %E",
> >  	get_output_handle_nat ());
> > @@ -1101,7 +1110,8 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
> >  		  WaitForSingleObject (input_mutex, mutex_timeout);
> >  		  acquire_attach_mutex (mutex_timeout);
> >  		  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
> > -				  input_available_event);
> > +				  input_available_event,
> > +				  input_transferred_to_cyg);
> >  		  release_attach_mutex ();
> >  		  ReleaseMutex (input_mutex);
> >  		}
> > @@ -1277,14 +1287,14 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
> >  	{
> >  	  acquire_attach_mutex (mutex_timeout);
> >  	  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
> > -			  input_available_event);
> > +			  input_available_event, input_transferred_to_cyg);
> >  	  release_attach_mutex ();
> >  	}
> >        else if (!mask && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
> >  	{
> >  	  acquire_attach_mutex (mutex_timeout);
> >  	  transfer_input (tty::to_nat, get_handle (), get_ttyp (),
> > -			  input_available_event);
> > +			  input_available_event, input_transferred_to_cyg);
> >  	  release_attach_mutex ();
> >  	}
> >      }
> > @@ -1862,11 +1872,15 @@ fhandler_pty_slave::fch_open_handles (bool chown)
> >    shared_name (buf, INPUT_AVAILABLE_EVENT, get_minor ());
> >    input_available_event = OpenEvent (READ_CONTROL | write_access,
> >  				     TRUE, buf);
> > +  shared_name (buf, INPUT_TRANSFERRED_EVENT, get_minor ());
> > +  input_transferred_to_cyg = OpenEvent (READ_CONTROL | write_access,
> > +					TRUE, buf);
> >    output_mutex = get_ttyp ()->open_output_mutex (write_access);
> >    input_mutex = get_ttyp ()->open_input_mutex (write_access);
> >    pipe_sw_mutex = get_ttyp ()->open_mutex (PIPE_SW_MUTEX, write_access);
> >    inuse = get_ttyp ()->open_inuse (write_access);
> > -  if (!input_available_event || !output_mutex || !input_mutex || !inuse)
> > +  if (!input_available_event || !output_mutex || !input_mutex || !inuse
> > +      || !input_transferred_to_cyg)
> >      {
> >        __seterrno ();
> >        return false;
> > @@ -1883,11 +1897,13 @@ fhandler_pty_slave::fch_set_sd (security_descriptor &sd, bool chown)
> >  
> >    get_object_sd (input_available_event, sd_old);
> >    if (!set_object_sd (input_available_event, sd, chown)
> > +      && !set_object_sd (input_transferred_to_cyg, sd, chown)
> >        && !set_object_sd (output_mutex, sd, chown)
> >        && !set_object_sd (input_mutex, sd, chown)
> >        && !set_object_sd (inuse, sd, chown))
> >      return 0;
> >    set_object_sd (input_available_event, sd_old, chown);
> > +  set_object_sd (input_transferred_to_cyg, sd_old, chown);
> >    set_object_sd (output_mutex, sd_old, chown);
> >    set_object_sd (input_mutex, sd_old, chown);
> >    set_object_sd (inuse, sd_old, chown);
> > @@ -1900,6 +1916,7 @@ void
> >  fhandler_pty_slave::fch_close_handles ()
> >  {
> >    close_maybe (input_available_event);
> > +  close_maybe (input_transferred_to_cyg);
> >    close_maybe (output_mutex);
> >    close_maybe (input_mutex);
> >    close_maybe (inuse);
> > @@ -2151,6 +2168,9 @@ fhandler_pty_master::close (int flag)
> >    if (!ForceCloseHandle (input_available_event))
> >      termios_printf ("CloseHandle (input_available_event<%p>), %E",
> >  		    input_available_event);
> > +  if (!ForceCloseHandle (input_transferred_to_cyg))
> > +    termios_printf ("CloseHandle (input_transferred_to_cyg<%p>), %E",
> > +		    input_transferred_to_cyg);
> >  
> >    /* The from_master must be closed last so that the same pty is not
> >       allocated before cleaning up the other corresponding instances. */
> > @@ -2248,7 +2268,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >  	      acquire_attach_mutex (mutex_timeout);
> >  	      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
> >  						  get_ttyp (),
> > -						  input_available_event);
> > +						  input_available_event,
> > +						  input_transferred_to_cyg);
> >  	      release_attach_mutex ();
> >  	      ReleaseMutex (input_mutex);
> >  	    }
> > @@ -2346,7 +2367,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >      {
> >        acquire_attach_mutex (mutex_timeout);
> >        fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
> > -					  get_ttyp (), input_available_event);
> > +					  get_ttyp (), input_available_event,
> > +					  input_transferred_to_cyg);
> >        release_attach_mutex ();
> >      }
> >  
> > @@ -2707,6 +2729,24 @@ reply:
> >    return 0;
> >  }
> >  
> > +void
> > +fhandler_pty_master::apply_line_edit_to_transferred_input ()
> > +{
> > +  const size_t pipesize = fhandler_pty_common::pipesize;
> > +  char buf[pipesize];
> > +  DWORD n;
> > +  ReadFile (from_master, buf, pipesize, &n, NULL);
> 
> One edge case: this reads up to `pipesize` bytes in a single
> `ReadFile()`. If `transfer_input()` wrote more than that (unlikely
> with typeahead, but possible in principle), the remaining bytes stay
> in the pipe. The forward thread would pick them up on the next
> iteration via the regular `ReadFile()` path, but _without_
> `line_edit()` processing. In practice `pipesize` is 128 KB which is
> large enough that this is unlikely to matter, but it might be worth a
> comment explaining the assumption, or a loop to drain all pending
> bytes through `line_edit()`.

The `pipesize` is the size (depth) of cyg pipe and nat pipe. So,
ReadFile() here never reads (the pipe never keeps) more than 
`pipesize`. Therefore, the size of the buffer here of pipesize
bytes is enough.


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

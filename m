Return-Path: <SRS0=tl+H=FA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 717744BA2E09
	for <cygwin-patches@cygwin.com>; Mon,  6 Jul 2026 03:21:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 717744BA2E09
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 717744BA2E09
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783308084; cv=none;
	b=JfPUjHRJIL3HamSAa6xeo0oIPzzl/TrPUipZjN+wy/GMJR2+3WRpq+4MQS3bazF4sNAq9rdyXb7Cm1thkv25BVDP7mIPvNAD2UFNVmsiZzTG4LjONmvlX88iN2kfQA66Xf3QAE5FVMxIuaWknCf43ez2HVfWjLBDHdOwboimjxI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783308084; c=relaxed/simple;
	bh=RUQ6mIHH2GpNBnsC8aOdlTguMew2hqPHdong+hqhZDA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=v1Dst7CNAhm4MD8N1VXohl9+XHZHTbJjMRFcgDQ41JU3GT/PNBENcmxYk7MPPeGAHtzq97u6XKaK6nf+6dDr7RtLRP9wyvLIhqy+n3UwXSvPWznH1c+ZnulLaF727qCYnJjoipeXOXj1BO+SKgkFviSm2UaPgi/rEFe31mp4Q2c=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ddohanXZ
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 717744BA2E09
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ddohanXZ
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260706032121681.TDXD.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 6 Jul 2026 12:21:21 +0900
Date: Mon, 6 Jul 2026 12:21:20 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Do not transfer input to nat-pipe while
 masked
Message-Id: <20260706122120.bd5fba24fa7e4d01c3ee8543@nifty.ne.jp>
In-Reply-To: <67131026-6c13-7d7e-f80f-56565aea5aa2@gmx.de>
References: <20260630081436.2427-1-takashi.yano@nifty.ne.jp>
	<67131026-6c13-7d7e-f80f-56565aea5aa2@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783308081;
 bh=tTj1Vc0TC3Ze8W4TsbkOsBAJSqljMNfMujRw2I1zZsc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ddohanXZ67Qx7mzvT/2GMKzm07xpkR5xbIkFkXYGdZlNHgezXxYNpMmjjq7pMTj+0iKET7XC
 NkIQ7kcmFGt1wluX4P2FE8bXa0sbyxjuJD7HtfqPq4WmYxa4W5b49EqyMdoqaUG+cFidlp8zB6
 Ne6wNR9qMK27kh+Gd2ZjMc0YyNcMn1or8kQHf8kT0R/Wt7UgHf1MRM/LKowp/saOdDgzKgUjxH
 MT67p9C8inHUs2XZ+t7IpiVZyd6QZe840V+VkgKTXAPdBBHH+GTkrtmTHQL0CYqxhoSWiuJmM9
 tlvZE+Sr0vGj9UGR7TOHtbXGZut/dIIq6hnz3Zx/x4UcNiSA==
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Sun, 5 Jul 2026 10:10:51 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> Thank you for v2. The overall direction (blocking the nat-pipe transfer
> while a cygwin reader is active on the cyg-pipe) is correct, and the new
> cleanup hook is a good defensive addition against a slave that exits
> mid-read wedging the pipe state. I do want to flag one hazard, though,
> which I think v2 introduces by moving `slave_reading` and `num_reader`
> from the fhandler into the shared `tty` struct.
> 
> On Tue, 30 Jun 2026, Takashi Yano wrote:
> 
> > On the command "cat | non-cygwin-app", `cat` sometimes fails to read
> > key input. This happens when `cat` starts to read input before `non-
> > cygwin-app` configures pseudo console. This is because pipe state is
> > switched to nat-pipe when pseudo console is configured.
> > 
> > This patch prevent the pipe state from changing to nat-pipe state if
> > some cygwin process is reading input from the cyg-pipe.
> > 
> > Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> > v2: Release all masks owned by myself on cleanup()
> > 
> >  winsup/cygwin/fhandler/pty.cc           | 33 +++++++++++++++++++++----
> >  winsup/cygwin/local_includes/fhandler.h |  3 +--
> >  winsup/cygwin/local_includes/tty.h      |  2 ++
> >  3 files changed, 31 insertions(+), 7 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 35e320507..54cd64a47 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -951,7 +951,7 @@ out:
> >  
> >  fhandler_pty_slave::fhandler_pty_slave (int unit, dev_t via)
> >    : fhandler_pty_common (), inuse (NULL), output_handle_nat (NULL),
> > -  io_handle_nat (NULL), slave_reading (NULL), num_reader (0)
> > +  io_handle_nat (NULL), masked_cnt (0)
> >  {
> >    dev_referred_via = via;
> >    if (unit >= 0)
> > @@ -1230,6 +1230,10 @@ fhandler_pty_slave::open_setup (int flags)
> >  void
> >  fhandler_pty_slave::cleanup ()
> >  {
> > +  fhandler_pty_slave *arch = (fhandler_pty_slave *) archetype ? : this;
> > +  while (arch->masked_cnt)
> > +    mask_switch_to_nat_pipe (false, false);
> > +
> >    if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () == myself->pgid)
> >      req_fixup_pcon_state ();
> >  
> > @@ -1499,11 +1503,18 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
> >    WaitForSingleObject (input_mutex, mutex_timeout);
> >    if (mask)
> >      {
> > -      if (InterlockedIncrement (&num_reader) == 1)
> > -	slave_reading = CreateEvent (&sec_none_nih, TRUE, FALSE, name);
> > +      if (InterlockedIncrement (&get_ttyp ()->num_reader) == 1)
> > +	get_ttyp ()->slave_reading =
> > +	  CreateEvent (&sec_none_nih, TRUE, FALSE, name);
> >      }
> > -  else if (InterlockedDecrement (&num_reader) == 0)
> > -    CloseHandle (slave_reading);
> > +  else if (InterlockedDecrement (&get_ttyp ()->num_reader) == 0)
> > +    CloseHandle (get_ttyp ()->slave_reading);
> 
> `num_reader` is fine to share (it is just a counter, and the interlocked
> increment/decrement pair does the right thing across processes).
> `slave_reading`, however, is a `HANDLE`, and HANDLE values are
> per-process: they index into the owning process's handle table and are not
> portable to another process without `DuplicateHandle`. Storing the raw
> value in shared memory and letting an arbitrary process call `CloseHandle`
> on it later is therefore hazardous.

Ouch, that's my fatal mistake!

> Concretely, consider two cygwin readers on the same pty:
> 
> Process A takes the first mask. `InterlockedIncrement` returns 1, so A
> calls `CreateEvent` and writes A's handle value into `get_ttyp
> ()->slave_reading`. Process B then takes a second mask; the counter goes
> to 2, so B does not create or store anything. A releases first: the
> counter goes to 1, so A does not close. B releases last: the counter goes
> to 0, and B executes `CloseHandle (get_ttyp ()->slave_reading)`. But that
> HANDLE value lives in A's handle table, not B's. In the benign case B gets
> `ERROR_INVALID_HANDLE` and the event object leaks (A already lost its slot
> in this API, so nobody will ever close it). In the malignant case, that
> same numeric HANDLE value happens to be live in B's own handle table
> pointing at an unrelated object, which B then closes out from under
> itself.
> 
> In v1 both fields were per-fhandler, so this could not arise: whichever
> fhandler created the event also closed it, in the same process. For the
> specific same-process teardown path that v2's `cleanup ()` adds ("release
> all masks I still own"), the hazard also does not trigger by construction,
> since the process draining `masked_cnt` is the same one that took those
> masks. So the concern is purely about the general mask/unmask API contract
> now that the storage is shared.
> 
> Two questions, then:
> 
> First, is cross-process mask ownership actually reachable via the current
> call sites (read paths, `cleanup ()`, `close ()`, exec/spawn transitions)?
> If every mask is guaranteed to be released by the same process that took
> it, the hazard is theoretical and it would suffice to document that
> invariant near the field. I have not fully traced this myself and would
> trust your reading here.

This happens when,
 1) Start `cat` and suspend it by Ctrl-Z
 2) Start another `cat` and suspend it by Ctrl-Z
 3) Foreground the first `cat` and press Ctrl-D
 4) Foreground the second `cat` and press Ctrl-D

> Second, if it _is_ reachable, would it make sense to mirror the by-name
> lookup you already do in `transfer_input ()` on the release side as well,
> that is, `OpenEvent` the named event by name inside
> `mask_switch_to_nat_pipe (false, ...)` when the counter hits zero and
> close the freshly opened handle, so `CloseHandle` always operates on a
> handle native to the closing process? Then `slave_reading` in the shared
> struct would only serve as the "an event with this name exists" flag, and
> no cross-process HANDLE ever gets closed.

Looks good. Thanks! You can find the similar in v3 patch.
It reverts the change that made num_reader and slave_reading shared.
Even if a process close slave_reading, the other process keeps
slave_reading opened. Therefore, checking `masked` by OpenEvent() returns
true. Therefore, there was no need to make slave_reading and num_reader
shared.

> One much smaller, non-blocking observation on the check you added at the
> top of `transfer_input ()`:
> 
> > +
> > +  fhandler_pty_slave *arch = (fhandler_pty_slave *) archetype ? : this;
> > +  if (mask)
> > +    InterlockedIncrement (&arch->masked_cnt);
> > +  else
> > +    InterlockedDecrement (&arch->masked_cnt);
> >  
> >    if (!!masked != mask && xfer && get_ttyp ()->switch_to_nat_pipe)
> >      {
> > @@ -4401,6 +4412,18 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
> >  				    HANDLE input_available_event,
> >  				    HANDLE input_transferred_to_cyg)
> >  {
> > +  if (dir == tty::to_nat)
> > +    {
> > +      char name[MAX_PATH];
> > +      shared_name (name, TTY_SLAVE_READING, ttyp->get_minor ());
> > +      HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
> > +      CloseHandle (masked);
> > +      if (masked)
> > +	/* Cygwin process is reading cyg-pipe.
> > +	   Do not transfer input to nat-pipe. */
> > +	return;
> > +    }
> 
> There is a small TOCTOU window here: another thread can take the first
> mask (and create the event) in between our `OpenEvent` returning NULL and
> our `to_nat` transfer actually starting. The bounded worst case is one
> spurious transfer, not corruption, so I do not consider this a blocker;
> just noting it for the record in case a tighter interlock via
> `input_mutex` is cheap here.

Indeed. The caller of transfer_input() has already acquired the input
mutex. So, guarding mask_switch_to_nat_pipe() by input_mutex is needed
in addition. Please have a look v3 patch.

Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

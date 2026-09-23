Return-Path: <SRS0=bHhe=HP=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 653B94B9DB66
	for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2026 10:58:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 653B94B9DB66
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 653B94B9DB66
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790161138; cv=none;
	b=QFJACAN6ZZpRejx0BRRypY8WmqiyOciUDjLJcXh5NQAdHN2FjdWApu0flQGo9jBgvfbBlvgaIp+4C1KELXSbDlAEEqVb29iiRMqVMLVRkePGLZrGPp9Y8CbDqiFb45G+57fBZfqhaY8HH97f6fEPQPeekEgXVNG5yKOBPyGo8aA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790161138; c=relaxed/simple;
	bh=OZiFCktbBjT9K65yuUn3+8mq77WzeK25Usa940tKmqw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=lT4EDQYyVFFGK7IJ1D1rcH1GFUn22F7kmLMGBVmVgKZCkU5Qhe8Qha0LBZu0Yxa5LS3wJVRVgqeCd/eJV/qRL0QzvA7Jh8vEOhKoGL64HHHmSMA9IqXSuK8B4xMNnGTW27Z09tVuNZ5o1kLlZ4TQ+s62U6R46hT6uZRH0jKzNfQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=uFgKk2ge
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 653B94B9DB66
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=uFgKk2ge
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790161135; x=1790765935;
	i=johannes.schindelin@gmx.de;
	bh=WvoUM35AWGt9UFG6vwuNOSP82xlR+SuSjAnzBmS3GkE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uFgKk2gehUpK6Lbu2jxvZb/oQ9L5jjJmRokJRWDJTNcHiqwi4O5cx8MoNUk2r7Si
	 f3oauDJynQXtr8hWKZrGElrOcT/o7KGAX3Z1BLDWHJ+U1w1AOrDwnSB/VRSHqQeEi
	 DeuAJxLH7t91INP/ZOYq/+yeFKf7hSjyXW2tigdaxcbjhPMp64Y33fCOK9xrvrkVV
	 1zgsNSUEkc9x+yfE2gCvGM2Ji8Frn5DhnZgoNnomknMPMKd+O5qeQb7ZuFJ+ZpzJ+
	 NifsxeZMM8rVXj6bXC3L/RExuy2Y2rXCC0Tm/2cw3QkvWRMFF/NWwP5zrf8QYuKQD
	 cKnk/BcJfEL958FxTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63RQ-1wgccR013w-011bq3; Wed, 23
 Sep 2026 12:58:55 +0200
Date: Wed, 23 Sep 2026 12:58:52 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: console: Abort setting disable_master_thread
 when no con.owner
In-Reply-To: <20260923105326.d57b0710f1519e32b9c5d496@nifty.ne.jp>
Message-ID: <9fbe8256-2235-0fda-eb05-014d8d5ec84d@gmx.de>
References: <20260919151641.57452-1-takashi.yano@nifty.ne.jp> <cf05d989-d95b-4aff-b4d7-c9fbfcf8496b@gmx.de> <20260923105326.d57b0710f1519e32b9c5d496@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=8323328155489711317901611343445071
X-Provags-ID: V03:K1:wSgcPCLSUBnhUR/Z5OU8Rwy5t3S277OX3FtQeWRrCktYCDNrHsv
 ng9qES9dPLTfX+bpMVMqd1ZoGFw13ui7JvkVRdzFnbDgpXTdHQoJzOewgtApCVfMxdr/2HW
 HS59TgdKDd67Ksctra/2GZrNDpbV0Hcdt9McuQK3RwdrVtdcExZelI8RbO3aU08zCGdPcOi
 L5+yhJ6Pcfya4/AVZ36+Q==
UI-OutboundReport: notjunk:1;M01:P0:vXt9QwSoBLg=;Ui3toetCoxtB7vpGg3G1VbLQb1n
 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
 EaMYv0FA==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328155489711317901611343445071
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, 23 Sep 2026, Takashi Yano wrote:

> On Tue, 22 Sep 2026 18:44:02 +0200 (CEST)
> Johannes Schindelin wrote:
> >=20
> > On Sun, 20 Sep 2026, Takashi Yano wrote:
> >=20
> > > With the commit 733d5a953fa9 ("Cygwin: console: Ensure the master
> > > thread runs only when it is supposed to"), the process which calls
> > > set_disable_master_thread() hangs if the con.owner already exited,
> > > because set_disable_master_thread() waits for cons_master_thread
> > > accepting the status change and reflecting the current status to
> > > master_thread_suspended. With this patch, set_disable_master_thread(=
)
> > > is aborted if the owner process no longer exists to avoid this
> > > hang.
> > >=20
> > > Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260037=
.html
> > > Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs=
 only when it is supposed to")
> > > Reported-by: Jay Libove Alzina <libove@felines.org>
> > > Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > ---
> > > v2: Treat the absence of the master thread the same as suspension.
> > > v3: Handle the crash of owner process.
> > > v4: Put my concept together based on Johannes's.
> >=20
> > Thank you!
> >=20
> > About what you said in the v3 thread:
> >=20
> > > If we mistakenly wait for an acknowledgement, it can cause a hang.
> >=20
> > You were right to point out that continuing to wait can hang. My propo=
sed
> > fixup does not solve that: if the process query keeps failing and no
> > worker acknowledgement arrives, it logs an inconclusive result and kee=
ps
> > waiting, potentially indefinitely.
> >=20
> > A failed query does not establish that the owner exited, though. If we
> > want to stop waiting in that situation, I think we should report an
> > explicit failure rather than silently treating the owner as dead. Sinc=
e
> > set_disable_master_thread() currently returns void, that would require
> > changing both the function and its callers.
> >=20
> > Could we discuss that choice separately from the fix for an observed o=
wner
> > exit? I think we need to decide whether to keep waiting or report a
> > failure before changing that behavior. Avoiding the same diagnostic on
> > every retry is a smaller change that we can make independently.
>=20
> IMHO, we should not continue to wait response from master_thread
> in error case. It is safer.

In a practical sense, yes, it is safer. A query error does not prove that
the master thread exited. Nevertheless, continuing to wait for an
acknowledgement that may never arrive is less safe than entering the
existing processed-input fallback.

In my original approach to this problem, I was convinced that a transient
query error needs to be handled differently, but in practice it will be
simpler and more robust to stop waiting.

> > About v4, I have a couple more things:
> >=20
> > >=20
> > >  winsup/cygwin/fhandler/console.cc       | 40 ++++++++++++++++++++++=
+--
> > >  winsup/cygwin/local_includes/fhandler.h |  1 +
> > >  2 files changed, 38 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhand=
ler/console.cc
> > > index 2d5382c0d..140837add 100644
> > > --- a/winsup/cygwin/fhandler/console.cc
> > > +++ b/winsup/cygwin/fhandler/console.cc
> > > @@ -900,7 +900,7 @@ fhandler_console::fix_input_mode_if_necessary ()
> > >      }
> > >    bool need_processed_input =3D
> > >      con.master_thread_suspended || con.disable_master_thread
> > > -    || con.need_win32_input_mode_fix;
> > > +    || con.need_win32_input_mode_fix || master_thread_exited (unit)=
;
> > >    if (need_processed_input =3D=3D con.is_processed_input)
> > >      {
> > >        ReleaseMutex (cons_mode_mutex);
> > > @@ -947,7 +947,7 @@ fhandler_console::set_input_mode (tty::cons_mode=
 m, const termios *t,
> > >        flags |=3D ENABLE_WINDOW_INPUT;
> > >        con.is_processed_input =3D
> > >  	con.master_thread_suspended || con.disable_master_thread
> > > -	|| con.need_win32_input_mode_fix;
> > > +	|| con.need_win32_input_mode_fix || master_thread_exited (unit);
> > >        if (con.is_processed_input)
> > >  	flags |=3D ENABLE_PROCESSED_INPUT;
> > >        if (wincap.has_con_24bit_colors () && !con_is_legacy)
> > > @@ -5011,6 +5011,36 @@ fhandler_console::need_console_handler ()
> > >    return con.disable_master_thread || con.master_thread_suspended;
> >=20
> > I am concerned that the Ctrl+C fallback might not reach signal deliver=
y:
> > When the owner dies with both request and acknowledgment false, v4 can
> > enable `ENABLE_PROCESSED_INPUT`. Windows then delivers Ctrl+C as a con=
trol
> > event rather than queued input. But `need_console_handler()` still che=
cks
> > only those two flags, so `ctrl_c_handler()` ignores the event, assumin=
g
> > the missing worker will handle it.
> >=20
> > How about extending the condition like this:
> >=20
> >     return con.disable_master_thread || con.master_thread_suspended
> > 	|| (con.curr_input_mode =3D=3D tty::cygwin
> > 	    && con.is_processed_input);
> >
> > This would basically handle the case where we asked Windows to handle
> > Ctrl+C, i.e. we want to accept Windows' notifications.
>=20
> Good point!
>=20
> What abount simply:
>     reurn con.is_processed_input;
> ?

Great idea! This is clean: When Windows consumes Ctrl+C instead of queuing
it, Cygwin=E2=80=99s console handler must accept the resulting control eve=
nt.

However, `is_processed_input` is currently not _quite_ reliable enough:

- It is a plain `bool`; Might need to be turned into a `volatile bool`?
- In `fix_input_mode_if_necessary()`, it is set before `SetConsoleMode()`,
  in `setup_input_mode()` it is set _after_, and neither checks whether
  `GetConsoleMode()` or `SetConsoleMode()` succeeded.

I think the safest invariant to settle on would be: Whenever Windows might
have `ENABLE_PROCESSED_INPUT` set, `con.is_processed_input` must be true.
What do you think?

Hardening the code to set `is_processed_input` more consistently is the
only remaining concern about this patch that I have; If you agree with
this idea, I think it would make for a good follow-up patch.

> ctrl_c_handler() should handle Ctrl-C when ENABLE_PROCESSED_INPUT
> is really set, I think. For example, In
> sleep 10 | ./winsleep 10
> where winsleep is non-cygwin program, con.curr_input_mode is
> tty::native. However sleep 10 needs console handler to be
> stopped by Ctrl-C because master_thread is suspended.
>=20
> > >  }
> > > =20
> > > +bool
> > > +fhandler_console::master_thread_exited (_minor_t unit)
> > > +{
> > > +  DWORD owner =3D con.owner;
> > > +  if (owner =3D=3D (DWORD) -1) /* About to exit, however still aliv=
e */
> > > +    return false;
> > > +  if (owner =3D=3D 0)
> > > +    return true;
> > > +  bool exited =3D false;
> > > +  DWORD error =3D ERROR_SUCCESS;
> > > +  HANDLE process =3D OpenProcess (SYNCHRONIZE, FALSE, owner);
> > > +  if (process)
> > > +    {
> > > +      DWORD res =3D WaitForSingleObject (process, 0);
> > > +      if (res =3D=3D WAIT_FAILED)
> > > +	error =3D GetLastError ();
> > > +      exited =3D (res =3D=3D WAIT_OBJECT_0);
> > > +      CloseHandle (process);
> > > +    }
> > > +  else
> > > +    {
> > > +      error =3D GetLastError ();
> > > +      exited =3D (error =3D ERROR_INVALID_PARAMETER);
> >=20
> > The first `=3D` is correct, but the second `=3D` needs to be a compara=
tor:
> >=20
> > 	exited =3D (error =3D=3D ERROR_INVALID_PARAMETER);
>=20
> Fixed the local commit. Thanks.
>=20
> > > +    }
> > > +  if (error && !exited)
> > > +    system_printf ("Cannot query console owner %u, error %u", owner=
, error);
> > > +
> > > +  return exited;
> >=20
> > Could we double-check that the owner hasn't changed here, via
> >=20
> > 	return exited && con.owner =3D=3D owner;
>=20
> Rather, I think we should
>   return (exited || error) && con.owner =3D=3D owner;
> This aborts waiting for a response from the master thread in the
> error case, as long as the error does not stems from an owner PID
> that is no longer valid. What do you think?

Sure, this makes sense. The condition is true if the current worker is
unavailable or cannot safely be waited for. It's not, as I thought, "the
process exited".

At some stage it might make sense to rename `master_thread_exited()` to
`master_thread_unavailable()` to reflect that?

And of course, persistent errors querying the state would produce repeated
diagnostic messages. That's probably okay.

tl;dr I think with your proposed changes, this patch is good to go, with a
potential hardening of `is_processed_input` as a follow-up.

Ciao,
Johannes

>=20
> > That way, we reject a stale result if `con.owner` no longer matches th=
e
> > PID we queried. The owner can still change after the recheck, though, =
so
> > this alone does not guarantee mode changes to be serialized.
> >=20
> > I think with these changes, my concerns would be addressed. I'd leave =
the
> > policy discussion for inconclusive queries to be continued independent=
ly
> > instead of trying to settle it in this patch.
> >=20
> > Ciao,
> > Johannes
>=20
> --=20
> Takashi Yano <takashi.yano@nifty.ne.jp>
>=20

--8323328155489711317901611343445071--

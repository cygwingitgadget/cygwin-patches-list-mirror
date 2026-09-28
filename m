Return-Path: <SRS0=RROI=HU=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id EDB7F4BA7994
	for <cygwin-patches@cygwin.com>; Mon, 28 Sep 2026 13:46:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EDB7F4BA7994
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EDB7F4BA7994
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790603188; cv=none;
	b=EwNiUGbBNnuw0O3nowpdimWp6HR+P06PeFc+STMy3cr4MuBXK8oLKc+fVHqS7HVll2XOZius+RsBmV/c+wNmEsoNlvb3q8vH9zsFr0F8Fmmx5N2OI8YbYn+3DdRIxQTFE/HpyTTFi6p+seLqSEuG9LKyxa/relTeGCiJd5ifi84=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790603188; c=relaxed/simple;
	bh=3c8B5UPtfiMrQBaoNaeDgTwcEqUPt3furOeyHZniRKo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ppZ+fhKCEWczzxAnLp1C8TLVXxIOMx3Ks+kIMJMSmQz5dvB3KX/XbrmVF8jfn/ui0HZzHJO7vK7ASuq/axEiwT0ZdKDEJXhs2APdUczGC7GwaZusgq92tdMQ8VM6NeTFZ1mXR4Ed7/a0d7yuPErqAOZ6WRi2a/82X5J9/tY6ej4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=K6ARGiIp
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EDB7F4BA7994
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=K6ARGiIp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790603180; x=1791207980;
	i=johannes.schindelin@gmx.de;
	bh=V84L1cUURYdkUIWzXrfb1zWH0DQUxMd6NWAM8rqBS3Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K6ARGiIp9Ex75Y8kbiCC8M0fjvMhpumrWzKoJV6TCYu3ynMi4JPDRPCY1LGyAjNv
	 50e3TwBf9G74i1bmqIBSTSQ5a9du/cxpfc5WIwP1lBp5QrxGQVFKOh+6hrhL4wL8z
	 mzB1aK689Tbwzp+HRoSXRgwoTYRbeQjYBsNOl10CRCZiWCFfcaQuhUInXGhu68J7k
	 KW335AbJNr97yJVpVzTp5uU3YTQgUBkUW7fVOPCtZv/kNvMOjOxJ3UsL0kAILp6Nf
	 veWyc26IUFt9u/M5G9tc+mGZSw19R2InRswLGyErY2wMlG5dx1G5MtaFvqF45T0pp
	 WRL5zG11x6HOAq+SgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1wtvmU463F-011pcv; Mon, 28
 Sep 2026 15:46:20 +0200
Date: Mon, 28 Sep 2026 15:46:18 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: preserve terminal replies after PTY
 adoption
In-Reply-To: <20260928205303.4d9215defd8a403bbc994e23@nifty.ne.jp>
Message-ID: <3df19bfa-d20e-2c8d-f230-70cbde39f318@gmx.de>
References: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com> <20260915213259.fd24c38cac2c2adafdd2b097@nifty.ne.jp> <20260917201943.dbe64d19e53c7d18eafb31e3@nifty.ne.jp> <20260928205303.4d9215defd8a403bbc994e23@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:M/3glSxyas70CDlReTDse8GgqBs7d3g0sFtgZSFhYGxGnHzKJKN
 SuEdFhhSPEn331FRYPV0DVsJo8xQ6jD1jLlp9R859zpg8N+g0uiDk0/Wk52m4u7tviH1kLw
 z3WIcKpM3zO3NUyTKX+hPOZfRkV1TShPK71by8QBdLpKvbYKZVksimiujUOcJ865xlS488c
 c8tdfXJjnd2whsOycwWqw==
UI-OutboundReport: notjunk:1;M01:P0:nQn/54YBvEU=;INTer+T/EW6jZqCEP3zPtNBYIGC
 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
 4IZBcrbpm1XZxyFGw==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mon, 28 Sep 2026, Takashi Yano wrote:

> Ping? > Johannes,

Yes, I am still working on this. My AI assistant is still struggling to
come up with a light regression test... the AI said something about a
different code path that needs addressing, too (I forgot the details, it's
been a few days since I had a chance to dive deep into _that_ patch) and
my attempts at addressing that in an elegant way have so far been foiled
by being pulled away to prepare for Git for Windows v2.56.0, which is due
later today.

Hopefully I'll have something worth showing to you, soon!

Thanks for the ping,
Johannes

>=20
> On Thu, 17 Sep 2026 20:19:43 +0900
> Takashi Yano wrote:
> > On Tue, 15 Sep 2026 21:32:59 +0900
> > Takashi Yano wrote:
> > > Hi Johannes,
> > >=20
> > > Thanks for the patch.
> > >=20
> > > On Sun, 13 Sep 2026 12:30:05 +0000
> > > "Johannes Schindelin wrote:
> > > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > >=20
> > > > This fixes an issue reported about MSYS2/Win32 interaction, but ap=
plies
> > > > to regular Cygwin as well. In the following, the original scenario=
 is
> > > > described.
> > > >=20
> > > > MSYS Vim launched by native Git from Bash in MinTTY can delete the=
 first
> > > > line, enter Insert mode or insert RGB text at startup. PTY adoptio=
n sends
> > > > Vim's output directly to MinTTY, but input stays with ConHost unti=
l the
> > > > first Cygwin read/select. Vim inherits Git's foreground process gr=
oup, so
> > > > the process-group callback does not trigger an earlier handoff.
> > > >=20
> > > > Vim sends terminal queries before reading. ConHost interprets curs=
or
> > > > position reports as function keys, which the later input transfer =
delivers
> > > > to Vim as keystrokes. A color reply split across the handoff reach=
es Vim
> > > > without its introducer. Fragmented writes are valid; inconsistent =
routing
> > > > corrupts their contents.
> > > >=20
> > > > Requesting noncanonical input with tcsetattr() provides a control =
point
> > > > before these queries. Handing input to the Cygwin PTY there aligns=
 both
> > > > directions before replies can be misdirected, rather than waiting =
for
> > > > consumption. Only the foreground process on an active pseudoconsol=
e takes
> > > > this path; canonical, background and pcon-disabled calls are unaff=
ected.
> > > >=20
> > > > The existing synchronized transfer preserves queued input and line
> > > > discipline. Balancing the temporary reader registration without tr=
ansferring
> > > > back keeps input on the Cygwin pipe without a permanent reader cla=
im or
> > > > changes to native-owner cleanup. Releasing the output mutex first =
avoids
> > > > holding it across the input-transfer path.
> > > >=20
> > > > Addresses: https://github.com/git-for-windows/git/issues/6403
> > > > Fixes: 6eed1ef74869 ("Cygwin: pty: detect pcon-backed pty for non-=
Cygwin-spawned children")
> > > > Assisted-by: GPT-6
> > > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > > ---
> > > >     Cygwin: pty: preserve terminal replies after PTY adoption
> > > >    =20
> > > >     I just merged this into Git for Windows' fork of the MSYS2 run=
time, as
> > > >     it is a somewhat pressing problem due to Git for Windows v2.56=
.0-rc0
> > > >     already being overdue.
> > > >    =20
> > > >     This patch is based on cygwin-3_6-branch, but is easily cherry=
-picked
> > > >     onto master, too.
> > > >=20
> > > > Published-As: https://github.com/cygwingitgadget/cygwin/releases/t=
ag/pr-10%2Fdscho%2Ffix-vim-terminal-replies-v1
> > > > Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin =
pr-10/dscho/fix-vim-terminal-replies-v1
> > > > Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/10
> > > >=20
> > > >  winsup/cygwin/fhandler/pty.cc | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >=20
> > > > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandle=
r/pty.cc
> > > > index c5081bcaf..f6e051b9e 100644
> > > > --- a/winsup/cygwin/fhandler/pty.cc
> > > > +++ b/winsup/cygwin/fhandler/pty.cc
> > > > @@ -1637,6 +1637,15 @@ fhandler_pty_slave::tcsetattr (int, const s=
truct termios *t)
> > > >    acquire_output_mutex (mutex_timeout);
> > > >    get_ttyp ()->ti =3D *t;
> > > >    release_output_mutex ();
> > > > +
> > > > +  /* Terminal queries can precede the first read/select after ent=
ering
> > > > +     noncanonical mode.  Their replies must bypass the native con=
sole. */
> > > > +  if (!(t->c_lflag & ICANON) && get_ttyp ()->pcon_activated
> > > > +      && get_ttyp ()->getpgid () =3D=3D myself->pgid)
> > > > +    {
> > > > +      mask_switch_to_nat_pipe (true, true);
> > > > +      mask_switch_to_nat_pipe (false, false);
> > > > +    }
> > > >    return 0;
> > > >  }
> > > > =20
> > > >=20
> > > > base-commit: c19c1e6ad9d8abad640ffcb95996642cc35955ec
> > > > --=20
> > > > cygwingitgadget
> > >=20
> > > To me, the root cause and the proposed fix seem out of alignment.
> > > If "input stays with ConHost until the first Cygwin read/select",
> > > the solution is calling transfer_input() in the slave::open(),
> > > say, around here:
> > >=20
> > >   if (get_ttyp ()->pcon_activated)
> > >     {
> > >       HANDLE pcon_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> > >                                        get_ttyp ()->nat_pipe_owner_p=
id);
> > >       if (pcon_owner)
> > >         {
> > >           HANDLE new_in =3D NULL, new_out =3D NULL;
> > >           bool ok_in =3D DuplicateHandle (pcon_owner, get_ttyp ()->h=
_pcon_in,
> > >                                        GetCurrentProcess (), &new_in=
,
> > >                                        0, TRUE, DUPLICATE_SAME_ACCES=
S);
> > >           bool ok_out =3D DuplicateHandle (pcon_owner, get_ttyp ()->=
h_pcon_out,
> > >                                         GetCurrentProcess (), &new_o=
ut,
> > >                                         0, TRUE, DUPLICATE_SAME_ACCE=
SS);
> > >           if (ok_in && ok_out)
> > >             {
> > >               /* Replace these before open_with_arch() copies them i=
nto the
> > >                  archetype shared by all pty slave fhandlers. */
> > >               CloseHandle (get_handle_nat ());
> > >               CloseHandle (get_output_handle_nat ());
> > >               set_handle_nat (new_in);
> > >               set_output_handle_nat (new_out);
> > >             }
> > >           else
> > >             {
> > >               if (new_in)
> > >                 CloseHandle (new_in);
> > >               if (new_out)
> > >                 CloseHandle (new_out);
> > >             }
> > >           CloseHandle (pcon_owner);
> > >         }
> > >     }
> > >=20
> > > What do you think?
> >=20
> > No. Not here. Too early perhaps. May be in slave::init().
> >=20
> > I also noticed that the same problem occurs if vim is
> > started with non-cygwin program running in background.
> > This also affects cygwin-3_6-brancy.
> >=20
> > Therefore, I think we need transfer_input also in
> > slave::fixup_after_exec().
>=20
> I confirmed that the following patch works as expected.
> What do you think?
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index fb49c02b3..e56b9f55f 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -1362,6 +1362,8 @@ fhandler_pty_slave::init (HANDLE h, DWORD a, mode_=
t, int64_t dummy)
>    if (h !=3D INVALID_HANDLE_VALUE)
>      CloseHandle (h);	/* Reopened by open */
> =20
> +  fixup_input_state_for_cygwin_app ();
> +
>    return ret;
>  }
> =20
> @@ -1407,18 +1409,7 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (voi=
d)
>  	  mutex_timeout =3D INFINITE;
>  	  if (isHybrid)
>  	    {
> -	      WaitForSingleObject (input_mutex, mutex_timeout);
> -	      if (get_ttyp ()->getpgid () =3D=3D myself->pgid
> -		  && GetStdHandle (STD_INPUT_HANDLE) =3D=3D get_handle ()
> -		  && get_ttyp ()->pty_input_state_eq (tty::to_nat))
> -		{
> -		  acquire_attach_mutex (mutex_timeout);
> -		  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
> -				  input_available_event,
> -				  input_transferred_to_cyg);
> -		  release_attach_mutex ();
> -		}
> -	      ReleaseMutex (input_mutex);
> +	      fixup_input_state_for_cygwin_app ();
>  	      if (get_ttyp ()->master_is_running_as_service
>  		  && get_ttyp ()->pcon_activated)
>  		/* If the master is running as service, re-attaching to
> @@ -2939,6 +2930,8 @@ fhandler_pty_slave::fixup_after_fork (HANDLE paren=
t)
>  void
>  fhandler_pty_slave::fixup_after_exec ()
>  {
> +  fixup_input_state_for_cygwin_app ();
> +
>    if (!close_on_exec ())
>      fixup_after_fork (NULL);	/* No parent handle required. */
> =20
> @@ -4945,3 +4938,20 @@ fhandler_pty_slave::replace_nat_handles (HANDLE n=
ew_input, HANDLE new_output)
>    CloseHandle (orig_input_handle_nat);
>    CloseHandle (orig_output_handle_nat);
>  }
> +
> +void
> +fhandler_pty_slave::fixup_input_state_for_cygwin_app ()
> +{
> +  WaitForSingleObject (input_mutex, mutex_timeout);
> +  if (get_ttyp ()->getpgid () =3D=3D myself->pgid
> +      && GetStdHandle (STD_INPUT_HANDLE) =3D=3D get_handle ()
> +      && get_ttyp ()->pty_input_state_eq (tty::to_nat))
> +    {
> +      acquire_attach_mutex (mutex_timeout);
> +      transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
> +		      input_available_event,
> +		      input_transferred_to_cyg);
> +      release_attach_mutex ();
> +    }
> +  ReleaseMutex (input_mutex);
> +}
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index 341a326a6..9fc615291 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2544,6 +2544,7 @@ class fhandler_pty_slave: public fhandler_pty_comm=
on
>    static void release_ownership_of_nat_pipe (tty *ttyp, fhandler_termio=
s *fh);
>    void replace_nat_handles (HANDLE new_input, HANDLE new_output);
>    void req_fixup_pcon_state (void);
> +  void fixup_input_state_for_cygwin_app (void);
>  };
> =20
>  #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (uni=
t))
>=20
> --=20
> Takashi Yano <takashi.yano@nifty.ne.jp>
>=20

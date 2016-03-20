Return-Path: <cygwin-patches-return-8441-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27932 invoked by alias); 20 Mar 2016 15:00:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27857 invoked by uid 89); 20 Mar 2016 15:00:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.3 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KAM_LOTSOFHASH,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=convention, sk:notific, pthread, closehandle
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 20 Mar 2016 15:00:36 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0A9A5A8039E; Sun, 20 Mar 2016 16:00:34 +0100 (CET)
Date: Sun, 20 Mar 2016 15:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: Cygwin select() issues and improvements
Message-ID: <20160320150034.GE24954@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C03624.1030703@glup.org> <20160215125703.GE8374@calimero.vinschen.de> <56C66DDE.9070509@glup.org> <20160219104641.GA5574@calimero.vinschen.de> <20160304085843.GB8296@calimero.vinschen.de> <56E5DD8D.7060302@glup.org> <20160314101257.GE3567@calimero.vinschen.de> <56EA78DC.3040201@glup.org> <56EADD32.4010802@redhat.com> <56EDD62E.3040309@glup.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <56EDD62E.3040309@glup.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00147.txt.bz2


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 6473

Hi John,

On Mar 19 18:43, john hood wrote:
> From c805552cdc9e673ef2330388ddb8b7a0da741766 Mon Sep 17 00:00:00 2001
> From: John Hood <cgull@glup.org>
> Date: Thu, 28 Jan 2016 17:08:39 -0500
> Subject: [PATCH 1/5] Use high-resolution timebases for select().
>=20
> 	* cygwait.h: Add cygwait_us() methods.
> 	* select.h: Change prototype for select_stuff::wait() for larger
> 	microsecond timeouts.
> 	* select.cc (pselect): Convert from old cygwin_select().
> 	Implement microsecond timeouts.
> 	(cygwin_select): Rewrite as a wrapper on pselect().
> 	(select): Implement microsecond timeouts.
> 	(select_stuff::wait): Implement microsecond timeouts with a timer
> 	object.

I have a bit of a problem with patch 1 and 4.  In the same patchset
you add cygwait_us and remove it again.  That doesn't really look
useful to me.  Can you create the patches so that this part is skipped,
please?  The rest of the patch should work as is with the existing version
of cygwait.

Two general style issues:

- Please don't use Microsofts variable naming convention.  It's used in
  kernel.cc to use the same names as in the documentation and there are
  a few rare cases where class members are using this convention, but
  other than that we usually use lowercase and underscores only.  Please
  use that as well.

- Always prepend a space to an opening bracket in function or macro calls,
  gnu-style.  There are a couple of cases where you missed that.  If you fi=
nd
  such cases prior to your patch, pleae change them while you're at it.

Btw., it would be helpful to get a patch series the way git format-patch/
send-email generates them.  It allows easier review to have every patch
in a single mail.  I changed the text on https://cygwin.com/contrib.html
to be a bit more clear about this.  Well, hopefully a bit more clear.

> @@ -362,13 +362,50 @@ err:
>  /* The heart of select.  Waits for an fd to do something interesting. */
>  select_stuff::wait_states
>  select_stuff::wait (fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
> -		    DWORD ms)
> +		    LONGLONG us)
>  {
>    HANDLE w4[MAXIMUM_WAIT_OBJECTS];
>    select_record *s =3D &start;
>    DWORD m =3D 0;
>=20=20
> +  /* Always wait for signals. */
>    wait_signal_arrived here (w4[m++]);
> +
> +  /* Set a timeout, or not, for WMFO. */
> +  DWORD dTimeoutMs;
> +  if (us =3D=3D 0)
> +    {
> +      dTimeoutMs =3D 0;
> +    }
> +  else
> +    {
> +      dTimeoutMs =3D INFINITE;
> +    }

Please, no braces for oneliners.  Also, this entire statement can be
folded into a oneliner:

     ms =3D us ? INFINITE : 0;

> +  status =3D NtCreateTimer(&hTimeout, TIMER_ALL_ACCESS, NULL, Notificati=
onTimer);

Does it really make sense to build up and break down a timer per each
call to select_stuff::wait?  This function is called in a loop.  What
about creating the timer in the caller and only arm and disarm it in the
wait call?

> +  if (dTimeoutMs =3D=3D INFINITE)
> +    {
> +      CancelWaitableTimer (hTimeout);
> +      CloseHandle (hTimeout);
> +    }

For clarity, since the timer has been created and armed using native
functions, please use NtCancelTimer and NtClose here.

> From 225f852594d9ff6a1231063ece3d529b9cc1bf7f Mon Sep 17 00:00:00 2001
> From: John Hood <cgull@glup.org>
> Date: Sat, 30 Jan 2016 17:33:36 -0500
> Subject: [PATCH 2/5] Move get_nonascii_key into fhandler_console.
>=20
> 	* fhandler.h (fhandler_console): Move get_nonascii_key() from
> 	select.c into this class.
> 	* select.cc (peek_console): Move get_nonascii_key() into
> 	fhandler_console class.

Patch applied.

> From b2e2b5ac1d6b62610c51a66113e5ab97b1d43750 Mon Sep 17 00:00:00 2001
> From: John Hood <cgull@glup.org>
> Date: Sat, 30 Jan 2016 17:37:33 -0500
> Subject: [PATCH 3/5] Debug printfs.
>=20
> 	* fhandler.cc (fhandler_base::get_readahead): Add debug code.
> 	* fhandler_console.cc (fhandler_console::read): Add debug code.
> 	* select.cc (pselect): Add debug code.
> 	(peek_console): Add debug code.

Why?  It's a lot of additional debug output.  Was that only required for
developing or does it serve a real purpose for debugging user bug reports
in future?  If so, I wouldn't mind to have a bit of additional description
in the git log to explain the debug statements...

> From cf2db014fefd4a8488316cf9313325b79e25518d Mon Sep 17 00:00:00 2001
> From: John Hood <cgull@glup.org>
> Date: Thu, 4 Feb 2016 00:44:56 -0500
> Subject: [PATCH 4/5] Improve and simplify select().
>=20
> 	* cygwait.h (cygwait_us) Remove; this reverts previous changes.
> 	* select.h: Eliminate redundant select_stuff::select_loop state.
> 	* select.cc (select): Eliminate redundant

See above.

> @@ -182,30 +181,7 @@ select (int maxfds, fd_set *readfds, fd_set *writefd=
s, fd_set *exceptfds,
>  	  }
>        select_printf ("sel.always_ready %d", sel.always_ready);
>=20=20
> -      /* Degenerate case.  No fds to wait for.  Just wait for time to ru=
n out
> -	 or signal to arrive. */
> -      if (sel.start.next =3D=3D NULL)
> -	switch (cygwait_us (us))
> -	  {
> -	  case WAIT_SIGNALED:
> -	    select_printf ("signal received");
> -	    /* select() is always interrupted by a signal so set EINTR,
> -	       unconditionally, ignoring any SA_RESTART detection by
> -	       call_signal_handler().  */
> -	    _my_tls.call_signal_handler ();
> -	    set_sig_errno (EINTR);
> -	    wait_state =3D select_stuff::select_signalled;
> -	    break;
> -	  case WAIT_CANCELED:
> -	    sel.destroy ();
> -	    pthread::static_cancel_self ();
> -	    /*NOTREACHED*/
> -	  default:
> -	    /* Set wait_state to zero below. */
> -	    wait_state =3D select_stuff::select_set_zero;
> -	    break;
> -	  }
> -      else if (sel.always_ready || us =3D=3D 0)

This obviously allows to fold everything into select_stuff::wait, but
the more it seems like a good idea to move the timer creation into the
caller for this case, doesn't it?

Alternatively, we could add a per-thread timer handle to the cygtls
area.  It could be created on first use and deleted when the thread
exits.  But that's just an idea for a future improvement, never
mind for now.

> From 3f3f7112f948d70c15046641cf3cc898a9ca4c71 Mon Sep 17 00:00:00 2001
> From: John Hood <cgull@glup.org>
> Date: Fri, 18 Mar 2016 04:31:16 -0400
> Subject: [PATCH 5/5] 	* winsup/testsuite/configure: chmod a+x

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7rsRAAoJEPU2Bp2uRE+gvx0P/AiLvLTJGzjIGyXz8uoCEeki
o+QSgK5gBUUSEvNELkZ+QB4urXUi3G6yXEcQtq/cExp5X1u0likJgmYYQeipJmsi
YAzJGYo7f4a2tkrAltwYn3FOiLFpabqI8MTdTo0LvDIRdGAcLpZaFKeGwbc65NLZ
kz4LrbxWzr1UKgmMRVN0uWlR0HlpD9YKdYMPQHYTIW6Gbi2q8u7acQoRbaBjbBd9
o+RJTAqoeIOKZ7YZJp7DwkHlvXevd/xaeKhTY/6JyVQrSNfABl0pWq0JTaBzmAyW
pBhQI3W05smY0dYKOPsgwS0ee3tWLfEr1SwBeyHy6jbwR1lMGmVUa8jSWlza6XeL
zbBlHV0zVZ9QdnINye3oEnCVBl36hlDoV1Dv+Gx02WNtmLr7unI07yftrBLNxZeY
U2Mv4WgrxtYpnTVau9m0iRu5j+2eeFQN65eHBGewgC9Kx9TY4gObHRgWwD47jS0S
eNU5UD0jaBvR5pVL9tYQkEJbZbeHOOBy+YWVJp88jGl2FP3Llgb97W7xIBVwwXEr
UM2Sbup4KE66QJSuswFuMST6ZROd5Z/kFCD9s6Tx8YJ4LO0WguXI1lUnIgBaUjy4
w+vfgPG9Bi5UCcvHjgBzBZya9PoYEFOPy9BU7rAyoImdjDZQnj9lktkXKbMeAx4/
J13lxJC639LLP8CG4qFt
=l9cK
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--

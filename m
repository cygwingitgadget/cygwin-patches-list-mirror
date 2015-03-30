Return-Path: <cygwin-patches-return-8078-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76767 invoked by alias); 30 Mar 2015 10:21:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76754 invoked by uid 89); 30 Mar 2015 10:21:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,EXCEL_ATTACHED autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 30 Mar 2015 10:21:32 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B40D5A80982; Mon, 30 Mar 2015 12:21:29 +0200 (CEST)
Date: Mon, 30 Mar 2015 10:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Make EXCEPTION_POINTERS available to signal handlers
Message-ID: <20150330102129.GH29875@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427383517-3360-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
In-Reply-To: <1427383517-3360-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00033.txt.bz2


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3176

Hi Jon,

On Mar 26 15:25, Jon TURNEY wrote:
> Add ucontext.h header, defining ucontext_t and mcontext_t types.
>=20
> Provide sigaction sighandlers with a ucontext_t parameter containing a
> mcontext_t with exception context information, if available.
>=20
> 	* include/sys/ucontext.h (__ucontext): New header.
> 	* include/ucontext.h (_UCONTEXT_H): Ditto.
> 	* exception.h (cygwin_exception): Add exception_record accessor.
> 	* exceptions.cc (call_signal_handler): Provide ucontext_t
> 	parameter to signal handler function, if available.

Thanks for this patch.  Looks like a good idea.

But there are a few problems we should discuss first.

> +typedef struct __mcontext {
> +	EXCEPTION_POINTERS *ep;
> +} mcontext_t;
> +
> +typedef struct __ucontext {
> +	struct __ucontext *uc_link;
> +	sigset_t	uc_sigmask;
> +	// We don't have a type stack_t, so we don't have a uc_stack member
> +	mcontext_t	uc_mcontext;
> +} ucontext_t;

* Per the Linux man page this structure should be called `struct
  ucontext' without the underscores.  However, we already have
  definitions of `struct ucontext' in include/cygwin/signal.h... which
  have nothing at all to do with the definition of ucontext on Linux.

  This needs fixing.

  Historically, the ucontext definition in cygwin/signal.h is equivalent
  to the Windows thread CONTEXT definition.  Why ever CONTEXT was used to
  define ucontext beats me in retrospect.
=20=20
  It is used only when sending the thread context to a debugger when a
  signal occured.  The definition of struct ucontext from cygwin/signal.h
  is only used as part of struct _cygtls (struct ucontext thread_context)
  and then thread_context is used in _cygtls::signal_debugger, that's it.
  Cygwin doesn't use it anywhere else.
=20=20
  GDB uses only the definition of __COPY_CONTEXT_SIZE from cygwin/signal.h,
  but not the definition of struct ucontext.  I sent a patch upstream to
  get rid of that dependency.

  We should remove or rename struct ucontext in cygwin/signal.h, so we
  can use that name for your above struct __ucontext.  That leads to the
  next point...

* Since struct ucontext from cygwin/signal.h is actually a redefinition
  of CONTEXT + an oldmask value. it's basically the Cygwin/Windows
  representation of gregset_t + fpregset_t + cr2 + oldmask, aka
  mcontext_t.

  As for oldmask, this can be fetched easily from _my_tls, so in theory
  we can use the current definition of ucontext from cygwin/signal.h as
  mcontext_t.

  But this drops the EXCEPTION_RECORD.  I'm not sure it belongs here.
  Keep in mind that a signal handler is not only called in case an
  exception occured.  I think the context is all a signal handler needs.

* As for stack_t, we have that.  It's defined in newlib's sys/signal.h.
  The stack base and stack size can be fetched from the TEB; with a
  test for a user-defined stack, see pthread_wrapper in miscfuncs.cc.

  While we're at it we should contemplate to define SIGSTKSZ and
  MINSIGSTKSZ along the lines of 64K, I guess.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVGSOpAAoJEPU2Bp2uRE+gQOgP/RPu1NN9yAdSKEjMRYpE13Mn
oYSG7veXAle7yPMBI7ERgWN0WaQJIh/6SIRamE0UtY1FEx/cUZClVliughMn00F3
w56UIrE+FheVrO8HrFBgjxMNaJ/42ThrFkYyxW4wM6eb1BAMB3xlYRwV4PC7D7AS
F7pVeNKdTsoScw5Lv1FjifsSI2NoFh4hjx5FMsZoNamn9CNSbQQTQM1nsKbeyKjh
aQ1AbYNpUuFIz6i6n/Ku2Yfd3kbnh/r4IHBY3+9GO5rLNTYw5EDzDy24VhCzztdp
bAvmYpfvhGhjJ48eZEHqE1k9pXZXpecZ6H0PW1WIui9x2yF0/dFGlXyS3+cP02g0
BNhizY8aYfMz1YhSjmdbYK+KYlIuZM7R0F+c5ZZEdpXqdwLZC0I9a7ycqI0h1sWl
u1vh+6LXbtsUc1UewB/wrbnuuJtiEtmGBfsf7/wEP7D1nL3g/hRrZa17Q6OMzOkv
B29N/0uUZYmKP45aWAUOmZ7vq2kHHMx6ZVDwMyNCqC9kF+ntHYPnlCUdGjWKFxZg
xvrtQBK1zec5ktvu6dqLrtpy75eSTtllgWQeGZ5HfrVRB1xO8iCB8VVZVnnIZZqP
49mWrvyaX8h20PK8u7AbktPREu75XlanSMluOofyTFgBchayJ65M+DN/JMUGxDh6
s1RmQwHUnbZ5EA2sZhmm
=4eEu
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--

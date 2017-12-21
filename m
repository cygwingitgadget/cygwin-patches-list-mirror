Return-Path: <cygwin-patches-return-8985-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1770 invoked by alias); 21 Dec 2017 10:25:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1709 invoked by uid 89); 21 Dec 2017 10:25:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-100.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Actually, air, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 21 Dec 2017 10:25:04 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 14D37721E281E	for <cygwin-patches@cygwin.com>; Thu, 21 Dec 2017 11:25:02 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id B632D5E01D4	for <cygwin-patches@cygwin.com>; Thu, 21 Dec 2017 11:25:01 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 32520A80612; Thu, 21 Dec 2017 11:25:02 +0100 (CET)
Date: Thu, 21 Dec 2017 10:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin_internal methods to get/set thread name
Message-ID: <20171221102502.GJ19986@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171220080832.2328-1-mark@maxrnd.com> <20171220115122.GF19986@calimero.vinschen.de> <Pine.BSF.4.63.1712202346060.17134@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1712202346060.17134@m0.truegem.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00115.txt.bz2


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3035

On Dec 21 00:29, Mark Geisert wrote:
> On Wed, 20 Dec 2017, Corinna Vinschen wrote:
> > Hi Mark,
> >=20
> > A lot to discuss here.
>=20
> Yes, but first let me say I'd call these "speculative" patches, things I
> found necessary during aio library development.  I had an incorrect mental
> picture of the Cygwin DLL: I was treating it as just a user-space DLL whe=
re,
> for an add-on library, one was free to use Cygwin constructs or pthread
> constructs, or even Win32 constructs for that matter.
>=20
> I've now updated that mental picture of the Cygwin DLL to treat it as a
> kernel, where one can only use constructs provided by Cygwin.  So, in the
> aio library there will be cygthreads only and no pthreads or Win32 thread=
s.
> (So I should also separately update the gmon profiler to use a cygthread
> rather than a Win32 thread ;-)).

You're right that Cygwin is treated as kernel because it plays this
role (combined with libc, libm, etc) for all the rest of Cygwin libs
and executables.

But I'm not sure what you mean by "aio library" here.  aio functionality
should be part of Cygwin itself.  As soon as you implement another
library linking against the Cygwin DLL, you're "user space" and thus you
can only use POSIX calls.  The cygwin_internal() call is a very narrow
exception, which basically should only be used to access Cygwin
internals by applications which know what they are doing.  That's almost
exclusively the stuff in the winsup/utils dir.  Given that cygthreads
are not exported from the Cygwin DLL, you would not be able to use them(*)

So as I understood it, aio stuff should be implemented inside the
"kernel", the Cygwin DLL, using internal classes, methods and functions,
exporting aio POSIX calls to user space.  Thus it's not clear to me what
you mean by "aio library" at the moment.=20=20

(*) Actually, I think you won't need threads at all if you use Windows
    completion routines, but you know that already :}

> So these patches reflect the earlier mental picture.  Maybe none of the c=
ode
> makes sense in an accurate mental picture.  I wanted to at least air the
> code to see if some use might be made of it before discarding it.

I don't see a need for such calls unless they are used by very specific
scenarios, like GDB or strace.

> [...]
> I was using strace and getting annoyed with it displaying "unknown thread
> 0x###" for my aio threads.  At that point they were pthreads and not
> cygthreads.  So that was the impetus for the name-getting additions.
> Name-setting, that's another story.  I thought that perhaps a debugging a=
pp
> might want to tag threads of a subject process with names if they don't
> already have names.  But I concede there is no such app at present.

Given that you'd have to call cygwin_internal as well as
pthread_setname_np in the context of the traced process, there's not
much difference...


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaO4v9AAoJEPU2Bp2uRE+gqFYQAJfP08NxMYd9ozmmexhX2vHK
8ac0BwVOYvLAzsi2guy/lgBwBUtWCUifDq5a0PfEle2kreUZlDFP7PCUzcvdi7IP
eUU82amG0FpwsbAbS5wumB+qKBT+uPNBXcLM7UoGlUWzDx1YLRalatHCjshrFlC+
dePZyuiJPw6u3griOyS8QL2tZ3WEDGvul6ioEFvVYXysrncYsUAyWaHgUgtYo+pZ
Nmg18K7KO7nHH9cbnxxRtzRBD2S06aCBYM8QzPNn9JF+QGYY+xhWGkZe9eS9xfbd
jbHUYIZ0uDgTlTj06NehwenUJ1QvdPSdJdJkQ32HjYFO0o/3LU8NVcK9DUEQFIqi
OHdY8F2RkLqFfwiDFHOiz6AzUWQZUihrCJ7gZvaZpGp7Lk3qhkZV+zQNdRdkax5o
tkx6Y0vrnpBct/H/DaiAWdm024J+6mqq6rNNv72Y3Wt+al3CMrItBWGLqJC20Pl/
yH8n9zc92vv50x6owqLswSLh+olPUYvGHpJm3Be8Hz2B/fbhBCurYvsISGeFL6Vc
LfIP5WZAi1cWnOLjQD2n8NUYkmYn0gGnZm7UrwKsDAuxf0zDrAYeO7SVJ+92yGvV
vW/5IVmGc5RHOh6/+1RV3chbqg2npv5kLm1q6qKmSNr7wQnc9C49Yn63wiPT3nVr
df2ka1x/rP3i+rohcZnn
=AE5I
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--

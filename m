Return-Path: <cygwin-patches-return-8127-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87230 invoked by alias); 9 Apr 2015 14:54:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 87213 invoked by uid 89); 9 Apr 2015 14:54:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 09 Apr 2015 14:54:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 242ABA80A70; Thu,  9 Apr 2015 16:54:45 +0200 (CEST)
Date: Thu, 09 Apr 2015 14:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Set mcontext.cr2 to the faulting address
Message-ID: <20150409145445.GA6901@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1428585205-14420-1-git-send-email-jon.turney@dronecode.org.uk> <1428585205-14420-4-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <1428585205-14420-4-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00028.txt.bz2


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1390

Hi Jon,


Just a formatting nit:

On Apr  9 14:13, Jon TURNEY wrote:
> 	* exceptions.cc (call_signal_handler): Set mcontext.cr2 to the
> 	faulting address.
>=20
> Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
> ---
>  winsup/cygwin/ChangeLog     | 5 +++++
>  winsup/cygwin/exceptions.cc | 4 ++++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index 0223052..919122e 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -1521,6 +1521,10 @@ _cygtls::call_signal_handler ()
>=20=20
>            context.uc_sigmask =3D context.uc_mcontext.oldmask =3D this_ol=
dmask;
>=20=20
> +          context.uc_mcontext.cr2 =3D (thissi.si_signo =3D=3D SIGSEGV
> +                                     || thissi.si_signo =3D=3D SIGBUS)
> +            ? (uintptr_t) thissi.si_addr : 0;

Please use leading TABs with ts=3D8 throughout, and I'd prefer if the ?
in the above expression is right under the paren two lines above, like
this:

	  context.uc_mcontext.cr2 =3D (thissi.si_signo =3D=3D SIGSEGV
				     || thissi.si_signo =3D=3D SIGBUS)
				    ? (uintptr_t) thissi.si_addr : 0;

With these changes, all patches are ok to push.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVJpK1AAoJEPU2Bp2uRE+gSKkQAJ9zd2UNJOglQI+qDpsm466u
TG70ejUEAkV8y/RSPxpOqOAp4YrR8JndcSrdjnW9AroWDn/nbsHGmHi2C4U6Has5
Q5gp3MTzLwehFwLhKc26dFbbOQDqffRB6A6PZGLslYzrxT/QUTOg2j2FvMLbGCNK
pX20rMSZ71sS+Vt1Hrjo3Q+OzPwOpddaaEvguR6Mli7QQap2h024fKcFHPkNrbjt
C1bnFgWqI2HY3/yDh98foNKjqbyYb7w7JFAORcwXa3mKTkn3OVDXjzvTtw/4NpGE
+9bI1rwNeKgI1vUKM/nw76ZyiYlxifmuG+Z6G20g86o4I3edFIFvBgJFacrrUXs3
96ghJ4fMwtwfpw9FrUr+xtp52NichAu+EXHaOL9z20QEg3qxtU9W8KxGiFH30OKl
THiGofP+hmriZJTwKzBQg1L4qNWNRHtt5Ke9fIR2oY19ulNyz6xPBdedELD44dCP
/qZMqIfIFAnAjR22pu7g5Uz/v6faHJmKKxWeT+tBHsLDzRxIeuQg7FYDZWYsF3sm
sNxY7HHVPTygeQe83jwQ2ShDKHUwIdzKqoREM8xZQLlzK/FfN73dJUW66F6FBptl
wjxbUTe0dRZBu5txQmlHlCAIAd3h7UYxhCW7hQNmvPD7mcvSfBAHY2UkAzjnvje1
Fs6S8o3jZmxj8kYluCbe
=IJ+q
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

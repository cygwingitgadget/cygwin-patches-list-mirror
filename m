Return-Path: <cygwin-patches-return-8607-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130788 invoked by alias); 28 Jul 2016 19:21:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130770 invoked by uid 89); 28 Jul 2016 19:21:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-94.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=cp, yuk, UD:glibc.git, glibc.git
X-HELO: calimero.vinschen.de
Received: from ipbcc0190b.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.25.11) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Jul 2016 19:21:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8D364A80EF9; Thu, 28 Jul 2016 21:21:00 +0200 (CEST)
Date: Thu, 28 Jul 2016 19:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Add pthread_getname_np and pthread_setname_np
Message-ID: <20160728192100.GA26311@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20160728114341.1728-1-jon.turney@dronecode.org.uk> <20160728114341.1728-2-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20160728114341.1728-2-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.6.2 (2016-07-01)
X-SW-Source: 2016-q3/txt/msg00015.txt.bz2


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 4352

Hi Jon,

On Jul 28 12:43, Jon Turney wrote:
> This patch adds pthread_getname_np and pthread_setname_np.
>=20
> These were added to glibc in 2.12[1] and are also present in some form on
> NetBSD and several UNIXes.
>=20
> The code is based on NetBSD's implementation with changes to better match
> Linux behaviour.
>=20
> Implementation quirks:
>=20
> * pthread_setname_np with a NULL pointer segfaults (as linux)
>=20
> * pthread_setname_np accepts names longer than 16 characters (linux retur=
ns
> ERANGE)

Given the behaviour of pthread_getname_np we should do the same, I think.

> * pthread_getname_np with a NULL pointer returns EFAULT (as linux)
>=20
> * pthread_getname_np with a buffer length of less than 16 returns ERANGE =
(as
> linux)
>=20
> * pthread_getname_np truncates the thread name to fit the buffer length.
> This guarantees success even when the default thread name is longer than =
16
> characters, but means there is no way to discover the actual length of the
> thread name. (Linux always truncates the thread name to 16 characters)
>=20
> * Changing program_invocation_short_name changes the default thread name.
>=20
> I'll leave it up to you to decide any of these matter.
>=20
> This is implemented via class pthread_attr to make it easier to add
> pthread_attr_[gs]etname_np (present in NetBSD and some UNIXes) should it
> ever be added to Linux (or we decide we want it anyway).

Good thinking.

> [1] https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3DNEWS;h=3Dd55a8=
44d4ec06d164cb786c6c9f403a9672a674d;hb=3De28c88707ef0529593fccedf1a94c3fce3=
df0ef3
>=20
> diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/inclu=
de/cygwin/version.h
> index 1f5bf72..d403f0e 100644
> --- a/winsup/cygwin/include/cygwin/version.h
> +++ b/winsup/cygwin/include/cygwin/version.h
> @@ -454,12 +454,13 @@ details. */
>         nexttowardf, nexttowardl, pow10l, powl, remainderl, remquol, roun=
dl,
>         scalbl, scalblnl, scalbnl, sincosl, sinhl, sinl, tanhl, tanl,
>         tgammal, truncl.
> +  298: Export pthread_getname_np, pthread_setname_np.

Yuk!  This collides with my changes in topic/locales.  Oh well, nothing
we can do about it...

> --- a/winsup/cygwin/thread.cc
> +++ b/winsup/cygwin/thread.cc
> @@ -1099,7 +1099,7 @@ pthread::resume ()
>  pthread_attr::pthread_attr ():verifyable_object (PTHREAD_ATTR_MAGIC),
>  joinable (PTHREAD_CREATE_JOINABLE), contentionscope (PTHREAD_SCOPE_PROCE=
SS),
>  inheritsched (PTHREAD_INHERIT_SCHED), stackaddr (NULL), stacksize (0),
> -guardsize (wincap.def_guard_page_size ())
> +guardsize (wincap.def_guard_page_size ()), name (NULL)
>  {
>    schedparam.sched_priority =3D 0;
>  }
> @@ -2569,6 +2569,65 @@ pthread_getattr_np (pthread_t thread, pthread_attr=
_t *attr)
>    return 0;
>  }
>=20=20
> +#define NAMELEN 16
> +
> +extern "C" int
> +pthread_getname_np (pthread_t thread, char *buf, size_t buflen)
> +{
> +  char *name;
> +
> +  if (!pthread::is_good_object (&thread))
> +    return ESRCH;
> +
> +  if (!thread->attr.name)
> +    name =3D program_invocation_short_name;
> +  else
> +    name =3D thread->attr.name;
> +
> +  // Return ERANGE if the provided buffer is less than NAMELEN.  Truncat=
e and
> +  // zero-terminate the name to fit in buf.  This means we always return
> +  // something if the buffer is NAMELEN or larger, but there is no way t=
o tell
> +  // if we have the whole name.

Please use C-style /* */ bracketing for multiline comments.

> +  if (buflen < NAMELEN)
> +    return ERANGE;
> +
> +  int ret =3D 0;
> +  __try
> +    {
> +      strlcpy (buf, name, buflen);
> +    }
> +  __except (NO_ERROR)
> +    {
> +      ret =3D EFAULT;
> +    }
> +  __endtry
> +
> +  return ret;
> +}
> +
> +#undef NAMELEN
> +
> +extern "C" int
> +pthread_setname_np (pthread_t thread, const char *name)
> +{
> +  char *oldname, *cp;
> +
> +  if (!pthread::is_good_object (&thread))
> +    return ESRCH;
> +
> +  cp =3D strdup(name);
               ^^^
              space?

> +  if (!cp)
> +    return ENOMEM;
> +
> +  oldname =3D thread->attr.name;
> +  thread->attr.name =3D cp;
> +
> +  if (oldname)
> +    free(oldname);
          ^^^
         space?

Looks good, otherwise.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXmlscAAoJEPU2Bp2uRE+gYf0P/jdBoPOSm65FEhXO+dbyYWa0
7Gctvpjt61BBJ0RFtxP4rMJFNKQUPfTe+qM3GKL8IXMcz5OkpF2Zlmy+gRZAnka0
xXoZc9Cu94GqRNGSzaFQhpXbOCxDNodN7YX6dWuR5zkDr0ZbPweB8G0L0XunlJ+O
aS4vc5Q3UsJEAyM9kBvom3JQ9aQcj4+rXGQWo1bxYPp9qId/Xcx96Y4wy4yj27IM
YjyZ043f2E3xoYbk6J3OPmy6Wdchh6vRJ868nLO4GfUTZdXZEP4+cEEeloyHRJL+
99bAFEryn6D4Mbp2WQC89NUxWv7k7Nvby790vDi0lmL2NeEi8zC9tG2RBOchGSCq
v5uBe2vQb+FqB3WALSwTsnkijHzGDNBc+s42Mdbt57dRASCGy4kliRiHe2F4IR95
OzP2vGSNpNvYiRaGjdWn9hhHUJiiVOXjP6wijCuRg0wnYnPRCM/GJLZiO5xWqz04
glopfUC/NIN4ReqcXQ/esbXUKDPhE8dhohRu+LBXfUG0o0bnX7yWrTfnc8TDsmy2
mX7tb/grhaNws5B4lmYsw8Q/tMddoItJAJ0xPJbjcpFccSMj33r2jo+ukSakIlL8
CWqPMysORxuk0LSpmIZFxp3w3EB9X0MGkCnKoJv2mWOyinmqA6xBInWA/Wc3zD/A
W/7UIl9K9uj44LGEA+lY
=qssU
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

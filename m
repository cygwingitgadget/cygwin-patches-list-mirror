Return-Path: <cygwin-patches-return-8488-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 102512 invoked by alias); 23 Mar 2016 10:46:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 102489 invoked by uid 89); 23 Mar 2016 10:46:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, our
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 23 Mar 2016 10:45:52 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 91C3EA80643; Wed, 23 Mar 2016 11:45:50 +0100 (CET)
Date: Wed, 23 Mar 2016 10:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/5] Add nonnull annotation to posix_memalign.
Message-ID: <20160323104550.GR14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-5-git-send-email-pefoley2@pefoley.com> <20160320111558.GG25241@calimero.vinschen.de> <CAOFdcFPxwdnyjbtAm5FVD6d4DhZB9Cm80kPzzNVaCPKfN9yX9Q@mail.gmail.com> <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <56F0A52D.5070303@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="3XZQkxCYp0f/VEFS"
Content-Disposition: inline
In-Reply-To: <56F0A52D.5070303@cygwin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00194.txt.bz2


--3XZQkxCYp0f/VEFS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1551

On Mar 21 20:51, Yaakov Selkowitz wrote:
> On 2016-03-21 12:15, Peter Foley wrote:
> >GCC 6.0+ asserts that the memptr argument to the builtin function
> >posix_memalign is nonnull.
> >Add the necessary annotation to the prototype and
> >remove the now unnecessary check to fix a warning.
> >
> >newlib/Changelog
> >newlib/libc/include/stdlib.h: Annotate arg to posix_memalign as
> >non-null.
> >
> >winsup/cygwin/ChangeLog
> >malloc_wrapper.cc (posix_memalign): Remove always true nonnull check.
> >
> >Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> >---
> >  newlib/libc/include/stdlib.h    | 2 +-
> >  winsup/cygwin/malloc_wrapper.cc | 3 +--
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> >
> >diff --git a/newlib/libc/include/stdlib.h b/newlib/libc/include/stdlib.h
> >index f4b2626..7d4ae76 100644
> >--- a/newlib/libc/include/stdlib.h
> >+++ b/newlib/libc/include/stdlib.h
> >@@ -253,7 +253,7 @@ int	_EXFUN(_unsetenv_r,(struct _reent *, const char =
*__string));
> >
> >  #ifdef __rtems__
> >  #if __POSIX_VISIBLE >=3D 200112
> >-int _EXFUN(posix_memalign,(void **, size_t, size_t));
> >+int _EXFUN(__nonnull (1) posix_memalign,(void **, size_t, size_t));
> >  #endif
> >  #endif
>=20
> Note the ifdef __rtems__ there; we have our own posix_memalign declaration
> in winsup/cygwin/include/cygwin/stdlib.h.  Perhaps these should be merged?

Definitely.  Thanks for catching.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--3XZQkxCYp0f/VEFS
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8nPeAAoJEPU2Bp2uRE+g7WoQAIKBHIGg0gHKV2an748Xx7UU
XgoBykVnt2fo88IXWht6bA0dfTnsENt/br4I08FFUbn4mEqpbTVbR5TMMSt+4rCq
ey/bpYnyxP80ZFGTclkqGCC4wokFw/wcFe1BrXf4PQbGr/0TltKo1uA6RjOLCbOo
sQ3KQ5CjfKBOu/GMAL1u6MLPzx6UR+m8qLvM6B50MzL4jDc/XvS7r7UeJXU+TJzj
Z3n/Y5GyRu4G/U8yLpmY7iiYy2yetdD9tokcDvep5kfPolX8pBNMbproJimrWaZB
j8x0aomH7BF9E9X0OBpqLUUfGowFHO9cVTdC6sx3/2xWzFdYTjF/7ElnNlL0Taw9
gUafViuxGFubjuO/b48LT1IROvIEz2H+c4/6lZ1eA28C3wQZGzp0xicAm+dijYwC
e82q6AP58CvUUyGhUzoaymwsxciTvWYUjoZc551vMbup8XU431YOU/ieoxdBA8Fj
j+pyGKUN/Ws8qKolsLZymc9atnipVux3LQ4xTrQr3m3z2q+GXXfQYNRagpdytZMi
pGCkSjmU+wHvQDUwHEbyLOBMu+7WpgdIpHqr+K/2/ib0HHNGRtdM940ymYfmnoiK
Fzfg7igu7K97DKb+IFEQyOIz3opi8Qs6OY93eYrG2rzYdSRhlCcqbWjYxe87gXNl
anmUmPgXTAVlJhibRazl
=/hrq
-----END PGP SIGNATURE-----

--3XZQkxCYp0f/VEFS--

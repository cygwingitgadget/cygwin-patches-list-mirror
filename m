Return-Path: <cygwin-patches-return-9193-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124838 invoked by alias); 10 Jan 2019 20:17:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124826 invoked by uid 89); 10 Jan 2019 20:17:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-125.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=realised, H*F:D*cygwin.com, H*Ad:U*cygwin-patches, reading
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 10 Jan 2019 20:17:01 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MWiYi-1goKbC14EC-00X3Mg for <cygwin-patches@cygwin.com>; Thu, 10 Jan 2019 21:16:58 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 90CAEA80756; Thu, 10 Jan 2019 21:16:57 +0100 (CET)
Date: Thu, 10 Jan 2019 20:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: af_unix_spinlock_t: add initializer
Message-ID: <20190110201657.GP593@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190110175635.16940-1-kbrown@cornell.edu> <20190110180253.GO593@calimero.vinschen.de> <3f1d89ac-a91a-e8c5-7fc2-61a8a30ecb3e@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jIYo0VRlfdMI9fLa"
Content-Disposition: inline
In-Reply-To: <3f1d89ac-a91a-e8c5-7fc2-61a8a30ecb3e@cornell.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SW-Source: 2019-q1/txt/msg00003.txt.bz2


--jIYo0VRlfdMI9fLa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2278

On Jan 10 18:36, Ken Brown wrote:
> On 1/10/2019 1:02 PM, Corinna Vinschen wrote:
> > On Jan 10 17:56, Ken Brown wrote:
> >> Also fix a typo.
> >> ---
> >>   winsup/cygwin/fhandler.h | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> >> index d02b9a913..7e460701c 100644
> >> --- a/winsup/cygwin/fhandler.h
> >> +++ b/winsup/cygwin/fhandler.h
> >> @@ -832,9 +832,10 @@ class fhandler_socket_local: public fhandler_sock=
et_wsock
> >>   /* Sharable spinlock with low CPU profile.  These locks are NOT recu=
rsive! */
> >>   class af_unix_spinlock_t
> >>   {
> >> -  LONG  locked;          /* 0 oder 1 */
> >> +  LONG  locked;          /* 0 or 1 */
> >=20
> > Huh.
> >=20
> >>   public:
> >> +  af_unix_spinlock_t () : locked (0) {}
> >=20
> > Why do we need that?  The spinlock is created as part of a shared mem
> > region which gets initialized to all zero, no?  Or do you plan to use it
> > outside of this scenario?
>=20
> At the moment I'm using it in the new FIFO code, and I'm not sure yet whe=
ther it=20
> will eventually be in shared memory.  (Until I get things working, I'm=20
> postponing thinking about whether I need shared memory.)
>=20
> Would it be better to use some other kind of spinlock until I know for su=
re that=20
> I need shared memory?  My only reason for choosing af_unix_spinlock_t is =
that I=20
> was copying code from fhandler_socket_unix, and this saved me the trouble=
 of=20
> learning about other kinds of spinlocks.

The above patch shouldn't hurt in the least since it's not used anyway
when allocating the shared mem region used by the AF_UNIX socket code.
If it helps you, I can push it, no problem.

Just make sure this spinlock is the right thing for you.  The idea here
was to have a fast, sharable(*) lock without context switching, only
guarding small code blocks which don't hang due to resource starving.

If you have to guard more complex code chunks, it might be better to
use a kernel locking object like mutex or semaphore.


So, push or no push?


Corinna


(*) Originally I thought slim R/W locks are nice for unix sockets...
    until I realised they are not sharable.  Reading MSDN helped :}

--=20
Corinna Vinschen
Cygwin Maintainer

--jIYo0VRlfdMI9fLa
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlw3qDkACgkQ9TYGna5E
T6BCiQ//bhwWglcPH9krvBOoQq7ILvqIFYKMfc0bVJ61MXJGOikCnQy2ja6CILaM
NeTzciAKAQgHofcTy7karqGEkeIsVkb/GWQqEGvFucdCRGrbbkzLRZhllD9lSxRj
mQavr/zljEoLWCLvQkDb6hWnclwTkdjcQjSMiIs/5zLhJWYlLKZPHJSUtC7iorzl
9YflFLKkfkYEgd1JxXBsfHOtvrYU5W4fJzfEA27nKojdDvzY5XfZV3yubAFFBn9U
W2OINfBCO7Rg34dOHD5cyq4cZltAcNTcrMDD+Y9Qnu9+RhGn8W8pdMeKwT6fcl50
4fhXtYMnBl8n51AbrEsEt4uSqxIy0WZDEOGM35emPKcCm+v3ifyLRBNsD393czCM
p/7DJZg4/dxiCQjcm8ZHSKY6V2HpSbApoxIUGyvuwn+QvfYI1iosUkIiFqMMFLCd
Ck655BLUDY2fDNhZxb0dWOw5Fhf3XseRrk/+3PVx7+SZ5WoczD9klvRE5eJvWf8y
9ghXR39yL+WWsdJLyJLjDcI6YVzFSzbv+hZPo5NpsRmNA4jAKj7LS24WqbX70+V9
ZNZjRrrrGjPrqW9356j1l0LtNqUzxCkeaaHB57PWutPEHRgtRR5IGay5NeYG4O2U
9nJQadEOtBCEUD4YCQLzBBxfLGf8+hIxjerNUPS7ofRu0GuNvgE=
=MBwl
-----END PGP SIGNATURE-----

--jIYo0VRlfdMI9fLa--

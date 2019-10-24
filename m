Return-Path: <cygwin-patches-return-9793-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12124 invoked by alias); 24 Oct 2019 09:38:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12110 invoked by uid 89); 24 Oct 2019 09:38:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-52.1 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=SYSTEM, screen, H*F:D*cygwin.com, UD:cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 24 Oct 2019 09:38:21 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MfpGR-1hm1pb21NJ-00gJB4 for <cygwin-patches@cygwin.com>; Thu, 24 Oct 2019 11:38:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3EB56A8045C; Thu, 24 Oct 2019 11:38:17 +0200 (CEST)
Date: Thu, 24 Oct 2019 09:38:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-ID: <20191024093817.GD16240@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191021094356.GI16240@calimero.vinschen.de> <20191022090930.b312514dcf8495c1db4bb461@nifty.ne.jp> <20191022065506.GL16240@calimero.vinschen.de> <20191022162316.54c3bc2ff19dbc7ae1bdedf2@nifty.ne.jp> <20191022080242.GN16240@calimero.vinschen.de> <20191022182405.0ce3d7c17b0e7d924430b89c@nifty.ne.jp> <20191022134048.GP16240@calimero.vinschen.de> <20191023122717.66d241bd0a7814b7216d78f5@nifty.ne.jp> <20191023120542.GA16240@calimero.vinschen.de> <20191024100130.4c7f6e4ac55c10143e3c86f6@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="AAkN98o3X3ouhQaz"
Content-Disposition: inline
In-Reply-To: <20191024100130.4c7f6e4ac55c10143e3c86f6@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00064.txt.bz2


--AAkN98o3X3ouhQaz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1439

On Oct 24 10:01, Takashi Yano wrote:
> Hi Corinna,
>=20
> On Wed, 23 Oct 2019 14:05:42 +0200
> Corinna Vinschen wrote:
> > In my limited testing it seems to work nicely.
>=20
> Isn't the screen contents before opening pty cleared when cmd.exe is
> executed?

Well, what I see when starting cmd.exe with this patch is a short
flicker in the existing output in mintty, but the cursor position
stays the same. and cmd.exe output is where you'd expect it.

> Also Michael's test case probably does not work.
> https://www.cygwin.com/ml/cygwin-patches/2019-q4/msg00054.html
>=20
> > > +static bool
> > > +is_running_as_service (void)
> >=20
> > This function should probably use check_token_membership(PSID).
> > I'm also not quite sure if checking for mandatory_system_integrity_sid
> > makes sense.  Are there examples where the service SID is missing
> > but the integrity is set to system integrity level?
>=20
> If sshd or inetd is executed as cyg_server, S-1-5-6 (Service) is set.
> However, when they are executed as Local System Account, only SIDs
> set are as follows.
>=20
> S-1-5-32-544 (Administrators)
> S-1-1-0 (Everyone)
> S-1-5-11 (Authenticated Users)
> S-1-16-16384 (Mandatory System Integrity)

If it's running as Local System (actually SYSTEM), it should have
the user SID S-1-5-18.  You can just check this with

  cygheap->user.saved_sid () =3D=3D well_known_system_sid


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--AAkN98o3X3ouhQaz
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl2xcQkACgkQ9TYGna5E
T6AEkg//VChz0sMryIw7uEGOWsxI3TWACTjuD3K4iStl4BWX2Wa7E5Hk1Amz6UM2
teqC+NMemoY9mIbfIZ8HIOBmeAtjwb5IbOCFRi12vZ75oNhtqRY+Wfrv1CGptVWX
17U7bmYP2hbD0VhLVJwUzkNUJ8GAhFByS+0SIUZHNnPLF4qLqUQY09SkUFKykPQN
8NvVk3XAYHdsMMZtzfYRFQV5i2UmkgeGZ+D++c+GbQBOs1j5W2TLnIu2nb5h3xwW
Ln2Msn+Tf3C+QdEaHPC4R3lEdqx5sXOjycwP/gURNvQC/T9NyAC81aEABceyaQSB
VjtL83LarANGwajPlmdgRb4OR5bNOYFGDOnZGaqf6pbumsRLXoxeYlu4dh6DJ2Za
YqtqJN7yzLIdvN0J4tz4h+B6BuS7EaxoW13WrkX7ak+uJOXvNBJYAknnAJ0MJcso
OS5Jon0VJNdhNxGSYy0shLelgAEnaOiEEc2YE3WKcq8PBmcLnEnf/RWkxscQqTNw
Wbs/t+WpfRUHC/x8+jS6E/6phjmVGA5yE1lJwKNTo95Q2g6yb0kxiC6ZouLuEIa3
hfv1P4zi42A3KgwApqvjVzQAGTEUlat4xad53iSgeVnyFYdibzJsUKXGrMl/IFbV
WofpETjfPJIiqPo/zlwLZk1gCc8xEX5dah4NrMFN6yIlh68z6Tg=
=XRHk
-----END PGP SIGNATURE-----

--AAkN98o3X3ouhQaz--

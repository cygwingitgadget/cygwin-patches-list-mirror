Return-Path: <cygwin-patches-return-9492-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5195 invoked by alias); 19 Jul 2019 08:28:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 5178 invoked by uid 89); 19 Jul 2019 08:28:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=editorial, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Jul 2019 08:28:48 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MOQu6-1i5L2R46gw-00Pu1x for <cygwin-patches@cygwin.com>; Fri, 19 Jul 2019 10:28:46 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 76858A80382; Fri, 19 Jul 2019 10:28:45 +0200 (CEST)
Date: Fri, 19 Jul 2019 08:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: make path_conv::isdevice() return false on socket files
Message-ID: <20190719082845.GO3772@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190718200026.1377-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Mjqg7Yu+0hL22rav"
Content-Disposition: inline
In-Reply-To: <20190718200026.1377-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00012.txt.bz2


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1041

Hi Ken,

On Jul 18 20:02, Ken Brown wrote:
> As a result, socket files are no longer treated as lnk special files.
> This prevents rename() from adding ".lnk" when renaming a socket file.
>=20
> Remove a redundant !pc.issocket() from fhandler_disk_file::link().

I see what you're doing here, but it's totally non-obvious from the
commit message why this fixes the problem and doesn't introduce weird
side-effects.  Changing isdevice() also changes the definition of
is_auto_device(), which is used in symlink_worker().=20=20

To ease the pain during later bisecting session, it would be kind to
explain detailed why the problem occurs and why your patch is the right
thing to do.

An editorial note: While looking into your patch it occured to me that
it would be about time to go over all the is***device() methods and
clean up the mess.  E.g., is_fs_device() is used by is_lnk_special()
only, is_auto_device() doesn't have much meaning, some funcs have
underscores, some don't.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0xfz0ACgkQ9TYGna5E
T6CRhhAAl+kMW4JmIgV+Jmo7WA0kZqQK017CLy6bEuzVJ7Ok/SO4zF7xJXPyvS5G
sHYxcm8RgjnR7iimbh4GNKmA3gds0FvJcAnN+AAsNhXHpjzhRLjNBgxm4WTsq+dL
5iFy/ICfy3QiyLxogImpVpE86mV3p3PnNs7yKNuRvXQylJ7O2GyN+nzGh+SOxYKK
If2QW6Rn9uqNmgagPvyHVujmMpidjyT6ZsdFkgiFSB1sxoApz+ph8mNKqABb5emd
UXvECTZI0SiK1+lO8tokmrJ84TDL6Bzeu9FBCl9T8nN6uQJ//zHrO/qgzC5tsgOl
5Z9ugu860CG2GWm2dAwcBm9yVPpLl+Xusi8KSMDU9Oou7IN77+ofSezGL7QrRCuz
47+NuyWJNuAIrevxeFNYu9bGUgCZKoxeik75R8WMWQ8tHfkiDoj+JHqjQD4+VKq3
SghA1DQAEaKF4lVG+imdr6r6kEzX1J3k2qqvgUhG6z5aUyIWLli/urxwPijdsNvp
AWT60eaUokcvtlWtVdaURt1EEYgLMhL9NYMSss+QAfHLhwkebC7Y9VqKvmshW4cZ
svcUqgU2zg+sJZVK6HrUM3QPVHUepmknIlsVlykdePsCNKX79CbDC2zrMIanSgl6
p3x2aV+r5/W40GIihUg9RRVaxhH4blkR34szUuBJO61uQLhE99s=
=yl3V
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--

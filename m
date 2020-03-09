Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by server2.sourceware.org (Postfix) with ESMTPS id 75E4C3940CE1
 for <cygwin-patches@cygwin.com>; Mon,  9 Mar 2020 08:59:14 +0000 (GMT)
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVv8f-1ik6Ro0Uar-00Rrkw for <cygwin-patches@cygwin.com>; Mon, 09 Mar 2020
 09:59:13 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 74165A827DA; Mon,  9 Mar 2020 09:59:12 +0100 (CET)
Date: Mon, 9 Mar 2020 09:59:12 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] wpbuf class-ification
Message-ID: <20200309085912.GB4042@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1583611115.git.HBBroeker@T-Online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <cover.1583611115.git.HBBroeker@T-Online.de>
X-Provags-ID: V03:K1:BXKS8UkCPiln63xRGxARErjM8mQrPHByWyFa/LehXTiwjkC3pVl
 Qfi3tMOu/vF6JDPmyGT9+Bx3Zy0keFLvGOazPh/db2kSqXDXqc8tdDvO1aWOa7haXgjc42h
 yx+o46Vk0bXd7kVMf2cNxAbDkK/J4sOs0GgMRibMyAbcTK/223DwHnHDRwxLpp6m3WG6ZZO
 UzGS5h2MK6fXJ2lY2KbFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kI5ziXcKzXI=:1OWNglkaNJoiceqzpB3Glz
 nbp6KmC0nWA7XFu4IAsutTtxCMISyw4nsud7zwLHB22cmlfcOUEFknAMWbPdRSMYynyyn4IuU
 VzSElMh8rDygP9v8Nv9NutS9K0lAqPiTI12CvQRMRwDWYFE8GnWP0jrgjn7JPl2pU/JAA1hrj
 odYocm5q1a1y686F2tEJitfyhGLYG7/oFahfXLf5KTJanUvZe4ypqJYEXli1S8sdEo508nw+i
 Ld3jXyXRYdyA2/Fc2r4MhBN2pv09n3988+JRd9V6japH3dATPqziZeXPaGi7JXCutkAhFs+Ns
 DKmM3PeDlgt/OkaUsaiM+ShPK7Nzr2W71a6RXJvSykzMLTNgeHFAujxKvTMGK2tkZXWtgSUzU
 teVtHmgYkIAlLo978plrepaMiFGJq6/viHh4Tv/nn1TgwVxnQhy61+S1ha6fY5nxmaUq/y2oV
 2icSdMsFsnviXw9eldVMnffm3ZiYy1zaASxm97Wj/J88EyxN+Or0KWFIcvSx0knMjSfIGhIxt
 cVfsDCoUTpyTFVfPOvxHsnbclK5HQjmVgMg3TeMPA8wwhyUMTOh3i5NnS0iKviMeeQnVum4Xr
 NRyxo+SjnFfBusaZu0wSj7fEo0sxyXQQNM2H/gQKl+UV3mFANHfUj8oJRcSG5rWAEn5+r3ndK
 1lPCavEdTnWAZ7OUMwlYFlf6T0fhJNhpkE1b753/p+gewYIww4I0dwduXv5VOqgeeFNz62uLm
 NoKcJBSGZkPOgHHTSwhhhliBLrtZ7dTsVgyj+EAkd+aNAAC5Ag2C2R2lHsyGRWKr2NPNBE0sS
 p153cckW+UIjkfBl1HCaRxW2w8X47N/WkykDHEGrkm9JbTvhE/EdPMtSOtqWN3aeDbe0hRJ
X-Spam-Status: No, score=-106.9 required=5.0 tests=BAYES_00, GIT_PATCH_2,
 GOOD_FROM_CORINNA_CYGWIN, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_NONE autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin-patches mailing list <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <http://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 09 Mar 2020 08:59:15 -0000


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar  8 21:41, Hans-Bernhard Broeker wrote:
> Second shot at wpbuf class-ification.  Also no longer
> request data from WriteConsoleA that is not used for anything.
>=20
> Hans-Bernhard Broeker (2):
>   Collect handling of wpixput and wpbuf into a helper class.
>   Do not bother passing optional argument to WriteConsoleA.
>=20
>  winsup/cygwin/fhandler_console.cc | 164 ++++++++++++++++--------------
>  1 file changed, 85 insertions(+), 79 deletions(-)
>=20
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5mBWAACgkQ9TYGna5E
T6Cs5RAAic4TyoWVO06PUyo0RAxhsTTHJPFSA/0PdSHtC1k5e0SR5RYBvo+H1n5U
ipG56Wa9QGD02vKxbARPq/QJi2mqDhpHrzVYzOujAqgaDcV5GC+WhOUetKbUr8eU
JXD3Ii3sCYK+TlrpXX4FNhqE609aKR/WL2mkpbQ60TklVoqVZO7tsSNT7LWaEBe8
MDPFbDXFJYG3s7xc6i72PImudipY2g/oYefHqrDjLN5tdXW4SYpu8J0AgkGPjtNp
dJ2j+AquyKazh5ZgVk7gj+R4sHikBHpgNiRHgDIuckkp3obraiEmOm/g5DPZAUd6
Pu74BfjqiaPo6KoKb/FWj8M001IC5VsGITCU0O42Le4GsQwegNErj3j1vQIC6kKx
MyiUG79Jgiqod2UIBqM1k6re2Sc5Ai1tbJIMfTnWYOH7IVg7VOsQBZzEjx91Ghjm
zaHt2pEOmaScDHDc5hgjE/lAy1xJSEkhI/0avG0lkLyf6mGPd3eApj9llH0uv98F
x/AvIrJ1pr/CwKGNR5F+rDcQKGbELAl8UOWb4MVgjQS9aNcDnGpz8RoxwD+5orpv
YgulUD4le6SnB0dsdwwNCx9v3ZL4pNJhLOdlzinswAbnTVZK7NGNrAv//kbCsEA9
rZpnKMK3Ll2q/goP7zs5/15+1HhXgbomdn5rt7S2yHzzPYPtYHI=
=3+GT
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

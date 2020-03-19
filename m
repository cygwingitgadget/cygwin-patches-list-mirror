Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id E44A7385E830
 for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2020 15:04:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E44A7385E830
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M2ON6-1jHh4k0gtK-003r1G; Thu, 19 Mar 2020 16:04:20 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A8812A80734; Thu, 19 Mar 2020 16:04:19 +0100 (CET)
Date: Thu, 19 Mar 2020 16:04:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Cygwin: Use a separate Start Menu folder for WoW64
 installs
Message-ID: <20200319150419.GD778468@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
 Jon TURNEY <jon.turney@dronecode.org.uk>
References: <20200319135837.2104-1-jon.turney@dronecode.org.uk>
 <20200319150249.GC778468@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
In-Reply-To: <20200319150249.GC778468@calimero.vinschen.de>
X-Provags-ID: V03:K1:7MTcW6xQk3yVAPScodeF73Y+FCd3KfXnP9Kj06PdP4vm5Atv1Sm
 ZGr5L9LeefLr8ofQd0EDanQ4awzpMg0oKfnMoQ/c4ZGh6Bg4EPtnpz7INmEBYsgNfDDzbL+
 OWc053yVd+xg/KnVfSXCfl7kzpYXoTQZmW1nrXAaeKn4d5Ti9SCdJ5J6lXFkqy1SXlv986e
 PjUdcmfGtlrWJLRHikk7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GahWXtyr4lE=:hyLrBWpO8G1f3WY0Td5eVA
 fZx3N/AG/dXk3aTc/bfbeTz/MyQh4iJZ+ObV0rI1vaArnr5/NuDlXxt9Cbwj994IRnLkfdoWB
 UgPNsXfcCDYq915aJgTUu/eJGvgjAZNkkcDP5dnVBqVaspZ1ILlD1nA213bRU8mg5+mJuzfux
 /MAaKAKb7Lmy70wk2JqYwXFcA4APVj4EIlnNbiNGSNJEjzxuUeeEIpllMTses7Jk5FgKBADD/
 Eei2u21s8Z1F9ZttS+eqZJ9GGhudzJqXnnfGM4oU2fratdTuyvKOc77Xdb5O8L78t6X7bZGFZ
 oy9gr4w/qD+sFNsJ0t0Fy535U752fv+Puw9w4byDZC0AkyWoDpgC29hxCISrXsdL3PBsXqXTf
 wrBX04rD0i0bqaVNuVbEhCs/9YkZRe7m7cUJkxv5OCN8aN055T3AK4lLiMD4ruQhLbOcgPnNp
 kE+MWIcN9hFpdgJeiasMauDNU/xuMDMaSNHv2e/xFBFCky014CZ8rwgJ7eImSTc8Xja7GrkFY
 ra/rJAa61RDPGY4lVH0IAnTLJ3gFj8ibFPxHiXF5HpzHLmFS4vj0Miq3SLJdlWgR8e1v7OsGC
 O3rfSz4mrGMyen7/0HvbWT5eI5VBE4kGIZbhJ9w8NRt+vv4QfKnQxN2cy0YBur7eTR9yH0J8E
 GAiBXg4BFfi8b5lKrbDu054l0hPfnOaVWLbNRDVomZbHovCftxWPA3Z9HT15m1sNtvBSpdrGB
 3ClUL1KfMxQNmPFaFO3+gXY6uIVfNJUcWfTwtR2ij/l3rorI6XCmcByIBEBQpN+fJ0qx7iz7P
 9IbPpJwYSm6mvomMAsuw5OOTxkNuZR6m8argfxKBaiQZDVmqHH1UyRE9zVHfDjJmjrVsqDl
X-Spam-Status: No, score=-124.2 required=5.0 tests=GIT_PATCH_0, GIT_PATCH_1,
 GIT_PATCH_2, GIT_PATCH_3, GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
 SPF_NEUTRAL autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 19 Mar 2020 15:04:25 -0000


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 19 16:02, Corinna Vinschen wrote:
> On Mar 19 13:58, Jon Turney wrote:
> > This aligns the shortcuts to documentation with the setup changes in
> > https://sourceware.org/pipermail/cygwin-apps/2020-March/039873.html
> > ---
> >  winsup/doc/etc.postinstall.cygwin-doc.sh | 3 ++-
> >  winsup/doc/etc.preremove.cygwin-doc.sh   | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/winsup/doc/etc.postinstall.cygwin-doc.sh b/winsup/doc/etc.=
postinstall.cygwin-doc.sh
> > index de7d9e0c3..65ce2ad77 100755
> > --- a/winsup/doc/etc.postinstall.cygwin-doc.sh
> > +++ b/winsup/doc/etc.postinstall.cygwin-doc.sh
> > @@ -37,7 +37,8 @@ do
> >  done
> > =20
> >  # Cygwin Start Menu directory
> > -smpc_dir=3D"$($cygp $CYGWINFORALL -P -U --)/Cygwin"
> > +case $(uname -s) in *-WOW*) wow64=3D" (32-bit)" ;; esac
> > +smpc_dir=3D"$($cygp $CYGWINFORALL -P -U --)/Cygwin${wow64}"
> > =20
> >  # check Cygwin Start Menu directory exists
> >  [ -d "$smpc_dir/" ] || exit 0
> > diff --git a/winsup/doc/etc.preremove.cygwin-doc.sh b/winsup/doc/etc.pr=
eremove.cygwin-doc.sh
> > index 5e47eb579..f07b70c5d 100755
> > --- a/winsup/doc/etc.preremove.cygwin-doc.sh
> > +++ b/winsup/doc/etc.preremove.cygwin-doc.sh
> > @@ -26,7 +26,8 @@ do
> >  done
> > =20
> >  # Cygwin Start Menu directory
> > -smpc_dir=3D"$($cygp $CYGWINFORALL -P -U --)/Cygwin"
> > +case $(uname -s) in *-WOW*) wow64=3D" (32-bit)" ;; esac
> > +smpc_dir=3D"$($cygp $CYGWINFORALL -P -U --)/Cygwin${wow64}"
> > =20
> >  # check Cygwin Start Menu directory still exists
> >  [ -d "$smpc_dir/" ] || exit 0
> > --=20
> > 2.21.0
>=20
> Good idea, please push.

=2E..this requires a new release of setup and Cygwin in lockstep, right?


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5zifMACgkQ9TYGna5E
T6A3zRAAo7+Kpm5D/FsCyIMAtvtOSlKrrEaj649q+uUKxCe0ez7PM1nSRB/geWUY
twt0GBuVRqEdJGtYCJkksxMICSVEBXPgQ31ZD81OEbaw2oY83rdudBpb/VQn67MG
wwrWcL3yVS2FtshfPJ71+vqZaUK0897Yh2qAlOKbEwCnSF/hpRrRdPQ0rxFtd5Zr
lfzp1Bkf1Ra2ldR+8WHOlX3iZbushJcSzwo+ho1Cdwg22H8SgIVG514S+TmDRiF2
oZ3zDSEGqqVGYWeV6o1AlV3KtXfQd15jIO9rwocmkFo2PZGpqbRz4iLBtN2jvr9y
4pNQC/bJz/ZFRuOKqGdmf8mxCiy8uX649djMtBgGmQKlIcbCBIAMSvHLAkruqbxc
KSgg+ZcRT54zuQ4T9uYkDKTp8+wdvREYvBIKbCPdzoWC2MU1Yr2RU4GxkbO31XwP
Uh8Pm5L7ZmrIuZesQ8cp8cp9x52SV8tUx9FhQ32u6DtwETEiJ7+9cFuUlJydzXfK
gpRgfSWHPtYT9h1c6sik1IfrtOm2jw4VMMncMGo6KNP9gjt3w5xjgTJUbP6aQQZn
vDY/u4pgb6YqY9A49f3vefpVT0vmTS0aDyUUtYmdE3M1yKvum3FUc0DWQc9YBYWV
wv1DwSBMCU9+XVYBXIdteqL8Tpqt7sX0sLPQ1OtRWx1Q9V2//Z4=
=JVir
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--

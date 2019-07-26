Return-Path: <cygwin-patches-return-9529-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36168 invoked by alias); 26 Jul 2019 07:09:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36153 invoked by uid 89); 26 Jul 2019 07:09:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*i:sk:5b98b10, H*f:sk:5b98b10, UD:cygwin.com, cygwincom
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 26 Jul 2019 07:09:17 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MVv4X-1i16yy3DPx-00RpU3; Fri, 26 Jul 2019 09:09:05 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 56CCDA808BB; Fri, 26 Jul 2019 09:09:04 +0200 (CEST)
Date: Fri, 26 Jul 2019 07:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>
Cc: Jon Turney <jon.turney@dronecode.org.uk>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2] Cygwin: Fix the address of myself
Message-ID: <20190726070904.GE11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>,	Jon Turney <jon.turney@dronecode.org.uk>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20190724162524.5604-1-corinna-cygwin@cygwin.com> <20190724165447.28339-1-corinna-cygwin@cygwin.com> <22d165b6-2b4b-4e94-7bbf-77449b662e8a@cornell.edu> <20190725133729.GB11632@calimero.vinschen.de> <5b98b10f-73f8-4567-1aaf-934a1200dd75@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <5b98b10f-73f8-4567-1aaf-934a1200dd75@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00049.txt.bz2


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2029

On Jul 25 19:59, Ken Brown wrote:
> On 7/25/2019 9:37 AM, Corinna Vinschen wrote:
> > On Jul 24 19:11, Ken Brown wrote:
> >> On 7/24/2019 12:54 PM, Corinna Vinschen wrote:
> >>> From: Corinna Vinschen <corinna@vinschen.de>
> >>>
> >>> v2: rephrase commit message
> >>>
> >>> Introducing an independent Cygwin PID introduced a regression:
> >>> [...]
> >>> This patch makes sure to set the handle to INVALID_HANDLE_VALUE again
> >>> when creating a new process, so init knows that myself has to be crea=
ted
> >>> in the right spot.  While at it, fix a potential uninitialized handle
> >>> value in child_info_spawn::handle_spawn.
> >>>
> >>> Fixes: b5e1003722cb ("Cygwin: processes: use dedicated Cygwin PID rat=
her than Windows PID")
> >>> Fixes: 88605243a19b ("Cygwin: fix child getting another pid after spa=
wnve")
> >>> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> >>> [...]
> >>
> >> I'll be glad to take a close look at this as you asked.  But I'm not f=
amiliar
> >> with this part of the code, so it will take me a little time.
> >>
> >> Ken
> >=20
> > Thanks!  I accidentally pushed the patch a few minutes ago when I
> > was actually just planning to push the ndbm.h patch.  Anyway, I
> > took the opportunity to create new snapshots with all patches from
> > yesterday and today, so the getpgrp problems in GDB 8.1.1 and 8.2.1
> > should both be fixed there as well.
> >=20
> > I'd still be glad if the two of you could check if my patch makes
> > sense as is.
>=20
> It looks fine to me, though I can't claim to have grasped all its implica=
tions.=20
> In any case, I've installed it and have done a few things that often catc=
h bugs=20
> (e.g., building emacs and running its test suite), and there are no probl=
ems so far.
>=20
> My next step will be to install the experimental pipe code that I posted =
in=20
> https://cygwin.com/ml/cygwin-patches/2019-q2/msg00144.html to see if that=
 shakes=20
> anything loose.
>=20
> Ken

Great, thank you!


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl06pxAACgkQ9TYGna5E
T6AwXA/+NtAIDXSgnJkzj8k+pBk3AlJDtcFdNkUGCy0xwb7/PygegJi6wUrJL3gF
rnwF2SwSWgboNtwvFew97Vhlgj8vCMOSoGlMv9JWW6+5PAJ/yyOT8sZ/vkpHQsuk
SxbjYirvfrZnbUUahBJ99HfPWHwu/TDG+BCGdXB7V3TU/VetRkkwCIi5NMHEYaNY
2jwJGKJs3B3P2bpAzHm90ZjaZjeehWYtT/Klypw25W9E1B/DGuzFLqS45TydW3k9
Mel+nesvSCn39fBWZxGJBABQ9TII6nehdY0WYsGXGdc/aJC2VrKUIDW9SPu1MY5q
+inpEy4Mp1exyKWMBvWChoo3irH1MeGVihE26dx8Q6HxLBPA3ETk64It3MIFtZc6
QTP5l+TeNxwDshEMTZffRXSZZbQOtzzfvDBBIiPIYMlLpDOaD1YgtA9QwDgzQzuP
cDUU6rXNdGuAFOacs4Dk5jxM7hpzP1m6eoeGnR69P8EmqY339Gx/VxD0zXDOlJOz
E2fY3gFdlzBsbwcY3+tb+W/IEMUFkOea9w/DBLaFT9b2SubWh0kdsiiZ73J69K6/
UmvYLwV8AdKstb/uWUjLl404Y7DlG82htTD/hLKawOR9Gfd1F84ilcjp8N/hvbjP
jMQ5fUUVSv2PAN8c/OIsevirCCHxqkkpHBivFfO5rq3Szlb+MBs=
=Nhvv
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--

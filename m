Return-Path: <cygwin-patches-return-10023-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 105472 invoked by alias); 29 Jan 2020 09:52:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 105300 invoked by uid 89); 29 Jan 2020 09:52:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-112.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*f:sk:c0d1e1d, H*MI:sk:c0d1e1d, H*i:sk:c0d1e1d, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jan 2020 09:52:37 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N2EDg-1jihGn1EFS-013hxj for <cygwin-patches@cygwin.com>; Wed, 29 Jan 2020 10:52:35 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AA0E1A80BDD; Wed, 29 Jan 2020 10:52:34 +0100 (CET)
Date: Wed, 29 Jan 2020 09:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Some O_PATH fixes
Message-ID: <20200129095234.GJ3549@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200127132050.4143-1-kbrown@cornell.edu> <20200128170651.GG3549@calimero.vinschen.de> <fccbc7cb-0ea5-17b4-0cbb-de44eb21fff6@cornell.edu> <bc7e009a-074c-36e7-e2d2-c4f2c0a045a0@cornell.edu> <c0d1e1da-f50d-a9f8-0148-0518690b906b@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="bygAmIonOAIqBxQB"
Content-Disposition: inline
In-Reply-To: <c0d1e1da-f50d-a9f8-0148-0518690b906b@cornell.edu>
X-SW-Source: 2020-q1/txt/msg00129.txt


--bygAmIonOAIqBxQB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1946

On Jan 29 03:08, Ken Brown wrote:
> On 1/28/2020 3:48 PM, Ken Brown wrote:
> > On 1/28/2020 2:01 PM, Ken Brown wrote:
> >> On 1/28/2020 12:06 PM, Corinna Vinschen wrote:
> >>> On Jan 27 13:21, Ken Brown wrote:
> >>>> Ken Brown (3):
> >>>>      Cygwin: fhandler_base::fstat_fs: accomodate the O_PATH flag
> >>>>      Cygwin: fhandler_disk_file::fstatvfs: refactor
> >>>>      Cygwin: FIFO::fstatvfs: use our handle if O_PATH is set
> >>>>
> >>>>     winsup/cygwin/fhandler.h            |  1 +
> >>>>     winsup/cygwin/fhandler_disk_file.cc | 24 +++++++++++++++++-------
> >>>>     winsup/cygwin/fhandler_fifo.cc      |  8 ++++++++
> >>>>     3 files changed, 26 insertions(+), 7 deletions(-)
> >>>>
> >>>> --=20
> >>>> 2.21.0
> >>>
> >>> Patches are looking good to me.
> >>
> >> OK, I'll push them.
> >>
> >>> As outlined on IRC, I found a problem with the ACLs created on new
> >>> FIFOs and frixed that (I think).  However, Cygwin doesn't actually
> >>> return the real permissions in stat(), only the constant perms 0666,
> >>> kind of like for symlinks.  I didn't have time to look into that yet,
> >>> but it would be great if we could fix that, too.
> >>
> >> I'll take a look if you don't get to it first.
> >=20
> > Two quick thoughts, and then I won't have time to think about this any =
more
> > until tomorrow:
> >=20
> > First, I wonder why in fstat_fs we're not using the stat handle (i.e., =
pc.handle()).
>=20
> Ignore this.  I was confused.
>=20
> > Second, in the call to get_file_attribute in fstat_helper
> > (fhandler_disk_file.cc:478), why do we set the first argument to NULL i=
nstead of
> > using our handle?

The handle is a pipe handle, not the file handle, and the permissions
on the pipe handle were not reflecting the permissions on the file.
The NULL pointer was trying to make sure that the file gets opened
for fetching the security descriptor in get_file_sd().


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--bygAmIonOAIqBxQB
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4xVeIACgkQ9TYGna5E
T6C3zBAAgdZpzdet3OsBPPfMuwp4bz8+IMyZ/nEXkvgfA5EQDHe5sg5OGVc4A6Xd
jNOU3bxAJKXFETlTJAfMe8sERJKvVROxTfTvPMa+VlvdDzXw2qXZ2z23KkzzIIiF
un/xfnnmTU35UeZ6IBeYZV57gwuQqwtvopymn3cwG8F71qzP8kKqN4/7A/kWYAGK
gZ8JhBgC+OknK8qwi+zbwVLbedCd13zoZR91v8WJmt1Fg7rirvS/0W7xk+7YpuGs
8eY7lGbn+qu4K086QPYpJP+lCeyKBjZf6GjwgDH528jTNUBd0vLdanu8ZvpXZcWN
dEzaHsA5Tbdz6T/sRWgOJxm77qrRWKVKN3zX3WFk+4sGOtp8yL3ySu1RYWYoqGIH
qj4vk7VnhSzHgFZ2/OuObhVAr2PMGkb8740cSx33umXvKSaEZFf6XuMDNmcvnLcw
x51RCgOveaEoRXM+aXQhyoBYs3uWy87hePcUUrAxYewPn+G4H0o9RgLEENjbsWRV
ckLEC1zsyIkrdU7+xNLaQ96aX5aNmI2F2SsETEFa3CMQ235AUL3OB/Ztack62Uwk
Sm4xwAFtatiB+wYBgN/0QkewXzjFS1jFJANG2XmYI+As5bctm31Q/m7BOJPNe5T5
Mmdmtb2taVd/9s/0pHZO4aTETFJiN9+RcxtQQxveaPufxBJYszs=
=J9Q2
-----END PGP SIGNATURE-----

--bygAmIonOAIqBxQB--

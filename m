Return-Path: <cygwin-patches-return-10024-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 86378 invoked by alias); 29 Jan 2020 14:22:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86356 invoked by uid 89); 29 Jan 2020 14:22:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.1 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, our
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jan 2020 14:22:44 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MGA0o-1imvnh0l24-00GbhT for <cygwin-patches@cygwin.com>; Wed, 29 Jan 2020 15:22:41 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4FE06A80BDF; Wed, 29 Jan 2020 15:22:40 +0100 (CET)
Date: Wed, 29 Jan 2020 14:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Some O_PATH fixes
Message-ID: <20200129142240.GN3549@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200127132050.4143-1-kbrown@cornell.edu> <20200128170651.GG3549@calimero.vinschen.de> <fccbc7cb-0ea5-17b4-0cbb-de44eb21fff6@cornell.edu> <bc7e009a-074c-36e7-e2d2-c4f2c0a045a0@cornell.edu> <c0d1e1da-f50d-a9f8-0148-0518690b906b@cornell.edu> <20200129095234.GJ3549@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="vbzKE9fGfpHIBC6T"
Content-Disposition: inline
In-Reply-To: <20200129095234.GJ3549@calimero.vinschen.de>
X-SW-Source: 2020-q1/txt/msg00130.txt


--vbzKE9fGfpHIBC6T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1578

On Jan 29 10:52, Corinna Vinschen wrote:
> On Jan 29 03:08, Ken Brown wrote:
> > On 1/28/2020 3:48 PM, Ken Brown wrote:
> > > On 1/28/2020 2:01 PM, Ken Brown wrote:
> > >> On 1/28/2020 12:06 PM, Corinna Vinschen wrote:
> > >>> As outlined on IRC, I found a problem with the ACLs created on new
> > >>> FIFOs and frixed that (I think).  However, Cygwin doesn't actually
> > >>> return the real permissions in stat(), only the constant perms 0666,
> > >>> kind of like for symlinks.  I didn't have time to look into that ye=
t,
> > >>> but it would be great if we could fix that, too.
> > >>
> > >> I'll take a look if you don't get to it first.
> > >=20
> > > Two quick thoughts, and then I won't have time to think about this an=
y more
> > > until tomorrow:
> > >=20
> > > First, I wonder why in fstat_fs we're not using the stat handle (i.e.=
, pc.handle()).
> >=20
> > Ignore this.  I was confused.
> >=20
> > > Second, in the call to get_file_attribute in fstat_helper
> > > (fhandler_disk_file.cc:478), why do we set the first argument to NULL=
 instead of
> > > using our handle?
>=20
> The handle is a pipe handle, not the file handle, and the permissions
> on the pipe handle were not reflecting the permissions on the file.
> The NULL pointer was trying to make sure that the file gets opened
> for fetching the security descriptor in get_file_sd().

I pushed a fix for the permission problem, but I didn't touch the
get_file_attribute() call in fstat_helper.  If you think this can
be further streamlined, go ahead.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--vbzKE9fGfpHIBC6T
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4xlTAACgkQ9TYGna5E
T6ACbxAAl4ABb6zeZtvHgBik24YsDIplTLFLMAfyzJub/oKE7Wj5Bi8br02DdtiY
LZUs9+9xN6ERZbWpy0Z0atBhaFqoa3uP2MPeKI16LR+d4TdORWX3DFmMi9lLOQxn
avg7LxqaZ5HxTndAydnm8awCmMUKl6jVIZY6Lk/umQ/ni3Gita6GEpNeddu4TvVA
T0iNf9O/p3/sqX7vD9KA+tQji2tWig/8/C6hNPH9ib2b5hqWoZuvMRnv3acMRx7X
NRHUCJlxDo4gELsMirH6kqcbFNx1vYBJcxO0TT6pSUQ2dG95E0ceJhU4+3zF9Fl/
r4ZuQjLZ7lh1B1wp+6Au5doppMkPQJ56cIOfam98GwIMf+rzIUnUUFMYkWbl5rI1
GskIb+4pGE40YZY6CEQ4j6Iig8XLCDA5GMDgK5LBHn66raMES3AFjGkaAe0A5ye6
zogWepJr/tvDGCZyznmNIVZUXLjIw7S1Z7WpOpVeKr+mmS05abD8rR3t5dmssc6d
+M1RHwB+XH6c5VxZ/uf3Y+ETIFdjEvcjHE2Po3VjtY4dh/aqx5++ABS1zmxYAOHf
6dMVIUx1CNHfW94jraUbiZd2HC6Y21gkB/+0ZSlbr+7tF1RDchsFboHxUHHaaDge
3ZMWgtraef/VNZTYMI/1rkIHXMvsfaXVfXJptOwbg5vC28n2qWs=
=EAvu
-----END PGP SIGNATURE-----

--vbzKE9fGfpHIBC6T--

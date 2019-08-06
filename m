Return-Path: <cygwin-patches-return-9548-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64904 invoked by alias); 6 Aug 2019 14:18:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64893 invoked by uid 89); 6 Aug 2019 14:18:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*i:sk:b545f4f, H*f:sk:b545f4f
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 06 Aug 2019 14:18:42 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N3bCH-1iLe9P31KV-010alF; Tue, 06 Aug 2019 16:18:36 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CD1C8A80649; Tue,  6 Aug 2019 16:18:35 +0200 (CEST)
Date: Tue, 06 Aug 2019 14:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: exec: check execute bit prior to evaluating script
Message-ID: <20190806141835.GP11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20190806085354.14996-1-corinna@vinschen.de> <b545f4f8-f890-7877-0a00-9634ad369e5f@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="VZLKKa0PG5KXlQhV"
Content-Disposition: inline
In-Reply-To: <b545f4f8-f890-7877-0a00-9634ad369e5f@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00068.txt.bz2


--VZLKKa0PG5KXlQhV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2391

On Aug  6 12:09, Ken Brown wrote:
> On 8/6/2019 4:53 AM, Corinna Vinschen wrote:
> > From: Corinna Vinschen <corinna-cygwin@cygwin.com>
> >=20
> > When the exec family of functions is called for a script-like
> > file, the av::setup function handles the exec[vl]p case as
> > well.  The execve case for files not starting with a she-bang
> > is handled first by returning ENOEXEC.  Only after that, the
> > file's executability is checked.
> >=20
> > This leads to the problem that ENOEXEC is returned for non-executable
> > files as well.  A calling shell interprets this as a file it should try
> > to run as script.  This is not desired for non-executable files.
> >=20
> > Fix this problem by checking the file for executability first.  Only
> > after that, follow the other potential code paths.
> > ---
> >   winsup/cygwin/spawn.cc | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> > index 7f7af4449da1..d95772802f8f 100644
> > --- a/winsup/cygwin/spawn.cc
> > +++ b/winsup/cygwin/spawn.cc
> > @@ -1172,6 +1172,12 @@ av::setup (const char *prog_arg, path_conv& real=
_path, const char *ext,
> >   	  }
> >   	UnmapViewOfFile (buf);
> >     just_shell:
> > +	/* Check if script is executable.  Otherwise we start non-executable
> > +	   scripts successfully, which is incorrect behaviour. */
> > +	if (real_path.has_acls ()
> > +	    && check_file_access (real_path, X_OK, true) < 0)
> > +	  return -1;	/* errno is already set. */
> > +
> >   	if (!pgm)
> >   	  {
> >   	    if (!p_type_exec)
> > @@ -1188,12 +1194,6 @@ av::setup (const char *prog_arg, path_conv& real=
_path, const char *ext,
> >   	    arg1 =3D NULL;
> >   	  }
> >=20=20=20
> > -	/* Check if script is executable.  Otherwise we start non-executable
> > -	   scripts successfully, which is incorrect behaviour. */
> > -	if (real_path.has_acls ()
> > -	    && check_file_access (real_path, X_OK, true) < 0)
> > -	  return -1;	/* errno is already set. */
> > -
> >   	/* Replace argv[0] with the full path to the script if this is the
> >   	   first time through the loop. */
> >   	replace0_maybe (prog_arg);
>=20
> LGTM, and I've confirmed that it fixes the problem reported in=20
> http://www.cygwin.org/ml/cygwin/2019-08/msg00054.html.
>=20
> Ken

Thanks!  Pushed.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--VZLKKa0PG5KXlQhV
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1JjDsACgkQ9TYGna5E
T6ClGg/9EjTNSj0E6la607KTFU/VDU93pARlODmqSLqudbtw7wMLJLx4rAJksEzm
JJ6NeaPYRTO7Boo93aBIbnKkBi6NXsOHJO0N9zONyhWi2qdWe5eoUZOTjPYTWRqa
D4mnjVMi0kvqcq6YN8uofEsuJ5WJO42y03WgamuMy6Oc3GMz8vf3AiQrSW2bnU7x
pztvFR3mzCYvTq1tGtKO5k5qZjxJM7U24qHAqlyc2jk9m/3jZRpAz5B5mOsnNT+B
V+59I4jWAAcgky6DZcJOEtlV5yzqMcrkWOo8o63CNcg9bdNu+SpQlWROvsO5f8MC
h78y3CqmsKHBxhzSWH4CL+wvVrw+XPmWjF69sEf132fmz+BawWoRy43+eKeW6YNM
SPyQPQhFtovbXjKdNjCMktiHdGskXZEHaSPLSEEqRruIKK1EFV6xOCKzrV20yTjJ
xWLdJTvK7a3uVJeG8E1hs3K32+99xx8Njd0fQ4LbKNyTUlRpUCM9w7khkkzScKbt
EUo7+VRpmOtzlw5oWxt4xydZke8TzLY9IYFTSJdmhimMN624XtoZSbrFyQLI+o9E
R40UlP8v0VICeO/WDsA6NLXhPxgbmcOUd4XoFGeHuQ5ng2T6UT14VICviya+KqtG
LBLSdJeQ7gCFr0kRObC/7O9GGkTtnHxCTx9bPeLMovdXzlCGwTc=
=ADmj
-----END PGP SIGNATURE-----

--VZLKKa0PG5KXlQhV--

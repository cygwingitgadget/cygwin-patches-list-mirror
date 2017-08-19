Return-Path: <cygwin-patches-return-8823-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16605 invoked by alias); 18 Aug 2017 15:16:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2886 invoked by uid 89); 18 Aug 2017 15:15:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:3885, neat
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 18 Aug 2017 15:15:41 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 8AB8871B09F0E	for <cygwin-patches@cygwin.com>; Fri, 18 Aug 2017 17:15:26 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 8A0AA5E01D3	for <cygwin-patches@cygwin.com>; Fri, 18 Aug 2017 17:15:25 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 66E93A80990; Fri, 18 Aug 2017 17:15:25 +0200 (CEST)
Date: Sat, 19 Aug 2017 14:29:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: renameat2
Message-ID: <20170818151525.GA6314@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00025.txt.bz2


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 4046

Hi Ken,

On Aug 18 09:21, Ken Brown wrote:
> Linux has a system call 'renameat2' which is like renameat but has an
> extra 'flags' argument.  In particular, one can pass the
> RENAME_NOREPLACE flag to cause the rename to fail with EEXIST if the
> target of the rename exists.  See
>=20
>  http://man7.org/linux/man-pages/man2/rename.2.html
>=20
> macOS has a similar functionality, provided by the function
> 'renameatx_np' with the flag RENAME_EXCL.
>=20
> There's also a recently introduced Gnulib module 'renameat2', but it
> requires two system calls on Cygwin (one to test existence and the
> second to do the rename), so that there is a race condition.  On Linux
> and macOS it uses renameat2 and renameatx_np to avoid the race.
>=20
> The attached patch implements renameat2 on Cygwin (but only supporting
> the RENAME_NOREPLACE flag).  I've written it so that a rename that
> just changes case on a case-insensitive file system succeeds.
>=20
> If the patch is accepted, I'll submit a second patch that documents
> the new function.

Neat stuff, but there are a few points for discussion, see below.

> --- a/winsup/cygwin/include/cygwin/fs.h
> +++ b/winsup/cygwin/include/cygwin/fs.h
> @@ -19,4 +19,9 @@ details. */
>  #define BLKPBSZGET   0x0000127b
>  #define BLKGETSIZE64 0x00041268
>=20=20
> +/* Flags for renameat2, from /usr/include/linux/fs.h. */
> +#define RENAME_NOREPLACE (1 << 0)
> +#define RENAME_EXCHANGE  (1 << 1)
> +#define RENAME_WHITEOUT  (1 << 2)

Given that there's no standard for this call (yet), do we really want to
expose flag values we don't support?  I would opt for only RENAME_NOREPLACE
for now and skip the others.

> +
>  #endif
> diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/inclu=
de/cygwin/version.h
> index efd4ac017..7640abfad 100644
> --- a/winsup/cygwin/include/cygwin/version.h
> +++ b/winsup/cygwin/include/cygwin/version.h
> @@ -481,12 +481,14 @@ details. */
>    314: Export explicit_bzero.
>    315: Export pthread_mutex_timedlock.
>    316: Export pthread_rwlock_timedrdlock, pthread_rwlock_timedwrlock.
> +  317: Export renameat2.  Add RENAME_NOREPLACE, RENAME_EXCHANGE,
> +       RENAME_WHITEOUT.

You can drop the flag values here.  renameat2 is sufficient.

> +rename2 (const char *oldpath, const char *newpath, unsigned int flags)
>  {
>    tmp_pathbuf tp;
>    int res =3D -1;
> @@ -2068,6 +2073,12 @@ rename (const char *oldpath, const char *newpath)
>=20=20
>    __try
>      {
> +      if (flags & ~RENAME_NOREPLACE)
> +	/* RENAME_NOREPLACE is the only flag currently supported. */
> +	{
> +	  set_errno (ENOTSUP);

That should ideally be EINVAL.  Unsupported bit values in a flag argument?
EINVAL, please.

> +	  __leave;
> +	}
>        if (!*oldpath || !*newpath)
>  	{
>  	  /* Reject rename("","x"), rename("x","").  */
> @@ -2337,6 +2348,13 @@ rename (const char *oldpath, const char *newpath)
>  	  __leave;
>  	}
>=20=20
> +      /* Should we replace an existing file? */
> +      if ((removepc || dstpc->exists ()) && (flags & RENAME_NOREPLACE))
> +	{
> +	  set_errno (EEXIST);
> +	  __leave;
> +	}
> +

Do we really need this test here?  If you check at this point and then
go ahead preparing the actual rename operation, you have the atomicity
problem again which renameat2 is trying to solve.

But there's light.  NtSetInformationFile(FileRenameInformation) already
supports RENAME_NOREPLACE :)

Have a look at line 2494 (prior to your patch):

    pfri->ReplaceIfExists =3D TRUE;

if you replace this with something like

    pfri->ReplaceIfExists =3D !(flags & RENAME_NOREPLACE);

it should give us the atomic behaviour of renameat2 on Linux.

Another upside is, the status code returned is STATUS_OBJECT_NAME_COLLISION,
which translates to Win32 error ERROR_ALREADY_EXISTS, which in turn is
already converted to EEXIST by Cygwin, so there's nothing more to do :)

What do you think?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZlwSNAAoJEPU2Bp2uRE+gz4cQAJB24xUgoBNby7UV0/OhNkYd
XVbhhoNfku1wvciDsxZYuQ3cIat7NtDtZLiX7PAEHAtbMkbQJ+KN2WlGr6AHLb5J
/WVsObupFuEN8Qdc1G73Q5THvHXXtqEGW6aSA30vAl6xv4mWPRKES80GaSQd0Hru
2zgL54q12NswrQXx44WUlRuLzzFJbW9YswsQ86fCpx7zIzfuH36Wya3VTWRHuPHL
Y+Nlh4A6fFF8sUzpunvmC8Kn0xRbX/hmIwuYl+iB+gj7JMUR4ujpZYWe42oIIoaV
HVE/G9mNqnw2qo9BV5M6XXZjftiR1ieTOt67GcSfmn+fYMhkvuHTxmKPsthON0W0
Q/k+Nf29OO7waRmCXUBU5cOJ2gq8+Sgsn3yZCvO4ErwdF4nVh6ARuDLwD4Iu4YC4
0eOcYtd71ttKJ8zJ3LdMIr+5enjcMVLpIFD41EKrdHQFSbeJJGRZM9s7eDcmkum/
nIblCsIu4LC+H9c3iejBqAL+/LLuJsD5FCVfkJSQ5wzOlE1bl9Deda7NjzDbxjgg
D0ZiYv6Pd2epViAF9sOvxkDfeYL1WQlSgGKUdWgO/CEymEFtpANx7Cygmu818TQ0
k6u2OHpTFX9kMK6/nkqcLOTfQx5RrKbQoci6GxbDW5dNSONCwA/zqNepGmqlp1DG
Hpm6qCzEkktSofZ0snu3
=i6oU
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

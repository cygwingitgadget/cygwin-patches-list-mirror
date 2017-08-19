Return-Path: <cygwin-patches-return-8825-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 56064 invoked by alias); 19 Aug 2017 09:57:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 55812 invoked by uid 89); 19 Aug 2017 09:57:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=ntfs, NTFS
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 19 Aug 2017 09:57:12 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id DDB9A70F8FC11	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 11:57:08 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id B1AE85E01BE	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 11:57:07 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 903D8A80994; Sat, 19 Aug 2017 11:57:07 +0200 (CEST)
Date: Sat, 19 Aug 2017 16:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: renameat2
Message-ID: <20170819095707.GE6314@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu> <20170818151525.GA6314@calimero.vinschen.de> <f7e3cc27-6989-54d8-8e3e-c11cdd5dfeca@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
In-Reply-To: <f7e3cc27-6989-54d8-8e3e-c11cdd5dfeca@cornell.edu>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00027.txt.bz2


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3881

Hi Ken,

On Aug 18 18:24, Ken Brown wrote:
> Hi Corinna,
>=20
> On 8/18/2017 11:15 AM, Corinna Vinschen wrote:
> > On Aug 18 09:21, Ken Brown wrote:
> > But there's light.  NtSetInformationFile(FileRenameInformation) already
> > supports RENAME_NOREPLACE :)
> >=20
> > Have a look at line 2494 (prior to your patch):
> >=20
> >      pfri->ReplaceIfExists =3D TRUE;
> >=20
> > if you replace this with something like
> >=20
> >      pfri->ReplaceIfExists =3D !(flags & RENAME_NOREPLACE);
> >=20
> > it should give us the atomic behaviour of renameat2 on Linux.
> >=20
> > Another upside is, the status code returned is STATUS_OBJECT_NAME_COLLI=
SION,
> > which translates to Win32 error ERROR_ALREADY_EXISTS, which in turn is
> > already converted to EEXIST by Cygwin, so there's nothing more to do :)
> >=20
> > What do you think?
>=20
> Thanks for the improvements!  A revised patch is attached.  As you'll see=
, I
> still found a few places where I thought I needed to explicitly set the
> errno to EEXIST.  Let me know if any of these could be avoided.

No, you're right.  Just one thing:

> @@ -2410,6 +2433,11 @@ rename (const char *oldpath, const char *newpath)
>  	 unlink_nt returns with STATUS_DIRECTORY_NOT_EMPTY. */
>        if (dstpc->isdir ())
>  	{
> +	  if (noreplace)
> +	    {
> +	      set_errno (EEXIST);
> +	      __leave;
> +	    }
>  	  status =3D unlink_nt (*dstpc);
>  	  if (!NT_SUCCESS (status))
>  	    {
> @@ -2423,6 +2451,11 @@ rename (const char *oldpath, const char *newpath)
>  	 due to a mangled suffix. */
>        else if (!removepc && dstpc->has_attribute (FILE_ATTRIBUTE_READONL=
Y))
>  	{
> +	  if (noreplace)
> +	    {
> +	      set_errno (EEXIST);
> +	      __leave;
> +	    }
>  	  status =3D NtOpenFile (&nfh, FILE_WRITE_ATTRIBUTES,
>  			       dstpc->get_object_attr (attr, sec_none_nih),
>  			       &io, FILE_SHARE_VALID_FLAGS,

Both of the above cases are just border cases of one and the same
problem, the destination file already exists.

In retrospect your original patch was more concise:

+      /* Should we replace an existing file? */
+      if ((removepc || dstpc->exists ()) && (flags & RENAME_NOREPLACE))
+       {
+         set_errno (EEXIST);
+         __leave;
+       }

The atomicity considerations are not affected by this test anyway, but
it would avoid starting and stopping a transaction on NTFS for no good
reason.

Maybe it's better to revert to this test and drop the other two again?

> @@ -2491,11 +2524,15 @@ rename (const char *oldpath, const char *newpath)
>  	  __leave;
>  	}
>        pfri =3D (PFILE_RENAME_INFORMATION) tp.w_get ();
> -      pfri->ReplaceIfExists =3D TRUE;
> +      pfri->ReplaceIfExists =3D !noreplace;
>        pfri->RootDirectory =3D NULL;
>        pfri->FileNameLength =3D dstpc->get_nt_native_path ()->Length;
>        memcpy (&pfri->FileName,  dstpc->get_nt_native_path ()->Buffer,
>  	      pfri->FileNameLength);
> +      /* If dstpc points to an existing file and RENAME_NOREPLACE has
> +	 been specified, then we should get NT error
> +	 STATUS_OBJECT_NAME_COLLISION =3D=3D> Win32 error
> +	 ERROR_ALREADY_EXISTS =3D=3D> Cygwin error EEXIST. */
>        status =3D NtSetInformationFile (fh, &io, pfri,
>  				     sizeof *pfri + pfri->FileNameLength,
>  				     FileRenameInformation);
> @@ -2509,6 +2546,11 @@ rename (const char *oldpath, const char *newpath)
>        if (status =3D=3D STATUS_ACCESS_DENIED && dstpc->exists ()
>  	  && !dstpc->isdir ())
>  	{
> +	  if (noremove)
> +	    {
> +	      set_errno (EEXIST);
> +	      __leave;
> +	    }

Oh, right, that's a good catch.

The patch is ok as is, just let me know what you think of the above
minor tweak (and send the revised patch if you agree).


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZmAtzAAoJEPU2Bp2uRE+gq2EP/1KCN+6JCbymDXZK0R9iDym9
+qgYfRNOI26Kara6qiZlN2T1Xfz+LPmsdgTzskd0XNgsXLUgf3cxf0IzsmwjjBn8
JZ+PThHtWxVFnZEiMCYxfvGssAedk4Pt++kkZEDE6pTzn4BLRLfY2f+eL5QGCHvO
bTJ81lZob12XwB9ZlWo4ojh/aqRD1aT2hLeZ0/EQ8wq4YQyLdhImhXPqXHq5FMrA
9XQSTPhfirki5TLiRTpblfMVhmhspQaH7Kd0TfsdDNefYDxa54JFQq/KNNek+7oQ
0kAzWl86zlBjveBiKfbq9pYMokrCIu6ypRIBZMkxVm5BSNqARUp/5QvmOFJ2ON7V
a0lzI5S7nxWSAp2Ki3kNEkuUsiQt7z+Mdk3NaMkzfYUgyCY61VXj/D6r7YpKNh3S
jtXtTyS1lbX06uuQQGVTwAruWAcAjxKCdO23CQwdf+Q+hyKHtmGaVQ4iiustZ8uh
FeqV2oDIJaC36k3TYEUVo89ISdoBOqQE5v3hhXLcXZLXqPjfoOluUML+AcklrV1y
Edrlcw3v3Kvm5crfENTsrWpUTdVyBFJn3Qf2bCt2qdyGSmTFwodx9Zb5mcQVhV5L
+ub6CLevL/o+4DOkiBiAHSv2n+7Ok/4+ldtyi1yP6m0Rte/RedK7zNfauU+cEvmH
9PBePBw/ZKSC5uP18u0W
=M7mw
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--

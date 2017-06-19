Return-Path: <cygwin-patches-return-8789-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17485 invoked by alias); 19 Jun 2017 11:45:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2171 invoked by uid 89); 19 Jun 2017 11:45:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=lnk, Hx-languages-length:5464, H*c:application, H*Ad:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 19 Jun 2017 11:45:36 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id B225C721E282E	for <cygwin-patches@cygwin.com>; Mon, 19 Jun 2017 13:45:33 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id DAC325E0463	for <cygwin-patches@cygwin.com>; Mon, 19 Jun 2017 13:45:32 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BE42EA8064A; Mon, 19 Jun 2017 13:45:32 +0200 (CEST)
Date: Mon, 19 Jun 2017 11:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Compatibility improvement to reparse point handling, v3
Message-ID: <20170619114532.GC26654@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <594199C4.9080804@pismotec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <594199C4.9080804@pismotec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00060.txt.bz2


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 5863

Hi Joe,

On Jun 14 13:17, Joe Lowe wrote:
> 3rd pass at reparse point handling patch.
>=20
> Changes to this version of the patch.
> 1. Refactored, smaller, less code impact.
> 2. readdir() and stat() consistency changes now also handle native file
> (non-directory) symbolic links. readir() returns DT_REG to match lstat()
> indicating a normal file.

I still have a problem here...

> -/* Check reparse point for type.  IO_REPARSE_TAG_MOUNT_POINT types are
> -   either volume mount points, which are treated as directories, or they
> -   are directory mount points, which are treated as symlinks.
> -   IO_REPARSE_TAG_SYMLINK types are always symlinks.  We don't know
> -   anything about other reparse points, so they are treated as unknown. =
 */
> -static inline uint8_t
> -readdir_check_reparse_point (POBJECT_ATTRIBUTES attr)
> +/* Check reparse point to determine if it should be treated as a posix s=
ymlink
> +   or as a normal file/directory. Mount points are treated as normal dir=
ectories
> +   to match behavior of other systems. Unknown reparse tags are used for
> +   things other than links (HSM, compression, dedup), and generally shou=
ld be
> +   treated as a normal file/directory. Native symlinks and mount points =
are
> +   treated as posix symlinks, depending on the prefix of the target name.
> +   This logic needs to agree with equivalent logic in path.cc
> +   symlink_info::check_reparse_point() .
> +   */
> +static inline bool
> +readdir_check_reparse_point (POBJECT_ATTRIBUTES attr, bool remote)
>  {
> -  uint8_t ret =3D DT_UNKNOWN;

> +  bool ret =3D false;
>    IO_STATUS_BLOCK io;
>    HANDLE reph;
>    UNICODE_STRING subst;
> @@ -185,20 +189,29 @@ readdir_check_reparse_point (POBJECT_ATTRIBUTES att=
r)
>  		      &io, FSCTL_GET_REPARSE_POINT, NULL, 0,
>  		      (LPVOID) rp, MAXIMUM_REPARSE_DATA_BUFFER_SIZE)))
>  	{
> -	  if (rp->ReparseTag =3D=3D IO_REPARSE_TAG_MOUNT_POINT)
> +	  if (!remote && rp->ReparseTag =3D=3D IO_REPARSE_TAG_MOUNT_POINT)
>  	    {
>  	      RtlInitCountedUnicodeString (&subst,
>  		  (WCHAR *)((char *)rp->MountPointReparseBuffer.PathBuffer
>  			    + rp->MountPointReparseBuffer.SubstituteNameOffset),
>  		  rp->MountPointReparseBuffer.SubstituteNameLength);
> -	      /* Only volume mountpoints are treated as directories. */
> -	      if (RtlEqualUnicodePathPrefix (&subst, &ro_u_volume, TRUE))
> -		ret =3D DT_DIR;
> -	      else
> -		ret =3D DT_LNK;
> +	      if (check_reparse_point_target (&subst))
> +	        ret =3D true;
>  	    }
>  	  else if (rp->ReparseTag =3D=3D IO_REPARSE_TAG_SYMLINK)
> -	    ret =3D DT_LNK;
> +	    {
> +	      if (rp->SymbolicLinkReparseBuffer.Flags & SYMLINK_FLAG_RELATIVE)
> +		ret =3D true;
> +	      else
> +		{
> +		  RtlInitCountedUnicodeString (&subst,
> +		      (WCHAR *)((char *)rp->SymbolicLinkReparseBuffer.PathBuffer
> +			    + rp->SymbolicLinkReparseBuffer.SubstituteNameOffset),
> +		      rp->SymbolicLinkReparseBuffer.SubstituteNameLength);
> +		  if (check_reparse_point_target (&subst))
> +		    ret =3D true;
> +		}
> +	    }
>  	  NtClose (reph);
>  	}
>      }
> @@ -1995,8 +2008,7 @@ fhandler_disk_file::readdir_helper (DIR *dir, diren=
t *de, DWORD w32_err,
>    /* Set d_type if type can be determined from file attributes.  For .lnk
>       symlinks, d_type will be reset below.  Reparse points can be NTFS
>       symlinks, even if they have the FILE_ATTRIBUTE_DIRECTORY flag set. =
*/
> -  if (attr &&
> -      !(attr & (~FILE_ATTRIBUTE_VALID_FLAGS | FILE_ATTRIBUTE_REPARSE_POI=
NT)))
> +  if (attr && !(attr & ~FILE_ATTRIBUTE_VALID_FLAGS))

As discussed in the previous iteration of this patch, this change
results in nuking DT_UNKNOWN for reparse points we don't handle.  Still,
IMHO, if we have reparse points we know nothing about, they should stay
DT_UNKNOWN.

Why is changing them to DT_DIR/DT_REG a good idea?  Please convince me.

>      {
>        if (attr & FILE_ATTRIBUTE_DIRECTORY)
>  	de->d_type =3D DT_DIR;
> @@ -2005,19 +2017,22 @@ fhandler_disk_file::readdir_helper (DIR *dir, dir=
ent *de, DWORD w32_err,
>  	de->d_type =3D DT_REG;
>      }
>=20=20
> -  /* Check for directory reparse point. These may be treated as a posix
> -     symlink, or as mount point, so need to figure out whether to return
> -     a directory or link type. In all cases, returning the INO of the
> -     reparse point (not of the target) matches behavior of posix systems.
> +  /* Check for reparse points that can be treated as posix symlinks.
> +     Mountpoints and unknown or unhandled reparse points will be treated
> +     as normal file/directory/unknown. In all cases, returning the INO of
> +     the reparse point (not of the target) matches behavior of posix sys=
tems.
>       */
> -  if ((attr & (FILE_ATTRIBUTE_DIRECTORY | FILE_ATTRIBUTE_REPARSE_POINT))
> -      =3D=3D (FILE_ATTRIBUTE_DIRECTORY | FILE_ATTRIBUTE_REPARSE_POINT))
> +  if (attr & FILE_ATTRIBUTE_REPARSE_POINT)
>      {
>        OBJECT_ATTRIBUTES oattr;
>=20=20
>        InitializeObjectAttributes (&oattr, fname, pc.objcaseinsensitive (=
),
>  				  get_handle (), NULL);
> -      de->d_type =3D readdir_check_reparse_point (&oattr);
> +      /* FUTURE: Ideally would know at this point if reparse point
> +         is stored on a remote volume. Without this, may return DT_LNK
> +         for remote names that end up lstat-ing as a normal directory. */
> +      if (readdir_check_reparse_point (&oattr, false/*remote*/))

The "remote" information is available.  A reparse point is remote
if its parent dir is remote.  At this point in the code we're in the
readdir function of the parent dir.  So you can just use the isremote()
member here.

The rest of the patch looks good to me.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZR7lcAAoJEPU2Bp2uRE+gfyYP/13q1xM7AG83dENlZvWcYVEm
2h84GzB1X8lmSNRh+9EHTmiMobM4Dl0hDJPgCV3D4K2AzC5HeQE5RIQOUr8GTio7
CJKESbkUfzD6jg1BBqK5PAbdzNFl+cKth7UMFWBKfdfjc+SluphiuDs2bRhbzEUh
inObuH2D7tfciRPe08yqcHm+EL7MlRQ3b/9N9F/rJ+VRLns+u6KBv0mtfCum34Fm
2gZQo3kToXinozUf2Rnf4k4wgssRpW9mg+ihtlUf2mte6z0Jud6EBgeJTyOMv8UV
thxAGpCKkFMO/P45XAQNMrkCHk592Ps+Ww+NG9bpbLKkCg+ITqztkkBuNlAJ1LTm
SFsgCuk5lHCSEJ8d+/eNJTPYafhdTKpsKaAJb12D/hdPnSs8lxAQBsz5tDioRGNZ
cELOuqwb3oRVKdt6uwiGvsYmByfR5hR0/gG98KYeRU0eeO2vtec0Ixm2G8nB/Cfm
zs0x10w1yO1I6F9sCjC24S3iiGBPfEQGkHOSRuLGqIrDYn+BpANYOIeh3U556qHv
sOXml8Esjgyh4jhj39+maCo630SZ2a4njK7vzccYZH7RgIXIIbdamzaCabqm+T/u
ezlFV/Z9zrDCPCI+ZbTU15kv0n9NuPxf3e/bCg19ZLGcJhJ/CDEQVljxcoyvXh3s
L39Is6WyB5nTkQutMbl0
=bOwy
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--

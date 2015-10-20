Return-Path: <cygwin-patches-return-8248-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 548 invoked by alias); 20 Oct 2015 09:37:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 478 invoked by uid 89); 20 Oct 2015 09:37:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 20 Oct 2015 09:37:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D2D79A806C9; Tue, 20 Oct 2015 11:37:41 +0200 (CEST)
Date: Tue, 20 Oct 2015 09:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Introduce the 'usertemp' filesystem type
Message-ID: <20151020093741.GA17374@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <0MIuft-1ZZdDB2IaP-002Y2r@mail.gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <0MIuft-1ZZdDB2IaP-002Y2r@mail.gmx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00001.txt.bz2


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 4091

Hi Johannes,


Preliminaries: we need a copyright assignment from you before being able
to include your patches.  Please see https://cygwin.com/assign.txt.

On Sep 16 09:35, Johannes Schindelin wrote:
> 	* mount.cc (mount_info::from_fstab_line): support mounting the
> 	current user's temp folder as /tmp/. This is particularly
> 	useful a feature when Cygwin's own files are write-protected.
>=20
> 	* pathnames.xml: document the new usertemp file system type
>=20
> Detailed explanation:
>=20
> In the context of Windows, there is a per-user directory for temporary
> files, by default specified via the environment variable %TEMP%. Let's
> allow to use that directory for our /tmp/ directory.
>=20
> With this patch, we introduce the special filesystem type "usertemp":
> By specifying
>=20
> 	none /tmp usertemp binary,posix=3D0 0 0
>=20
> in /etc/fstab, the /tmp/ directory gets auto-mounted to the directory
> specified by the %TEMP% variable.

In theory you could also utilize /etc/fstab.d/$USER, without the need to
implement a usertemp mount type.

> This feature comes handy in particularly in scenarios where the
> administrator might want to write-protect the entire Cygwin directory
> yet still needs to allow users to write into the /tmp/ directory.
> This is the case in the context of Git for Windows, where the
> Cygwin (MSys2) root directory lives inside C:\Program Files and hence
> /tmp/ would not be writable otherwise.

You are aware that this breaks interoperability in some cases where
files are shared in /tmp, right?  It's very important to stress the fact
that one user's /tmp is not the same as another user's /tmp when working
on the same machine in this scenario, e.g. via terminal services.
X server sockets won't be in the expected place, etc.  Also, what about
/var/tmp, /var/log, /var/run, /dev/mqueue, /dev/shm?

Creating this kind of mount type only solves part of the problem in this
scenario.  If the Admins insist to install the Cygwin directory
structure in an unexpected way, a full solution appears to be much more
extensive.

Wouldn't it be simpler to install a generic, writable temp dir and just
point to it via standard mount point?

As for the patch itself:

- The ChangeLog entry is missing.

> diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
> index 6cf3ddf..0b3dbdc 100644
> --- a/winsup/cygwin/mount.cc
> +++ b/winsup/cygwin/mount.cc
> @@ -1139,6 +1139,8 @@ mount_info::from_fstab_line (char *line, bool user)
>    unsigned mount_flags =3D MOUNT_SYSTEM | MOUNT_BINARY;
>    if (!strcmp (fs_type, "cygdrive"))
>      mount_flags |=3D MOUNT_NOPOSIX;
> +  if (!strcmp (fs_type, "usertemp"))
> +    mount_flags |=3D MOUNT_IMMUTABLE;
>    if (!fstab_read_flags (&c, mount_flags, false))
>      return true;
>    if (mount_flags & MOUNT_BIND)
> @@ -1163,6 +1165,21 @@ mount_info::from_fstab_line (char *line, bool user)
>        slashify (posix_path, cygdrive, 1);
>        cygdrive_len =3D strlen (cygdrive);
>      }
> +  else if (!strcmp (fs_type, "usertemp"))
> +    {
> +      WCHAR tmp[MAX_PATH];
> +
> +      if (GetEnvironmentVariableW (L"TEMP", tmp, sizeof(tmp)) && *tmp)

- Maybe using GetTempPathW instead?  It always returns a path.

> +	{
> +          DWORD len;
> +          char mb_tmp[len =3D sys_wcstombs (NULL, 0, tmp)];

- len =3D sys_wcstombs() + 1

  Alternatively, use tmp_pathbuf:

  tmp_pathbuf tp;
  char mb_tmp =3D tp.c_get ();

> +          sys_wcstombs (mb_tmp, len, tmp);
> +
> +	  int res =3D mount_table->add_item (mb_tmp, posix_path, mount_flags);
> +	  if (res && get_errno () =3D=3D EMFILE)
> +	    return false;
> +	}
> +    }
>    else
>      {
>        int res =3D mount_table->add_item (native_path, posix_path, mount_=
flags);

- What about adding a mount flags to allow fillout_mntent to print out
  the mount type?  This isn't essential, I'm just wondering if there
  might be a good reason to see the type in mount(1) output.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWJgtlAAoJEPU2Bp2uRE+g7tUP/idqJ+Hdc/Ii+Y0zuldGgWdq
XVtvZwa19+oeSGAqMzpYXqUkKZ+IXdtc6hkirGCaj9ocBviFdg0agNE+kfR19Krh
Bt/0EK6X/ZsBo9XQGs0sqwwGULurKoRNdMU8FF5iu7bcBhD5x0eWRns3KtPSGPKD
G8EqY7FFtoxPWRXBfw/bXBUoThwPemqpMw/K5+RQaw6OIx6+yilzxlziUgGXR9xH
T2rLldztdqUEhni+BoHl1qG32A62xl87Rts86E3PHBz/yOwjcgRi94H/nYa7VRsx
AStTiaPq2qxMQivaFdFehcA4YXcxnGlzvbOCTD80kcsDLCwjs1FlgyG43FAWnXxl
zm9tdS49XgtBeODj8mUtbgbNg0otA6CEp7M4Y649hwmJzZLiU5jhsdjtPabadzhC
S3kp4IXF+Gp70HA+reQOOKGlkw+ejo6+V39aem8w1pjvS2MEevyvCyqIWxdi6qef
7KorHw5JPMkvUOCs7XYNRMVEzGcW0z1tyjfv0rYhlZZ1rZO0VGAoTJe9s+dWtUL7
oFWOpv3zlFBAbCC+MYC/1cFV+JSP2fWeDm9dm10ocTzdm6a9Rcc2VG+A4hDNZQ4W
fheoJnSO97+SE2viNYFkCcxk3AL+gqDhCX4XYmMXf87/r+f8CR6Vs/bvUc7/KppL
KShdK4UiBZP4hwrGCxnD
=KRtp
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

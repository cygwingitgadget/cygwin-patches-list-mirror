Return-Path: <cygwin-patches-return-8626-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 84368 invoked by alias); 1 Sep 2016 13:33:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 84344 invoked by uid 89); 1 Sep 2016 13:33:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 01 Sep 2016 13:33:03 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 7CF30721E280D	for <cygwin-patches@cygwin.com>; Thu,  1 Sep 2016 15:32:56 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 994025E051D	for <cygwin-patches@cygwin.com>; Thu,  1 Sep 2016 15:32:55 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8B264A804AE; Thu,  1 Sep 2016 15:32:55 +0200 (CEST)
Date: Thu, 01 Sep 2016 13:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/4] dlopen: on x/lib search x/bin if exe is in x/bin
Message-ID: <20160901133255.GC1128@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1472666829-32223-4-git-send-email-michael.haubenwallner@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
In-Reply-To: <1472666829-32223-4-git-send-email-michael.haubenwallner@ssi-schaefer.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
X-SW-Source: 2016-q3/txt/msg00034.txt.bz2


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3117

Hi Michael,

On Aug 31 20:07, Michael Haubenwallner wrote:
> citing https://cygwin.com/ml/cygwin-developers/2016-08/msg00020.html
> > Consider the file /usr/bin/cygz.dll:
> > - dlopen (libz.so)            success
> > - dlopen (/usr/bin/libz.so)   success
> > - dlopen (/usr/lib/libz.so)   fails
>=20
> * dlfcn.c (dlopen): For dlopen("x/lib/N"), when the application
> executable is in "x/bin/", search for "x/bin/N" before "x/lib/N".
> ---
>  winsup/cygwin/dlfcn.cc | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
> index e592512..f8b8743 100644
> --- a/winsup/cygwin/dlfcn.cc
> +++ b/winsup/cygwin/dlfcn.cc
> @@ -153,6 +153,25 @@ collect_basenames (pathfinder::basenamelist & basena=
mes,
>    basenames.appendv (basename, baselen, ext, extlen, NULL);
>  }
>=20=20
> +/* Identify dir of current executable into exedirbuf using wpathbuf buff=
er.
> +   Return length of exedirbuf on success, or zero on error. */
> +static int
> +get_exedir (char * exedirbuf, wchar_t * wpathbuf)
> +{
> +  /* Unless we have a special cygwin loader, there is no such thing like
> +     DT_RUNPATH on Windows we can use to search for dlls, except for the
> +     directory of the main executable. */
> +  GetModuleFileNameW (NULL, wpathbuf, NT_MAX_PATH);
> +  wchar_t * lastwsep =3D wcsrchr (wpathbuf, L'\\');
> +  if (!lastwsep)
> +    return 0;
> +  *lastwsep =3D L'\0';
> +  *exedirbuf =3D '\0';
> +  if (cygwin_conv_path (CCP_WIN_W_TO_POSIX, wpathbuf, exedirbuf, NT_MAX_=
PATH))
> +    return 0;
> +  return strlen (exedirbuf);
> +}

You could just use the global variable program_invocation_name.  If in
doubt, use the Windows path global_progname and convert it to full POSIX
via cygwin_conv_path.

>  extern "C" void *
>  dlopen (const char *name, int flags)
>  {
> @@ -184,13 +203,28 @@ dlopen (const char *name, int flags)
>        /* handle for the named library */
>        path_conv real_filename;
>        wchar_t *wpath =3D tp.w_get ();
> +      char *cpath =3D tp.c_get ();
>=20=20
>        pathfinder finder (allocator, basenames); /* eats basenames */
>=20=20
>        if (have_dir)
>  	{
> +	  int dirlen =3D basename - 1 - name;
> +
> +	  /* if the specified dir is x/lib, and the current executable
> +	     dir is x/bin, do the /lib -> /bin mapping, which is the
> +	     same actually as adding the executable dir */
> +	  if (dirlen >=3D 4 && !strncmp (name + dirlen - 4, "/lib", 4))
> +	    {
> +	      int exedirlen =3D get_exedir (cpath, wpath);
> +	      if (exedirlen =3D=3D dirlen &&
> +		  !strncmp (cpath, name, dirlen - 4) &&
> +		  !strcmp (cpath + dirlen - 4, "/bin"))
> +		finder.add_searchdir (cpath, exedirlen);
> +	    }
> +
>  	  /* search the specified dir */
> -	  finder.add_searchdir (name, basename - 1 - name);
> +	  finder.add_searchdir (name, dirlen);
>  	}
>        else
>  	{
> --=20
> 2.7.3

Rest looks ok.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXyC4HAAoJEPU2Bp2uRE+gMDAQAJW9zLgtqCdrLsxOo/8OT+Sx
aeP8VSW/XAP3u8I6KN5JBdK/mwSf0blN1kKxEwslel6wywVu87Us7Uk1kpilTUxI
OmJSYtPgVjPMHFvuXHQwNMOMJlvrpwz/uO7OVxlcxpWjjHVp8jOqw8xrYyLQCSxf
Yo7hmvOP0nkegB8ftaDvTFiXMxinYXmrVPXES2XA/LgsjCyskgp2hIWnq3sJkJPL
KjAPtD6VH1BdFh9QaTYUAsyFf2u8JloEmHdJOvuuhoaBYxWRl/WAiuGJJTsPdwVT
h5pPf9DiKurGpIYw2G/T6tMpL+GUGOoLOh5Uv254v6qOoNIrWiDBGiiScVQ3HFL/
bWGiyKt79rTdNVTlqv9v6RjW36KeVcGlH3INSXMtE4S28/4Jx1oDDoxV7a0egqqg
LCgRTtS0RteavxrWokWfqWfXyTBpfyBqjKujhF+hnskQJ0aoYf5gP4M2lFIdFW+A
G60N5Cy0uXBTgiao+RbKoaqQsuBPs5b6HZaymyCdr0bOCD4tmyvzKTO+1DSon76/
anxSspsuzXRRGDcU3t/NKen1dHeHiSpwoWPiPUpo67fea+HE1osTKjTnprRinD+L
gp2kOZVGeG4h7Uh6XNt58OwwH0T8CYO+Oh41WRCN2BrKYKfYG2tEi/Kdf5Aq7zbW
xaaLf6k+5A4ILLkUAaev
=l/f9
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--

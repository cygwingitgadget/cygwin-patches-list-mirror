Return-Path: <cygwin-patches-return-8629-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51382 invoked by alias); 1 Sep 2016 14:05:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51362 invoked by uid 89); 1 Sep 2016 14:05:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 01 Sep 2016 14:05:40 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 2E3BA721E280D	for <cygwin-patches@cygwin.com>; Thu,  1 Sep 2016 16:05:27 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id A02835E051D	for <cygwin-patches@cygwin.com>; Thu,  1 Sep 2016 16:05:26 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9EDBDA804AE; Thu,  1 Sep 2016 16:05:26 +0200 (CEST)
Date: Thu, 01 Sep 2016 14:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/4] dlopen: on unspecified lib dir search exe dir
Message-ID: <20160901140526.GF1128@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1472666829-32223-5-git-send-email-michael.haubenwallner@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline
In-Reply-To: <1472666829-32223-5-git-send-email-michael.haubenwallner@ssi-schaefer.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
X-SW-Source: 2016-q3/txt/msg00037.txt.bz2


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1454

On Aug 31 20:07, Michael Haubenwallner wrote:
> Applications installed to some prefix like /opt/application do expect
> dlopen("libAPP.so") to load "/opt/application/bin/cygAPP.dll", which
> is similar to "/opt/application/lib/libAPP.so" on Linux.
>=20
> See also https://cygwin.com/ml/cygwin-developers/2016-08/msg00020.html
>=20
> * dlfcn.cc (dlopen): For dlopen("N"), search directory where the
> application executable is in.
> ---
>  winsup/cygwin/dlfcn.cc | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
> index f8b8743..974092e 100644
> --- a/winsup/cygwin/dlfcn.cc
> +++ b/winsup/cygwin/dlfcn.cc
> @@ -232,6 +232,12 @@ dlopen (const char *name, int flags)
>  	     not use the LD_LIBRARY_PATH environment variable. */
>  	  finder.add_envsearchpath ("LD_LIBRARY_PATH");
>=20=20
> +	  /* Search the current executable's directory like
> +	     the Windows loader does for linked dlls. */
> +	  int exedirlen =3D get_exedir (cpath, wpath);
> +	  if (exedirlen)
> +	    finder.add_searchdir (cpath, exedirlen);
> +
>  	  /* Finally we better have some fallback. */
>  	  finder.add_searchdir ("/usr/bin", 8);
>  	  finder.add_searchdir ("/usr/lib", 8);
> --=20
> 2.7.3

Still not quite sure if that's the right thing to do...


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXyDWmAAoJEPU2Bp2uRE+gKccP/12mLeXW/if0yAktpH7T2IHY
RocYENqky9jNagUw7XXD9E9+5savDmPyfwR9wLAI9GwpIK8tYqqJCjF2QUNWCD50
c0+x1Byz/6BR0370ORPnhieeLw0ADF0yNGbuYoDuG75SAOqyXZXyfN9IIJ/Op+iQ
/8Zq5cB+z4vt16wFpW2/xQDbrMDg+7tIGg747tfgXffXL0WJ1KFMgNETgJ33anyL
2DEbCHxtulBfERoXBNg86mNm+RFLPBCUXunW++oqIadQBjQI7yYwr9nV5DO6NfY4
WXxy71TnWEN3IHP6Ij9u4Frpf40vbAJjo00E4isHRAU44kJoaexqLgQpsaYF29eT
tK1EAjErA8OzbOvWpmO+TTtzwRSG3EdYZrv22Z3g6jieYoKxfHIk1mU2SUJJQ2D8
qs9npZSy5Xkg5PslyIPSCj8oqQVX06ageDlvgf5XPJQP5f3Isp7poogouZRNQEsY
Kn5peawVGBCfaN1XK3YyYbfDdkg8npX3OKY3w+sZRxpIPxT4ea6eR1SByxduVtu7
jmMtYC7XqFMeWValgNOZUywshSyzCy8j7SRwlldI1O4nuOnTNkdrODmgzLATm1+Y
k+zF/QipVOolust2yGM/YG2Odpbm2rojSzGB8CLubMmvZXMfi69TqmPgP59kNFIL
siof11yyxZ4th7InFDQt
=bJnV
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--

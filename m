Return-Path: <cygwin-patches-return-8136-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29619 invoked by alias); 27 Apr 2015 09:33:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29502 invoked by uid 89); 27 Apr 2015 09:33:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Apr 2015 09:33:22 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2EAF2A80970; Mon, 27 Apr 2015 11:33:20 +0200 (CEST)
Date: Mon, 27 Apr 2015 09:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] * cygserver.xml: Add new section. How to install Cygserver.
Message-ID: <20150427093320.GT3657@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1430124378-16484-1-git-send-email-mikedep333@gmail.com> <1430124378-16484-2-git-send-email-mikedep333@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="t1cwe7X0UXDc61Gr"
Content-Disposition: inline
In-Reply-To: <1430124378-16484-2-git-send-email-mikedep333@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00037.txt.bz2


--t1cwe7X0UXDc61Gr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1030

On Apr 27 04:46, Mike DePaulo wrote:
> ---
>  winsup/doc/cygserver.xml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/winsup/doc/cygserver.xml b/winsup/doc/cygserver.xml
> index 6a4ec4e..2367a60 100644
> --- a/winsup/doc/cygserver.xml
> +++ b/winsup/doc/cygserver.xml
> @@ -179,6 +179,19 @@
>=20=20
>  </sect2>
>=20=20
> +<sect2 id=3D"install-cygserver"><title>How to install Cygserver</title>
> +
> +<para>
> +  Cygserver is part of the base <emphasis role=3D'bold'>cygwin</emphasis=
> package.
> +  Therefore, whenever Cygwin is installed, so is Cygserver.
> +</para>
> +<para>
> +  You may want to install Cygserver as a service. See
> +  <xref linkend=3D"start-cygserver"></xref>.
> +</para>
> +
> +</sect2>
> +
>  <sect2 id=3D"start-cygserver"><title>How to start Cygserver</title>
>=20=20
>  <para>
> --=20
> 2.1.4

Patch applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--t1cwe7X0UXDc61Gr
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVPgJgAAoJEPU2Bp2uRE+gTfEP/RuXacbTKKEkY9NGtVljLiaV
ZJS6HJ41dbuS2HpmUhTjBDIXGYBoqHWMEpgCPjFOWNg+SqF9TgA++7Pigi4CcnvR
nfLYC8bf7yYFDj45pmH6ohuTN3lpItSAusK3w+UQkncACKuSWF5XRMGa9ml6kdq8
rVhkFKdBpfaBt0RvT4h/YpFt4ph2rUnXBkxxu1cQr5FViNGDKKFM0Xa/L9kVsgOh
5/KEEBiv8W8IIFcT1O+ULQVVGUZ9LuLsBUumV7+/DAky9mlYUwJjx9NDUqH16Sm/
nITlErFFCBn91CUHeGoWb0w34vQ/jG0wag/3r0cUmKZDiXJtrH+b/8w9PLnlIXc5
jwDf9VLoIrmu1w8bUwpgwCkHnr4xRDNLcRzmaGDxCkxly1kU34O0q8h2tqI3oknM
Ds15t/7p5eUNKX8PKtRYnU7DxDHwilDxFrVJjo3+YMhEGMvEa36xLqCQzd9r1+EH
98/EF1d34oPlmF+/7SRKBPJaOyVmnyCpjVax1vnKfrqjod37D5TFIEPzFi32vUsz
aEvJ6kkNw30XcE5lpg6YseFi9N30UZsICUDBiLMK4lUSIDTxf8f8O9J7noD8AjNb
bws1Knt8U2bbI3uOQR9MkZn7Cu+yqi7APpl7fe8QFXahxKbmKPHj0v00CJN+Jinb
p5MgVvyihFHaMRo0HO1M
=l5uc
-----END PGP SIGNATURE-----

--t1cwe7X0UXDc61Gr--

Return-Path: <cygwin-patches-return-8892-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 111168 invoked by alias); 2 Nov 2017 15:06:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 111100 invoked by uid 89); 2 Nov 2017 15:06:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-125.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Nov 2017 15:06:07 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id C372D721E2830	for <cygwin-patches@cygwin.com>; Thu,  2 Nov 2017 16:06:04 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 2D4A05E038E	for <cygwin-patches@cygwin.com>; Thu,  2 Nov 2017 16:06:04 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1C925A805B7; Thu,  2 Nov 2017 16:06:04 +0100 (CET)
Date: Thu, 02 Nov 2017 15:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] posix_fallocate() *returns* error codes but does not set errno
Message-ID: <20171102150604.GF8599@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171102141512.4732-1-erik.m.bray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline
In-Reply-To: <20171102141512.4732-1-erik.m.bray@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00022.txt.bz2


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 987

Hi Erik,

On Nov  2 15:15, Erik M. Bray wrote:
> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler=
_disk_file.cc
> index f46e355..9d5ec30 100644
> --- a/winsup/cygwin/fhandler_disk_file.cc
> +++ b/winsup/cygwin/fhandler_disk_file.cc
> @@ -1116,11 +1116,11 @@ fhandler_disk_file::ftruncate (off_t length, bool=
 allow_truncate)
>    int res =3D -1;

Shouldn't this initialization to -1 go away then?  Or set to 0 and...

> @@ -1160,7 +1159,7 @@ fhandler_disk_file::ftruncate (off_t length, bool a=
llow_truncate)
>  				     &feofi, sizeof feofi,
>  				     FileEndOfFileInformation);
>        if (!NT_SUCCESS (status))
> -	__seterrno_from_nt_status (status);
> +	res =3D geterrno_from_nt_status (status);
>        else
>  	res =3D 0;

...this else branch go away like you did in posix_fallocate?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ+zRbAAoJEPU2Bp2uRE+gF3IP/3Cr9rw4npsxENIUq6uwiqBi
s+ICyjqo+B6GPZw+UO/OkMFF5C131s4WD2r2LTbvIKY7yo8GaFPHe/lESu8KnyDT
k38JZiGEiSPR7DDc1Aw8WN8rC/qDZDnQ97QI32czUaHA7xL9ZT58FYmtfPM0rPb9
LLGzlG3fSAJ0jpohHXhnLh2hmbw4GSE4bYT1dKyyr08m25JROATaXve3DopVcpUG
LZD93toPxEyWM7U7212Q2N4l1ZbDb1p/Y0/vIqBpHUK6gF582FTcg44qOELX3Ang
rueTXRph+8LWUVOpuWQ4EJdLuE7nwcVP1RUsi+Wi/X5fcJR5VaEGJ8hhDm/wqnjW
TnUwsStN08vv9mEFYxKl8cEH4gHAK8IvP8I/Is3iZwHzsEehKudMIl7ZD4wEP+g9
vIPdVIJbrj089QzTBe4POaQGwnT8huF5KFS4Q9saDMMAHVqb571/U8aH7WC2kyA+
L+XYIjWbk7gt3Q6Ak6lKJ40b01oXwyg7+Xj0gnNCqlbObiBBI/SEBNMtBFvI17yZ
5OYyNKaVJ2QZP1Tif77pn2iqj1usEBTtbp20gx4kiYSDS9Utt8Fqd+IJQSGfbrUq
MKARWyoa/c1XvIn70PyUwJ+x77CWSczASbvlOo0BiF2ZENOWvcwDwwNQSyF4xKHl
IFQa9bemzGMNp+DqLZMn
=zeML
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--

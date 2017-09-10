Return-Path: <cygwin-patches-return-8848-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24782 invoked by alias); 2 Sep 2017 07:45:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24672 invoked by uid 89); 2 Sep 2017 07:45:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=para, consent, H*R:D*cygwin.com, H*Ad:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 02 Sep 2017 07:44:57 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 4F67870F7EC0A	for <cygwin-patches@cygwin.com>; Sat,  2 Sep 2017 09:44:49 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 5C7E35E0404	for <cygwin-patches@cygwin.com>; Sat,  2 Sep 2017 09:44:48 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 46006A8073C; Sat,  2 Sep 2017 09:44:48 +0200 (CEST)
Date: Sun, 10 Sep 2017 04:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: Document crypt_r
Message-ID: <20170902074448.GN14109@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170901222718.19076-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline
In-Reply-To: <20170901222718.19076-1-yselkowi@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00050.txt.bz2


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 864

On Sep  1 17:27, Yaakov Selkowitz wrote:
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/doc/posix.xml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> index 6e96272b7..c99e003ba 100644
> --- a/winsup/doc/posix.xml
> +++ b/winsup/doc/posix.xml
> @@ -1286,6 +1286,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
>      clog10
>      clog10f
>      clog10l
> +    crypt_r			(available in external "crypt" library)
>      dladdr			(see chapter "Implementation Notes")
>      dremf
>      dup3
> --=20
> 2.14.1

Sure, go ahead.  You can apply stuff like that without waiting for
my consent, Yaakov, no worries here.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZqmFwAAoJEPU2Bp2uRE+gKJgQAKEtq2k6NdLTjLheRMM12jmZ
DcUKllnw2Axxf0LqscZGosQG1KUodOHHNP5dgPT9dYJD9XGbsUSBo3VSZgNQqmo2
XWv5teXieJRCAk/gBxCLsZi187e0TbREQ5S6j3F0OnSllSXemQtFh9fdd1ZBg80M
LcCNEWkBa4IcFdjDLb1GuDKuLYcHUexLnoKXxj4TbjwaeHFVM74NIDJjZLbg0j98
P4bsgAYU2zTZ7Ap0isnSSn3WeJxycJNlRDEN8IqjakkNhcB7wpdWaaX/MeuGamQ1
qXaFxWgEfhmYvj6YkamcUdJkI2HIFcmylZUUU3fzlL7OyF3zPUbz6QXdcHZIHa55
B83KoVlsSZvcs8bPq03OFTsXlUQ0EBHc7Jiz7gxReBeBnWIXI4WEj3hFKpbffCN6
q/K3ddKxlLtyuqM2DKN24T13wGGhing7CsMyf/MmhJ/O9poaPrjVAAv7qaaa8AJd
jNWVSOyo5STRR7MkqOJNxrdD9XqSMve7Ellsf5izwFLw2fwQK72ZDzVBmj0rdl7Q
k+X9XX8w6cZmNQnABAyFdW27A5aO5lqvZrw4yxahsmIwEuJLfg/4xcBKCWTxETwg
/rqT+IVFohVozpKoieG1/UeWk1Z+fGJL/Ja91Y73d/VHGaKnsP/lMwZ+99KoONdz
F7B/XoJmWlM5rTSQ8CfI
=DXqZ
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--

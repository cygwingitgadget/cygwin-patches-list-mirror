Return-Path: <cygwin-patches-return-8850-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 84251 invoked by alias); 2 Sep 2017 19:02:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 84225 invoked by uid 89); 2 Sep 2017 19:02:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=para, click, H*R:D*cygwin.com, services
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 02 Sep 2017 19:02:00 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 8A0A9721E2822	for <cygwin-patches@cygwin.com>; Sat,  2 Sep 2017 21:01:53 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 9D2575E01D5	for <cygwin-patches@cygwin.com>; Sat,  2 Sep 2017 21:01:52 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8808AA80670; Sat,  2 Sep 2017 21:01:52 +0200 (CEST)
Date: Wed, 13 Sep 2017 21:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Remove some dangerous advice from the FAQ
Message-ID: <20170902190152.GA5769@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <87pob95gns.fsf@Rainer.invalid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <87pob95gns.fsf@Rainer.invalid>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00052.txt.bz2


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2408

On Sep  2 16:17, Achim Gratz wrote:
> >From f19ff76eb48e82dcc15fd02bc97a503f1f4a3344 Mon Sep 17 00:00:00 2001
> From: Achim Gratz <Stromeko@Stromeko.DE>
> Date: Sat, 2 Sep 2017 16:14:02 +0200
> Subject: [PATCH] Remove some dangerous advice from the FAQ
>=20
> ---
>  winsup/doc/faq-setup.xml | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/winsup/doc/faq-setup.xml b/winsup/doc/faq-setup.xml
> index 3917f2d30..b242fbae4 100644
> --- a/winsup/doc/faq-setup.xml
> +++ b/winsup/doc/faq-setup.xml
> @@ -610,16 +610,20 @@ folders that are causing the error.  For example, s=
ometimes files used by
>  system services end up owned by the SYSTEM account and not writable by r=
egular
>  users.</para>
>  <para>The quickest way to delete the entire tree if you run into this pr=
oblem
> -is to change the ownership of all files and folders to your account.  To=
 do
> +is to take ownership of all files and folders to your account.  To do
>  this in Windows Explorer, right click on the root Cygwin folder, choose
>  Properties, then the Security tab.  If you are using Simple File Sharing=
, you
>  will need to boot into Safe Mode to access the Security tab.  Select Adv=
anced,
>  then go to the Owner tab and make sure your account is listed as the own=
er.
>  Select the 'Replace owner on subcontainers and objects' checkbox and pre=
ss Ok.
>  After Explorer applies the changes you should be able to delete the enti=
re tree
> -in one operation.  Note that you can also achieve this in Cygwin by typi=
ng
> -<literal>chown -R user /</literal> or by using other tools such as
> -<literal>icacls.exe</literal>.=20
> +in one operation.  Note that you can also achieve by using other tools s=
uch as
> +<literal>icacls.exe</literal> or directly from Cygwin by using
> +<literal>chown</literal>.  Please note that you shouldn't use the
> +recursive form of chown on directories that have other file systems
> +mounted under them (specifically you must avoid
> +<literal>/proc</literal>) since you'd change ownership of the files unde=
r those
> +mount points as well.
>  </para>
>  </listitem>
>  <listitem><para>Delete the Cygwin shortcuts on the Desktop and Start Men=
u, and
> --=20
> 2.14.1
>=20

Pushed.

Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZqwAgAAoJEPU2Bp2uRE+gtCAQAJIdIkVmEsGO/zJXboo8p4gF
JI0WfZUbsoM3GqXerxvnHK+RbU/zMhw6Jc2phIcdE5NWRKVNBxrCoOYsiwEmyF5p
N4pP15MG7fotc7hm862Zd4x6LV3oKG36KkUqaC9Z1CGRpSL354mOtKiHQmrkpsTT
fnn10pqYlSmiaLg4XLmGU7g8LN8NwjAsBrjisEA5X41wZNzCch82zIRJ9IK3FNl0
lPkuNPgsXV/VwqtkVkSQFee/kKKmtVK3TlXK0+bFM+/kewkB83INt+/LYvFu/vcb
jAQQd4PhHG1L4fIjmZ/U3g0sbvqV1ce2GVHlAVnGcU/PaomfX/OBL0ulo8W0kBnL
XU/xcZMRVhcu5ATO0jkHaSrTiF/WzW/DtTru7iWfe1wAnjh1fWkHPHdh61AOmj3M
6YZs+ppuMZwtHFFacIb1Efy86o2n7MWjHt5Waa7LyJ0m4ZFz4jw9l3N9b64pGKGo
EdH/8nKjtb+7jMG0X3NaBIi/V4xN5dZ3EO8M2A8IA8Mo5BPlzXtL/7vn54+Jy5aZ
pNkMlITaLg78EH8Pv6rJiIkrW4pYGsL4xGtuWvEbmMT4yY+AO1bxsZEBguuxjIE3
xnth06R1qbH8sXhXZ0duwn8jzAxe/i8sXfDmJAXXo6socPmIZr40FOm7vf7fgsGf
Lww8n3NQan9SI+H3DcrV
=IbOa
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

Return-Path: <cygwin-patches-return-9821-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35619 invoked by alias); 11 Nov 2019 09:13:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35549 invoked by uid 89); 11 Nov 2019 09:13:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-114.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, H*Ad:U*cygwin-patches, HX-Envelope-From:sk:corinna, completion
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 11 Nov 2019 09:13:41 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MsZeX-1hbaIr1Pcx-00u0xJ for <cygwin-patches@cygwin.com>; Mon, 11 Nov 2019 10:13:38 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AFB33A806F4; Mon, 11 Nov 2019 10:13:37 +0100 (CET)
Date: Mon, 11 Nov 2019 09:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] regtool: Ignore /proc/registry{,32,64}/ prefix, with forward or backslashes, allowing path completion
Message-ID: <20191111091337.GE3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191110161445.53479-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="h1wVxq8aeHrvhZJz"
Content-Disposition: inline
In-Reply-To: <20191110161445.53479-1-Brian.Inglis@SystematicSW.ab.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00092.txt.bz2


--h1wVxq8aeHrvhZJz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1431

Hi Brian,


The patch idea is nice.  Two nits, though.

Please shorten the commit msg summary line and add a bit of descriptive
text instead.


On Nov 10 09:14, Brian Inglis wrote:
> ---
>  winsup/utils/regtool.cc | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/utils/regtool.cc b/winsup/utils/regtool.cc
> index a44d90768..ddb1304cd 100644
> --- a/winsup/utils/regtool.cc
> +++ b/winsup/utils/regtool.cc
> @@ -167,7 +167,9 @@ usage (FILE *where =3D stderr)
>        "  users    HKU   HKEY_USERS\n"
>        "\n"
>        "If the keyname starts with a forward slash ('/'), the forward sla=
sh is used\n"
> -      "as separator and the backslash can be used as escape character.\n=
");
> +      "as separator and the backslash can be used as escape character.\n"
> +      "If the keyname starts with /proc/registry{,32,64}/, using forward=
 or backward\n"
> +      "slashes, allowing path completion, that part of the prefix is ign=
ored.\n");

Is that really essential user information?

I assume this behaviour is something you just expected to work but then
didn't.  With your patch it now works as you expected.  So it's kind of
a bugfix, rather than a change of behaviour the user needs to learn about.

The above text is, IMHO, more confusing than helpful to a user just
asking for regtool --help.  I'd just drop it.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--h1wVxq8aeHrvhZJz
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3JJkEACgkQ9TYGna5E
T6Dg+RAAiAhynG+bDw1XunF6wX+C15LK7ApaJhfsSyzW8EeScOxUuXvIPkhpIAAi
LRNCQ9wd90Pgx7BoT/loZYwcrG4lk4RxU4ypzWfGtVgNf4q0OxppKs/VSgFyrcig
HdonZRS6JMgIg6U8TpzKOv5RYckyicRkGmWSYMYUg8xfEnd/WQkMotN+kEdaG7fs
jKXTldeLSaoYMVEEEB5yxFM4JtAIeO4jGY5rrC30Q9sgD9nSjkgH7SgkSUbcO8Bd
CEoEL+m01XUgNhJNfFJet8WW60KTwZHM2LadPEioFpb0UJql0+tOF/IheOQ+YqHT
HtbE2fjS1fk0R9iCHYcGT0SwgAm64qsl8kjlBNH3mSVMy4bRnqWJ8G0ak268Iz09
ZKqNPtINXEaPQ0zzdmJpU+KrMEe+4QTLvCRnGIv2D1aRkKaJHaNe/wqK87LFW7sp
veWhu/jeZ3ZD3odQlCLkBF5a9dLBp3u+hJXir6zVIY3KHn0QDxmDeA+x+/i9mBQH
hT4msmMjWh4rrOZZ9+6L6ezKB9d7FAkaBT6jf+NutwQm52Tt2eFyjvZiZGkrE6bX
uU7I1taXY9GDzZCtxA2v40MoTR3oa5RLLtPE3GtdOlGKfp3e2fGXazjuoMQQZPrB
01L/mhwaov1YFilu+ick/od4L0mcPvpWFA/hCAp3fnKmW7RhKos=
=LuQe
-----END PGP SIGNATURE-----

--h1wVxq8aeHrvhZJz--

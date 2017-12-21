Return-Path: <cygwin-patches-return-8984-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30084 invoked by alias); 21 Dec 2017 09:44:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30041 invoked by uid 89); 21 Dec 2017 09:44:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-122.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=PDF, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 21 Dec 2017 09:43:56 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 80F69721E281E	for <cygwin-patches@cygwin.com>; Thu, 21 Dec 2017 10:43:52 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id DDAC85E02F2	for <cygwin-patches@cygwin.com>; Thu, 21 Dec 2017 10:43:51 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5A8F0A80612; Thu, 21 Dec 2017 10:43:52 +0100 (CET)
Date: Thu, 21 Dec 2017 09:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/doc/etc.postinstall.cygwin-doc.sh fix shell variable typo
Message-ID: <20171221094352.GI19986@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171220230153.8512-1-Brian.Inglis@SystematicSW.ab.ca> <0a3543fb-d85a-90c5-65f0-dedbaee5ad28@redhat.com> <66aa6880-5c66-7b02-12bf-9550a54b9f8f@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <66aa6880-5c66-7b02-12bf-9550a54b9f8f@SystematicSw.ab.ca>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00114.txt.bz2


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1650

On Dec 20 19:26, Brian Inglis wrote:
> On 2017-12-20 16:10, Eric Blake wrote:
> > On 12/20/2017 05:01 PM, Brian Inglis wrote:
> >> ---
> >> =C2=A0 winsup/doc/etc.postinstall.cygwin-doc.sh | 2 +-
> >> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/winsup/doc/etc.postinstall.cygwin-doc.sh
> >> b/winsup/doc/etc.postinstall.cygwin-doc.sh
> >> index 2873d9395..935bd94e1 100755
> >> --- a/winsup/doc/etc.postinstall.cygwin-doc.sh
> >> +++ b/winsup/doc/etc.postinstall.cygwin-doc.sh
> >> @@ -52,7 +52,7 @@ fi
> >> =C2=A0 # create User Guide and API PDF and HTML shortcuts
> >> =C2=A0 while read target name desc
> >> =C2=A0 do
> >> -=C2=A0=C2=A0=C2=A0 [ -r $t ] && $mks $CYGWINFORALL -P -n "Cygwin/$nam=
e" -d "$desc" -- $target
> >> +=C2=A0=C2=A0=C2=A0 [ -r $target ] && $mks $CYGWINFORALL -P -n "Cygwin=
/$name" -d "$desc" --
> >> $target
> >=20
> > Wrong.=C2=A0 Needs to be [ -r "$target" ] to be properly quoted.
>=20
> >From working with Windows paths, I feel I often overdo the quotes: origi=
nally
> had both uses quoted, then seeing the diff, took them off again, pre-comm=
it.
> Those are base Cygwin paths - don't *need* quotes - unless you feel shell=
 var
> uses should be quoted just in case, or just in tests?

Eric is right.  You can't really overquote.  Quoting fixes the border
case scenario of an empty path leading to a shell syntax error.

Personally I even prefer "${target}" which, admittedly, is a bit on the
paranoid side, so just ignore it :)


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaO4JYAAoJEPU2Bp2uRE+g0zkP/R+pooqUeLUVvUdOf9W+sx5b
RlT42OMP3LlDAJtmibG5uoYPHfQAMtK3CCxTIFsk3ZbCG0F+RGwZ2S895RhkrfWU
8xhGcu7cLT75S9vST7WYf65zWKstdPok3DDRTrR0bL0h/KA9Kgf6EeD0hZGHqRpK
2f/tyY8wwUIvcvozqgUwvCrNH6nX30LUxW9QESiJWodzOuSHMUQFIIdJXxX/eOS0
LdDDElE+lAQ8tVVsVFphy17z62Uc4+luIUWotUY0guGeS5Xmp3wQkkaVMmsBqHdc
0+wF0j7DRWEaVXsfb6KnnEpguiI9GpyJNWgvOnyV4rd0oAMFG/DqsqMTz/ZJfFsQ
Q2mQu4aTA88oBBnun0dBxp19flITdFXxOUBzA40FJZimE6tiKEvSjncZevZKuDgS
R7kAGFJmtQbBujCNc34iRvcWRGCML1rEgUm9IWrWhGM5NJc6VJtt634IKAMND6Rk
JRn30E4W0UfJtd1BS0v0NPGkcpwe2+84rwns5TOPL/tKb7OTLXfDkJW2edj8kseX
cdME5TpedzwSV1VEMAAGWaOv6OovXs+5Tso7CxiKRLARn31lJJTEHvG/scKSadjj
f9tmfVTSIBUu6mcj+Cle2RL1/o9l9qdK1eqPZ9qJCelj7HUFVJlufi/w/bOLx63l
b1icZRAZ6RZqYxYfcm7V
=+7kc
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--

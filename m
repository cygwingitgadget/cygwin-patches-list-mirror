Return-Path: <cygwin-patches-return-9823-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 45832 invoked by alias); 11 Nov 2019 09:19:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 45816 invoked by uid 89); 11 Nov 2019 09:19:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-118.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=completion
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 11 Nov 2019 09:19:13 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MOiLv-1iG9lh19Pr-00QERt for <cygwin-patches@cygwin.com>; Mon, 11 Nov 2019 10:19:10 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CDC06A806F4; Mon, 11 Nov 2019 10:19:09 +0100 (CET)
Date: Mon, 11 Nov 2019 09:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] regtool: Ignore /proc/registry{,32,64}/ prefix, with forward or backslashes, allowing path completion
Message-ID: <20191111091909.GG3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191110161445.53479-1-Brian.Inglis@SystematicSW.ab.ca> <20191111091337.GE3372@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="9o1Xi4ZMQ45MudWG"
Content-Disposition: inline
In-Reply-To: <20191111091337.GE3372@calimero.vinschen.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00094.txt.bz2


--9o1Xi4ZMQ45MudWG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1662

On Nov 11 10:13, Corinna Vinschen wrote:
> Hi Brian,
>=20
>=20
> The patch idea is nice.  Two nits, though.
>=20
> Please shorten the commit msg summary line and add a bit of descriptive
> text instead.
>=20
>=20
> On Nov 10 09:14, Brian Inglis wrote:
> > ---
> >  winsup/utils/regtool.cc | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/winsup/utils/regtool.cc b/winsup/utils/regtool.cc
> > index a44d90768..ddb1304cd 100644
> > --- a/winsup/utils/regtool.cc
> > +++ b/winsup/utils/regtool.cc
> > @@ -167,7 +167,9 @@ usage (FILE *where =3D stderr)
> >        "  users    HKU   HKEY_USERS\n"
> >        "\n"
> >        "If the keyname starts with a forward slash ('/'), the forward s=
lash is used\n"
> > -      "as separator and the backslash can be used as escape character.=
\n");
> > +      "as separator and the backslash can be used as escape character.=
\n"
> > +      "If the keyname starts with /proc/registry{,32,64}/, using forwa=
rd or backward\n"
> > +      "slashes, allowing path completion, that part of the prefix is i=
gnored.\n");
>=20
> Is that really essential user information?
>=20
> I assume this behaviour is something you just expected to work but then
> didn't.  With your patch it now works as you expected.  So it's kind of
> a bugfix, rather than a change of behaviour the user needs to learn about.
>=20
> The above text is, IMHO, more confusing than helpful to a user just
> asking for regtool --help.  I'd just drop it.

In fact, a descriptive sentence like the above would better serve as
part of the commit message, methinks :)


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--9o1Xi4ZMQ45MudWG
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3JJ40ACgkQ9TYGna5E
T6CBvg//WAtk/yw/C8k3iMtHRFwDSU17oTusIegV+M6V2rxgvyoVk4lCLfY3FwBp
LpQCGcXFDiOvv2qjdY6AhzGAjVCIaGW/dlJJGJ5YkjiOI3pgd34BIldvdNzUj/iA
KSeI1GOFLjhAcBw9xDN6OuBdTCm+eIAzKSF6YlS4NxT9ydzq4z+xxuYIlCDkRM5M
WuHA2SrYAgbCsXfR1vQbxVFw9+2c+9oKUPlHeYn238Ovtw2vnFaY2NKAD+Eo494F
D5vucoYrA37wWXO1EdkktgqDczbOGosDRRePXpJxueEyHWj1mGvqnwowGmZ1Fro4
4bydKAumXawl2TNpHmyVlgJDgUzR4QXKViBpDHNfApH1q8zQrEgWckKjIPVKOiMh
o5gzNPdeWVHw9bzij8h+UxgqSm/X+mOTPaXl+mnz/9tJj2iM5QkRE58j2E8KV7UO
yuERQOxwiO9SIPeXSr14FExNj+vZS1Ve+DaxUnf4xtkQHC/n6/Qtd+mdWJ+2HDDr
QXmxTT6g1aBeADFG51X66MJpD1fVMmq0hDOC+qnqXZy5igl0e8MAkQ+/02iRs63y
lRj1Su9JjUEBwtlkUa2gKMtXZhk0b8pPPaBNuoFLNgHbmvl3N8Sq32N6pVm7XJLy
jgGvW5+z/8T/1dXlwWpfrMasSASRzagMgcrIjJFPfw/iA4hJBW4=
=Gqro
-----END PGP SIGNATURE-----

--9o1Xi4ZMQ45MudWG--

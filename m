Return-Path: <cygwin-patches-return-9826-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 96783 invoked by alias); 11 Nov 2019 16:28:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 96773 invoked by uid 89); 11 Nov 2019 16:28:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-120.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=utilize, Absolutely
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 11 Nov 2019 16:28:56 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MLA6m-1iDDu81mZG-00I9Ka for <cygwin-patches@cygwin.com>; Mon, 11 Nov 2019 17:28:54 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BF63FA806F4; Mon, 11 Nov 2019 17:28:53 +0100 (CET)
Date: Mon, 11 Nov 2019 16:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] regtool: Ignore /proc/registry{,32,64}/ prefix, with forward or backslashes, allowing path completion
Message-ID: <20191111162853.GI3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191110161445.53479-1-Brian.Inglis@SystematicSW.ab.ca> <20191111091337.GE3372@calimero.vinschen.de> <20191111091909.GG3372@calimero.vinschen.de> <130d853b-1614-0e22-3bdd-c79f311ace0f@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="OFtM20PmL5gDcvsL"
Content-Disposition: inline
In-Reply-To: <130d853b-1614-0e22-3bdd-c79f311ace0f@SystematicSw.ab.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00097.txt.bz2


--OFtM20PmL5gDcvsL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3366

On Nov 11 08:30, Brian Inglis wrote:
> On 2019-11-11 02:19, Corinna Vinschen wrote:
> > On Nov 11 10:13, Corinna Vinschen wrote:
> >> On Nov 10 09:14, Brian Inglis wrote:
> >> The patch idea is nice.  Two nits, though.
> >> Please shorten the commit msg summary line and add a bit of descriptive
> >> text instead.
>=20
> Sorry, I forget and don't notice longer than standard messages, from using
> 120x60 or larger windows.
>=20
> >>> ---
> >>>  winsup/utils/regtool.cc | 13 ++++++++++++-
> >>>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/winsup/utils/regtool.cc b/winsup/utils/regtool.cc
> >>> index a44d90768..ddb1304cd 100644
> >>> --- a/winsup/utils/regtool.cc
> >>> +++ b/winsup/utils/regtool.cc
> >>> @@ -167,7 +167,9 @@ usage (FILE *where =3D stderr)
> >>>        "  users    HKU   HKEY_USERS\n"
> >>>        "\n"
> >>>        "If the keyname starts with a forward slash ('/'), the forward=
 slash is used\n"
> >>> -      "as separator and the backslash can be used as escape characte=
r.\n");
> >>> +      "as separator and the backslash can be used as escape characte=
r.\n"
> >>> +      "If the keyname starts with /proc/registry{,32,64}/, using for=
ward or backward\n"
> >>> +      "slashes, allowing path completion, that part of the prefix is=
 ignored.\n");
> >>
> >> Is that really essential user information?
>=20
> Absolutely essential!
>=20
> >> I assume this behaviour is something you just expected to work but then
> >> didn't.  With your patch it now works as you expected.  So it's kind of
> >> a bugfix, rather than a change of behaviour the user needs to learn ab=
out.
>=20
> To those with similar background or experience it may appear that it shou=
ld be
> supported, but hasn't been until now.
>=20
> It is definitely not expected behaviour, given how regedit, reg, etc. exp=
ect
> only hive paths, and how the the current regtool --help reads, clearly ex=
pecting
> Windows style backslash separated registry paths, probably pasted within =
single
> quotes. That expectation is changed somewhat by the forward slash sentenc=
e.
> Further changes to expectation needs more documentation.
>=20
> >> The above text is, IMHO, more confusing than helpful to a user just
> >> asking for regtool --help.  I'd just drop it.
>=20
> It needs documented because it can not in any way be inferred from the ex=
isting
> regtool ---help, and would not be expected, that it should work. It was n=
ever
> previously supported or seen as helpful or necessary, so it should be see=
n as a
> non-obvious "surprising" addition, in the opposite sense to "least surpri=
se".
>=20
> Please someone suggest better wording for the help, as that is the only
> documentation available, and is needed, to update existing and inform new=
 users.
> Like the code, I tried to maintain the style of the existing help.
>=20
> As an alternative, how about:
> "To support path completion, a keyname prefix of /proc/registry{,32,64}/ =
is
> ignored."

Ok, we can add something to the help text, but the text still sounds
confusing, even the altenative one.  I think the reason is the negative
expression "ignore" here.  Why not express this in a positive way like
this:

  "Use the /proc/registry{,32,64}/ registry path prefix to utilize path
   completion."

Something like that anyway.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--OFtM20PmL5gDcvsL
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3JjEUACgkQ9TYGna5E
T6CtZA/8CPUq8wJyl2/lCq3uWfGHxmP9y8bR+sOvsB6Eb3rtyd2QlJZlSIyNttAP
j8fxn/GnY0XBwUcr6HCPvoEsw3FFc+p5IdDCL1qsDr7ZyWk6tvgdoXlMAh08glDI
nYycPBVtmox7Q6NbCZIx3Gq0pkfQoRfEaKkG2Ag3Kqyt4y3/MlV7t3OztC0ACgmy
NvQ9yg7QWdOw7FXIW6jr+/mW89mGrnI5luyyoSzGHGALC4t2UFRzYjMF77FbpSJi
DBPxnyJTHG1HOw34iopW0pATeJmvEuXZtZxduuLXwOv08mFq6fmSTEWNMJC4GmH3
LlYWAw+JbKZwzg2eFDATg0MI38lOhlL76dDvlDEXw0fJgMtq+qiYWZ7iwdXUbdCQ
TWlGbhF9HE3hwVPaXGAtFo41KTo8z1vJVjhEDbnb2JEoOzOkd82Yu6BrpQ7OMRVo
FRU3dwumoZy42iAxY+JVGLiCdmt7AJBQbpl5WkQgycQV/Sxf/2+T8LXyDN9WSFWY
81L6HRVraBMMSXqDbFl0Em3IylwBrNRmcr6UATiqcgW48HLqNXG9IoWa4wltu8PW
h4plRmPaHTxQXFR1eVOGX0w8yqB1px2UPulj/UaACh6Bc/RCiM3DIWSFHC9ASAJS
Mz7z55Hp6xmycDkOYSoYMz4deyFV1a1tTvvME+eOBNbuXMuaBN0=
=jNRA
-----END PGP SIGNATURE-----

--OFtM20PmL5gDcvsL--

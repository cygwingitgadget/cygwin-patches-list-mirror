Return-Path: <cygwin-patches-return-8920-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 127528 invoked by alias); 13 Nov 2017 12:05:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127507 invoked by uid 89); 13 Nov 2017 12:05:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-103.0 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=facts, H*R:D*cygwin.com, contacting, company
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Nov 2017 12:05:15 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 53DB7721E281C	for <cygwin-patches@cygwin.com>; Mon, 13 Nov 2017 13:05:10 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 9A0695E0152	for <cygwin-patches@cygwin.com>; Mon, 13 Nov 2017 13:05:09 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 84A51A8096A; Mon, 13 Nov 2017 13:05:09 +0100 (CET)
Date: Mon, 13 Nov 2017 12:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add FAQ 4.46. How do I fix find_fast_cwd warnings?
Message-ID: <20171113120509.GA3881@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ac78412d-748f-ed22-473e-9d101f7bde2f@SystematicSw.ab.ca> <0cf17d74-23a4-f08d-fd67-afed0bd3be9d@cornell.edu> <e4e9d518-3a00-6d60-f653-7162711e9672@SystematicSw.ab.ca> <8be9463b-1349-c309-afe1-828712489f74@cornell.edu> <cb561bef-71bc-4261-a5ba-7a5164d10400@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <cb561bef-71bc-4261-a5ba-7a5164d10400@SystematicSw.ab.ca>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00050.txt.bz2


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2958

On Nov 13 00:04, Brian Inglis wrote:
> On 2017-11-12 16:02, Ken Brown wrote:
> > On 11/12/2017 4:27 PM, Brian Inglis wrote:
> >> +=C2=A0=C2=A0=C2=A0 <para>Some ancient Cygwin releases asked users to =
report problems that were
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 difficult to diagnose to the mailing l=
ist with the message:</para>
> >> +
> >> +=C2=A0=C2=A0=C2=A0 <screen>find_fast_cwd: WARNING: Couldn't compute F=
AST_CWD pointer. Please
> >> report
> >> +=C2=A0=C2=A0=C2=A0 this problem to the public mailing listcygwin@cygw=
in.com</screen>
> >> +
> >> +=C2=A0=C2=A0=C2=A0 <para>These problems were fixed long ago in update=
d Cygwin releases.</para>
> >=20
> > The wording of the warning message was changed 3 years ago, in commit 0=
793492.=C2=A0
> > I'm not sure that qualifies as ancient.=C2=A0 I also don't think it's a=
ccurate to
> > refer to the problem as "difficult to diagnose" or to say that the prob=
lems
> > "were fixed long ago".
>=20
> The original message was added in 2011 - 1.7.10 maybe earlier - NT4 suppo=
rt was
> dropped around then - pretty ancient in Cygwin terms of how many Windows
> releases have had support dropped since then!
>=20
> > The issue (Corinna will correct me if I'm wrong) is simply that new rel=
eases of
> > Windows sometimes require changes in how Cygwin finds the fast_cwd poin=
ter.=C2=A0 So
> > users of old versions of Cygwin on new versions of Windows might have p=
roblems,
> > and this can certainly happen again in the future.=C2=A0 But the FAQ do=
esn't need to
> > go into that.=C2=A0 Why not just say what the warning currently says (s=
ee
> > path.cc:find_fast_cwd()):
> >=20
> > "This typically occurs if you're using an older Cygwin version on a new=
er
> > Windows.=C2=A0 Please update to the latest available Cygwin version from
> > https://cygwin.com/.=C2=A0 If the problem persists, please see
> > https://cygwin.com/problems.html."
> >=20
> > You can also add your sentence about contacting the vendor who provided=
 the old
> > Cygwin release.
>=20
> We are trying in the FAQ entry to persuade an annoyed user that it may be=
 in
> their best interest to do some remediation, rather than just complain in =
an
> email to an org they think is a company (cygwin.com) they have never hear=
d of,
> who they expect from their application message to take care of their prob=
lem
> with no other effort on their part, and who they can blame if nothing hap=
pens.
>=20
> Assuming they find the FAQ entry, emphatic language may persuade them to =
do
> something more than the message says they should do.

Nevertheless, Ken has a point.

s/ancient/older and the text should really explain the "older Cygwin on
newer Windows" problem without necessarily going into too much detail.
"The problem has been fixed" just doesn't fit the facts.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaCYp1AAoJEPU2Bp2uRE+g7PUP/3Xu/wEGTLreCLv5Pod+uwAQ
WsywuymdleLQd8nTfvGe4IonuHKpIIKGUn0PCVK4owAVAS0JGjkdluCEe4Ap+RIR
xcZV9nWBvgtwNTD2URPHQE6mOwm6zirOC/YKbdE330/YbXS3b6cdnvr9zO6GQH+p
yyveND1jfUSd7XRfsKpsTdq/ClNodQ6G47FR29t0UUT5s6F7wCaCt1DAAUcons5b
m8c3/8MGpJI4vqamk7eR/yV3swBEpxGoyWIknEJcrV45EkQnQLzud/lJ5+5pnnZf
GqOdQXMChJSxjrF3j1CHFfrp2Hj7ReQrMC1VmjTZh5ALw3ZYrDhf1SUPHr5I4wDp
/RjBzbzmGkyx98Tu/swVUlKNcj6O9mRt5Zx56fO3MxjJARATHNlv0GtHPQd7EE2d
/mbfddeleSEGHqZcjvoDgBe7FAyosPmJlxQI5fw4YAjQ/O/ojErS+XS6yi9G0SVm
8iRCTA65y96cKzvqsXc3TPabcTZ98daOUxwUDiZglrNqtUG62lTH9DSFoJvhNwCm
vZeb0eoZN+B3Qg8PdlysG+qCBGnOQ+bXbCegFoWwtvm9I/gqdWnLJ4mzJz6oAoGu
5NPXrZXl7QeKe90bMAHQ7sXytqVTpIPHtnsbRmvFX26zerfv3eeRn8ziiYpzgjCd
Vy13mDk2+iSGNT9a0kUH
=6DYn
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

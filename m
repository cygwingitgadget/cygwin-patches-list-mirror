Return-Path: <cygwin-patches-return-8925-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 94614 invoked by alias); 14 Nov 2017 21:26:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 93181 invoked by uid 89); 14 Nov 2017 21:26:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-91.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=vista, Vista, Hx-languages-length:2145, para
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 14 Nov 2017 21:26:23 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 5BB44721E280D	for <cygwin-patches@cygwin.com>; Tue, 14 Nov 2017 22:26:20 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id AFE1D5E03A6	for <cygwin-patches@cygwin.com>; Tue, 14 Nov 2017 22:26:18 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9E7A4A8073D; Tue, 14 Nov 2017 22:26:18 +0100 (CET)
Date: Tue, 14 Nov 2017 21:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add FAQ How do I fix find_fast_cwd warnings?
Message-ID: <20171114212618.GA14730@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ac78412d-748f-ed22-473e-9d101f7bde2f@SystematicSw.ab.ca> <0cf17d74-23a4-f08d-fd67-afed0bd3be9d@cornell.edu> <e4e9d518-3a00-6d60-f653-7162711e9672@SystematicSw.ab.ca> <8be9463b-1349-c309-afe1-828712489f74@cornell.edu> <cb561bef-71bc-4261-a5ba-7a5164d10400@SystematicSw.ab.ca> <20171113120509.GA3881@calimero.vinschen.de> <50152c8a-8086-57c5-0b4e-603a771ed7b8@SystematicSw.ab.ca> <3a0ad9a8-0cb7-00ca-e698-dca59bc600e4@SystematicSw.ab.ca> <20171114092902.GF6054@calimero.vinschen.de> <d9422d11-f5f0-4f8e-9e56-04efd40cec4b@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <d9422d11-f5f0-4f8e-9e56-04efd40cec4b@SystematicSw.ab.ca>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00055.txt.bz2


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2153

On Nov 14 13:52, Brian Inglis wrote:
> On 2017-11-14 02:29, Corinna Vinschen wrote:
> > On Nov 13 11:51, Brian Inglis wrote:
> >> On 2017-11-13 10:12, Brian Inglis wrote:
> > Please send this as `git format-patch' with commit message and all.
>=20
> One more diff for comment, and I could use some pointer on how to build h=
tdocs
> html from doc xml, and whether I need to concatenate the screen ulinks to=
 get
> them to render as a single line, which could be answered by the build.
>=20
> >> +    <para>This happens when the Cygwin release you installed can not =
find out
> >> +	how to get your current directory from the Windows release you are
> >> +	using.</para>
> > I think this paragraph raises more questions than it answers.  Of course
> > Cygwin still can get the CWD, just not in the preferred way.  Even if
> > you change it to more technically correct terms, it doesn't give any
> > useful info for users.  Let's just drop it.
>=20
> Reworded to say that it the issue may not be serious, but may be a perfor=
mance
> impact, to put the issue into perspective, and give the user some context.
> I think your comment applies best to the message itself. ;^>
> Perhaps we should consider dropping it, or rewording to be less alarming?

The technical issue is much more complicated than just performance.  In
a nutshell, CWD handles are opened without FILE_SHARE_DELETE by the OS,
so we open the CWD handle by ourselves.  Starting with Vista the OS
changed the way CWD info is stored for reasons unknown.  Performance was
just an assumption at the time which led to the FAST_CWD name for the
struct.  Unfortunately the new ways to handle CWDs is even less
documented than the old ways and changed two times between five OS
versions.  And this doesn't yet explain why we want the CWD opened with
FILE_SHARE_DELETE at all, which requires YA nutshell.

None of this info should be of any interest to the user struggling
with the FAST_CWD message.  That's why I opt for dropping.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaC196AAoJEPU2Bp2uRE+gR2oQAJBVKLKRs3+wChEQJ5uRd/kE
PuTsDOKkvues80QQk524oBV5LJRbJBqJBkEvh00bXdk/3v+tM3LdT7M9szeW2a9B
IfXClOABXrgAisgfGaiv5bUyKORDz7wGF4W0IX404JlU+MKPkAR8oVYXDGrcoPnY
ikWVjxb1Bq/R0zdZ31IxzY4WUSzOg4817QmcF/AFGcOVHJ0tpx0H/Yz9bIEfQ/1H
fYDmuxHhS21YJMj+ppyPbhwWd5EWPEARULwZSS+8Q3HkWIyJK8QhsqUMV9VFO2uU
uHF3poAQY5ynWsCX65kApKhjLdoCgmTH4NSsoI6qGlBzJviMJZAVSGNLB7tJap3t
UJjoBIKyfdYeCIOmTASa6duaI3eemeVxUcFp6q7e9P2ruaaeyxBa6G5XKX74pyjN
2kSff9JsN6jW6+p7bV3hVa+DZ9XvT+OimTKv/vaaf4iwI/dLbYiAvoCIFEbTPMLc
VqZo6pxGltDM879sW0a3d0aQZ7XOVakTYzHAPlgY8Vnl/XfBhwdpQ3GBP2hFASFC
Vwz9WeC2DP6dgQUkN0TE8kb836j5hlUl5ZZPco7mq9wqkgWjwa01N3ghGiSEL6vG
gTHA3qVbvnAFBDUBQ2gaZsWduZa8lhULAZLFZ6e0KESXsC+Dq9fIXqggcvQZZn/s
DP/QPMMSXLje6iKhHOxE
=Oi8T
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

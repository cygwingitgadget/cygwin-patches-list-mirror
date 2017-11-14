Return-Path: <cygwin-patches-return-8923-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 118023 invoked by alias); 14 Nov 2017 09:29:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 117980 invoked by uid 89); 14 Nov 2017 09:29:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-102.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=para, products
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 14 Nov 2017 09:29:06 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 126E3721E281E	for <cygwin-patches@cygwin.com>; Tue, 14 Nov 2017 10:29:03 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 5C9015E0152	for <cygwin-patches@cygwin.com>; Tue, 14 Nov 2017 10:29:02 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 471A8A806CB; Tue, 14 Nov 2017 10:29:02 +0100 (CET)
Date: Tue, 14 Nov 2017 09:29:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add FAQ How do I fix find_fast_cwd warnings?
Message-ID: <20171114092902.GF6054@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ac78412d-748f-ed22-473e-9d101f7bde2f@SystematicSw.ab.ca> <0cf17d74-23a4-f08d-fd67-afed0bd3be9d@cornell.edu> <e4e9d518-3a00-6d60-f653-7162711e9672@SystematicSw.ab.ca> <8be9463b-1349-c309-afe1-828712489f74@cornell.edu> <cb561bef-71bc-4261-a5ba-7a5164d10400@SystematicSw.ab.ca> <20171113120509.GA3881@calimero.vinschen.de> <50152c8a-8086-57c5-0b4e-603a771ed7b8@SystematicSw.ab.ca> <3a0ad9a8-0cb7-00ca-e698-dca59bc600e4@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
In-Reply-To: <3a0ad9a8-0cb7-00ca-e698-dca59bc600e4@SystematicSw.ab.ca>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00053.txt.bz2


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3755

Hi Brian,

On Nov 13 11:51, Brian Inglis wrote:
> On 2017-11-13 10:12, Brian Inglis wrote:
> > [full quote deleted]
> > I guess I may have been a little enthusiastic to get something out ther=
e we
> > could refer to in future - and reduce the annoyance level for both post=
ers and
> > subscribers - attaching a hopefully more accurate diff for comment, also
> > addressing some of the other points I suggested.
>=20
> Made all URIs in messages links, fixed tags, links, improved flow and wor=
ding.

Please send this as `git format-patch' with commit message and all.

> +    <para>This happens when the Cygwin release you installed can not fin=
d out
> +	how to get your current directory from the Windows release you are
> +	using.</para>

I think this paragraph raises more questions than it answers.  Of course
Cygwin still can get the CWD, just not in the preferred way.  Even if
you change it to more technically correct terms, it doesn't give any
useful info for users.  Let's just drop it.

> +    <para>Unfortunately some projects and products still distribute older
> +	Cygwin releases which do not support newer Windows releases, instead of
> +	installing the current release from the Cygwin project.
> +	They also may not provide any obvious way to keep the Cygwin packages
> +	their application uses up to date with fixes for security issues and
> +	upgrades.</para>
> +    <para>The fix is simply downloading and running Cygwin Setup, follow=
ing the
> +	instructions in the Internet Setup section of
> +	<ulink url=3D"https://cygwin.com/cygwin-ug-net/setup-net.html">
> +	    Setting Up Cygwin</ulink> in the Cygwin User's Guide.</para>
> +    <para>When running Setup, you should not change most of the values
> +	presented, just select the <literal>Next</literal> button in most
> +	cases, as you already have a Cygwin release installed and only want to
> +	upgrade your current installation.
> +	You should make your own selection if the internet connection to your
> +	system requires a proxy; and you must always pick an up to date Cygwin
> +	download (mirror) site, preferably the site nearest to your system for
> +	faster downloads, as shown with more details to help you choose on the
> +	<ulink url=3D"https://cygwin.com/mirrors.html">
> +	    Mirror Sites</ulink> web page.</para>
> +    <para>Cygwin Setup will download and apply updates to all packages r=
equired
> +	for Cygwin itself and installed applications.
> +	Any problems with applying updates, or the application after updates,
> +	should be reported to the project or product vendor for follow up
> +	action.</para>
> +    <para>As Cygwin is a volunteer project, and we can not provide suppo=
rt for
> +	older releases installed by projects or products, but would like to be
> +	able to follow up to reduce reports of these issues if possible, it
> +	would be helpful if you would send us a quick
> +	<ulink url=3D"mailto:cygwin@cygwin.com?subject=3DSource%20of%20applicat=
ion%20providing%20Cygwin%20warning%20about%20FAST_CWD">
> +	    email</ulink> to let us know where you obtained the application
> +	which installed the older Cygwin release: whether it was purchased from
> +	a vendor or a project downloaded from the Internet, any related web
> +	pages, or other details you may have readily available.</para>

Do we really want all this information?  It should be sufficient to know
the name of the project, so it's in the records for later reference.
But we won't follow up on this anyway.  There are just too many
well-meaning, but short-lived TPPs on the web using Cygwin under the
hood.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaCrdeAAoJEPU2Bp2uRE+gnYIP+wb8vJ0MgAFDrBiNctvF+H6C
7I9SzBLwPPohWyMBh/BB+gPYYo5ga3ww6KC7/fAzesTMD21TsNW3Pw7uRgoWsyoh
RZ38RDoqdf70ITPG1s9hXiLN0J2tI8Be77Wr0j6KBUK2GnpLECNhChC+DiKEvPnT
3S4Wn4uP9V2NT4JZNbb0tAjB9viH7PAtA30DOE0gFjfUPqT8+WpkBSTQ5n1Qqd6J
o4EQ0Dx4tXbe3M+2K9e6b/G3z+unJvoAX9nKJPRUJ8hVII7ZOFylNUGkVk0zhEdi
nFM16vBBtq0LrNV2i3I/YSNibOVm+eNFDT1iTackoeR4gzrejpTYuwA1eF7+F5SR
IRCk9967hcd7Zo3EWV25fFjGPI5FeEe8sy8KhAit+M0z3ILBEqlSzDghlaFzhxqa
2yZye2hxIELpM49bWX/rru8J1c5uwuYHQr59+eJ7bhwO0Sb6S8Kthw0A2F/zXyhf
4llDdwUcRwyTYJqe8BgzwJUftOHHf0maEwQPvx0FMEtqQ+p7bAI5tFSTTzcTZEuK
o6PPZfsuf2H0kZp5MpqQTRor9IFsyjHyFwiFR7lz3iUrOaQtZn7JGXZSx3Uli1un
m/hZeWbDZwvA2pwtKb0/86O+sgfi+WqPwPXg7chIFCi7qyUNYv0pqMwXstH20J1F
4m8/4X1Tz9PifMFF69sk
=eeiC
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--

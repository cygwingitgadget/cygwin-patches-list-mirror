Return-Path: <cygwin-patches-return-8672-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 742 invoked by alias); 10 Jan 2017 10:54:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130343 invoked by uid 89); 10 Jan 2017 10:54:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*F:D*cygwin.com
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Jan 2017 10:54:43 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 170E4721E280D	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2017 11:54:39 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 61CFA5E00CD	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2017 11:54:38 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4D665A804C1; Tue, 10 Jan 2017 11:54:38 +0100 (CET)
Date: Tue, 10 Jan 2017 10:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Add support for /proc/<pid>/environ
Message-ID: <20170110105438.GE316@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170105173929.65728-1-erik.m.bray@gmail.com> <20170109144304.GA13527@calimero.vinschen.de> <CAOTD34a4VmiqfLADGPj8a0a4gR=UzR=1UNBu8dN6mmC=zBGuHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline
In-Reply-To: <CAOTD34a4VmiqfLADGPj8a0a4gR=UzR=1UNBu8dN6mmC=zBGuHA@mail.gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00013.txt.bz2


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2357

On Jan 10 11:48, Erik Bray wrote:
> On Mon, Jan 9, 2017 at 3:43 PM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > Hi Erik,
> >
> > On Jan  5 18:39, erik.m.bray@gmail.com wrote:
> >> From: "Erik M. Bray" <erik.bray@lri.fr>
> >>
> >> Per this discussion started in this thread: https://cygwin.com/ml/cygw=
in/2016-11/msg00205.html
> >>
> >> I finally got around to finishing a patch for this feature. It support=
s both Cygwin and
> >> native Windows processes, more or less following the example of how /p=
roc/<pid>/cmdline is
> >> implemented.
> >>
> >> Erik M. Bray (3):
> >>   Move the core environment parsing of environ_init into a new
> >>     win32env_to_cygenv function.
> >>   Add a _pinfo.environ() method analogous to _pinfo.cmdline(), and
> >>     others.
> >>   Add a /proc/<pid>/environ proc file handler, analogous to
> >>     /proc/<pid>/cmdline.
> >>
> >>  winsup/cygwin/environ.cc          | 84 +++++++++++++++++++++---------=
------
> >>  winsup/cygwin/environ.h           |  2 +
> >>  winsup/cygwin/fhandler_process.cc | 22 ++++++++++
> >>  winsup/cygwin/pinfo.cc            | 89 ++++++++++++++++++++++++++++++=
++++++++-
> >>  winsup/cygwin/pinfo.h             |  4 +-
> >>  5 files changed, 163 insertions(+), 38 deletions(-)
> >
> > Patch looks good basically, but I have a few nits:
> >
> > - We need your 2-clause BSD license text per the "Before you get starte=
d"
> >   section of https://cygwin.com/contrib.html.  For the text see
> >   https://cygwin.com/git/?p=3Dnewlib-cygwin.git;a=3Dblob;f=3Dwinsup/CON=
TRIBUTORS
> >
> > - While this appears to work nicely on other processes, it seems to be
> >   broken on the process itself.  Did you try `cat /proc/self/environ'?
> >   I'm getting a "Bad address" error when trying that.
> >
> > - A few formatting issues, see my next replies.
> >
> > Other than that, thanks for this nice addition!
>=20
> Incidentally, I don't think I did test `/proc/self/environ`.  I'll
> certainly fix whatever's wrong with that.
>=20
> When I fix that and the issues you pointed out on the other patches,
> should I just submit a new patch set?  When I do so I can also include
> the BSD license statement.

Sounds good!


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdL1uAAoJEPU2Bp2uRE+gSLYP/1O0uKjLyt+P/lXsfY9OE6D6
cd2mGukyaFCEA1ND+44UH5m1aLZCf4qYikxAEfHUEEBcjV3rrSByLXtCzQqee6+5
FqZiH/rBb8iEmAshT/AxUG7j76DPXBKUuETgtJS9ek2d3pZevA4sLmPkaRqu20LC
Os7ujA4tG88vCMTxTKotcZcd67qePh8I5FzpNIFs9QVuGXaFWn4Miau2mHfTM1Zo
JSQAiZh3EELPyG+xsTUiG4RTklqEkbYbHBEl3gELRSurK7jqx7C1kDCR3OFu7ikb
7iRi/dOxQC9yqQm3X5FxhFGWvpbrtbcwPZusMd1z5PdKEFsniMoYifuGYWpV+Nu2
I5mZfWTPpUtdrN07Zys7PUK5+jvrhQPOac/Lg4acjOROl4h3F7dB+d6GpKqYLniV
kEE9wNEWXP9YBPxEBRff/NdBMlxq48FoQiaDupZLHKhBILwmLO1SG6wmfAfQ87ze
AU3yBAmrG8ho6qpY83x2goiA+m1TB/I0P2jOUUCoFWS9oaEAokT18cyxQgASNUs0
oV6GC97j24607fbTD0dePDnoxTCyQMOjels3/kGgHIIDrghN/sfC3QDfeEerBNmf
Fw5ichT2mHIhW+wHdIQFF9ohKDMxLgOTIRaCWTY5waInIn1H7y2RLzPh613lC2nm
Olt5JLikdhd0vzzmwqPT
=SqB/
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--

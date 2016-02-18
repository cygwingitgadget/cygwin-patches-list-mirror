Return-Path: <cygwin-patches-return-8326-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 115084 invoked by alias); 18 Feb 2016 10:41:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 114992 invoked by uid 89); 18 Feb 2016 10:41:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-95.2 required=5.0 tests=BAYES_05,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=behavioral, qualifies, H*R:U*cygwin-patches, H*F:U*corinna-cygwin
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Feb 2016 10:41:28 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D54FBA803FA; Thu, 18 Feb 2016 11:41:25 +0100 (CET)
Date: Thu, 18 Feb 2016 10:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: gprof profiling of multi-threaded Cygwin programs
Message-ID: <20160218104125.GB8575@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C404FF.502@maxrnd.com> <20160217104241.GA31536@calimero.vinschen.de> <Pine.BSF.4.63.1602172218120.19332@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1602172218120.19332@m0.truegem.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00032.txt.bz2


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2271

On Feb 17 22:35, Mark Geisert wrote:
> On Wed, 17 Feb 2016, Corinna Vinschen wrote:
> >On Feb 16 21:28, Mark Geisert wrote:
> >>There is a behavioral change that ought to be documented somewhere:  If=
 a
> >
> >If it ought to be documented, what about providing the doc patch, too?
> >Any chance you could come up with a short section about profiling in the
> >context of winsup/doc/programming.xml?  Otherwise there's basically only
> >the description of the ssp tool in winsup/doc/utils.xml yet, which is a
> >bit ... disappointing.
>=20
> I can provide a doc patch but I could not figure out where this behavior
> change should be documented.  winsup/doc/utils.xml is concerned with tools
> written for Cygwin, but the behavior change is to bog-standard gprof from
> binutils that we're using on Cygwin.  (Note that no gprof code was change=
d;
> it's the system that's changed under it.)  There is no
> /usr/share/doc/Cygwin/binutils.README yet and I guess that's because there
> hasn't been a need for one.  Not sure this qualifies.

No, I was thinking of a piece of documentation within the user docs under
winsup/doc, something that can be uploaded to cygwin.com.

> It seems like a Cygwin-specific gprof man page patch is what's called for.
> Is there an example of that in the source tree I could crib from?
>=20
> I do see that a case could be made for general profiling documentation in
> winsup/doc/programming.xml but that's more than I want to take on at the
> moment.

It doesn't have to be part of the source patch.  It would just be nice
if you could write a few words about profiling.  I'm *not* asking for
a complete gprof doc or somehting like that, it's safe to assume that
the users of the tool know how to read man or info pages.  Therefore,
something short like gcc.xml or gdb.xml would be totally sufficient.
Even shorter than those.  Just a few words about profiling in general,
and an example would be cool.

> All your other review comments are OK by me and I'll implement those and
> resubmit the patch when that's done, including the simple doc update.
> Thanks much,

Thanks to you!


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxZ/VAAoJEPU2Bp2uRE+guPMP/iffo2T9s0MHuE7u5lynmbNa
cyupGg6rXuirkSPsJKTMe3kEongru/X0r8e63nkNeVP4VYKedxLtdMZ1hQVHOAQQ
NWwkSI5v1e6u7W5xhsivzqTQXrWeY2Ow8uDBsjhAoz2gQRBReYvPWQbl375y5+Wi
phMKDDNA3CL1B8carPmYqQ1oODlJ+abs24bZsYvGfhAYKcbZMAU515Wz6rbaRLqn
9tsGjde/U3Rmz9VvDTKKw0W/+qKzzrWHYPhKjYNAvCDwODKxgxcO6phKpkbUGWRC
GQKr7UWrq7achtsSpo8aZCmpYmdVMlpC3ew4rQD2iV1EHdUoxRzj9asTFentSkO7
p7kGVjuH9UP/hgESFJ+bIysWlFtqsQ3DDBJMiDeIVbTYGWOyChgVqiIioUhQfWDl
SEd28lw3zt3Ox/5xyubdlZ/Azow4j1gPB0uXpZZXicmLZ90qbiQefFbPJgoec1x1
GJYGNyllzWxxQtcHZkREqHaE2eRgUEy9gzkeSTD5fcwEx6IecONwMFKgRE2p7zuR
D3m+gDCMpMvF6b/68mCcOscC5b45OWOduivmGOw0Werjm/t/m5ysGwOMhVhNhl9Z
OA6ziRERojxeHDy3YScbcJaI/oZfBDC4koy6kmZ2TnB3jtvFk7FYYqSXQA4qfsu5
Dw1pJAX8KE4lYqilp1r2
=OyEA
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

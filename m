Return-Path: <cygwin-patches-return-7999-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17288 invoked by alias); 17 Jun 2014 08:47:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17276 invoked by uid 89); 17 Jun 2014 08:47:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 17 Jun 2014 08:47:10 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 125918E05FF; Tue, 17 Jun 2014 10:47:08 +0200 (CEST)
Date: Tue, 17 Jun 2014 08:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin_rexec() returns pointer to deallocated memory
Message-ID: <20140617084708.GA31704@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <53811668.5010208@tiscali.co.uk> <5382E760.7@lysator.liu.se> <538312E4.1040201@tiscali.co.uk> <5383434B.8070508@lysator.liu.se> <53835D4E.9040603@tiscali.co.uk> <20140526163505.GA7018@ednor.casa.cgf.cx> <5383A667.9070407@lysator.liu.se> <20140526214049.GB4754@ednor.casa.cgf.cx> <20140526214610.GA6786@ednor.casa.cgf.cx> <20140526235408.GA2716@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20140526235408.GA2716@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q2/txt/msg00022.txt.bz2


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 839

On May 26 19:54, Christopher Faylor wrote:
> On Mon, May 26, 2014 at 05:46:10PM -0400, Christopher Faylor wrote:
> >Btw, the latest version of freebsd can't have this particular problem
> >since ahostbuf is now gone.  We probably should pull in the latest versi=
on
> >into Cygwin's tree.
>=20
> ...and that's apparently because Corinna added the code in question...

...and I can't remember why I added the buffer at all.  It looks like I
was trying to workaround a problem with the lifetime of the hp buffer
content.  The ahostbuf buffer is in there since I pulled the code in
from FreeBSD in 2006 so I had ... some ... reason.  Which eludes me.

I applied David's patch.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToACLAAoJEPU2Bp2uRE+gNL0P/2wxcEIt8sk/HOoRHPpiddM7
9u5z4LVHd2mot8e3WZfhRhYDC7yONCPNr8ZkQLvKP0UTaefdPd2vnoJUYnrR2oRl
59ftI73ao8wofgygRjzbrISk/h4b6kVXat6n0LuOvfmntX4QePIxflyIDlVmKGsx
nvKcNE8xDGObUY5JwOGMsTQBuTJTOZneLn2eYl+3GTtTwJaeIPYcPL2EVkr90nct
Qgp1fe/cTYPbvKs56ZYpyAy/ircVfotgWBKJ7A1DSrZTUfEMoPNJont8b3qKIk2a
eGy9lIZv0M6VzpFx/jx/trttIDCCQPC/mfkTIm2LLseGX276edELq3V41TJO753O
ZGiS+DvO1L3vC6yhdjbfzqmp+v73goKaSNAnLqVnapgm/ZbLdJ2a3KSFDNYTSbzb
bV8p6CK27jUwNtbmtJEreSh2joQaYotUMAW+bm34UVQjXMIma4+8k1/XX/bpfy1T
bFisM+RgzQetvrjlWddQJhMbQARHiZN2hmsvjXbQk1nE8Uc5UeTJEG2iUawtjz1N
HGlVrkfRQQr8e4F/REaNEW5pf7gCcEBOejvy5hh38rfHvq6cWrYNOy8o/0NyhxWU
M65atqBDHqSiUzIOVK8A6HcZ+qzIC9jX0dZZP9AEKxUwW2Pui+UuPJuB5159/Opo
3PMoyG3fs6sNwrRR/UfQ
=/10U
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--

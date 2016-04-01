Return-Path: <cygwin-patches-return-8527-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39442 invoked by alias); 1 Apr 2016 12:19:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39387 invoked by uid 89); 1 Apr 2016 12:19:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=hosting, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Apr 2016 12:19:13 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2F94AA8060E; Fri,  1 Apr 2016 14:19:11 +0200 (CEST)
Date: Fri, 01 Apr 2016 12:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/6] Protect fork() against dll- and exe-updates.
Message-ID: <20160401121911.GC16660@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <56FC211E.4030204@dancol.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <56FC211E.4030204@dancol.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q2/txt/msg00002.txt.bz2


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1108

On Mar 30 11:55, Daniel Colascione wrote:
>=20
>=20
> On 03/30/2016 11:53 AM, Michael Haubenwallner wrote:
> > Hi,
> >=20
> > this is the updated and split series of patches to use hardlinks
> > for creating the child process by fork(), in reply to
> > https://cygwin.com/ml/cygwin-developers/2016-01/msg00002.html
> > https://cygwin.com/ml/cygwin-developers/2016-03/msg00005.html
> > http://thread.gmane.org/gmane.os.cygwin.devel/1378
> >=20
> > Thanks for review!
> > /haubi/
> >=20
> >=20
>=20
> Creating a new process now requires a write operation on the filesystem
> hosting the binary? Seriously? I don't think that's worth it no matter
> the other benefits.

I'm with you on that, but as long as the entire functionality is
*optional* and does *not* affect environments not using it, it should
be ok.

What I'm concerned about is the size of the patches required to make
this stuff work.  I have to review this carefully but I need some time.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/mc/AAoJEPU2Bp2uRE+gf4AP/14Vt5VJseLtm2b0YXDNXKa3
k+ZaTFF1xw/VojLJUDkBW4ZlDFLB1qg0Ww9H24yHY0pLeKjbyIFajEFXhFF3YLiV
nOYyOKu9ZxymZUwa98l5mz0n/RLKPSyXyMsG+Mhsc5z25JVOWiFHvj8OwAn/WB7N
o9sGCPgg2/5cJ/Wc+ZodqpcaWm69xPu2TfLyd84Gvcrnoy/D+uTNBNW32WRTacWu
VVFk8pT3ZwJ32mKlAqDNP18BBspvVkS86nrFP2XpKycwvLb7fsI3p1ea3y/k8YUG
4WOUkvd99tpL8//GzwvEjdyRbZkYfavMFEmHuS2wOhDDK6m2KPi2pwlokUuDpy9h
Z4GaB5MxcifWWxXlNJAh0+BTkW2j85FhFAba8lCjjNflnH7PyYDvI/u61tc5l8G/
4hGzEruczJtBY9A6SS7BNTkTU6FmuOQ64xuSmiHyBYWw/djqJMneBt542pY4LJwo
Th6fczww0HpXsaRi+DazAaXw9/RQCrqaIzCavrhATzVKuecmfNltQALK9Vh4M1hj
8h4UrdlEsJojnMDpvRcBdlTvV1wlLDgNwPF91Z2ZnqXlUk7SVcrSjUx+VReA2WHk
gOh8IgOxK2w6pb1OH6avK6X+YsXc5RZSN4gs0zMkk5McStlIfhZU3OCh9jwDQQW4
nTLOC2GJradYCytCNBhP
=G5Jm
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--

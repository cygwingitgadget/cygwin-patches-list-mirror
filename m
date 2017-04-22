Return-Path: <cygwin-patches-return-8758-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 56411 invoked by alias); 22 Apr 2017 14:54:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 56391 invoked by uid 89); 22 Apr 2017 14:54:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=explorer, Hx-languages-length:1674, emphasis, H*Ad:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 22 Apr 2017 14:53:59 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id D0E50721E280D	for <cygwin-patches@cygwin.com>; Sat, 22 Apr 2017 16:53:58 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 3F20E5E01E3	for <cygwin-patches@cygwin.com>; Sat, 22 Apr 2017 16:53:58 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 25500A803F5; Sat, 22 Apr 2017 16:53:58 +0200 (CEST)
Date: Sat, 22 Apr 2017 14:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix stat.st_blocks for files compressed with CompactOS method
Message-ID: <20170422145358.GD26402@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <81896c1a-a5c8-1f96-c478-5e24f7c1eb56@t-online.de> <20170422135909.GC26402@calimero.vinschen.de> <511c97f0-6f05-3ecc-7b12-018480027d42@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <511c97f0-6f05-3ecc-7b12-018480027d42@t-online.de>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00029.txt.bz2


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1686

On Apr 22 16:34, Christian Franke wrote:
> Corinna Vinschen wrote:
> > Hi Christian,
> >=20
> > On Apr 22 14:50, Christian Franke wrote:
> > > Cygwin 2.8.0 returns stat.st_blocks =3D 0 if a file is compressed with
> > > CompactOS method (at least on Win10 1607):
> > > [...]
> > > This is because StandardInformation.AllocationSize is always 0 for th=
eses
> > > files. CompressedFileSize returns the correct value.
> > >=20
> > > This is likely related to the interesting method how these files are =
encoded
> > > in the MFT:
> > > The default $DATA stream is a sparse stream with original size but no
> > > allocated blocks.
> > > An alternate $DATA stream WofCompressedData contains the compressed d=
ata.
> > > An additional $REPARSE_POINT possibly marks this file a special and l=
ets
> > > accesses fail on older Windows releases (and on Linux, most current f=
orensic
> > > tools, ...).
> > >=20
> > > With the attached patch, stat.st_blocks work as expected:
> > > [...]
> > > -  else if (::has_attribute (attributes, FILE_ATTRIBUTE_COMPRESSED
> > > -					| FILE_ATTRIBUTE_SPARSE_FILE)
> > > +  else if ((pfai->StandardInformation.AllocationSize.QuadPart =3D=3D=
 0LL
> > > +	    || ::has_attribute (attributes, FILE_ATTRIBUTE_COMPRESSED
> > > +					  | FILE_ATTRIBUTE_SPARSE_FILE))
> > Are you saying these files actually have no FILE_ATTRIBUTE_COMPRESSED
> > bit set???
> >=20
>=20
> Yes. The only evidence is the CompressedSize.
> There is also no visual emphasis in explorer listings.

Weird.  Patch pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY+26FAAoJEPU2Bp2uRE+g+78P/0iZfJNsGTn/XKIJ3dKepwH5
mKZ7D4RDlZ1zUOc0LQpwp+/Pe86Xku02LjJJ+kQ8me3NVIuGuOLpHzjehUh4Med7
TF1YhKZBH07ynaWnP9SBpwKhkdqe7b0JdbnzeX1sNmFE4p3i/g8iPQ/3t2byuEVg
Al8bE80lpQzmFU/v29TUAB1h5GYFXd/0wajXaRTzvW3DmQYV5yN9gK0OCOhnDDyE
i9D1g4UNAxTW9ubehe4ERtlxxW1+D+JFI1LfQMwKNY4OKDb+oqKbpofO71/esM7j
xFUijUcj4MmGFLNSEsTeJN88pYHVThA5pQKtSb2slylYfP7I/mpAfXvod68Mjxah
NuNoDKoVRY8I3rPhQAie0SclfpCOWX5mCyB3Pj1tm4iB6HuGQyS/wEZYMXP+OaOR
sb8mHM3g85d0Y+07LtAV6ayhBe3TE1/3HBQqWeeR4XpgG2Z1VuMnMYxXWlc/zlLg
yT41QL1981/EF6gUEBROnZ93TjpaA97FQ8WpikOGxN9lzvBNB8DHR15os8tyFHWp
vluBZwi/XYq5KHRmxUaUW+fnufNo9edr91BsOGJ+J3y46fSU8EW+jqTi3FY9CB1z
lQ0zQHjsTBdk4KUaDWE1UlCT4NeYjNG1F5nkwFJ2e7mOmuj1hsaHYOPEdYuVmt0j
h4vZrxfRK8rB+NvYrAZD
=GhN2
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--

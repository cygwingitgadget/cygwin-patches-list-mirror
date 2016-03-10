Return-Path: <cygwin-patches-return-8385-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31609 invoked by alias); 10 Mar 2016 09:39:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31599 invoked by uid 89); 10 Mar 2016 09:39:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-93.9 required=5.0 tests=BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=DOT, Maintainer, Geisert, geisert
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 10 Mar 2016 09:39:35 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9FD20A805DE; Thu, 10 Mar 2016 10:39:33 +0100 (CET)
Date: Thu, 10 Mar 2016 09:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Support profiling of multi-threaded apps.
Message-ID: <20160310093933.GD13258@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56DFE128.6080308@maxrnd.com> <20160309224400.GA13258@calimero.vinschen.de> <Pine.BSF.4.63.1603091646490.69685@m0.truegem.net> <56E131C6.5080008@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <56E131C6.5080008@maxrnd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00091.txt.bz2


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 625

On Mar 10 00:35, Mark Geisert wrote:
> This is Version 4 incorporating review comments of Version 3.  This is ju=
st
> the code patch; a separate doc patch is forthcoming.

Uhm...

> +		long divisor =3D 1000*1000*1000; // covers positive pid_t values

...still "long"?

Was that an oversight or did you decide to keep it a long?  Either way,
no reason to resend another patch version.  If you want an int32_t here,
I fix that locally before pushing the patch.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4UDVAAoJEPU2Bp2uRE+gh7QP/3LDpVTA4xR5yQ5bEQA4UaoO
mDZEsYcVT9SThrCDe5RAxy5/6HgPVjMXJkjzDGciGnRpYjdHCaL9MtFwaI3kY9UD
8Dr0BoK5N6TDD4vXtzZ2FTt0SAia2YYL6KiqoHftKVkgwHHqqtbowlhmyG6H5yXH
1Ixe6ASI4Z95ZuO627ASVW2RwE7mHTWmA0Nzl9MHz4wEBKY4dHJaosSqUHOUJjiE
9wUfKXLgf0FEAK6yDo0zvfq2LfwiTpwbE8u6LXGFh8aa/9O0a4xBXhMV6CFJp8rS
Irq6lHE+QxcnVwHPiDk9zmuBatHKS0c/JTB2Dwj8h2iqkrfT0Z+KcWULXmXww6r2
q+syqGoShOQeC5P7ByvEbjnt9ugRCTTRxLaMlIKlChPsY5lvlhebxYwg9CoPsATI
nnpZvXPMuuQmz43OlMKWdLbUxFiY/p3luIkoTvwvhRV0e4/KQOtfysbPMgkWO5NB
9RuEAgGL7XZ8O1FpcB2XEW+F7JLHormAro3p0vFCjLcDBvwsXQcpOzQ1x98+nP9M
NnXj08Uc98NIbhtBygmugbMSELvZMTdCHU1OXbd1ODKa4KbW4FzgjFkOpmii7LjX
Ge7FkvOD3MrIdek/Spq0Jsa3hfr5oInGaKlHLRJb02cjo7m/ZiaBRWvwmLZHY6g6
dtjqkYj8MoT15XRR+M37
=XCue
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--

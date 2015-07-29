Return-Path: <cygwin-patches-return-8231-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18053 invoked by alias); 29 Jul 2015 20:21:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18021 invoked by uid 89); 29 Jul 2015 20:21:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jul 2015 20:21:22 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 16790A80907; Wed, 29 Jul 2015 22:21:20 +0200 (CEST)
Date: Wed, 29 Jul 2015 20:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: RtlFillMemory fails on block sizes over 0x7fffffff
Message-ID: <20150729202120.GA7164@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3BD89E0BA5F96349B765DE1100906A6D016FC0267F@UKCH-PRD-EXMB01.illumina.com> <20150729162135.GA20388@calimero.vinschen.de> <3BD89E0BA5F96349B765DE1100906A6D016FC0276D@UKCH-PRD-EXMB01.illumina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <3BD89E0BA5F96349B765DE1100906A6D016FC0276D@UKCH-PRD-EXMB01.illumina.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q3/txt/msg00013.txt.bz2


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 949

On Jul 29 16:29, Petrovski, Roman wrote:
> Sure, in case you decide to go with the patch meanwhile, please use
> the one attached to this email. The original wrongly uses n instead of
> size for copying the memory.

I applied a patch which changes memset, memmove, memcpy, wmemset, wmemmove=
=20
and wmemcpy to assembler code based on the NetBSD implementation.

>=20
> As this is fairly critical issue, do you know when users should expect
> a  fix to become available in the binary release?

Hmm, it wasn't that critical for the last couple of years... ;)

Either way, I'm just creating a 2.2.0-0.5 test release which I'll upload
and announce in a couple of minutes.  Please give it a try.

Since I'm AFK for the rest of the week, the official 2.2.0-1 release
will occur next week.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVuTXAAAoJEPU2Bp2uRE+gJcQP/juC5IzHpcntHobgxwB2cyzr
/QKYZMWuapulnQM2HFtB1HLYcWp+oiDaIP0nGdk5dG1lNuh8qI2obyCRyHoH4KdW
KByuAOHlmEO33ZjXa9sXsGRGmtncEn29V+Y+/q7VHCEFc3birDqyaOKrToxmJWMM
VwI5NQxSloSbjEEuxHamf9SYT76Gi0khfgxa3c0Y/3bjtrbX+2tUe/DJUomB3o+n
EweB1OsqIXXYtj5AQOb5EA/klJmh4RRP5qAqGKLusi0V+R4euTuV44O0BKSVhvnP
txpJwrUgJEO9Beg7wj/wfP7x/Z+EtFQ2vAHFMxYV9M/Z9LDHA3i15n0Z6Tp6S50x
h6IwHgixCP0OPamSwVJoOJ1PdZpNmQYewcRfJIJiIQsTzdOWwv+8TOGJv0tGcAij
vfboRb+kiI0dpWJ4gQ9aCrZmUVkDUaOJGtEQLJTHeK7lkGF8vuL46eGiT2KMon1d
lbyhPdx/SP3xBtDsCQBoHRGOpzwo53fWCVZccjpohk9qxVyW8QBfWhPloDOcDea2
HsnV+7LAspBRNxGD/7byFT121GCowlnB8iqvuicXn7x/w9ITYM88SoGGOV79aWuZ
/clGMOo8GOlVEn1bTx7t2QCVqPenYExNnv9iYevCs+QdeILpp3eT8zrzzzwt2pH5
t4DlIuU2lXdWYe7moMXd
=+OJU
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

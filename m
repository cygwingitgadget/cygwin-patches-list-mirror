Return-Path: <cygwin-patches-return-8653-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24878 invoked by alias); 17 Nov 2016 09:55:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24751 invoked by uid 89); 17 Nov 2016 09:55:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*F:D*cygwin.com
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 17 Nov 2016 09:54:59 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 4A03371E3F90A	for <cygwin-patches@cygwin.com>; Thu, 17 Nov 2016 10:54:55 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id AE5EB5E008B	for <cygwin-patches@cygwin.com>; Thu, 17 Nov 2016 10:54:53 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9E8D5A805F2; Thu, 17 Nov 2016 10:54:53 +0100 (CET)
Date: Thu, 17 Nov 2016 09:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Return the correct value for sysconf(_SC_PAGESIZE)
Message-ID: <20161117095453.GA29853@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAOTD34ZMkY=Sfp6-8AFDg_Q=7NZB2oS+=QthfWauoboP6=szfg@mail.gmail.com> <20161115145849.GA25086@calimero.vinschen.de> <CAOTD34ajMRiL0RMJTrVvzK8bMwAta3XJ8Pi7sk27ww1B4HLp3Q@mail.gmail.com> <20161115161955.GD25086@calimero.vinschen.de> <CAOTD34Y=YeufL-kYHUsrQg1oWOdk3F_-Z+H6GSiadRXJ9LuRwA@mail.gmail.com> <6f461a14-f503-1aa1-e417-a5b4b24606bc@redhat.com> <CAOTD34biu0cNj5g7yS0GhUX2zTs6JDpdrvnFJ9knwPZMKJMzGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <CAOTD34biu0cNj5g7yS0GhUX2zTs6JDpdrvnFJ9knwPZMKJMzGw@mail.gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2016-q4/txt/msg00011.txt.bz2


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2238

On Nov 16 15:51, Erik Bray wrote:
> On Wed, Nov 16, 2016 at 3:01 PM, Eric Blake <eblake@redhat.com> wrote:
> > On 11/16/2016 07:56 AM, Erik Bray wrote:
> >
> >>> There is no good reason to use the non-POSIXy page size.  It doesn't
> >>> help you in the least for any pagesize-related functionality.  Mmap
> >>> as well as malloc and friends only work with _SC_PAGESIZE sized pages.
> >>>
> >>> It sounds as if you're looking for a solution for which there's no
> >>> problem...
> >>
> >>
> >> FWIW the background here is that I'm working on porting psutil [1] to
> >> Cygwin, and trying to accomplish as much as *possible* through the
> >> POSIX interfaces without having to fall back on the Windows API.  It's
> >> actually a great exercise in what is and isn't possible with Cygwin :)
> >>
> >> In this case I was trying to compute process memory usage from
> >> /proc/<pid>/statm which gives values in page counts, so I need the
> >> page size (the actual page size) to compute the values in bytes.
> >
> > If /proc/<pid>/statm is reporting memory in multiples that are not the
> > POSIX _SC_PAGESIZE, that is a bug in the statm file emulation that
> > should be fixed there.
>=20
> So then something like that attached (untested) patch should work,
> though it made statm inconsistent with what is reported in
> /proc/<pid>/status which reports memory in multiples of page size.  So
> that has to be patched as well.

Patches applied as obvious, thank you.

> This of course leads to memory reporting that is inconsistent with
> what Windows says.  But I guess if that's "normal" in Cygwin (for the
> reasons stated by Corinna) then it's an acceptable trade-off?

It is.  From the POSIX POV we have a 64K page size, from the Windows
POV we have a bastard of 4K pages which can only be allocated in
chunks of 16.  The latter simply doesn't fly well with POSIX
assumptions.

Since native Windows tools don't see the Cygwin internal assumptions,
it doesn't matter, unless you mix Windows and Cygwin memory functions.
Which, honestly, should only be done by Cygwin itself.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYLX5tAAoJEPU2Bp2uRE+gQJoP/iwTdQtKpSyh9Iy3P1TxTSmI
L52kp7wvfi3niHpaYGkZpOdxFGQKpBlljUsvTZ8MMIuwm2r3yHkv33DYxNAi0xs/
MrxuuPytbBeSa2Hln+hLkwEJGLPn5CDFDq0O8KJ3ixBQt+sTVjBW/vnwZ12dPWNE
ILwSd+4MhPgvIjJHRdkYfHgE5QMvL+C/ijMFDuOlg5jJdqMcUWLTfITQ5SV/p/ij
niQIUS10spAY47XdHF1Z2bDB/Xfy/KZTYWeDi2A+K/CeoPFQxjdKjPKGJ46VAWNa
U0Q+STIqwhK39ZW6/J0hBIcho/NxW+lpX/cINzQlO8oCRqokC/cNlPtn0JnpxmX8
iJpjkFZN5qXvu7QHnSRMa2n0noCxGaAoyW+hHSWVpOL4JTL9QtP7ML5p0Mrnw2P0
QCEtl9lhMvHnqLTcJfhSzUo4DEQ0W/76UvJWs2gh8F3javNjIF7kjfUXk6VK6x6K
IB6Ma5Ug/r3BLRqzuB8LlgaO50cbB2qEZmE6XQAO2UgajSFNyYq0DRGeIjRHpm98
ms32aJ+WFVx2iGMjRamLAX2y4TykVI3EyZjj1doCb3PZycixVI2rYsHvWdImr3v2
o14ON/BB+4Emq1PYZjq1E3XDmqKjSH6F5PcahuWxGwBZJ5xdBwVSv7Og+/0rMhto
L3whoC2Xn7Vp1kwqC8qA
=M44N
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

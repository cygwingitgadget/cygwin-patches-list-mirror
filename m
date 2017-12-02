Return-Path: <cygwin-patches-return-8958-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 59680 invoked by alias); 2 Dec 2017 10:46:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 59668 invoked by uid 89); 2 Dec 2017 10:46:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Nobody, bang, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 02 Dec 2017 10:46:13 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id D874571E3F450	for <cygwin-patches@cygwin.com>; Sat,  2 Dec 2017 11:46:09 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 058115E01D4	for <cygwin-patches@cygwin.com>; Sat,  2 Dec 2017 11:46:07 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6E866A81838; Sat,  2 Dec 2017 11:46:09 +0100 (CET)
Date: Sat, 02 Dec 2017 10:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
Message-ID: <20171202104609.GC4325@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com> <20171128105334.GQ547@calimero.vinschen.de> <20171201093754.GB25276@calimero.vinschen.de> <Pine.BSF.4.63.1712011340460.18120@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1712011340460.18120@m0.truegem.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00088.txt.bz2


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2266

On Dec  1 13:46, Mark Geisert wrote:
> On Fri, 1 Dec 2017, Corinna Vinschen wrote:
> > On Dec  1 10:30, Corinna Vinschen wrote:
> > > In terms of pread/pwrite, the new handle shares the same settings with
> > > the original handle.  However, if you use cygwin_attach_handle_to_fd,
> > > there's a chance information got lost.  Nobody actually uses this cal=
l ;)
> > >=20
> > > In terms of FILE_SYNCHRONOUS_IO_NONALERT, this is stored in
> > > fhandler_base::options, utilizing the get_options/set_options methods.
> > > I have a hunch that cygwin_attach_handle_to_fd fails to call set_opti=
ons,
> > > thus options is 0 when you call pwrite, thus the new handle is opened
> > > without FILE_SYNCHRONOUS_IO_NONALERT and all the other option flags
> > > we use by default.
> >=20
> > It's more than a hunch.  Of course the info gets lost since
> > none of the functions called by cygwin_attach_handle_to_fd calls
> > NtQueryInformationFile(FileModeInformation) to fetch the options.
>=20
> Bang.  There it is.  Let me fix the offending program to just use
> Cygwin-supplied handles and make sure this bug of mine is squashed.  I'll
> report back but it might be a few days.
>=20
> I'm open to using overlapped I/O for the usual read & write cases of aio =
but
> there are some extensions I have in mind that don't allow for overlapped =
so
> I think I need to have threads handle them.  I might combine the two.

I'm just a bit concerned in terms of calling lots of aio_read/write at
the same time or lio_listio with lots of entries.  One thread for each
entry?

> Using
> overlapped for the common case would, I think, allow me to reduce the num=
ber
> of worker threads hanging around.  Thanks for the input!

I wonder if APCs are the way to go for this use case.  As you might
know, Nt{Read,Write}File provide a way to specify an APC routine and a
APC context pointer (struct aiocb *?), so instead of waiting actively
for the event, you could just lean back and wait for the APC routine to
be called.

As a sidenote, I think we could use APCs in other scenarios, too, but
somehow we never got around to it.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaIoRxAAoJEPU2Bp2uRE+gfnIP/jhtCmR+gQjALmBI6Knzklhk
AEC5Qyy3x4ov9hxQJoaGWlloNRyeF8AWhioyOJbZXUVrrAF6UNg6KhN4k3Sg0p1S
Heq/SFbiU8gLV5jFerBly+1bNj1wq/cqo70IOh2NNcEv7ZEq7TIhBD132Fz1RQOF
WtlqdLcYYxNlX0yrQpSjN7DcW4rUzcCS8dGsmXr3vAPxZS32bKlegY8IBeyJ3N83
KeOY4ddCi2YmhSeRjF+kTPJRSXe063mp2nTTJqLWmaVzsyhq/4L7ehvjdzNBO4Aj
RR6SgdKLdcBu0UgBawmzlxAo41i9C/P/PLVm393MITOPWltvHsQndKB8Tnv7ZbFI
FBL96dubY3rKR7hZxkhff8F+f0jAh0y5Au1iKEa8r+oF+OaJ1vx2OnkyqAABSt43
F132JO02ZfsKSeUZfeVJW36LBtI2NVrazd5Cp+PhKEMLQJ5vH8l7NI8kSG+7rdXj
2R7I2YYii51wvdscUY/U/Ge4NkFE12rIsamSGsGAuh1w9QwZgH5CICdrHY3/Vt2F
NCiHpetZV36jQgD60m9vkUT0FC84vhr6JamuqZ4Gq1cmrKnYqlLtlznAV6CCjbez
DnA5gAvpxdQBHa2+0OcxEQKqpf5PpCJxCfFGaH13tZQmf9HePTKU1LtA0GMBqEuf
RXNfTrwEh9Kyl8u551am
=g3lO
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--

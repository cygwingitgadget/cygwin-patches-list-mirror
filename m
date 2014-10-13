Return-Path: <cygwin-patches-return-8029-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17049 invoked by alias); 13 Oct 2014 08:20:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17028 invoked by uid 89); 13 Oct 2014 08:20:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Oct 2014 08:20:37 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B42E18E1516; Mon, 13 Oct 2014 10:20:34 +0200 (CEST)
Date: Mon, 13 Oct 2014 08:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Disable AF_UNIX handshake with setsockopt(..., SO_PEERCRED, ...)
Message-ID: <20141013082034.GZ2681@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <54240D45.6080104@t-online.de> <20141009175956.GF2681@calimero.vinschen.de> <5436D241.3070104@t-online.de> <20141010110752.GA14455@calimero.vinschen.de> <54380B0E.7020803@t-online.de> <20141010180429.GO2681@calimero.vinschen.de> <20141011183644.GS2681@calimero.vinschen.de> <543B6533.807@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="hNG1vEeyG8BCaHbQ"
Content-Disposition: inline
In-Reply-To: <543B6533.807@t-online.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q4/txt/msg00008.txt.bz2


--hNG1vEeyG8BCaHbQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1877

On Oct 13 07:37, Christian Franke wrote:
> Corinna Vinschen wrote:
> >On Oct 10 20:04, Corinna Vinschen wrote:
> >>In short, the whole code is written under the assumption that any sane
> >>application calling nonblocking connect would always call select/poll to
> >>check if connect succeeded in the first place.  Obviously, as postfix
> >>shows, this is a wrong assumption.
> >>
> >>I'm not yet sure how to fix this, but I'll look into this next week.
> >I applied a fix which, I think, is much more elegant than the former
> >solution.  The af_local_connect call is now called as soon as an
> >FD_CONNECT event is generated and read by a call to wait_event.  It
> >worked for me, so I have tender hopes that I didn't miss something.
> >
> >I also applied your patch on top of this new stuff and I'm just building
> >a new developer snapshot for testing.
>=20
> A quick test of current postfix draft with the snapshot works as expected.
> Thanks.

Did you run other network-related tools, too, in the meantime?  Any
fallout which could be a result my change?

> >   In setsockopt I added a check for
> >socket family and type so setsockopt(SO_PEERCRED) only works for
> >AF_LOCAL/SOCK_STREAM sockets, just as the entire handshake stuff.
>=20
> Probably not needed because this check was already in
> af_local_set_no_getpeereid() itself.

Doh!  I reverted this part of my change.  I completely missed the
redundancy here, sorry.

> >   I
> >also added a comment to explain why we do this and a FIXME comment so we
> >don't forget we're still looking for a more generic solution for the
> >SO_PEERCRED exchange.
>=20
> Definitely, at least because the current AF_LOCAL emulation has some
> security issues.

-v?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--hNG1vEeyG8BCaHbQ
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUO4tSAAoJEPU2Bp2uRE+gZT8P/2nNXGybxgGFWexFsgxC7Uux
MxQl7mMlRm22OK7JuyhLXGGpm3+NBXVA93qOf/3ouBQjbBz84K+rVP52UDtrs0R5
ULFbfFlOi5WgjsaRbIZ0FdkZ1hBNIH1SZKyJrcqmo0Mwl9PmpLpIlPXP+2A/RbiX
1AipIvTvPucfDnxpuTuR8eN4Uv0iDeswFLU3Ex9/W7P7W8s0EApL3nfWlZfVunOY
9De/noHQbghNJ2lMy+8f3EQBiO95Fc4Lydo2YnZcQwG5DmBb/NKW81RG3W8JIMMF
U+HO0QFotWql0A4uKJ1TThhgv9/r5JWidtvkE4sPMl14SVB1KQdqShXJB7A5f4yH
57SfvwjUU3Giay56p2S1bmxjlA3MpXVN2UCbCHocKpDuUa3FdZim9Dl440tNFnbh
PfDZQK1oYfcCTBVfn2yBAMYMm6oQPCMJrUlw5z0UNIffxDbY3LHuFwI9ZF81mW/c
EK6xqbboAY21QimtXfqZYb6ve+b3ZXdmkNwlKGcGOJqBUz1yQi3XATktznm4vJ3o
91a7IHdDpH5tbhPH2qD3mlCgLcTrmBjRuPwEaye/Qq7/FKWODQOinAUdc+kyD2pQ
/rNiXTt5YluVH3zfEjyakI19niPZunaGJCVn2tqD5Iyc3ZwDyuwleuNxc+FRGO0P
ab+udiuk2Ro+UBdaFoO0
=TTcs
-----END PGP SIGNATURE-----

--hNG1vEeyG8BCaHbQ--

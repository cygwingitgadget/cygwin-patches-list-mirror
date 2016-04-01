Return-Path: <cygwin-patches-return-8536-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104657 invoked by alias); 1 Apr 2016 15:11:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104598 invoked by uid 89); 1 Apr 2016 15:11:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:605, H*f:sk:CAOFdcF, H*i:sk:CAOFdcF, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Apr 2016 15:10:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BF2AEA80612; Fri,  1 Apr 2016 17:10:54 +0200 (CEST)
Date: Fri, 01 Apr 2016 15:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add without-library-checks
Message-ID: <20160401151054.GH16660@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459442026-4544-1-git-send-email-pefoley2@pefoley.com> <20160401121601.GB16660@calimero.vinschen.de> <CAOFdcFO8cMnFLcYb=_++65JW0xu+YYAzC98bJ83McfsFFMY_RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline
In-Reply-To: <CAOFdcFO8cMnFLcYb=_++65JW0xu+YYAzC98bJ83McfsFFMY_RA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q2/txt/msg00011.txt.bz2


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 609

On Apr  1 09:31, Peter Foley wrote:
> On Fri, Apr 1, 2016 at 8:16 AM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > Can we please fold the --without-mingw-progs and --without-library-chec=
ks
> > into a single option?  Given the task is basically the same, the option
> > name should reflect something along the lines of "cross-build",
> > "bootstrap", and "stage 1", IMO.
>=20
> Sure,
> Maybe --with-cross-bootstrap?

Sounds good.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/o9+AAoJEPU2Bp2uRE+gxSEP+gKjDQpNwMBzxUthHqAAZXzG
yF/vKQveifvhAJILPEj6+WuHzm+YwW2JB9c6JgOh78DJq94BfjXJF5/LTvADHqs+
ffZuov+UD6MUBCW3N6BOL1IBHNfDYqInG06rjTLfFsQxMFUMzR9kS2SJMFdZuBBZ
4Czp4/0chpgYVSGs7FmdZSLZrH1EW7JLgtOuNcE2b8aQxncF9MOZs7HPdUl+auU8
sDCH+VE+541AUsFTTOsDT3R0B8D0fVAZ5HeIo3PWiFKNRYAgPY9AZb7zI7tpdCxk
/SQRXuWJdI6UFgTjCwXKfqP/ctLiWHOnB60lUscIDVM8rvumDjTilBkvX4Ke4rri
8/w2T7RZ51MnIEj5QxcHeFt3YKitroBdqpcqfzJLx8q0nUnAPBLlRfVJzTSPSVP4
qH2qBqoadgNKi4+SMAv7wt33QwZGan3QtpEVTQAi5kp9pp7ZKnRmhmPSrkMfFHCA
RnGwRRA9nlOv6A3pjly6zHx56v2q/U1HZx4heCFlPQm3jQsbN0uGKcTJcPzhg4Up
7WxJQRjh+YJHy5zBWYGI6cnTAPzzJCJ5eOt+FStUj/XHerYn8jXbeQw6dALE3xDh
1OJacII+Al7qV7afp9OZxMb0K1ihGMTBv3uREGs3nH7XTJKnILbLYWU3HClBe0ox
rChTgWdK4fcfno3lGVEj
=PowS
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--

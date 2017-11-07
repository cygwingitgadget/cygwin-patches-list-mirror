Return-Path: <cygwin-patches-return-8908-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16333 invoked by alias); 7 Nov 2017 15:36:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16323 invoked by uid 89); 7 Nov 2017 15:36:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-125.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Nov 2017 15:36:47 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 5641F721E280C	for <cygwin-patches@cygwin.com>; Tue,  7 Nov 2017 16:36:44 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id B42ED5E038E	for <cygwin-patches@cygwin.com>; Tue,  7 Nov 2017 16:36:43 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A3291A8056F; Tue,  7 Nov 2017 16:36:43 +0100 (CET)
Date: Tue, 07 Nov 2017 15:36:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix two bugs in the limit of large numbers of sockets:
Message-ID: <20171107153643.GD14762@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171107134449.11532-1-erik.m.bray@gmail.com> <20171107151134.GC14762@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
In-Reply-To: <20171107151134.GC14762@calimero.vinschen.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00038.txt.bz2


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1963

Erik,

On Nov  7 16:11, Corinna Vinschen wrote:
> On Nov  7 14:44, Erik M. Bray wrote:
> > * Fix the maximum number of sockets allowed in the session to 2048,
> >   instead of making it relative to sizeof(wsa_event).
> >=20
> >   The original choice of 2048 was in order to fit the wsa_events array
> >   in the .cygwin_dll_common shared section, but there is still enough
> >   room to grow there to have 2048 sockets on 64-bit as well.
> >=20
> > * Return an error and set errno=3DENOBUF if a socket can't be created
> >   due to this limit being reached.
> > ---
> >  winsup/cygwin/fhandler_socket.cc | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_=
socket.cc
> > index 7a6dbdc..b8eda57 100644
> > --- a/winsup/cygwin/fhandler_socket.cc
> > +++ b/winsup/cygwin/fhandler_socket.cc
> > @@ -496,7 +496,7 @@ fhandler_socket::af_local_set_secret (char *buf)
> >  /* Maximum number of concurrently opened sockets from all Cygwin proce=
sses
> >     per session.  Note that shared sockets (through dup/fork/exec) are
> >     counted as one socket. */
> > -#define NUM_SOCKS       (32768 / sizeof (wsa_event))
> > +#define NUM_SOCKS       ((unsigned int) 2048)
> >=20=20
> >  #define LOCK_EVENTS	\
> >    if (wsock_mtx && \
> > @@ -623,7 +623,14 @@ fhandler_socket::init_events ()
> >        NtClose (wsock_mtx);
> >        return false;
> >      }
> > -  wsock_events =3D search_wsa_event_slot (new_serial_number);
> > +  if (!(wsock_events =3D search_wsa_event_slot (new_serial_number)));
                                                                      ^^^
did you actually test this?

https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3D2e989b=
212955665384bf61ee82dd487844a9371a


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaAdMLAAoJEPU2Bp2uRE+gPfUP/1fiAqypz17pUG3+4ecmCsLN
3ifMbCAfEl1UdRLL4j28tnh2n8nT31omvBjzqxuXgvpFjFvRRZfLaA+bSpH9dCNn
EStOphobXcKIlUqApoP8pHeQxD/AdzWrmV/yev9HJA9Ds3SqWw8RIKB6qDAYyBPU
gphlUuN/Gd8BinvCSR+q7OCWEbpY73KOZTx8Z4g2FwKdOzHtkopLlrZadNL601As
Y+gvo8K1ABXbswCPDKnFxic1MN5NpyJiC9kJgd4p/gS9CROAvFO69N/WHRJiEGE/
DBX/l+jmzODzjjt7ZCSnQtKZLQulrSsPJC1F5S1BDGFNmYCW+FlXnZRgEeWS0SiS
irNFW1NX/+psOJgxQCBVMZzMznv2FcmMwsfgx7KrHJS7XuvtaBdTTUW1qXW25qVE
l3dTOUWNerZGWuiWMgoT9UWI+4Mw4Lrt1IgW11dDOC0sFMWeA1oon0oSKDUzVEkG
m0BUNb7ZrkFS+yP4xKJeTUhtflAepTRKJWYJxGQYvmoer2IZWEwxdo5shEGA48WG
JEJfY0HHfK6L+j+uMYTEYPdMMI8ng9LM/EIzgEhAjf1b+e4gdDSOjFsxdBIT9TnJ
RBI+jP2+nqU8UV+5t4VDzBX0uKZy+Lb/6I6m2BKFx7jRjvPerHV7aP1qPAyZhbog
aGoay8P6Qm7GUUGQeNrr
=Rl4d
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--

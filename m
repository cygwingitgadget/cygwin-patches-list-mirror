Return-Path: <cygwin-patches-return-8068-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17122 invoked by alias); 12 Mar 2015 19:22:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17039 invoked by uid 89); 12 Mar 2015 19:22:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 12 Mar 2015 19:22:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 809C7A809C8; Thu, 12 Mar 2015 20:22:53 +0100 (CET)
Date: Thu, 12 Mar 2015 19:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: braces around scalar initializer for type
Message-ID: <20150312192253.GD11522@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CABEPuQJGji9Ue5E+j55to-u+VZV_oZ5kqF6piJFjhmMR+OJbhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <CABEPuQJGji9Ue5E+j55to-u+VZV_oZ5kqF6piJFjhmMR+OJbhQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00023.txt.bz2


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1077

Alexey,

On Mar 12 21:18, Alexey Pavlov wrote:
> Building MSYS2 runtime I'm get:
>=20
> /build2/msys2-runtime/src/msys2-runtime/winsup/cygwin/net.cc:82:56:
> error: braces around scalar initializer for type 'u_char {aka unsigned
> char}'
>  const struct in6_addr in6addr_any =3D {{IN6ADDR_ANY_INIT}};
>=20
>                           ^
> /build2/msys2-runtime/src/msys2-runtime/winsup/cygwin/net.cc:83:66:
> error: braces around scalar initializer for type 'u_char {aka unsigned
> char}'
>  const struct in6_addr in6addr_loopback =3D {{IN6ADDR_LOOPBACK_INIT}};
>=20
>                                                ^
> /build2/msys2-runtime/src/msys2-runtime/winsup/cygwin/../Makefile.common:=
43:
> recipe for target 'net.o' failed
>=20
> So I think next patch can be applied:

I'm ok with that patch, but it's missing the ChangeLog entry,  Please
provide ChangeLog entries per https://cygwin.com/contrib.html.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVAeeNAAoJEPU2Bp2uRE+g/xkP/Ru9QItK1iNbSW0noes+ORl8
k5CFIKWAsxOlXOk3g4G1kjgp3dswyzrA1vSJUzkr1Z4brtY0zJDGl8KDUzUyLD7u
FwqXMMHV6jXkQdXxgqaHQW6dwCv08K4Uq44VgkSHWT4hjcKj1PB6bsCBy/rREkaY
OzSR/x/uMexE26eSKrHugaAV7ABOsbvfolkog8GFF33U61O1rw59fqpEgobzpWG4
/RPj+jzNX7BzUUPOaTIxy/MboXxz9Bszhl0eEbqsS0um/j4akyJJ2GdMERnyVGxH
VFNx1KMkKQTLUDi57oBjK9xjL2c4n2RIvcIT8f+ythtPEOhFNMsFhDYTVYcCUyjf
vSmGLlrcXGU0cBcVUypJ8EbpsrVlXf723Hvq0wbMYGwmHE74a5NwFR5kbT+1q6ii
5uG3oTHmXXMYAZkSXv9rb1tiQ9sJsqB7FZnc4SHxWm0bHyiTqUrmOVzwqrbBAESz
vXFMThX7/NTHLkI2aG5NakIdm8KrP3w1o8S6askL9+d0a3suO/C/Rr+0G8xXO/Wx
Qp2L3CSgJileTkctCiTMQfThPsz/123UXwVZglUfM/qfZ1GKsjnR1qSwBUr78c0m
bc6DDPbMOUajuOLa1fjyFby4MH+69XL6/E7/I3GncgZqhNJk3oQHd5Vx2ji1dKz2
D7O+pqpsfTvZ0pqvYBSO
=BdZx
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--

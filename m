Return-Path: <cygwin-patches-return-8026-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26640 invoked by alias); 10 Oct 2014 18:04:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26624 invoked by uid 89); 10 Oct 2014 18:04:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 10 Oct 2014 18:04:32 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 04A5F8E0A26; Fri, 10 Oct 2014 20:04:30 +0200 (CEST)
Date: Fri, 10 Oct 2014 18:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Disable AF_UNIX handshake with setsockopt(..., SO_PEERCRED, ...)
Message-ID: <20141010180429.GO2681@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <54240D45.6080104@t-online.de> <20141009175956.GF2681@calimero.vinschen.de> <5436D241.3070104@t-online.de> <20141010110752.GA14455@calimero.vinschen.de> <54380B0E.7020803@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="DwoPkXS38qd3dnhB"
Content-Disposition: inline
In-Reply-To: <54380B0E.7020803@t-online.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q4/txt/msg00005.txt.bz2


--DwoPkXS38qd3dnhB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2782

On Oct 10 18:36, Christian Franke wrote:
> Corinna Vinschen wrote:
> >I was just looking into applying your patch when I got thinking over the
> >change in select.cc once more.  You're setting the connect_state from
> >connect_pending to connected there when there's something to read on the
> >socket.
> >
> >This puzzles me.  A completed connection attempt should set the
> >write_selected flag (see function peek_socket).
>=20
> No, peek_socket() does not change write_selected. It sets write_read if
> write_selected is set.

Uh, sorry, I mistyped.  You're right, of course.

> >   The AF_LOCAL handling
> >in the
> >
> >   if (me->write_selected && me->write_ready)
> >
> >case in set_bits should cover this.  What situation is your special case
> >covering which is not already covered by the write_selected case?
>=20
> If only read status is requested via select()/poll(), write_selected is
> always false and the connect_pending=3D>connected transition is never don=
e.
>=20
> After a nonblocking connect(), postfix calls poll() with pollfd.events =3D
> POLLIN only. If poll() succeeds, it calls recv(). This fails with ENOTCONN
> because the state is still connect_pending.

Oh.  So it doesn't check if the connect succeeded?  Does it check the
poll result for POLLERR or does it explicitely check for revents=3D=3DPOLLI=
N?

Hmm.

[...time passes...]

It looks like you catched a long-standing bug here.

This isn't even AF_LOCAL specific.  The original comment in the
write_selected branch is misleading: The AF_LOCAL specific part is just
the call to af_local_connect, not setting the connect_state.  There was
a previous, longer comment at one point which I shortened for no good
reason in 2005:

  /* eid credential transaction on successful non-blocking connect.
     Since the read bit indicates an error, don't start transaction
     if it's set. */

However, If I'm not completely mistaken, your patch would only work in
the aforementioned scenario if setsockopt(SO_PEERCRED) has been called.
Otherwise the handshake would be skipped on the connect side and thus
the handshake would fail on the server side.  There's also the problem
that read_ready may indicate an error.  And POLLERR is only set if the
socket is polled for POLLOUT so a failing connect would go unnoticed.

In short, the whole code is written under the assumption that any sane
application calling nonblocking connect would always call select/poll to
check if connect succeeded in the first place.  Obviously, as postfix
shows, this is a wrong assumption.=20

I'm not yet sure how to fix this, but I'll look into this next week.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--DwoPkXS38qd3dnhB
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUOB+tAAoJEPU2Bp2uRE+gdaIP/2o0/rqzn3kCE/2tcX6rDnit
ZLVAFfiBjJjS75lFWQ5bDM0R2HcHVUUhoU60YE8zOwoSnrggMXmxM1qBBrhIGs24
SvZ81uyezkm6NWXoafyUmEhwVkSNm6ePqUJGBw2rB3PKTDSimct3GTsY6TcJiJP7
6anGCw0RhFoYQyYwHi6spAaOIHVqJ5f9BI7qVdY8B+k+ZOlPv4ZSCoUrGYHbB/G7
6Ucy5PWuROXyE05Cx3JxMieL4iIbnZR6mtZIkRvrXrPkJhNPihwrb9h/THOPFh3q
EoQcV3BMGVSXjLWVraTgd4xo5QP64wgw1eBhyj12hMn/7sjoWkmkgjbtB3jj0zXl
jYI9x0PgqSBb24kvJoErVWion6sCjsvYIPWW4g1l2VzLquZDv/BIjOPdR9tDcaE/
Wf/ZeesI+zOPpN/cvYxozhpFpNLapsZw51voajjk9TihzeNEICYT6mzAcKTUIUvX
NzujDgPAJa2rpMP7EZM1n8L86QX5aYexpLLh8jVpSiRp1Y5YkKkPuod03n3EXEnW
tyHoatQPZwOL8ZP2HWApwqwrhNnLPcuzCzbEa/Ol2AhM0hPwRo60Q7bGkZV0ookJ
ZbmIo7DW5Mtnxd9+jGKRZzicKeMKsJ9heQlavedfYi6/bBfXbn9+pEejG8uB1PcO
Tlvi4GNkNNZdEhoXGQog
=sRcE
-----END PGP SIGNATURE-----

--DwoPkXS38qd3dnhB--

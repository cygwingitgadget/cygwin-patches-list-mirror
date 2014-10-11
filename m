Return-Path: <cygwin-patches-return-8027-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10089 invoked by alias); 11 Oct 2014 18:36:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10077 invoked by uid 89); 11 Oct 2014 18:36:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 11 Oct 2014 18:36:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 01EA08E0A26; Sat, 11 Oct 2014 20:36:44 +0200 (CEST)
Date: Sat, 11 Oct 2014 18:36:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Disable AF_UNIX handshake with setsockopt(..., SO_PEERCRED, ...)
Message-ID: <20141011183644.GS2681@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <54240D45.6080104@t-online.de> <20141009175956.GF2681@calimero.vinschen.de> <5436D241.3070104@t-online.de> <20141010110752.GA14455@calimero.vinschen.de> <54380B0E.7020803@t-online.de> <20141010180429.GO2681@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="NhBACjNc9vV+/oop"
Content-Disposition: inline
In-Reply-To: <20141010180429.GO2681@calimero.vinschen.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q4/txt/msg00006.txt.bz2


--NhBACjNc9vV+/oop
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2692

On Oct 10 20:04, Corinna Vinschen wrote:
> On Oct 10 18:36, Christian Franke wrote:
> > After a nonblocking connect(), postfix calls poll() with pollfd.events =
=3D
> > POLLIN only. If poll() succeeds, it calls recv(). This fails with ENOTC=
ONN
> > because the state is still connect_pending.
>=20
> Oh.  So it doesn't check if the connect succeeded?  Does it check the
> poll result for POLLERR or does it explicitely check for revents=3D=3DPOL=
LIN?
>=20
> Hmm.
>=20
> [...time passes...]
>=20
> It looks like you catched a long-standing bug here.
>=20
> This isn't even AF_LOCAL specific.  The original comment in the
> write_selected branch is misleading: The AF_LOCAL specific part is just
> the call to af_local_connect, not setting the connect_state.  There was
> a previous, longer comment at one point which I shortened for no good
> reason in 2005:
>=20
>   /* eid credential transaction on successful non-blocking connect.
>      Since the read bit indicates an error, don't start transaction
>      if it's set. */
>=20
> However, If I'm not completely mistaken, your patch would only work in
> the aforementioned scenario if setsockopt(SO_PEERCRED) has been called.
> Otherwise the handshake would be skipped on the connect side and thus
> the handshake would fail on the server side.  There's also the problem
> that read_ready may indicate an error.  And POLLERR is only set if the
> socket is polled for POLLOUT so a failing connect would go unnoticed.
>=20
> In short, the whole code is written under the assumption that any sane
> application calling nonblocking connect would always call select/poll to
> check if connect succeeded in the first place.  Obviously, as postfix
> shows, this is a wrong assumption.=20
>=20
> I'm not yet sure how to fix this, but I'll look into this next week.

I applied a fix which, I think, is much more elegant than the former
solution.  The af_local_connect call is now called as soon as an
FD_CONNECT event is generated and read by a call to wait_event.  It
worked for me, so I have tender hopes that I didn't miss something.

I also applied your patch on top of this new stuff and I'm just building
a new developer snapshot for testing.  In setsockopt I added a check for
socket family and type so setsockopt(SO_PEERCRED) only works for
AF_LOCAL/SOCK_STREAM sockets, just as the entire handshake stuff.  I
also added a comment to explain why we do this and a FIXME comment so we
don't forget we're still looking for a more generic solution for the
SO_PEERCRED exchange.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--NhBACjNc9vV+/oop
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUOXi8AAoJEPU2Bp2uRE+gBEoQAJFEWT6bLc5WhSH2CCrH3i/B
bmf6w5/m3ETwaoiBzm4Rq4hJMVjXKDSTxPSfzJ2WSTC4JRrEujz5y8ng4jTCtdSh
cWg8Nye5FBzan+0lZr601tGyVI/suSFt51BGNdbDfgTQ6MogeLUj9UmJljDAF+hZ
wsj+UNSfnj3xEzdfCBReJGKClc/68lLohxIBCXlXPKl5MTCCDTrzH5vZjX1Y2FhI
QchGbU2HYpE2UZCVuokHSvNyqnAChJvsC/pe4e/FtvZEmnFG94Zt/3TLNEq02/or
YQn9k5CRmM7TQueQ5r+85U1M0H7BBKIbfgA/5oOS0NFZNMEc236+mJaC/0yfaLzo
Cj+2O0lKEYRcc15AFLs5eK15CEyZe1XnGnaZT5vg7lUrV/HrSN7SKnYVIym76f5w
JhbH9jo3b7sM3LEPnIkfzTEZ+VOlqrvFCZdla7j1mMRJAnJVCb58x5jBWdVslJXa
JKvFOjenS/QL8Jm4R7tw+bmMJcBSyvOO/C62LRiPk/mUJnnHyaR+U8Jr4uJzf9g+
CmTuZdA5Y/hOpE8J5gq8dO11RyMqRynK+KCtVNEfuSRkUOVHB32b3IKxWdqf2PRV
tk5jpNfeBOZzJ3dJQJuzbugutWNAwlwIemHVm9qnTLXG8O1Ur80Y9sJi83tnSpKi
keaawVs4N+PszunoHUWJ
=gCZT
-----END PGP SIGNATURE-----

--NhBACjNc9vV+/oop--

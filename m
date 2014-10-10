Return-Path: <cygwin-patches-return-8024-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23456 invoked by alias); 10 Oct 2014 11:07:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23442 invoked by uid 89); 10 Oct 2014 11:07:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 10 Oct 2014 11:07:54 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 170F88E0A26; Fri, 10 Oct 2014 13:07:52 +0200 (CEST)
Date: Fri, 10 Oct 2014 11:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Disable AF_UNIX handshake with setsockopt(..., SO_PEERCRED, ...)
Message-ID: <20141010110752.GA14455@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <54240D45.6080104@t-online.de> <20141009175956.GF2681@calimero.vinschen.de> <5436D241.3070104@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <5436D241.3070104@t-online.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q4/txt/msg00003.txt.bz2


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1291

On Oct  9 20:21, Christian Franke wrote:
> Corinna Vinschen wrote:
> >>+int
> >>+fhandler_socket::af_local_set_no_getpeereid ()
> >>+{
> >>+  if (get_addr_family () !=3D AF_LOCAL || get_socket_type () !=3D SOCK=
_STREAM)
> >>+    {
> >>+      set_errno (EINVAL);
> >>+      return -1;
> >>+    }
> >>+  if (connect_state () !=3D unconnected)
> >          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'
> >
> >Wouldn't it make sense to allow this call in the "listener" state as wel=
l?
>=20
> It should work, but I don't see any real world use case.

Indeed.  Another question, though.

I was just looking into applying your patch when I got thinking over the
change in select.cc once more.  You're setting the connect_state from
connect_pending to connected there when there's something to read on the
socket.

This puzzles me.  A completed connection attempt should set the
write_selected flag (see function peek_socket).  The AF_LOCAL handling
in the

  if (me->write_selected && me->write_ready)

case in set_bits should cover this.  What situation is your special case
covering which is not already covered by the write_selected case?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUN74HAAoJEPU2Bp2uRE+g4g0P/1tv51C9xBByCJLeAGsR15kw
b3Z0HGupd0mqfYjc8jkXXC6FqKur0hMAeiz/fVtNXGe8FoxPJgEhsK93EanYlKWV
qHGnq7mEOaKrsPsbjHc9NiSfncaeUdTqpsqLkrZQuT5hGvaXWc3IwgJtGO5OyRsi
yEqD8NQLK7/9vrQsbYfPMN0FA1ssmiePQQPEyhpSEHKXCALNq3hh6RgoP8oxG0Vz
e9umd1IULMaOlowXpgRJld9FUXIwFF47yXPhrMMWPrSZtbMPGZql084xV1rQsktw
WqszDDh6EH0ZlSbIaxP+vCbB8wDqw7cmPE+Di/sUQfPvv6je/YoIhegM7WTUwLB0
gMwxZK4aj8/psaSHeK/xf/2LEAWbWEsdsdEvF5COaZEAd9tH+1hC78iUpZKm4aqy
hssAP1kJvK/4y3Cux2Dla4FjWDMEpBMMtx6Q7eNhsSZuHxu6fN4qdmqQiCeJXxKn
QMzBTtCVYwzYZliLyEDglasmECqMh5DGaEaT3tkvIrABEwl6NbpW0B22nZOfFl28
NBN84qeQXc4vHVHxpNdgW+MRtjrbvo3VpFhtY0Jlo6p3+A6ypAOBgTsCXXsqHdJw
hiNjC3T7XPLwK3QHmOQw4Yi1bE5x69rDF3MO1LXTGbXBaXWNaSOGA+D2apnafuvV
bcfr8u15WuW4Gjze0lKL
=tgri
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--

Return-Path: <cygwin-patches-return-9219-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100389 invoked by alias); 23 Mar 2019 20:03:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98877 invoked by uid 89); 23 Mar 2019 20:03:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Programming, HX-Languages-Length:2651, HTo:D*cornell.edu, folks
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 23 Mar 2019 20:03:02 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MnIxu-1ggBnQ3kCS-00jMHA; Sat, 23 Mar 2019 21:02:56 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1A729A80751; Sat, 23 Mar 2019 21:02:55 +0100 (CET)
Date: Sat, 23 Mar 2019 20:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH fifo 0/8] Allow a FIFO to have multiple writers
Message-ID: <20190323200255.GC3471@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20190322193020.565-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <20190322193020.565-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00029.txt.bz2


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2697

Hey Ken,

On Mar 22 19:30, Ken Brown wrote:
> Currently a FIFO can have only one writer.  A second attempt to open
> the FIFO for writing blocks while fhandler_fifo::open waits for the
> read_ready event to be signalled.
>=20
> This patch series tries to fix the problem by having the reader open
> multiple instances of the Windows named pipe underlying the FIFO.
> When the FIFO is opened for reading, a 'listen_client' thread is
> created that listens for clients (writers) to connect to the pipe.  It
> creates new pipe instances as needed.
>=20
> fhandler_fifo::raw_read loops through the connected writers, checking
> for input.
>=20
> I've tested it by running the fifo client and server programs from
> Chapter 44 of the book "The Linux Programming Interface: Linux and
> UNIX System Programming Handbook" by Michael Kerrisk.  (See
> https://cygwin.com/ml/cygwin/2015-03/msg00047.html for simplified
> versions of these programs.)  These work as on Linux.
>=20
> I've also tried the test given in
> http://www.cygwin.org/ml/cygwin/2015-12/msg00311.html.  It works as on
> Linux also.
>=20
> TODO:
>=20
>  - Try to get the code to work for duplexers (FIFOs opened for reading
>    and writing).  I haven't thought about this at all yet.
>=20
>  - Think about what it would take to allow multiple readers.  I'm not
>    very optimistic about this, but my impression is that the
>    multiple-writer case is more important in practice.
>=20
> Ken
>=20
> Ken Brown (8):
>   Cygwin: FIFO: stop using overlapped I/O
>   Cygwin: FIFO: allow multiple writers
>   Cygwin: FIFO: add a spinlock
>   Cygwin: FIFO: improve EOF detection
>   Cygwin: FIFO: update clone and dup
>   Cygwin: FIFO: update fixup_after_fork
>   Cygwin: FIFO: update set_close_on_exec
>   Cygwin: FIFO: update select
>=20
>  winsup/cygwin/fhandler.h       |  58 ++-
>  winsup/cygwin/fhandler_fifo.cc | 732 +++++++++++++++++++++++++++------
>  winsup/cygwin/select.cc        | 161 +++++++-
>  winsup/cygwin/select.h         |   7 +
>  4 files changed, 819 insertions(+), 139 deletions(-)
>=20
> --=20
> 2.17.0

Your patch series looks really good.  For now I pushed it into the
topic/fifo branch as you suggested.

Just be aware that it won't get much 3rd party testing this way, so as
soon as you feel more confident, let's move it into master.  At that
time I'll create a Cygwin 3.0.y branch for bugfix releases, but the
snapshots will continue to be created from master so we get at least
*some* folks testing it.

A big thank you already!

Oh, there's obviously a downside to this, too:  You'll have to create
a release note for this change at one point ;)


Thanks again,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyWkO4ACgkQ9TYGna5E
T6BCWQ//QTiNpM8Qtvk3dRWSlwn+OEq0x/id7P6s1rZOeHhQpgoJyf14p2krgIRe
FUml9SrroYKlLXjdpmlf175qq6cZkrsn+r23CcN9TcfJnirDukNtgAH8cDK41TfK
T+QIiEI8F5NFSJhsHuyMT2rHs+Nl3Rq189MNyIHAp6i0Q6Z0cHtq+vxT94hH/n41
VxyyEJRE+JGLQr7Qa9Jh4/WLiP9kcwhOtfPdPiIr+HnevL0PQYeNTO314ap1oI56
6bRAgEcknXEPsXHppefZkvu/kD1kz7yT78RhsK2rO5fBQ/gAlXSMKUac6WP2dtzM
4bH0MqZlk6IH9aOaXP1RaxtBYeC5bzKxXP8H/ft7EpoVy37dGhGXG4BgRZT0qxse
kPtmv+24yPCgyoieIsKx/wG2A13dzqgQ+mWG/a0VmUSs/V6Q8NgGZbCMZE12+chE
Rl7bwmg1jVLI4eHdDYiR/EZGdHEt/PDbsZ6jaO/4kSQJhLz7LXyZqumpd1PoF5l0
XeH+7uwRdaGQaM+FfLS1s+KtgIXv1pQl/a8MAnL4oy9pRb+mW519n58mUgzV12lI
yJlb0bNagHMdaSyupAMcAr49YZnm4GforbAL0Y2/SplCzIPJq/aKYMp2z0L/0Vnb
drM+2GwORGF4X1UBseJ25VJzJY+CToM5pUcCSjC1pm1atTtSfaE=
=AdUR
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--

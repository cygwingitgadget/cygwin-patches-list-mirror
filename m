Return-Path: <cygwin-patches-return-9389-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8448 invoked by alias); 29 Apr 2019 19:06:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8438 invoked by uid 89); 29 Apr 2019 19:06:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=listening, pipes, H*f:sk:93c33c8, H*i:sk:93c33c8
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 29 Apr 2019 19:06:18 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N7Qgn-1giWsc0CaL-017pVS for <cygwin-patches@cygwin.com>; Mon, 29 Apr 2019 21:06:15 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7125DA80784; Mon, 29 Apr 2019 21:06:14 +0200 (CEST)
Date: Mon, 29 Apr 2019 19:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
Message-ID: <20190429190614.GL3383@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190325230556.2219-1-kbrown@cornell.edu> <6fbdf204-4be5-24b8-1df3-aa5d6589619b@cornell.edu> <93c33c8d-e303-9a06-f5da-4e6d8b7f195c@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <93c33c8d-e303-9a06-f5da-4e6d8b7f195c@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00096.txt.bz2


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1686

On Apr 29 18:42, Ken Brown wrote:
> On 4/29/2019 2:29 PM, Ken Brown wrote:
> > On 3/25/2019 7:06 PM, Ken Brown wrote:
> >> The second patch in this series enables opening a FIFO with O_RDWR
> >> access.  The underlying Windows named pipe is created with duplex
> >> access, and its handle is made the I/O handle of the first client.
> >>
> >> I tested the patch in two ways.
> >>
> >> First,
> >=20
> > [...]
> >=20
> >> The second test was the following sequence of commands in a bash
> >> shell:
> >>
> >> $ mkfifo foo
> >>
> >> $ exec 7<>foo
> >>
> >> $ echo blah > foo
> >>
> >> $ read bar <&7
> >>
> >> $ echo $bar
> >> blah
> >=20
> > I just realized that this doesn't test *writing* to the fd of a FIFO
> > opened with O_RDWR.  If I change the third command to "echo blah
> > >&7", it does test this, and the write fails with ECOMM.  It turns
> > >out that the call to NtWriteFile in fhandler_fifo::raw_write fails
> > >with STATUS_PIPE_LISTENING.
> >=20
> > Corinna, I'll try to debug this, but since I know you're about to be
> > AFK for a month, I thought I'd check to see if you have any idea why
> > this would happen.
>=20
> Actually, the answer might be obvious.  Looking at MSDN, it now seems
> clear to me that you can't do I/O on the server side of a pipe until
> the pipe connects to a client.  So I'll have to rethink how to deal
> with the O_RDWR case.

Sorry being late, but yeah, STATUS_PIPE_LISTENING means no client is
connected.  This is one of the more ugly implementation details of
Windows pipes.  There just isn't a generic buffer which can be filled
even if no one is listening yet on the other side :-P


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlzHSyYACgkQ9TYGna5E
T6CKGxAAli2Mn/d4L1NSIw0rOeYJa9s+t2uVGTfFteyh7+loWN+6aZTTrOinG4S1
QqkAKDMc0+VrhlxHJVtADuN2LFHY4dhmM+vPMBW6s4XiLXEjhDQboSFIRzYIyXRd
HuuiSa2yNoYBMGgtf6PxsZ1SIESj0+yWUru9isz0A4C3lXAcYpftfHUN9KewB/50
GlDaqTvLuXtPzuhGwBcY9VxsqFoZmsZcVRqU7r8I1ZRfZYhjblRsiRv4wWye0IHV
wqGnSt3mjhWPr31MjJ4/w32vCIErAU4WumGEd6F1NZCz+2DuVqocynxbSao1QM0M
V0c5U8zUU6hy5Wn9NxBmqZSmAF2fGv+ogPaC6XiK1oThJRzXQGlbVGft3y6SQiFl
dGX0QgWkLUY28KUp6vl7UbZPLWv2vcubKQUeZIS1zOOJ/NM31nOz1xNj38xeK7Ow
7ciP/YC/xRx7nBVJJ0Pln/aB+45aXoA+8kcPCa6VvKyBNi1PUDp4JvANdozhZemh
Sk91WbNqZk7ov1v7neUTf+UkRCbj9AVUQrEvevZ2PE2TEmzS3AQRdwjV8JgtR7Zp
4DYGbuubZ0uWvQEDBXtVZS+HRGQA9adsF6rhReCUcww0u5nvOqw+Kw89lKREVbY5
FBPou5nBMDfsWS4e6mBnxEaSbuZt7sH4EocpHUsjeeV1cyNTduM=
=iOBZ
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--

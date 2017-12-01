Return-Path: <cygwin-patches-return-8955-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10019 invoked by alias); 1 Dec 2017 09:30:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9589 invoked by uid 89); 1 Dec 2017 09:30:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-102.0 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=excited, re-open, utilizing, Hx-languages-length:4302
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Dec 2017 09:30:24 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 9257871B09916	for <cygwin-patches@cygwin.com>; Fri,  1 Dec 2017 10:30:08 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 2960A5E0291	for <cygwin-patches@cygwin.com>; Fri,  1 Dec 2017 10:30:05 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8F1BFA81810; Fri,  1 Dec 2017 10:30:07 +0100 (CET)
Date: Fri, 01 Dec 2017 09:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
Message-ID: <20171201093007.GA25276@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com> <20171128105334.GQ547@calimero.vinschen.de> <20171130103440.GA14313@calimero.vinschen.de> <Pine.BSF.4.63.1712010030250.24559@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1712010030250.24559@m0.truegem.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00085.txt.bz2


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 4352

On Dec  1 00:44, Mark Geisert wrote:
> On Thu, 30 Nov 2017, Corinna Vinschen wrote:
> > On Nov 30 01:50, Mark Geisert wrote:
> > > Yes, I believe that's correct.  But in my aio implementation for Cygw=
in, I'm
> > > not using overlapped I/O or any kind of async or nonblocking write. I=
'm
> > > using separate threads to do plain vanilla blocking writes (via pwrit=
e if
> > > able).  I'm doing this because I'm operating with user-supplied file
> > > descriptors that might or might not be underlain with async-capable W=
indows
> > > handles.
> > >=20
> > > (It's my understanding that if one wants to do overlapped I/O on a Wi=
ndows
> > > handle, one has to request that explicitly when creating the handle. =
 I
> > > don't think Cygwin does this by default.  Corrections welcome.)
> >=20
> > Right, Cygwin opens files with FILE_SYNCHRONOUS_IO_NONALERT by default,
> > unless it's a handle for meta operations only.
> >=20
> > But then I don't understand in what situation you see pwrite return a
> > STATUS_PENDING.  This should only occur with async I/O.
> >=20
> > > So in this environment seeing pwrite() return with a short write coun=
t, even
> > > though it's understandable that the underlying Windows write might st=
ill be
> > > underway, is a real problem.
> >=20
> > Something's really fishy here.  A synchronous write should *never*
> > return with STATUS_PENDING.  This breaks so many assumptions, Cygwin
> > wouldn't practically work at all.
> >=20
> > > A blocking pwrite() (i.e., not overlapped or async in any way) has to=
 wait
> > > for the underlying NtWriteFile() to complete in order to get a correc=
t write
> > > count and/or correct final status code, doesn't it?
> >=20
> > Yes, in theory, but if you use the default handles opened by
> > fhandler_base::open, pwrite should wait as is because NtWriteFile
> > doesn't return prematurely.
>=20
> I'd better take this info back to "the lab" and do some more digging. Tha=
nks
> very much for these details and your earlier replies.  When I saw
> FILE_SYNCHRONOUS_IO_NONALERT in your reply, I remembered that I'm not usi=
ng
> a Cygwin-supplied handle but rather a handle returned by Win32 CreateFile=
().
> Not only that, but using cygwin_attach_handle_to_fd() to get an fd to work
> with.

Ouch.

> And then pwrite() creates its own handle (or reuses one (!)) to avoid
> messing up the seek pointer of the fd passed in.

Wait.  Not "re-use", but "re-open".  If you're more familiar with POSIX
terms, this is along the lines of the fdopen(3) call, just on the NT
API level.  There's an equivalent Win32 function since Windows 2003
called ReOpenFile.

In terms of pread/pwrite, the new handle shares the same settings with
the original handle.  However, if you use cygwin_attach_handle_to_fd,
there's a chance information got lost.  Nobody actually uses this call ;)

In terms of FILE_SYNCHRONOUS_IO_NONALERT, this is stored in
fhandler_base::options, utilizing the get_options/set_options methods.
I have a hunch that cygwin_attach_handle_to_fd fails to call set_options,
thus options is 0 when you call pwrite, thus the new handle is opened
without FILE_SYNCHRONOUS_IO_NONALERT and all the other option flags
we use by default.

> I'm not specifying FILE_FLAG_OVERLAPPED, which is the only control one has
> over async- or sync-ness in Win32.  But maybe it's getting added somewhere
> on the way through these layers.  Is there a way to query handle attribut=
es
> in order to find out if a handle is sync or async?

NtQueryInformationFile with info class FileModeInformation.

However, I was thinking about using threads for aio.  Do we really need
them?  Should't it be fairly easy to implement aio with the stuff we
already have, just by using an asynchronous handle?  We could utilize
fhandler_disk_file::prw_open to open a handle always asynchronous and
the pread/pwrite functions to get an extra parameter to indicate if
it should wait for completion (ordinary pread/pwrite) or if it should
just return (called for aio operation).

> Thanks again,

No worries.  I' m pretty excited that you work on this aio stuff.
This is one of the block of functions I'm kicking down the road
for much too long...


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaISEfAAoJEPU2Bp2uRE+g0l4P/R4SFNx4wBjc2K3b1Sf53on2
qhd+ERX0g+Sln5u5WLRbE8ulHPaHsh0BxwlWqNjBB7DNnRukGX0qxP2/GtLx04TY
+AU/xZvNjirJ6WDYQa+eWgLeWLAqxcu9hBmGBWbrjofmszNow8cN77mqszbSTvDK
ilgGKb2Slc6Aue+ysU5u84Zm46CenK/2DQxxOK9dI29dHmkgKinslmTQsroqxFFM
8JAjRb/NnmCDD33aTtt8/ujvfuVrupLdQVDzdZdbb46kBXp9Lywuv8hIBQ+hb6qN
3RdGut1BOSL2LX8x8/T0j1W3r6vLESChSyi4E0MkB1rnrRuEui/2VVRyhVHhU8pd
OQpUwjK6rgqptRkoFCSC7p0nsHVrWiCqu025b7K4el6v7Xej+M1EQah+sGIKa0/A
OwmFULATlII8WvFDEebNJNbaktlW+qW935wgXf2Z2XDlVeysm2iZC4tCfIwgXUhG
Wmm/WwoAnajKJY4TjP5c7bQqOXvGoj5qE6Ar56XAbWRnsD50820nDnRRLNl5yMqg
8uqT2fejSHjKxUFjVwa/HMOlHokT54UVj+BgpHhpxCWS+en9UEwcvVZazBQGvG5I
/I4J4a4OcQpSdHDVneR89KS4X4j9Iixz3Q7++U0E92Ty0I2r5tjWIMzQwteK2oQh
cQRsz7lgZCSbg4uob26H
=SPl6
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

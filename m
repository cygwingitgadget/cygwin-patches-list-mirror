Return-Path: <cygwin-patches-return-8953-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104362 invoked by alias); 30 Nov 2017 10:34:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104348 invoked by uid 89); 30 Nov 2017 10:34:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-102.1 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=egg, afford, underway, Hx-languages-length:3071
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 30 Nov 2017 10:34:44 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 56EDD71A3A991	for <cygwin-patches@cygwin.com>; Thu, 30 Nov 2017 11:34:41 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 2E8345E0055	for <cygwin-patches@cygwin.com>; Thu, 30 Nov 2017 11:34:38 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A17D0A8074C; Thu, 30 Nov 2017 11:34:40 +0100 (CET)
Date: Thu, 30 Nov 2017 10:34:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
Message-ID: <20171130103440.GA14313@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com> <20171128105334.GQ547@calimero.vinschen.de> <20171129123806.GF547@calimero.vinschen.de> <Pine.BSF.4.63.1711300129090.59306@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1711300129090.59306@m0.truegem.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00083.txt.bz2


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3129

On Nov 30 01:50, Mark Geisert wrote:
> On Wed, 29 Nov 2017, Corinna Vinschen wrote:
> > On Nov 29 13:36, Corinna Vinschen wrote:
> > > On Nov 29 13:04, Corinna Vinschen wrote:
> > > > - If you do async IO, you have to handle STATUS_PENDING gracefully:
> > > >=20
> > > >   - The IO_STATUS_BLOCK given to NtWriteFile *must* exist for the
> > > >     entire time the operation takes after NtWriteFile returned
> > > >     STATUS_PENDING.  An IO_STATUS_BLOCK fhandler member comes to mi=
nd,
> > > >     maybe fhandler_base_overlapped::io_status can be reused.
> > >=20
> > > No, wait.  There can be more than one outstanding aio operations on t=
he
> > > same descriptor.  Therefore the IO_STATUS_BLOCK must be connected to =
the
> > > aiocb struct one way or the other, becasue only that struct is local =
to
> > > the aio operation.
> >=20
> > I guess that's what the Linux man page aio(7) subsumes under
> >=20
> >  struct aiocb {
> >    [...]
> >=20
> >    /* Various implementation-internal fields not shown */
> >  };
>=20
> Yes, I believe that's correct.  But in my aio implementation for Cygwin, =
I'm
> not using overlapped I/O or any kind of async or nonblocking write. I'm
> using separate threads to do plain vanilla blocking writes (via pwrite if
> able).  I'm doing this because I'm operating with user-supplied file
> descriptors that might or might not be underlain with async-capable Windo=
ws
> handles.
>=20
> (It's my understanding that if one wants to do overlapped I/O on a Windows
> handle, one has to request that explicitly when creating the handle.  I
> don't think Cygwin does this by default.  Corrections welcome.)

Right, Cygwin opens files with FILE_SYNCHRONOUS_IO_NONALERT by default,
unless it's a handle for meta operations only.

But then I don't understand in what situation you see pwrite return a
STATUS_PENDING.  This should only occur with async I/O.

> So in this environment seeing pwrite() return with a short write count, e=
ven
> though it's understandable that the underlying Windows write might still =
be
> underway, is a real problem.

Something's really fishy here.  A synchronous write should *never*
return with STATUS_PENDING.  This breaks so many assumptions, Cygwin
wouldn't practically work at all.

> A blocking pwrite() (i.e., not overlapped or async in any way) has to wait
> for the underlying NtWriteFile() to complete in order to get a correct wr=
ite
> count and/or correct final status code, doesn't it?

Yes, in theory, but if you use the default handles opened by
fhandler_base::open, pwrite should wait as is because NtWriteFile
doesn't return prematurely.

> ..mark
>=20
> P.S. I'll look into IRC clients.  You've suggested it before and I just
> recall the wild IRC days in the 90s with egg drops and bots and bans and =
it
> seemed like a time sink I couldn't afford.  Maybe #cygwin-developers
> on freenode is more civilized :-)).

Freenode is pretty civilized anyway.  As IRC client I suggest weechat.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaH97AAAoJEPU2Bp2uRE+grqQP+wbNsaUezG2HmobpGMwNHiKQ
5WT/Uow97mlY4nZ7qmXEkoJSOC+XHRB8ThqVUF2QFRNJyny6ssoQKDBAUCgM3MKF
66mtlW1dIedTcBcRjObDnB9SrsbCo4Wk0H3OiwZoSixF7vTGiJ3NLN+SL7Ouk3W5
su/ZHNMUs24+eJBNnxzYAOrMbkQdkb2aiPxHysNfiKKFNx1/WmvE0AdDiAtd5M0T
Yy+kPZJYNg0dFHpW3bjTiVHAYfAk7LV/oQvdfEHI5Bs28F003jENqqGKOHdV9vHp
ob3s2mKzWI2vnvP8djmwRsHQaAg0aSI2fWyuRlHW6iMerY08o2+Tt/wv8gXKbu84
UpXUtu8ilEsElS8caoWckvSJcML0Z8SrDJuaEuOGwQOtP5oJt9cij2yVFpAz+0/l
++hwbSgHuglJhUVaBCQabi5ELHp52RKlYW29O/d66QKD7IPtIdMMsV170evqlsO8
JJsIvNu2gW4vzWykRtO1OwaaDfx6SvYXcpgiR3R+PywkQ8qaEIhcgzX75k/K/8vL
cyT2u9qyj2Qlw8L2YTMxCI2NHJ/Z0MtMpkMwqVKU0rFhkC9zuMmVAvgIscJo44ws
RUCJFTh9oAMRH/ELp2Qj6iyuSrcyt4z/FLDat0Fkv9WYm7qzZiJTGEK+G0lm4Byt
OOtysNiVjryLQEWqGn1a
=Iqnb
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

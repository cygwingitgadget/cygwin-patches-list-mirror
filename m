Return-Path: <cygwin-patches-return-8942-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130254 invoked by alias); 29 Nov 2017 12:04:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130214 invoked by uid 89); 29 Nov 2017 12:04:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-100.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,UNSUBSCRIBE_BODY autolearn=ham version=3.3.2 spammy=wits, collecting
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Nov 2017 12:04:41 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 676DA721E281A	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 13:04:38 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 4572D5E0418	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 13:04:35 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AFB23A81808; Wed, 29 Nov 2017 13:04:37 +0100 (CET)
Date: Wed, 29 Nov 2017 12:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
Message-ID: <20171129120437.GC547@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com> <20171128105334.GQ547@calimero.vinschen.de> <e7c6061c-be0e-5c36-b135-5796f9cd5da0@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="NqNl6FRZtoRUn5bW"
Content-Disposition: inline
In-Reply-To: <e7c6061c-be0e-5c36-b135-5796f9cd5da0@maxrnd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00072.txt.bz2


--NqNl6FRZtoRUn5bW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 4504

On Nov 29 02:25, Mark Geisert wrote:
> Corinna Vinschen wrote:
> > On Nov 28 02:28, Mark Geisert wrote:
> > > Corinna Vinschen wrote:
> > > > On Nov 28 00:03, Mark Geisert wrote:
> > > > > Oops, I neglected to include an explanatory comment. Issuing simu=
ltaneous
> > > > > pwrite(s) on one file descriptor from multiple threads, as one mi=
ght do in a
> > > > > forthcoming POSIX aio implementation, sometimes results in garbag=
e status in
> > > > > the IO_STATUS_BLOCK on return from NtWriteFile(). Zeroing beforeh=
and made
> > > > > the issue go away.
> > > > > [...]
> > That doesn't mean it has been returned by NtWriteFile.  Random values
> > suggest NtWriteFile didn *set* a value in the first place, so what
> > you see is the random value from the stack position io is in.  And
> > that in turn suggests the status code should indicate why io wasn't
> > written by NtWriteFile.  If you're playing with async IO, is it possible
> > the status code indicates something like STATUS_TIMEOUT or STATUS_PENDI=
NG,
> > both of which are treated as NT_SUCCESS?
> > [...]
> I added the printf()s and, what do you know, it shows all the NtWriteFile=
()s
> are returning STATUS_PENDING.  On return some of the IO_STATUS_BLOCKS hav=
e the
> correct byte count but most of them have the same trash as before the cal=
l.

This is just a timing problem, see below.

> [...]
> Does this mean pwrite() should be waiting for the status to change from
> STATUS_PENDING to something else before returning?

MSDN has the following to say about this situation:

  The operating system implements support routines that write
  IO_STATUS_BLOCK values to caller-supplied output buffers. For example,
  see ZwOpenFile or NtOpenFile. These routines return status codes that
  might not match the status codes in the IO_STATUS_BLOCK structures. If
  one of these routines returns STATUS_PENDING, the caller should wait
  for the I/O operation to complete, and then check the status code in
  the IO_STATUS_BLOCK structure to determine the final status of the
  operation. If the routine returns a status code other than
  STATUS_PENDING, the caller should rely on this status code instead of
  the status code in the IO_STATUS_BLOCK structure.

STATUS_PENDING means the operation hasn't been finished yet, but that
only means that the IO_STATUS_BLOCK wasn't filled with correct information
when NtWriteFile returned.
^^^^^^^^^^^^^^^^^^^^^^^^^

So, after NtWriteFile returns with STATUS_PENDING it will still write
the completion status into the IO_STATUS_BLOCK parameter, as soon as it
finished its job, even if that takes a long time.

debug_printf of course takes time itself, so what happened in the
io.Infomation =3D=3D 0x1000000 case was that NtWriteFile finished its job
while debug_printf was still collecting its wits.

The other NtWriteFile calls just didn't finish their job in time for
debug_printf to already get the completion status.

So what does that mean for us?

- If you don't do async IO on files, you're completely off the hook,
  because NtWriteFile will never return with STATUS_PENDING.

- If you do async IO, you have to handle STATUS_PENDING gracefully:

  - The IO_STATUS_BLOCK given to NtWriteFile *must* exist for the
    entire time the operation takes after NtWriteFile returned
    STATUS_PENDING.  An IO_STATUS_BLOCK fhandler member comes to mind,
    maybe fhandler_base_overlapped::io_status can be reused.

  - You *must* call NtWriteFile with an event object as 2nd parameter,
    which will be signalled when NtWriteFile completes (and then the
    io.Status member indicates success or failure).  Otherwise you have
    no chance to implement aio_error or any aio_sigevent method.

  - And of course, you don't wait in pwrite for completion.  That
    would be counter to the idea of async I/O.  Rather, STATUS_PENDING
    means returning -1 with errno set to EAGAIN.

    On the other hand, aio_write would return 0 in this case, so calling
    pwrite for the purpose of implementing aio_write shouldn't set
    errno.  I guess changing pread/pwrite to return a negative error
    value may be the better approach.  The caller would then turn this
    into setting errno and a valid return value to user space.

I'd like to suggest the Freenode IRC channel #cygwin-developers for
discussion if something's unclear.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--NqNl6FRZtoRUn5bW
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaHqJVAAoJEPU2Bp2uRE+gLoAP/0NO42KLrs6FFqFgOybtVHDY
3B8xKG9TfBvmRtJ2piKzoHlSPGchyj33dbSBU+g+SHFvINPeGxPUNXi3mw9cN1G1
Gbd8vo+3K9GIvaiM5uQ9Ulp2fOd0eM21wF2PuS4lY54PPj2maPw5gwYF4bcCxYTc
5YOjCQnvQ0QMPjWCGYA9kiGvXAUlbPeImhAu8cvaLs+4E6NHHqtoi//GWq1DaZe6
0jQTYgnGB7TpiTGocg77T20XdVHC4ivw6M33FVsJbAjPdY7irjAuss21n6S/F1dy
yVSq9aDtoImD0ZnB2vUORuBAJirnGZkTClqs5nV0Hyo9rUlUOngANzEyEwEnWtZZ
B4//ObrN6IodhlaPgBZcEL427AzfCXQbxJRAAzmKZJd/lGFITqw9p3kFrHYE9i9U
u9OTExUXYxsgid7RU+4USV8FF8y2PRU9VA+mVFHuJVlIC2+nm6NfrZo5cGO3ibBu
J0M+oDv0sNONSivNQHT9k782nhViVyHLaGY7hR6SfXKGG6SEebJQea3vsJam7FC3
FJdZIseDpaVyDkuHGLJdQ94fvSDI8HtZhu3wq2+zZMLgjwJESwrpK7fb+Y5nX656
qoiZQn65WrkLZGAhOpi+9Xjj64XYHHXO1fxYSUeGql6ZWe2qTm9JMQftNnpHzTuG
SvRHA96CiafY9N0U2+rk
=5ydN
-----END PGP SIGNATURE-----

--NqNl6FRZtoRUn5bW--

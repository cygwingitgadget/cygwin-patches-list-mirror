Return-Path: <cygwin-patches-return-8938-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 49030 invoked by alias); 28 Nov 2017 10:53:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 49014 invoked by uid 89); 28 Nov 2017 10:53:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=findings
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Nov 2017 10:53:38 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 6FC3D721E281E	for <cygwin-patches@cygwin.com>; Tue, 28 Nov 2017 11:53:35 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 483715E020F	for <cygwin-patches@cygwin.com>; Tue, 28 Nov 2017 11:53:32 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B30C4A8072C; Tue, 28 Nov 2017 11:53:34 +0100 (CET)
Date: Tue, 28 Nov 2017 10:53:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
Message-ID: <20171128105334.GQ547@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline
In-Reply-To: <42633315-b082-232c-e310-31e05306d06f@maxrnd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00068.txt.bz2


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3831

On Nov 28 02:28, Mark Geisert wrote:
> Corinna Vinschen wrote:
> > On Nov 28 00:03, Mark Geisert wrote:
> > > Mark Geisert wrote:
> > > > ---
> > > >  winsup/cygwin/fhandler_disk_file.cc | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fh=
andler_disk_file.cc
> > > > index 5dfcae4d9..2ead9948c 100644
> > > [...]
> > >=20
> > > Oops, I neglected to include an explanatory comment. Issuing simultan=
eous
> > > pwrite(s) on one file descriptor from multiple threads, as one might =
do in a
> > > forthcoming POSIX aio implementation, sometimes results in garbage st=
atus in
> > > the IO_STATUS_BLOCK on return from NtWriteFile(). Zeroing beforehand =
made
> > > the issue go away.
> > >=20
> > > This is mildly concerning to me because there are many other uses of
> > > IO_STATUS_BLOCK in the Cygwin DLL that haven't seemed to have needed
> > > initialization.
> > >=20
> > > Puzzledly,
> >=20
> > Ok, let's start with, why did you tweak pread if you only observed
> > a problem in pwrite?
>=20
> Optimism? :-)  No, you're correct; I was getting ahead of myself.
>=20
> >                       In terms of pread, we already have a very recent
> > patch series:
> >=20
> > https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3D46=
702f92ea49
> > https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3Dc9=
83aa48798d
> > https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3D18=
1fe5d2edac
> >=20
> > In this case it turned out that the problem was related to hitting EOF.
> > I wonder if we hit a similar problem here.
> >=20
> > Two points:
> >=20
> > - Did you check the status code returned by NtWriteFile?  Not all non-0
> >   status codes fail the !NT_SUCCESS (status) test.
>=20
> I did check the status code but don't recall what it was.  The symptom I =
was
> seeing was outlandish io.Information values being returned by pwrite().  =
Far
> larger than the number requested in the call to pwrite() and NtWriteFile(=
).

That doesn't mean it has been returned by NtWriteFile.  Random values
suggest NtWriteFile didn *set* a value in the first place, so what
you see is the random value from the stack position io is in.  And
that in turn suggests the status code should indicate why io wasn't
written by NtWriteFile.  If you're playing with async IO, is it possible
the status code indicates something like STATUS_TIMEOUT or STATUS_PENDING,
both of which are treated as NT_SUCCESS?

> > - Do you have a simple, self-contained testcase?
>=20
> That would be difficult.  I can supply an strace excerpt just showing the
> region of these simultaneous pwrite() calls, without this patch.  If it's
> too large I'll put it somewhere and post a link (but I don't think it will
> be).

Alternatively, what you should do is adding debug_printf statements
before and after NtWriteFile, kind of like this...

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_d=
isk_file.cc
index 5dfcae4d9eb7..149c80484213 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1635,8 +1635,10 @@ fhandler_disk_file::pwrite (void *buf, size_t count,=
 off_t offset)
=20
       if (!prw_handle && prw_open (true))
 	goto non_atomic;
+      debug_printf ("Before NtWriteFile, io %Y", io.Information);
       status =3D NtWriteFile (prw_handle, NULL, NULL, NULL, &io, buf, coun=
t,
 			    &off, NULL);
+      debug_printf ("After NtWriteFile, io %Y, status %y", io.Information);
       if (!NT_SUCCESS (status))
 	{
 	  __seterrno_from_nt_status (status);

...and report your findings.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaHUAuAAoJEPU2Bp2uRE+gDqoP/i+/YIDsx1jwTZe2fdMHBXE4
0IS2M9U4vQ/H+hNc7o0CpVXgAJsbiKVrFK6sJT6rxYGF3Ro1nGfkOjCAj+3PKGfy
vkYPCJ6vDZF3vJAwcaEv5dlR3uTqoakcjCsXL3facmzw9p5P21TqvEcdJ8PVTOqm
ypafHokPigjyJakiiDmg7iJOXoUY93RnSZwfry6vZCwn9k6I+uTbz07F37TKepoN
L9J6KcqQZtYZeG3XlP5GdM5L+m1TK5DAN9HvlztnVo3AO0E9zw84EzSTr6p0dP7U
Fpv+XtxvW42mEf7SHscfbPPb5teO7kAhaQzpBOnD553TViEvPr/xOK6TyOdwWel+
/S3kjpZop8xBIHXOhvxWqj4xmOfmT/bt5f+paOoEgEJZ7cqQU0otx0kfSA3rLgsU
arraEXEv4A7RcufYMVoj54lnSSxFAreXfKI/j7WWxBuiN2mUIdL5hiykWhhSgejx
0zwLVmKDHrU4I4dTIBPEATgEI9ldLTlU5uULP2RYNNUMhdGpoX0XWzq1v9x8v1LL
sYGHez2T+o+T370vjXFHHdtydlI8RmZRLNo7AW4G2eAQiPe+QkW9vjycxZdkHt4W
RLRpTJApdoM2Rom0vfZ8tE1D1Fm6Liym+JkK4QDPLGdyQRLKob0l+0xyhX4CzDoU
dA4pdR7A8ydYBE6W7Ex1
=CfMc
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--

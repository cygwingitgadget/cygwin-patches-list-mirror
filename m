Return-Path: <cygwin-patches-return-8879-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67338 invoked by alias); 10 Oct 2017 12:44:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65833 invoked by uid 89); 10 Oct 2017 12:44:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, reserved, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Oct 2017 12:44:40 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 3D6C472106C11	for <cygwin-patches@cygwin.com>; Tue, 10 Oct 2017 14:44:37 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 7BA635E03B0	for <cygwin-patches@cygwin.com>; Tue, 10 Oct 2017 14:44:36 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 712E6A80C9D; Tue, 10 Oct 2017 14:44:36 +0200 (CEST)
Date: Tue, 10 Oct 2017 12:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: fix potential buffer overflow in fork
Message-ID: <20171010124436.GD30630@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1b4e1413-fa59-a954-f839-507abce7df11@ssi-schaefer.com> <20171010114832.GB30630@calimero.vinschen.de> <e6eb270a-1819-007c-d98e-c4f79177b3f7@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <e6eb270a-1819-007c-d98e-c4f79177b3f7@ssi-schaefer.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00009.txt.bz2


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2822

On Oct 10 14:26, Michael Haubenwallner wrote:
> On 10/10/2017 01:48 PM, Corinna Vinschen wrote:
> > Hi Michael,
> >=20
> > On Oct  9 18:58, Michael Haubenwallner wrote:
> >> When fork fails, we can use "%s" now with system_sprintf for the errmsg
> >> rather than a (potentially too small) buffer for the format string.
> >=20
> > How could buf be too small?
>=20
> See below.
>=20
> Actually I've found this by searching for suspect char array definitions
> while hunting the "uninitialized variable for RtlLookupFunctionEntry" bug.
>=20
> >> * fork.cc (fork): Use "%s" with system_printf now.
> >> ---
> >>  winsup/cygwin/fork.cc | 9 ++-------
> >>  1 file changed, 2 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
> >> index 73a72f530..bcbef12d8 100644
> >> --- a/winsup/cygwin/fork.cc
> >> +++ b/winsup/cygwin/fork.cc
> >> @@ -618,13 +618,8 @@ fork ()
> >>        if (!grouped.errmsg)
> >>  	syscall_printf ("fork failed - child pid %d, errno %d", grouped.chil=
d_pid, grouped.this_errno);
> >>        else
> >> -	{
> >> -	  char buf[strlen (grouped.errmsg) + sizeof ("child %d - , errno 429=
4967295  ")];
>=20
> Usually child_pid is longer than the 2 characters counted by "%d", but
> errno usually is shorther than the 10 characters counted by "4294967295",
> and there is another 2 reserved characters counted by trailing "  ".
>=20
> In practice the buffer unlikely will be too small, so this is merely cosm=
etics.

But buf is just the format string.  It won't get manipulated by
system_printf.  Which means the 4294967295 is nonsense, too, a %d
would have been sufficient.

> >> -	  strcpy (buf, "child %d - ");
> >> -	  strcat (buf, grouped.errmsg);
> >> -	  strcat (buf, ", errno %d");
> >> -	  system_printf (buf, grouped.child_pid, grouped.this_errno);
> >> -	}
> >> +	system_printf ("child %d - %s, errno %d", grouped.child_pid,
> >> +		       grouped.errmsg, grouped.this_errno);
> >>=20=20
> >>        set_errno (grouped.this_errno);
> >>      }
> >> --=20
> >> 2.14.2
> >=20
> > I guess this also means we can drop the if/else, kind of like
> >=20
> >   system_printf ("child %d %s%s, errno %d",
> > 		 grouped.child_pid,
> > 		 grouped.errmsg ? "- " : "",
> > 		 grouped.errmsg ?: "",
> > 		 grouped.this_errno);
> >=20
> > What do you think?
>=20
> Nothing I really take care of - yet suggesting:
>=20
>   system_printf ("fork failed - child %d%s%s, errno %d",
> 		 grouped.child_pid,
> 		 grouped.errmsg ? " - " : "",
> 		 grouped.errmsg ?: "",
> 		 grouped.this_errno);

Yep.

> But wait, what's the difference between syscall_printf and system_printf?

Prefixing with timestamps and stuff.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ3MC0AAoJEPU2Bp2uRE+grvAP/AvTNsLxc417kGzDgr3YkNs7
pKHI/9u6aqrAk5pmaVu+HYRU73x0D+rvlkbTo6g/dIaKxjrGmV8Cgk3JvwbVDbUk
MUH83V1Pdr0/SfK9kW72P9zCiMCGa4fOEm94e4GMcQg17RDiMijNzPXLOy9eJNXL
+CFwEoeSTrtayHKIYNNl/ZexLf5sN8cOpawYAbHxj/OkX52icZfphAcAv1ugx99y
y6Pzyw62hmT8hgDlE2AlL3inHj6ptlDilrr6QWttp6UnD8E66nrcVrWnupprjY1F
dceAK6eplamzX61el8hAMQRoLf0eeNu4kFwMgSBcG7e/r2mgwlm2BoO3Yu8zmD2e
mKbq0LNeaW3yJQd0/dJ70DxALO97e2knLJKUpYZ/4jPMufFmZlqNfTovHJD+Dwtt
5RaeHV90dzinA68m3QNMwxcBCuznKTdCG4bs4q6ektg+FGiPXTCrkooJ/qUD5Cjl
m+IKMQeuhl9mSkj49Rxlqt3xz/Q/fHIq/2Yi0DLrIW2swPlFgaWk69itA3O1MCkK
uY1be73icchZ37mNiqVW6DFmD7R6LShHiuzl0jBOgo7MSSyYr6iYsCarNVTbjnBb
rCl5abqBsDeBLKWGSZhb2KeSJvlS6tY4hP+WpVqntno9Al8ZgTr8igqpERVBJGHg
nqtyDkpq9CRkNC7WOPbz
=BwRo
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--

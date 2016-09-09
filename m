Return-Path: <cygwin-patches-return-8639-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19666 invoked by alias); 9 Sep 2016 11:19:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19656 invoked by uid 89); 9 Sep 2016 11:19:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=confident, desperately, indirection, hides
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 09 Sep 2016 11:19:10 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 4C803721E281A	for <cygwin-patches@cygwin.com>; Fri,  9 Sep 2016 13:19:04 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id AE7D35E0359	for <cygwin-patches@cygwin.com>; Fri,  9 Sep 2016 13:19:03 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A29BAA80361; Fri,  9 Sep 2016 13:19:03 +0200 (CEST)
Date: Fri, 09 Sep 2016 11:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/4] dlopen: switch to new pathfinder class
Message-ID: <20160909111903.GG3860@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1472666829-32223-2-git-send-email-michael.haubenwallner@ssi-schaefer.com> <20160831191231.GA649@calimero.vinschen.de> <09d08bc9-d430-f6e8-8076-e9f9ad992fd9@ssi-schaefer.com> <20160901140327.GD1128@calimero.vinschen.de> <3cd7bff6-2e56-addd-d9ca-88e203dfb337@ssi-schaefer.com> <20160902085213.GA7709@calimero.vinschen.de> <bd3e33f0-de36-a65c-2e28-ff8bfdbf2d22@ssi-schaefer.com> <20160908115857.GA8359@calimero.vinschen.de> <904e027a-f657-29c7-18bf-4695543798c8@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <904e027a-f657-29c7-18bf-4695543798c8@ssi-schaefer.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
X-SW-Source: 2016-q3/txt/msg00047.txt.bz2


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3202

On Sep  9 10:19, Michael Haubenwallner wrote:
> On 09/08/2016 01:58 PM, Corinna Vinschen wrote:
> > On Sep  2 13:36, Michael Haubenwallner wrote:
> >> On 09/02/2016 10:52 AM, Corinna Vinschen wrote:
> >>> On Sep  2 10:05, Michael Haubenwallner wrote:
> >>>> Moving the allocator into pathfinder would work then, but still the
> >>>> tmp_pathbuf instance to use has to be provided as reference.
> >>>
> >>> Hmm, considering that a function calling your pathfinder *might*
> >>> need a tmp_pathbuf for its own dubious purposes, this makes sense.
> >>> That could be easily handled via the constructor I think:
> >>>
> >>>   tmp_pathbuf tp;
> >>>   pathfinder finder (tp);
> >>>
> >>> Still, since I said I'm willing to take this code as is, do you want =
me
> >>> to apply it this way for now or do you want to come up with the propo=
sed
> >>> changes first?
> >>
> >> As I do prefer both pathfinder and vstrlist to not know about tmp_path=
buf
> >> in particular but a generic memory provider only: Yes, please apply as=
 is.
> >=20
> > Done, minus patch 4.
>=20
> Then my original problem with dlopen isn't fixed yet, where some applicat=
ion
> code within /opt/app/bin/app.exe does dlopen(libAPP.dll), currently findi=
ng
> /usr/bin/libAPP.dll although app.exe linked against /opt/app/bin/libAPP.d=
ll.

This change has quite a potential to break existing code.  I'm not
confident to do this indiscriminately.  Like Glibc, we can invent
implementation-specific RTLD_xxx flags, though, so why not use some
RTLD_APPDIR or something like that?

> However, thank you anyway!
>=20
> > I still think that there should be only a single
> > pathfinder object and the rest encapsulated within and called via some
> > pathfinder member function.  I'll look into it later this year.
>=20
> A thought to avoid the extra tmp_pathbuf_allocator class:
> Have cygmalloc.h (or similar) declare the allocator interface,
> to allow for tmp_pathbuf to implement it by itself.
>=20
> The complete idea is to have another allocator implementation using
> cmalloc+cfree, as well as one more using malloc+free. Probably there
> is use for another one using VirtualAlloc+VirtualFree as well.
>=20
> Then even path_conv might utilize the allocator interface, using the
> cmalloc+cfree implementation (provided by cygmalloc.h) by default...

Why the additional indirection level?  Every allocation type has it's
special properties and IMHO they should be visible to the reader.  As
the writer of the code you have to think about the right allocation
anyway.  A generic allocator hides the details and, in the worst case,
slows down the allocation operation due to additional checks otherwise
only required in bordercases.

What we *really* need desperately is another malloc/free implementation
which is more threading-friendly than the current one.  I made an effort
a few years back trying ptmalloc3 instead of dlmalloc, but encountered
a few problems so I had to revert it.  Still, changing to ptmalloc or
jemalloc would be cool.

Let's continue in November.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX0pqnAAoJEPU2Bp2uRE+gusgP/1oZjfFUO+yxg6+nulHkJ76n
GxsZpW6XoDEhn4Pb0xc198yOp/31ANizPJi31vdGiCpGwJ6uIvZWlBWYgzZqM/Xl
+APQf6NRLAhsrZFeBn1xpx1WPJqMeQK9xq4oaPDNU/RV7dU462N96VuJhpy9jVjh
QClzP9gCBhp6ydt5kbdbVfEYoYhaZMh9t2+fWClicfpkxoZlRNU92HLPhzsdO0eH
TI67Zp+vLsN2NsxPgNmj8rjBn/d3VuF0IiySoNq8cPID0/1LtDMJgco0Z5Uvc0G4
8IYvjCdcNk96yPqEGKnr73qCVB9y5q5jriHvadEBokAt0PQrTmMko5Zn2af64XZM
iEFut/wfVt3nWFhMSTpYxQCRv44+umFHuut6p50OrYxvy7JzI0TqCfzGF3w+XdMN
rrtIjMSLE8gxnxs6voOd8je0YiA73YuZS33QepcTIw9JqzaBk4ekoPGNUEauJOHJ
t5Aekc2xFZ/91ZAeb5YZwhR2ct6LxIE7qg4WyunJNCK8FK0uINu94ccWry2NyBo+
IyfKSDy5T/uUwDprMI8MdyTZLLD88MdRRWcPXZ6VevkwWuqwmnDP/5o/fOuAvgmJ
xK9wNv5+GCGbPxWmAw+ICITk5mfQih/q4xubXkfvv60c41sElxR+nu/WVT134vEi
gKaxB8Lb8E8qs9uG/LRs
=9QGj
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--

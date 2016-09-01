Return-Path: <cygwin-patches-return-8627-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36056 invoked by alias); 1 Sep 2016 14:03:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35135 invoked by uid 89); 1 Sep 2016 14:03:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=201609, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 01 Sep 2016 14:03:41 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 3087B721E281A	for <cygwin-patches@cygwin.com>; Thu,  1 Sep 2016 16:03:28 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 8F47C5E051D	for <cygwin-patches@cygwin.com>; Thu,  1 Sep 2016 16:03:27 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8799BA804AE; Thu,  1 Sep 2016 16:03:27 +0200 (CEST)
Date: Thu, 01 Sep 2016 14:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/4] dlopen: switch to new pathfinder class
Message-ID: <20160901140327.GD1128@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1472666829-32223-2-git-send-email-michael.haubenwallner@ssi-schaefer.com> <20160831191231.GA649@calimero.vinschen.de> <09d08bc9-d430-f6e8-8076-e9f9ad992fd9@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <09d08bc9-d430-f6e8-8076-e9f9ad992fd9@ssi-schaefer.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
X-SW-Source: 2016-q3/txt/msg00035.txt.bz2


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2236

On Sep  1 13:05, Michael Haubenwallner wrote:
> On 08/31/2016 09:12 PM, Corinna Vinschen wrote:
> > Hi Michael,
> >=20
> > On Aug 31 20:07, Michael Haubenwallner wrote:
> >> Instead of find_exec, without changing behaviour use new pathfinder
> >> class with new allocator_interface around tmp_pathbuf and new vstrlist
> >> class.
> >> * pathfinder.h (pathfinder): New file.
> >> * vstrlist.h (allocator_interface, allocated_type, vstrlist): New file.
> >> * dlfcn.cc (dlopen): Avoid redundant GetModuleHandleExW with RTLD_NOLO=
AD
> >> and RTLD_NODELETE.  Switch to new pathfinder class, using
> >> (tmp_pathbuf_allocator): New class.
> >> (get_full_path_of_dll): Drop.
> >> [...]
> >=20
> > Just one nit here:
> >=20
> >> +/* Dumb allocator using memory from tmp_pathbuf.w_get ().
> >> +
> >> +   Does not reuse free'd memory areas.  Instead, memory
> >> +   is released when the tmp_pathbuf goes out of scope.
> >> +
> >> +   ATTENTION: Requesting memory from an instance of tmp_pathbuf breaks
> >> +   when another instance on a newer stack frame has provided memory. =
*/
> >> +class tmp_pathbuf_allocator
> >> +  : public allocator_interface
> >=20
> > You didn't reply to
> > https://cygwin.com/ml/cygwin-developers/2016-08/msg00013.html
> > So, again, why didn't you simply integrate a tmp_pathbuf member into the
> > pathfinder class, rather than having to create some additional allocator
> > class?  I'm probably not the most diligent C++ hacker, but to me this
> > additional allocator is a bit confusing.
>=20
> Sorry, seems I've failed to fully grasp your concerns firsthand in
> https://cygwin.com/ml/cygwin-developers/2016-08/msg00016.html
> Second try to answer:
> https://cygwin.com/ml/cygwin-developers/2016-09/msg00000.html

Ok, I see what you mean, but it doesn't make me really happy.

I'm willing to take it for now but I'd rather see basenames being a
member of pathfinder right from the start, so you just instantiate
finder and call methods on it.  Given that basenames is a member,
you can do the allocator stuff completely inside the pathfinder class.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXyDUvAAoJEPU2Bp2uRE+g7a8QAJsYAUzdY0ARgDjGiXkJQNI1
DOh/tmxQ5WE8UQuFSQp7NE48Gi8d1lETgTP8WMzylh59J7kUnz6YlgDouMm5oyrW
mAYEZKgrIt00Imc/C1O7fsYQkfxguDLyjXlAIlnDZwS8hJ+Ietwe11mIU5gARoXe
GOvIyGLWyb00OCyIiDKmR2AKJqM6WIgtfYJ8afUjNGfRLh8GNkbf7qTFTvXsNB9Y
44irH8736fU8wl1xz0d/tZO9kSHIfnFyuPHrOfHPxdfwwIthavOdMfincz6XXy8t
0j67qnsP1jFzUbn1ecBRr6qs1DDuoVvwGyjWKIjmG0A2qjL9T4S4BB90HG2HgITQ
cssP7i35ihP9pzxwtHSQYFHh7hGNtM45p8HyMgUIJGpaRqpR12OSyWgDKKIcqgf2
1S3+2TtPzFFdiwk7fz32GiChgfsfwsMZG8ARXzk0t8cAh9O/ZdkC0xJpAhZCiLly
JqVDmXrvlCqvMvCWUOE2H28JiX2yAb5pn8dLJarg131RmytAV1SHlZAlanY44AYV
EWbfRK6ZPZrwQh5li3xozEjcLS3G6GZJ2NjSAM2QS2RyXr8b1ITlpuvdFbzQ8ZI8
I59ObiaXgkx8ovZL/ObU7lqr6VJPtgOv/cl25OqaQKgp+1/P5JdIbTc87GUsmzKg
R9D+WCPqjPcGcUzM3jb9
=1cXa
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--

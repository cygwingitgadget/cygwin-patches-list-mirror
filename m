Return-Path: <cygwin-patches-return-8624-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 58210 invoked by alias); 31 Aug 2016 19:12:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 58197 invoked by uid 89); 31 Aug 2016 19:12:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=diligent, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 31 Aug 2016 19:12:35 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id B0FC8721E281C	for <cygwin-patches@cygwin.com>; Wed, 31 Aug 2016 21:12:32 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 089095E031C	for <cygwin-patches@cygwin.com>; Wed, 31 Aug 2016 21:12:32 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id ECC8FA8059C; Wed, 31 Aug 2016 21:12:31 +0200 (CEST)
Date: Wed, 31 Aug 2016 19:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/4] dlopen: switch to new pathfinder class
Message-ID: <20160831191231.GA649@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1472666829-32223-2-git-send-email-michael.haubenwallner@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <1472666829-32223-2-git-send-email-michael.haubenwallner@ssi-schaefer.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
X-SW-Source: 2016-q3/txt/msg00032.txt.bz2


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1553

Hi Michael,

On Aug 31 20:07, Michael Haubenwallner wrote:
> Instead of find_exec, without changing behaviour use new pathfinder
> class with new allocator_interface around tmp_pathbuf and new vstrlist
> class.
> * pathfinder.h (pathfinder): New file.
> * vstrlist.h (allocator_interface, allocated_type, vstrlist): New file.
> * dlfcn.cc (dlopen): Avoid redundant GetModuleHandleExW with RTLD_NOLOAD
> and RTLD_NODELETE.  Switch to new pathfinder class, using
> (tmp_pathbuf_allocator): New class.
> (get_full_path_of_dll): Drop.
> [...]

Just one nit here:

> +/* Dumb allocator using memory from tmp_pathbuf.w_get ().
> +
> +   Does not reuse free'd memory areas.  Instead, memory
> +   is released when the tmp_pathbuf goes out of scope.
> +
> +   ATTENTION: Requesting memory from an instance of tmp_pathbuf breaks
> +   when another instance on a newer stack frame has provided memory. */
> +class tmp_pathbuf_allocator
> +  : public allocator_interface

You didn't reply to
https://cygwin.com/ml/cygwin-developers/2016-08/msg00013.html
So, again, why didn't you simply integrate a tmp_pathbuf member into the
pathfinder class, rather than having to create some additional allocator
class?  I'm probably not the most diligent C++ hacker, but to me this
additional allocator is a bit confusing.

The rest of the patch looks good.  I'll look further into the patchset
later tomorrow.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxywfAAoJEPU2Bp2uRE+gYPMP/jrzujrWWwJj7Twwcl1LoBvN
z2N0FQBfZZPrq8s2t+2MHUImT2CiHkjtlB0+1+9GJ4OWundy3dla2GaVMI6Cxr9s
sK5MXUj/M5QZPw9H7Y3psBChCw+y8ShRVk0nd1Wb/N70Ptb427Js2ax8eTg+cFG1
0JjopMbjC6CDpkjZWzz/GZM3wR97DWCfwJ0+gDWwzamkc5dqHkvNoV5RfIs4CB01
yseJhKXJJobRA93yvaicDnwe350Tv0M8ET/KrTqqz2qmrNKHt6jECrzp1QiXnKcL
oY9EIHKZRsenZ6O2rbdQu0/aOgnlTwkgOsNW7UYkMRUj1Cz7WlHTulkQKG8Qz7So
OhyFx+2dalOFmTFZTLPamPdAxaTSp7bp363wC8K/rgUfpsaseP3rJtTzXZJPwqOr
/XSEHrumOTAuQjYnBDDdu/uxjw+XIxys0rr6AjvUFK4XacmeWG7cwCrMdbYxei4Z
QyHVzC/7K+4k2LiQuvnRdPOR/TjJK8sncIOFQQ5JQlrFaPya8P8RGyp4uM/+2Flq
o6lQLtedCScsHoLPUSKl27HPh6yoDh7st18xD/zkd6/cDa4rK72ugFEWKbEaTC3q
Fww7Fwv/WhfVZ3+K4KgSBuQ1yg+6qDjdO7YQKn/OmUYo/s9JlZfkBI5hGceVH6qL
0PI7+FSwTvnV5bHq+T7a
=K1k2
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

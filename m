Return-Path: <cygwin-patches-return-8632-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79876 invoked by alias); 2 Sep 2016 08:52:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79864 invoked by uid 89); 2 Sep 2016 08:52:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:3437, 201609, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 02 Sep 2016 08:52:18 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 3A751721E280D	for <cygwin-patches@cygwin.com>; Fri,  2 Sep 2016 10:52:14 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 85CE25E0264	for <cygwin-patches@cygwin.com>; Fri,  2 Sep 2016 10:52:13 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 75F09A8059C; Fri,  2 Sep 2016 10:52:13 +0200 (CEST)
Date: Fri, 02 Sep 2016 08:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/4] dlopen: switch to new pathfinder class
Message-ID: <20160902085213.GA7709@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1472666829-32223-2-git-send-email-michael.haubenwallner@ssi-schaefer.com> <20160831191231.GA649@calimero.vinschen.de> <09d08bc9-d430-f6e8-8076-e9f9ad992fd9@ssi-schaefer.com> <20160901140327.GD1128@calimero.vinschen.de> <3cd7bff6-2e56-addd-d9ca-88e203dfb337@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <3cd7bff6-2e56-addd-d9ca-88e203dfb337@ssi-schaefer.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
X-SW-Source: 2016-q3/txt/msg00040.txt.bz2


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3464

On Sep  2 10:05, Michael Haubenwallner wrote:
> On 09/01/2016 04:03 PM, Corinna Vinschen wrote:
> > On Sep  1 13:05, Michael Haubenwallner wrote:
> >> On 08/31/2016 09:12 PM, Corinna Vinschen wrote:
> >>> On Aug 31 20:07, Michael Haubenwallner wrote:
> >>>> Instead of find_exec, without changing behaviour use new pathfinder
> >>>> class with new allocator_interface around tmp_pathbuf and new vstrli=
st
> >>>> class.
> >>>> * pathfinder.h (pathfinder): New file.
> >>>> * vstrlist.h (allocator_interface, allocated_type, vstrlist): New fi=
le.
> >>>> * dlfcn.cc (dlopen): Avoid redundant GetModuleHandleExW with RTLD_NO=
LOAD
> >>>> and RTLD_NODELETE.  Switch to new pathfinder class, using
> >>>> (tmp_pathbuf_allocator): New class.
> >>>> (get_full_path_of_dll): Drop.
> >>>> [...]
> >>>
> >>> Just one nit here:
> >>>
> >>>> +/* Dumb allocator using memory from tmp_pathbuf.w_get ().
> >>>> +
> >>>> +   Does not reuse free'd memory areas.  Instead, memory
> >>>> +   is released when the tmp_pathbuf goes out of scope.
> >>>> +
> >>>> +   ATTENTION: Requesting memory from an instance of tmp_pathbuf bre=
aks
> >>>> +   when another instance on a newer stack frame has provided memory=
. */
> >>>> +class tmp_pathbuf_allocator
> >>>> +  : public allocator_interface
> >>>
> >>> You didn't reply to
> >>> https://cygwin.com/ml/cygwin-developers/2016-08/msg00013.html
> >>> So, again, why didn't you simply integrate a tmp_pathbuf member into =
the
> >>> pathfinder class, rather than having to create some additional alloca=
tor
> >>> class?  I'm probably not the most diligent C++ hacker, but to me this
> >>> additional allocator is a bit confusing.
> >>
> >> Sorry, seems I've failed to fully grasp your concerns firsthand in
> >> https://cygwin.com/ml/cygwin-developers/2016-08/msg00016.html
> >> Second try to answer:
> >> https://cygwin.com/ml/cygwin-developers/2016-09/msg00000.html
> >=20
> > Ok, I see what you mean, but it doesn't make me really happy.
> >=20
> > I'm willing to take it for now but I'd rather see basenames being a
> > member of pathfinder right from the start, so you just instantiate
> > finder and call methods on it.
>=20
> The idea to build the basenames list before constructing pathfinder
> is that members of the searchdirs list reserve space for the maxlen
> of basenames:  This implies that the basenames list must not change
> after the first searchdir was registered.
>=20
> To make sure this doesn't happen I prefer to not provide such an API
> at all, rather than to check within some pathfinder::add_basename ()
> method and abort if there is some searchdir registered already.

Yes, that sounds good.

> > Given that basenames is a member,
> > you can do the allocator stuff completely inside the pathfinder class.
>=20
> Moving the allocator into pathfinder would work then, but still the
> tmp_pathbuf instance to use has to be provided as reference.

Hmm, considering that a function calling your pathfinder *might*
need a tmp_pathbuf for its own dubious purposes, this makes sense.
That could be easily handled via the constructor I think:

  tmp_pathbuf tp;
  pathfinder finder (tp);

Still, since I said I'm willing to take this code as is, do you want me
to apply it this way for now or do you want to come up with the proposed
changes first?


Thanks,
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

iQIcBAEBCAAGBQJXyT29AAoJEPU2Bp2uRE+gTb4P/RFLjbevi17g0sNlGG8/Fnvz
f6o4VTUSHr5CLF8rmZIBL8FzCp9FrvmUequVDySrpcrwhJsbFT6evJ2cQnbf2w/S
ahTkq5hqoxw3V/QoOGwMj2oKlPSrSYGSiyTUagWYHH8+IL/gjxR1zxMo2NONexFp
12XGlBZBPOOwzAOfHBuACa2elxYNZS2jqWj71SFyl3ZRMStLxrVlYzhtPECTC+I2
/tQnOWP393AHD1QDdbi5lSDP8czxDZIbSfpv2zfpiP/faQPed5HIIwB+Bdqmvogk
InK55s/cMVjBcD7DeyjEuxI/RNE+oqgmXgmVcmDFjKQ5ZZOotifNW3t6xxUlCc5I
APC1PYuHz9WP1YMqFShNtS0Ef1pyzDMGedkd9mqq5hSs2Q60ejp448gMpJhULJGs
dI2IFnyhwEvKoBFCwBLs9Wl1kiWZfNla8j5Id2zDNZFr7Fw2w/4fQKobfZHIu8nM
D+sxHd1ShDmytPMgpJKOFbf9dx6O20jI6651mikAGfUVYDKSeyXKTSbQH/fh+GNw
+6ygV6L7oa0c14CGsMpKUGWHAQKfRntMwoqOAQ9EMfZP3SNslFjoysFqJrpUCB5W
3wDflCodBGvNvwsZ5B/mOd3FyauQ/dSveEXBmNx0IajOdUFjmkzivvuo9FmhLULM
wTFpiTg8vzdULEiw/2F3
=rEf/
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

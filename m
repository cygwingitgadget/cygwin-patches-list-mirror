Return-Path: <cygwin-patches-return-8050-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27277 invoked by alias); 16 Jan 2015 19:50:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27250 invoked by uid 89); 16 Jan 2015 19:50:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 16 Jan 2015 19:50:31 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 24D2F8E1421; Fri, 16 Jan 2015 20:50:29 +0100 (CET)
Date: Fri, 16 Jan 2015 19:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: tracing malloc/free call
Message-ID: <20150116195029.GJ3122@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <54B6EE1F.60705@gmail.com> <20150115093451.GB10242@calimero.vinschen.de> <54B91EFD.80302@gmail.com> <20150116154425.GG3122@calimero.vinschen.de> <20150116162203.GI3122@calimero.vinschen.de> <54B94B59.4050606@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="2oox5VnwalALFvA7"
Content-Disposition: inline
In-Reply-To: <54B94B59.4050606@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00005.txt.bz2


--2oox5VnwalALFvA7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1795

On Jan 16 18:33, Marco Atzeri wrote:
> On 1/16/2015 5:22 PM, Corinna Vinschen wrote:
> >On Jan 16 16:44, Corinna Vinschen wrote:
> >>On Jan 16 15:23, Marco Atzeri wrote:
> >>>Attached patch that allows tracking of original caller,
> >>>for the 4 memory allocation calls.
> >>
> >>Thanks for the patch, but it won't work nicely either this way.  The
> >>problem is that, in theory, the code has to differ between internal and
> >>external callers.  Internal callers (that is, Cygwin functions itself)
> >>don't hop into the function via _sigfe/_sigbe.  Thus the output for
> >>internal callers of malloc/free is now wrong with your patch.
>=20
> I missed that point. ;-)
> First time I look at these inside details of cygwin

Hopefully not your last :)  Feel free to ask on the devs list if you
have questions about the code.

> >>The solution for this problem would be a test which checks if the return
> >>address is the _sigbe function and if so, returns *(_my_tls.stackptr-1),
> >>otherwise __builtin_return_address(0).  However, the symbol _sigbe is
> >>not exported since, so far, it was only used inside _sigfe.  This needs
> >>a bit of tweaking.  I'll have a look.
> >
> >I applied a patch to print the right caller address.  I created a new
> >macro caller_return_address() for reuse, should we have a desire to
> >print the caller address in other parts of the code.
> >
> >I'm going to create a snapshot with this change.  Please give it
> >a try.
>=20
> It works like charm.
> Much more easy to find misalignment between
> malloc/calloc/realloc and free calls

I'm glad it works for you, too.

Btw., did you see my PM?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--2oox5VnwalALFvA7
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUuWuFAAoJEPU2Bp2uRE+gfHgP/jQGnodobir1Qyqo/XoEfBXY
SAYCV0O30ZEpJ00fhdzFkAxVZzgjFVXGncUx7Nxdrakqm6q4HeqHxJFJW0CZJFwH
AkwOKzNmt9AtZsrXUBkkxZSfV+zsTfoOfaEUQQi2aWWnshwBmN19ZrKSR3KorolF
INA87cPA1lG70BzUxEAqsdL0nntUP0MOAqYWs21gUT+vkhmrqMSZc+EQZHL+5sqO
ebmEVzoV+Uchk9hW8eOFdjx2RuRAWrhN4Tgde43GPjdDJvbWf/Y/NMh7ot5SAvrx
rDTdO+1dkll0SEgoi8bP3NG+9xUZK95/5hRXDHoEXCZkLVWKAO9e7p0TSnrisehF
5y916hZnB1QR8bKOwMOKhrBSnzpbu4en1Hf3yec7rod2YSvUVH4fcoWd1/Owrffb
9OVXvletuFDABNjC8QlQaM084zpTcSpXHtTNqkY01nbGFsOFj6pXQDe69so1Eun3
p4c3Gh17yA8GX4Ma2oXZPCABIuui3k1+8UVob15A/FzRkXE4/4giB43vXsd+Ztln
jIe4P7wgO4H8KU5f3ClR45G0vxszAljm14Rqxqz9JyscBkFDQhJtYONrvMH99JU6
bCB+8tQ+lxSHYTHhkGA2CMpmlwHzE+LtxcsQqn9qjA5cB5uyIo3PgWhbvZYJYUD0
hgrOR2W3n5ax+hsGjxhu
=tmTb
-----END PGP SIGNATURE-----

--2oox5VnwalALFvA7--

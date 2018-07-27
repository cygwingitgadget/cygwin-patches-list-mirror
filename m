Return-Path: <cygwin-patches-return-9155-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7678 invoked by alias); 27 Jul 2018 19:04:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7612 invoked by uid 89); 27 Jul 2018 19:04:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=Geisert, geisert, breakdown, winsup
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 27 Jul 2018 19:04:54 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MQA9X-1fdvNI0cd9-005HU8 for <cygwin-patches@cygwin.com>; Fri, 27 Jul 2018 21:04:51 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2907912E0A37; Fri, 27 Jul 2018 21:04:49 +0200 (CEST)
Date: Fri, 27 Jul 2018 19:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/1] Update _PC_ASYNC_IO return value
Message-ID: <20180727190449.GB2540@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180725200643.10750-1-yselkowi@redhat.com> <20180726082000.GA6175@calimero.vinschen.de> <Pine.BSF.4.63.1807260140390.12009@m0.truegem.net> <20180726101706.GB6175@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20180726101706.GB6175@calimero.vinschen.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00050.txt.bz2


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2895

On Jul 26 12:17, Corinna Vinschen wrote:
> On Jul 26 01:51, Mark Geisert wrote:
> > Hi Corinna,
> >=20
> > On Thu, 26 Jul 2018, Corinna Vinschen wrote:
> > > On Jul 25 15:06, Yaakov Selkowitz wrote:
> > > > > From discussion on IRC:
> > > >=20
> > > > <yselkowitz> corinna, just sent a patch for _POSIX_ASYNCHRONOUS_IO =
as a
> > > > 	  follow-up to the AIO feature, but am still wondering about
> > > > 	  _[POSIX|PC]_ASYNC_IO
> > > > [snip]
> > > > <corinna> in terms of _PC_ASYNC_IO, the test might be a bit tricky
> > > > <corinna> let me check
> > > > <corinna> actually, no
> > > > <corinna> it's easy
> > > > <corinna> Mark implemented the stuff with pread/pwrite only on disk=
 files
> > > > <corinna> but otherwise it's device independent in that he implemen=
ted a
> > > > 	  workaround for pipes and stuff
> > > > <corinna> so, in theory we can just return 1
> > > >=20
> > > > I'm not sure how to test this atm, but based on the above I have ma=
de
> > > > the following patch so this doesn't get lost.
> > > >=20
> > > > Yaakov Selkowitz (1):
> > > >   Cygwin: fpathconf: update _PC_ASYNC_IO return value
> > > >=20
> > > >  winsup/cygwin/fhandler.cc | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > > > --
> > > > 2.17.1
> > >=20
> > > Mark?  Any comment you want to make?
> >=20
> > Thanks for asking.  Your characterization of my implementation is corre=
ct.
> > The intent is for aio_* async I/O to be supported on all descriptors.  =
On
> > the most useful case of binary local disk files, inline pread|pwrite is
> > used.  But I wanted to make sure the AIO interface would do the right t=
hing
> > on other kinds of descriptors without bothering the user about it.
> >=20
> > So if the intent of the _PC_ASYNC_IO flag is to say that async I/O is
> > supported generally, I do think setting it to 1 is appropriate.  That i=
s,
> > if it's talking about the aio_* interfaces.  If there's an O_ASYNC defi=
ned
> > for app coders, my recent contribution doesn't address that at all.
>=20
> Good question.  O_ASYNC is a BSD invention, and it's not defined in
> POSIX at all.  Since we're in POSIX territory, _PC_ASYNC_IO and
> _POSIX_ASYNC_IO can only refer to async io as implemented by your new
> aio code:
>=20
> - _POSIX_ASYNCHRONOUS_IO defines if the implementation supports async io
>   at all.
> - _POSIX_ASYNC_IO defines if the file in question supports async io.

Offline all day due to a major hardware breakdown.  The heat or something.
My server died the mainboard death.  I'm running a replacement system
right now with *much* less power.  Will take a week or more to get an
adequate replacement so I'm on half power for a while.

Oh well, enough lamenting.

Yaakov, please push your patch.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltbbNAACgkQ9TYGna5E
T6B0kA/4g+Qt1NjjYlTw404ZqfgoDaVcjbTFgBIawn5KTaprqhS7SBZ1ErM/5bwo
K024KvsRPAfyAwFymdHuu8RS/F2ECLCrYLtfsEGZWd5dNtrqWJv/x0ufptv2Cqyo
1FsPvgRTdKLJDSaT9vErpQrX4ei7y8d6e1UF24BnPSQ3FN9Ie/axF4LCLaYfzfGB
O3njxAOpgwmnGoGFvUYa4prQCs2dDIJF+tXmfgKkG9W0meCotumrXMbwjGtXXiNG
yPYJKhyzfa2nR5GtCmewgSwXAuk9sJPa6xJoNKIUU+etBFD71orvMmaORtWNEoyx
fHB8NN7HkhjSiGUOzEy4IttZ7VEfbht8HLF1nv4VYKBwM/SnW9wOuOFyR2f29tWP
P7hOxXR42D36X11eJ85POKP+b+p/tRE3she1U/adVorSds2hKfKUljtLH7M+Kg5N
8RDfTo7/U2s88H19jQu8w7sZIK6hcWWMOz6dAAWQ82FcMza/7VJ4hdDbVIZMiu87
eR7qjGielMcO+AST+JmS5RRb71zOQ4PrcYJ0Ml7WBKRKj8XjfeK2/QsZCIpbAeVk
oegDeuj5mznZsqZcBY+9XkWwqwg1dcWaeYFEQflpGpNJXZjibe1s9lwSLSfQTKxW
XXJE18pqIJkRUqnIqNmOhPngY6vK87/TSocbj4dExxe3Y1+Mbg==
=Pfke
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

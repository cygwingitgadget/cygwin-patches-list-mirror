Return-Path: <cygwin-patches-return-8699-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54492 invoked by alias); 27 Feb 2017 10:46:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 54469 invoked by uid 89); 27 Feb 2017 10:46:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=HCc:D*cygwin.com, H*f:sk:000001d, browser, extremely
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Feb 2017 10:46:29 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 68963721E281C;	Mon, 27 Feb 2017 11:46:26 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 8FD865E047B;	Mon, 27 Feb 2017 11:46:25 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 71BE8A805E0; Mon, 27 Feb 2017 11:46:25 +0100 (CET)
Date: Mon, 27 Feb 2017 10:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: David Allsopp <David.Allsopp@cl.cam.ac.uk>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Preserve order of dlopen'd modules in dll_list::topsort
Message-ID: <20170227104625.GA3536@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: David Allsopp <David.Allsopp@cl.cam.ac.uk>,	cygwin-patches@cygwin.com
References: <000001d28f84$0fce9ea0$2f6bdbe0$@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <000001d28f84$0fce9ea0$2f6bdbe0$@cl.cam.ac.uk>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00040.txt.bz2


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3684

Hi David,

On Feb 25 16:27, David Allsopp wrote:
> This patch (below - I hope I have managed to format this email correctly)
> alters the behaviour of dll_list::topsort to preserve the order of dlopen=
'd
> units.
>=20
> The load order of unrelated DLLs is reversed every time fork is called,
> since dll_list::topsort finds the tail of the list and then unwinds to
> reinsert items. My change takes advantage of what should be undefined
> behaviour in dll_list::populate_deps (ndeps non-zero and ndeps and deps n=
ot
> initialised) to allow the deps field to be initialised prior to the call =
and
> appended to, rather than overwritten.
>=20
> All DLLs which have been dlopen'd have their deps list initialised with t=
he
> list of all previously dlopen'd units. These extra dependencies mean that
> the unwind preserves the order of dlopen'd units.
>=20
> The motivation for this is the FlexDLL linker used in OCaml. The FlexDLL
> linker allows a dlopen'd unit to refer to symbols in previously dlopen'd
> units and it resolves these symbols in DllMain before anything else has
> initialised (including the Cygwin DLL). This means that dependencies may
> exist between dlopen'd units (which the OCaml runtime system understands)
> but which Windows is unaware of. During fork, the process-level table whi=
ch
> FlexDLL uses to get the symbol table of each DLL is copied over but becau=
se
> the load order of dlopen'd DLLs is reversed, it is possible for FlexDLL to
> attempt to access memory in the DLL before it has been loaded and hence it
> fails with an access violation. Because the list is reversed on each call=
 to
> fork, it means that a subsequent call to fork puts the DLLs back into the
> correct order, hence "even" invocations of fork work!
>=20
> An interesting side-effect is that this only occurs if the DLLs load at
> their preferred base address - if they have to be rebased, then FlexDLL
> works because at the time that the dependent unit is loaded out of order,
> there is still in memory the "dummy" DONT_RESOLVE_DLL_REFERENCES version =
of
> the dependency which, as it happens, will contain the correct symbol table
> in the data section. For my tests, this initially appeared to be an x86-o=
nly
> problem, but that was only because the two DLLs on x64 should have been
> rebased.
>=20
> I'm very happy to include the complete detail for this and, for the
> extremely keen, the relevant Git branch in OCaml which demonstrates this
> problem. Given the way in which FlexDLL operates, I would contend that th=
is
> is a sensible change of behaviour for the Cygwin DLL, though not a bug fi=
x.
> I'd be extremely happy to see this patch integrated, as the workaround
> necessary in FlexDLL to support Cygwin's fork is horrible (and
> non-transparent to the library user).
>=20
> This patch is licensed under 2-clause BSD as per winsup/CONTRIBUTORS,
> Copyright (c) 2017, MetaStack Solutions Ltd.

First of all, I think this makes perfect sense.  I just have a few
questions in terms of the patch itself.

- Your browser inserts undesired line breaks, so the patch is broken.
  Can you please resend the `git format-patch' output as attachment?

- While you're at it, please reformat your patch so the line length
  is not longer than 80 chars.

- Last but not least.  You add code to topsort so the loaded DLLs
  are handled first.  The subsequent code is untouched.  However,
  shouldn't the next loop then restrict calling populate_deps to the
  linked DLLs only, at least for performance?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtAOBAAoJEPU2Bp2uRE+gKaUP/3/pKeG1kbiDIe8ehoqcgInF
XLhGI5BWtcSaN1SuuY1L84MOg7lEb6ZALIoszljuvOnPz2HOXYoFjAQBuc+Sl1xU
e7sbqNfcZLbRTShf3r2GXW9cbYyljwRU6UEsZlhXHxD9/Q3w9eE93Mw5aRDf7FOc
WFiA/eQTRReEgM3PYGwOJemx8QGAAKB1td1RQAADWagiMCLIBwte4pQBhsdyWJvi
2AM6C1HhK3XiQyyoiSuj6/J1uo5L+6coe/ZAiD2ScRnUdPaFuB2wKueSKH6yoFxB
tJETtibL4lkfRhgGZOlPPHVuaqwFxeElIaa25OUMyRlshWTCUGumV25UjHggbdgE
4yV6oeKgaxQNXuAJcsc54MIFDPWtdyu2IPFcteTal6c0PYdvG7bmP62cbb6b06sS
9r4g/fwsEZbnav4GtsW/FjxjquVfPKqDNUlOTfHScWlFZ9fPD7/fhBOloWUmPUZR
W/KS1ozNX8fTvn1ig6jtE/9tmZQ2cwnou+n6wzo10X0086CiK9F9VaJwwrrzEiJK
/gniBp23n+XB+oYzGd88GPrPIUrgEtuKNaMwCLK27UwQRcbycRjB5K9IaUZC1fAQ
GdyapnUwpBXiia18QIH/snphsWHMFCFmlOJUoZ905+NPNKslvJYMGID8AQzooWpt
I+Mg8qikC55byneJ13CW
=F+Aw
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

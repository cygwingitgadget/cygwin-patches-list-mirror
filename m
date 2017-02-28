Return-Path: <cygwin-patches-return-8701-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48313 invoked by alias); 28 Feb 2017 10:29:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48290 invoked by uid 89); 28 Feb 2017 10:29:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=claim, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, Ltd
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Feb 2017 10:29:17 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id E300C721E281A	for <cygwin-patches@cygwin.com>; Tue, 28 Feb 2017 11:29:13 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 48E215E0091	for <cygwin-patches@cygwin.com>; Tue, 28 Feb 2017 11:29:13 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2CA49A80378; Tue, 28 Feb 2017 11:29:13 +0100 (CET)
Date: Tue, 28 Feb 2017 10:29:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Preserve order of dlopen'd modules in dll_list::topsort
Message-ID: <20170228102913.GB3536@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000001d28f84$0fce9ea0$2f6bdbe0$@cl.cam.ac.uk> <20170227104625.GA3536@calimero.vinschen.de> <000301d2911c$d89a0510$89ce0f30$@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <000301d2911c$d89a0510$89ce0f30$@cl.cam.ac.uk>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00042.txt.bz2


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2497

Hi David,

thanks for the new patch.

On Feb 27 17:13, David Allsopp wrote:
> Corinna Vinschen wrote:
> > On Feb 25 16:27, David Allsopp wrote:
> > > This patch (below - I hope I have managed to format this email
> > > correctly) alters the behaviour of dll_list::topsort to preserve the
> > > order of dlopen'd units.
> > > [...]
> > > This patch is licensed under 2-clause BSD as per winsup/CONTRIBUTORS,
> > > Copyright (c) 2017, MetaStack Solutions Ltd.

Do you really want to make it (c) MetaStack?

I'm asking because this way I can't add you personally as contributor to
the CONTRIBUTORS file and you will have to continue to add per-patch
copyright.  The idea of the CONTRIBUTORS file was to claim BSD 2-clause
for your first and all subsequent patches you provide to Cygwin, so you
never have to think about the copyright stuff again.  Your choice.

> > - While you're at it, please reformat your patch so the line length
> >   is not longer than 80 chars.
>=20
> Done - sorry, I'd inferred a longer length from a few other longer lines!

Yeah, the surrounding codes has a few minor formatting issues, in fact.

> > - Last but not least.  You add code to topsort so the loaded DLLs
> >   are handled first.  The subsequent code is untouched.  However,
> >   shouldn't the next loop then restrict calling populate_deps to the
> >   linked DLLs only, at least for performance?
>=20
> Oops :$ That's an artefact of the "story" of the patch's development.
> As it happens, the first dlopen'd DLL would have been initialised in
> the second loop, not the first, but the presence of two loops like
> that was indeed mostly inefficient. I've kept the original one as a
> "fast path" for the case of no dlopen'd DLLs, though I don't know if
> that's a worthwhile optimisation.=20

Well, interesting point.  Basically your new code is a drop-in
replacement, except for the fact that it always calls an extra
cmalloc/cfree.  However, this is only required if loaded_dlls > 0 so I
think we may get away with removing the old loop with a simple tweak to
your new one:

  dll** dlopen_deps =3D NULL;
  if (loaded_dlls > 0)
    dlopen_deps =3D (dll**) cmalloc (HEAP_2_DLL, maxdeps*sizeof (dll*));
  while ((d =3D d->next))
    {
      [...]
    }
  if (dlopen_deps)
    cfree (dlopen_deps);

Do you want to tweak your patch accordingly?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtVD4AAoJEPU2Bp2uRE+g2MwQAI/nlDJhU+dcZGPW1L/fmEhz
OfTdCektWxrtgBK15fiMI4MtVwThxyusmlh1ZsENkF0X7kKtTnDlwsbNkiqZ7coT
HiL7DbXo1Pe1xMmq/xrprJO1dQ+GR0ktwx34GDOH0Q8aAnYY5MFNyPzPvZZ1grZ7
zWRPQEXEb2gfK9/nWticHOxuqEvpbThq2Q6lI1/2ekp6fAANU0jAkUNM8xjIqo5h
Bb2SNNPgM/yyMkzTv0f4Qz0pOjQY/TpQsisvmF16nsBG7PqcpsRh3jH3Cm2hiN45
4ePvg7T6wQ8rBEpaKPbM/Xy+Z9v10INIiYxDJIvDsJCbosSyWFiTiZZdmF99UX1F
qEuXV5yhHqI4DzF2/lub/wSHsB6Tyd1V3gU+SrjOWH5OtRgAXmfb5LyOUD+J6LOQ
OQEtDXj8BiA3G+2jMsFfb0IH7arkTYbkUUcacXqX0QgMFzohlIW8UU30LTfAck8B
nMGxEN3WJzIgHlzrcOpt7MXYHAdxmznkoFNws2HH/uCxXH4BQlcEbDDdQKkU7MYg
IAWrVby4gQBXubPOrf0HAlrekbn/crfvF5eSbxlZcJf592+1Z8zlUKcN2P6uDrsa
m2kUSH8pzS+CVkAXM5Ph1tzu5ynf/xM9AYDxoN21JZJnizdJlm2jthm18ipV23q2
mXxfQlRpz/GH35t+0yvB
=DSVk
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--

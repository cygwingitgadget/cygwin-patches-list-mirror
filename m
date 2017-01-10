Return-Path: <cygwin-patches-return-8674-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125453 invoked by alias); 10 Jan 2017 11:29:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125383 invoked by uid 89); 10 Jan 2017 11:29:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=tabs, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*F:D*cygwin.com
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Jan 2017 11:29:34 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id D56C0721E281A	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2017 12:29:31 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 34C0D5E0210	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2017 12:29:31 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 18ED1A804C1; Tue, 10 Jan 2017 12:29:31 +0100 (CET)
Date: Tue, 10 Jan 2017 11:29:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Add a _pinfo.environ() method analogous to _pinfo.cmdline(), and others.
Message-ID: <20170110112931.GF316@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170105173929.65728-1-erik.m.bray@gmail.com> <20170105173929.65728-3-erik.m.bray@gmail.com> <20170109145813.GC13527@calimero.vinschen.de> <CAOTD34YRzFfRfjLjxQ5HZDj2RGPpzz_9DAwg6yrSbGA3pv-ybQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
In-Reply-To: <CAOTD34YRzFfRfjLjxQ5HZDj2RGPpzz_9DAwg6yrSbGA3pv-ybQ@mail.gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00015.txt.bz2


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2513

On Jan 10 11:56, Erik Bray wrote:
> On Mon, Jan 9, 2017 at 3:58 PM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > On Jan  5 18:39, Erik M. Bray wrote:
> >> diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
> >> index 1ce6809..a3e376c 100644
> >> --- a/winsup/cygwin/pinfo.cc
> >> +++ b/winsup/cygwin/pinfo.cc
> >> @@ -653,8 +653,29 @@ commune_process (void *arg)
> >>       else if (!WritePipeOverlapped (tothem, path, n, &nr, 1000L))
> >>         sigproc_printf ("WritePipeOverlapped fd failed, %E");
> >>       break;
> >> -      }
> >> -    }
> >> +       }
> >> +     case PICOM_ENVIRON:
> >> +       {
> >> +     sigproc_printf ("processing PICOM_ENVIRON");
> >> +     unsigned n =3D 0;
> >> +    char **env =3D cur_environ ();
> >> +    for (char **e =3D env; *e; e++)
> >> +        n +=3D strlen (*e) + 1;
> >> +     if (!WritePipeOverlapped (tothem, &n, sizeof n, &nr, 1000L))
> >> +       {
> >> +         sigproc_printf ("WritePipeOverlapped sizeof argv failed, %E"=
);
> >> +       }
> >
> >           No curlies here, please, just as in sibling cases.
> >
> >> +     else
> >> +       for (char **e =3D env; *e; e++)
> >> +         if (!WritePipeOverlapped (tothem, *e, strlen (*e) + 1, &nr, =
1000L))
> >> +           {
> >> +             sigproc_printf ("WritePipeOverlapped arg %d failed, %E",
> >> +                             e - env);
> >> +             break;
> >> +           }
> >> +     break;
> >> +       }
> >> +     }
> >
> > Please have another look into the PICOM_ENVIRON case.  Indentation is
> > completely broken in this code snippet, as if it has been moved around
> > a bit and then left at the wrong spot.
>=20
> One note on indentation: I tried to be consistent but it's hard
> because in that file and others there's a lot of mixing of tabs and
> spaces.  I'm happy to get everything cleaned up, I'm just not sure
> what the "intended" convention is wrt tabs vs. spaces (I know you're
> using the GNU coding standards otherwise).

It's not that tricky.  In vim terms, set ts=3D8 sw=3D2, and use tabs
if the indentation is >=3D 8.  If you do a >> << sequence in vim,
you get it right even if it was wrong before.

> Would you welcome a separate patch with general whitespace cleanup?

It's new code so that doesn't make much sense.  Otherwise cleaning
up existing stuff as separate patch is fine.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdMWaAAoJEPU2Bp2uRE+gXFoQAJkwlkVPSILte5UkjOSIiY6r
zwbYTOaD85SGjUML2WJ+E5dY91erpdrZIeL7CkO1TVmp7TAwEtF0yST8lT8Vot3R
t4g9EBngdYhMZ3MJ1f/psjuYFyM8G1GEa4YBB2J4Cty97kWmmSFxU3ijifdPCyzS
KygAKJTbf13bSkr1Fjm5+iqbSBIVbzlRIwvqh65fftiHAFLFtGFydCtUuGmfHU8t
FywxGlb4f8WZ6V3/HQ8YfE9SFSyWGc6fyNkFeAlUNZemu3SE7DA/e8js0rf90fr/
V1ZrxF8XExki9nLYZk+EGCbA2SS95J1GIFx7m8waSq0rtJrHSFoh60PQ2zAPRXN9
JvAcHrtX8OAf1E0oZjE9oAQm3zAJJSVRRXAe/hnr5Gc6NjjPm6TjcSFek5J/W1cz
RF2blT7fr2u9TtvbVxWACwRiyJoo7L3FYoYY5kim2L6ThDoguYRFVuZ8sqCddXLt
HXVbph6COS+4yJsPPepveZo/0sd6Wgj27pBc9JS6Am1zDyVcU0iQj5P4eAG3TtUr
4wHM6qWhcfE+8TcWEOJ7NlHeyEqMkey5OCyV8ZIHkvvZggLTQiTENVgkLPrEUvmj
JoG5hTiay5VpHapYvDyxmRy8M3j/626ORkNL47pAs/1mv1ReUELoYrelTv+Kh+iZ
Ry6dYXiaHiLTDqrDu34B
=4R65
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--

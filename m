Return-Path: <cygwin-patches-return-8146-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54491 invoked by alias); 10 Jun 2015 14:11:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 54471 invoked by uid 89); 10 Jun 2015 14:11:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.7 required=5.0 tests=AWL,BAYES_05,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 10 Jun 2015 14:11:23 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B29EFA8093B; Wed, 10 Jun 2015 16:11:20 +0200 (CEST)
Date: Wed, 10 Jun 2015 14:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Improve strace to log most Windows debug events
Message-ID: <20150610141120.GG31537@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1433937922-16492-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
In-Reply-To: <1433937922-16492-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00047.txt.bz2


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 957

Hi Jon,

On Jun 10 13:05, Jon TURNEY wrote:
> Not sure if this is wanted, but on a couple of occasions recently I have =
been
> presented with strace output which contains an exception at an address in=
 an
> unknown module (i.e. not in the cygwin DLL or the main executable), so he=
re is a
> patch which adds some more information, including DLL load addresses, to =
help
> interpret such straces.

That's a nice addition.  Two points, though:

- Do we *always* want that output or do we want a way to switch it on
  and off?  If the latter, we can simply add another _STRACE_foo option
  for it.=20=20

- The GetFileNameFromHandle function could be much simpler.  Rather than
  opening a mapping object for ev.u.LoadDll.hFile, just use the existing
  mapping object from ev.u.LoadDll.lpBaseOfDll.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVeEWIAAoJEPU2Bp2uRE+gJp0P/jfTiIlSD0yMvu+Nt4JH/Pf1
2Y4MAJGZ7ng6Yf31cRQszh1U8Z9nEN2yFcD+V7BLRKr0i+nxfUrmhQyUPhYcQLQQ
2s4e9djs15b7vzvxNMQSRxK7yO85whKVSaRxrrfF7uXznRqBFxSke0f5MrELxBhs
Bau7co1xb/h7bI3HZwucKUVXr2ECSdN5H6P9FctUhQpIrerEE2NZeZB1IAuhg+HA
kDlgFM/3TkEsA52Xw/rFgk1F8hHaW2G1zbO8ZcK8KfHO/lXz8H7DWXKBkgyMeEnR
Vuq1FW6uUD42byTaDhXJ0cGX45v0D8Own3Acilnh2K68G++MKeHidta1XBTDTXZo
8tDgQVSIScDL3s2tELERn/2ITY57lcPoMrAF8WT02Dg+lOBjK0PyAalYcAqkK5md
emXV46dbonuSzaJQoxiALMV+6zBiUsf1jHiXcMy5/GIjDlU+vZPdEM7+dZ4BRH3k
S26azw2Vgjr6y3r6rsydE92HY9KILqc2ChyRzLLpKUmkv5SEelLOkVmxllhqU+KW
g775sP2RCEvnLYq57wGqx8STKO8RXqvEM6PBgH2YfGtVl5wcWySs1khb6eVyCOMf
fhHUSnZ0fIP2Xp8L4bpp1GCNj4FA0xRnvFVvAUn4tl+wbhzj1tLfrU0B8ZSegD3v
BqN5+IyLZ6MWsHWn+rCH
=UxDJ
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--

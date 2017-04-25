Return-Path: <cygwin-patches-return-8765-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126607 invoked by alias); 25 Apr 2017 12:28:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126588 invoked by uid 89); 25 Apr 2017 12:28:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=connector, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Apr 2017 12:28:48 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 29778721E281A;	Tue, 25 Apr 2017 14:28:48 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 975845E0463;	Tue, 25 Apr 2017 14:28:47 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 955F1A80410; Tue, 25 Apr 2017 14:28:47 +0200 (CEST)
Date: Tue, 25 Apr 2017 12:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Daniel Santos <daniel.santos@pobox.com>
Subject: Re: [PATCH] Possibly correct fix to strace phantom process entry
Message-ID: <20170425122847.GB12712@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Daniel Santos <daniel.santos@pobox.com>
References: <20170424093754.536-1-daniel.santos@pobox.com> <20170424121922.GA5622@calimero.vinschen.de> <20170424153854.GA21872@calimero.vinschen.de> <9c820100-2ca5-6716-9ee4-7803fdd82a52@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <9c820100-2ca5-6716-9ee4-7803fdd82a52@pobox.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00036.txt.bz2


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1783

On Apr 24 19:00, Daniel Santos wrote:
> On 04/24/2017 10:38 AM, Corinna Vinschen wrote:
>=20
> > I'm going with my patch for now.  Mainly because I added some debug
> > output to see if we need the Sleep loop at all.  Right now I don't see
> > any situation which would qualify for this.
> >=20
> >=20
> > Thanks,
> > Corinna
>=20
> Thanks for your help on this Corinna!
>=20
> I'm inclined to agree about the sleep loop.  I have concerns about leaving
> these odd "ghost" process entries in and I have concerns about whacking t=
hem
> for all dynamic loads of cygwin1.dll. :)  The only cleaner solution that I
> can think of us to set an environment variable (or value in CYGWIN) to te=
ll
> cygwin1.dll not to call pinfo::thisproc() in
> child_info_spawn::handle_spawn() -- that still feels like a bandaid.  (I
> suppose there's also using LoadLibraryEx and if there's some parameter we
> can pass to the DLL from there.)
>=20
> Incidentally, when I debug strace with gdb the problem does away. Thus, I=
've
> been debugging this by littering the code with OutputDebugStringA()s,
> sometimes adding some Sleep delays, recompiling, exiting, restarting sshd,
> etc.  Is there an easier way to debug stuff like this?
>=20
> Either way, I want to better understand how all of the cases of how
> cygwin1.dll is loaded and processes are inited.  Searching the code, I see
> that cygcheck also uses LoadLibrary, as well as cygwin::connector::connec=
tor
> (const char *dll) (although I can't tell what that is for).
>=20
> I have to run, so I'll get back to this later.

I'm looking forward to any improvement in this area.


Thanks,
Cornna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY/0D/AAoJEPU2Bp2uRE+gn+UP/iOdBrKsEjb9g/7k8BDzAnfG
U/62rjYdFZ8Neu/2X3FrM33QN8FsfO8DXYmecVticMVud2eancQsaW/5zYv32fY/
emRvU51693MnVrxeoSwlmln5HYi8n3rHEnUKSsnj3logIvGKGr5pTpLYcnbx1Nz/
zleHMFQ7Tjgsr570tKtUuF9fFPKScAJGxu5raqVb5mYiOavwp+rQ+VC4PQ1fsMnz
tKerN2Df7Prt5cXdBK8ML7Hvkxa05R/O65UB6cesz4s9a8cIbhQtqkz8GhaIM2yo
w7HUkL9/c5+YXUXmPmgtGqOGuOTlIqzV//N1flWDi7Mu1x3GjCHpbss6cX91rTo/
rP9NbLH69DhyvjJdA3Kr3hoRRoSs1GhRNrnXLpyPk2Rb9Jt57osBF9Eh/QblUDWc
k0qiHrzlEgBg4WohkBWSFXOA3yuEGgKxZiSaeH9nubfMl7EKaIgcuvj24j2Kd8Fx
iijOu8qMBDkUnMglxwnPNZh0H8SptbcpvQ9iLJwOcg3123jDSbN0NzZo/StMUwtq
4n0ZVij/FUvdLysbLJWXsgLkVW3nLbGYkw4Vuv+WKBbIN+kygpU73NyVYNSO6c/7
uVjRC1lIv5QjJjs/cgPdTpMDzi5Ya4aHLObE0ieqceygMK/G6vmP5s2pMXoKRerf
j8fjjnYZ70SCWHW+tToz
=4D2m
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--

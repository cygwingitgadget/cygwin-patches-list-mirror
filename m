Return-Path: <cygwin-patches-return-8761-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 60382 invoked by alias); 24 Apr 2017 15:38:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 60370 invoked by uid 89); 24 Apr 2017 15:38:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-106.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1513, HTo:D*pobox.com, wondering, H*Ad:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Apr 2017 15:38:56 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 78C2C721E281A;	Mon, 24 Apr 2017 17:38:55 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id CF8B75E0463;	Mon, 24 Apr 2017 17:38:54 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B5454A8056A; Mon, 24 Apr 2017 17:38:54 +0200 (CEST)
Date: Mon, 24 Apr 2017 15:38:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com, Daniel Santos <daniel.santos@pobox.com>
Subject: Re: [PATCH] Possibly correct fix to strace phantom process entry
Message-ID: <20170424153854.GA21872@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Daniel Santos <daniel.santos@pobox.com>
References: <20170424093754.536-1-daniel.santos@pobox.com> <20170424121922.GA5622@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20170424121922.GA5622@calimero.vinschen.de>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00032.txt.bz2


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1513

On Apr 24 14:19, Corinna Vinschen wrote:
> Hi Daniel,
>=20
> On Apr 24 04:37, Daniel Santos wrote:
> > The root cause of problem with strace causing long delays when any
> > process enumerates the process database appears to be calling
> > myself.thisproc () from child_info_spawn::handle_spawn() when we've
> > dynamically loaded cygwin1.dll.  It definately fixes the problem, but I
> > don't konw what other processes dynamically load cygwin1.dll and, thus,
> > what other side-effects that this may have.  Please verify correctness.
> >=20
> > Please see discussion here: https://cygwin.com/ml/cygwin/2017-04/msg002=
40.html
> >=20
> > Daniel
> >=20
> > Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> > ---
>=20
> I was just looking into this myself, but I was looking into the weird
> Sleep loop itself and was wondering if that makes any sense at all.
>=20
> Assuming pinfo::init is called from process enumeration (winpids::add)
> then there's no good reason to handle this procinfo block at all.  It
> doesn't resolve into an existing "real" Cygwin process.  And that's
> exactly the case that hangs.
>=20
> So my curent fix would have been this:

I'm going with my patch for now.  Mainly because I added some debug
output to see if we need the Sleep loop at all.  Right now I don't see
any situation which would qualify for this.


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

iQIcBAEBCAAGBQJY/hwOAAoJEPU2Bp2uRE+gSGQQAJWUGrdgABzgw4tP7OZGfX9o
V0JqPNYdYK9TB8MQWQfxgjJANowjhfPY3qv0KZeULwgXhoqehi40TQ5wMF5ZUTI0
W0KN/5P01IfSTkjZJj3fxmScLsg5X46v60gMoQzMofXRfUejYW3CGiJl19PWhlBg
tW99qraiWBbFDMLMwjilgNypf3mJ4dccF/LOyLNlSjbUTGncoD/lmlsGswQO7sJu
ywEkII+hzaMIiVyupdH5ligsPG20Sb1Lnb8Dsif3gUjl2M0UvWxV31JlLVJRAXQ2
gbgazMUCEt51ITRW4g+ofLTjWSLsHgg0snXRdgODZfkkc/7f3KzP359/IfklWdQg
gR0b5/z5dGox2LsI84lFNoDVIRRuB5k+gNIpxe9QyfXpoejRL804kUYtp4oExsEX
BAsPyL03ojujz7hZcW9lOTC24Lw8aejOF2m/OFTziKGV+YnfBfHLTP34QHH2Uraa
CHyvA7guQnOPXqQU/pnDVB8VoBO2I0GuWHYnMGWnD7tjPrfUKFIrGWznRqofAvqS
CHj/2jpFC4qhNvmJMtSUVPQZw3vhf/jEQKl5iNyhui5aY+LKvsmGra9PdafJ4zeU
4tdeKUoGCKxcN4FMW4I2Yu0xOzFF+II3ZpO0DcMXSHjdo2shFMOvbWk2eiKAn94F
YWlYSgyHvAyhBxhO2ABK
=4X0w
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

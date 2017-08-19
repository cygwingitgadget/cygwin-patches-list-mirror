Return-Path: <cygwin-patches-return-8827-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18264 invoked by alias); 19 Aug 2017 16:28:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18193 invoked by uid 89); 19 Aug 2017 16:28:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*c:application
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 19 Aug 2017 16:28:33 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 25F6771AF2C44	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 18:28:30 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 1C6AD5E046F	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 18:28:29 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 026D5A80642; Sat, 19 Aug 2017 18:28:29 +0200 (CEST)
Date: Sat, 19 Aug 2017 17:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: renameat2
Message-ID: <20170819162828.GF6314@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu> <20170818151525.GA6314@calimero.vinschen.de> <f7e3cc27-6989-54d8-8e3e-c11cdd5dfeca@cornell.edu> <20170819095707.GE6314@calimero.vinschen.de> <68b3c713-3261-e9d7-0865-384d18553744@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Content-Disposition: inline
In-Reply-To: <68b3c713-3261-e9d7-0865-384d18553744@cornell.edu>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00029.txt.bz2


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 782

On Aug 19 10:29, Ken Brown wrote:
> Hi Corinna,
>=20
> On 8/19/2017 5:57 AM, Corinna Vinschen wrote:
> > Hi Ken,
> >=20
> > On Aug 18 18:24, Ken Brown wrote:
> > The patch is ok as is, just let me know what you think of the above
> > minor tweak (and send the revised patch if you agree).
>=20
> Yes, I agree.  But can't I also drop the third test (where you said "good
> catch") for the same reason?  I've done that in the attached.  If I'm wro=
ng
> and I still need that third test, let me know and I'll put it back.

Nope, you're right.  Same rules apply for the third test.  Patch pushed.
Doc changes coming? :)


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZmGcsAAoJEPU2Bp2uRE+gIyUP/2nAVbybaUCNQ3jebNEuAdNS
08iyVOJE1luLCjVpuDmoKBU43JtVP1znF9LWyRFxuw26gAncA8FFewjZ/DkDDTjK
W/jHMtN/C3DqRl9TuYg+SUHRIz20SSEMhF9gK2YvDAqtggtnMNP/KCMZKzOk8bCI
V55PqcIQe+X6YWKLYG1d/iVLlRzyZ2CeROBsb9XpVXQUpMb6rMMGI2Q+9lGKs8Cd
jKbCLxoRA6NasCQhN9dvCvoHu8dHou7gZ9zpJDFPuksNRSAcb12YsTWw9sRuCTC6
thBIvh/YCmYzYWaddiKnQIaoHXeluG81uXEvBikglCfJp+gKDgheBrDHMVSsBKYC
6xqyTXSp6pR276CEuh12hd77bGdBrv/iQWn6IRHyXJI1QCcswYd4D4OJLqwVRZBQ
C/akusD21HFN9xXSXEJCVhKDrMGNbg6fEsnxydZblpPMSnapq8hHkIbcdlgVmi32
JVD0my9P4urNbcqlYAug7PyE4aGlRpAkwNHMc78v+mRj7aAmXx0G8aan1lEuPmcn
O4HWk9ooGiuSfgcgzWwZzB2FjrtW+TkKbSsCSzlVIaL0aTgBMXhrNg27OZSsBUQY
ivp7kAHYlvXu3YsFBymQTilVuJttVnuFnRmSAM/GpVg6M+uPusq02z+/KM8GfxkY
X36mDQuSUuMB6zqCnyWa
=nZzn
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--

Return-Path: <cygwin-patches-return-8469-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 59975 invoked by alias); 21 Mar 2016 19:58:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 59946 invoked by uid 89); 21 Mar 2016 19:58:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, person
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 19:58:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2B164A803F7; Mon, 21 Mar 2016 20:58:45 +0100 (CET)
Date: Mon, 21 Mar 2016 19:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Don't build utils/lsaauth when cross compiling.
Message-ID: <20160321195845.GL14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-4-git-send-email-pefoley2@pefoley.com> <20160321193052.GG14892@calimero.vinschen.de> <CAOFdcFM-9XOAEPhSWbED_eiECu-UeWW2FBkg-u8jo40+0FwAjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="w2xx78T4DcG3O+DJ"
Content-Disposition: inline
In-Reply-To: <CAOFdcFM-9XOAEPhSWbED_eiECu-UeWW2FBkg-u8jo40+0FwAjA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00175.txt.bz2


--w2xx78T4DcG3O+DJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1035

On Mar 21 15:52, Peter Foley wrote:
> On Mon, Mar 21, 2016 at 3:30 PM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > I'm not sure this is the right thing to do.  I'm cross compiling
> > Cygwin all the time, and I certainly need the mingw compiler to
> > build the utils and lsaauth dir.  In what case do you not need them,
> > and shouldn't that bordercase(?) be handled by some configure option?
>=20
> The effect of this change is to not compile anything under the utils
> or lsaauth directories when cross compiling.

Again, I'm cross compiling all the time since I build Cygwin on Linux
for development and package building, and I'm certianly not the only
person doing that.  This is the default case.  Not building utils and
lsaauth is the exception.  Therefore this scenario should be handled
explicitely by a configure flag, not the other way around.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--w2xx78T4DcG3O+DJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8FJ0AAoJEPU2Bp2uRE+gI2IP/1vXU624lPSkrPg0eBB0y/VN
oDI6QuQWOSHEE9+fhpBsU3RmSf7lQ5VFk2RMyVpAqGX2y06N8VRh2oTyXuKqHHvE
QIMWcnjSrVyNSAS/E74AHwCzccBKdq2eI2asHGtku1mKfFHq1mjf1xR7i2m/UDCd
ir15U9uL0RTiNLYmgq3AwO2eG5d88JmrG6n2buAJr7HwXXco4Jxn01kT8Qc9nu8G
eGg78wwt8kHHPSusFvjpsXclTIG6pkrS2lhaSo3yDXBgiVE6SH5tvw04YruuxLG/
2U1KmAD+lzMzND0GGdSJjMt6mdkB2dJcIIHCr9Lrz3zGxCYKed5Zhf/WLA/XM1oi
yXIUXX8x45bciY1OJtJ2pzXoIq1RRakBGKZzDGioYQrhznBjXijohX0c7WirRU1P
J0poBlZsAMUuopo9H3fEYESjy/8VC7KxGKi+8YvQzQ1wJokrU5BxQKayrl7VR1sK
q0AMuonuWRTGGGL1KmHdgMm+/yyxrSFHgACvUzu+e4dI4hXcghVtDyEh2k3HPGGw
OK/tGuhZ48EoiH6AugrOZ8ZBj/yawtZ4ffb+BmTP4Y87P1go3bZNkm8aXfwT0UM/
cUg12HH5yyPypkkYIygNpBcgdaNEOGJLOgooksZtqbTpsNgUYZv9xlNsO+cL/J4i
Gs7p7ieKioo+JRa0FrUe
=AvAx
-----END PGP SIGNATURE-----

--w2xx78T4DcG3O+DJ--

Return-Path: <cygwin-patches-return-8721-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 105485 invoked by alias); 20 Mar 2017 15:40:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 105470 invoked by uid 89); 20 Mar 2017 15:40:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=pose, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Mar 2017 15:40:20 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 10258721E280C	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2017 16:40:17 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 51E2A5E03A5	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2017 16:40:16 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 32657A80CF3; Mon, 20 Mar 2017 16:40:16 +0100 (CET)
Date: Mon, 20 Mar 2017 15:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Implement getloadavg()
Message-ID: <20170320154016.GL16777@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170317175032.26780-1-jon.turney@dronecode.org.uk> <20170320103715.GH16777@calimero.vinschen.de> <0a1b00e9-229d-a1b4-9e4a-15cc14601713@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="o7gdRJTuwFmWapyH"
Content-Disposition: inline
In-Reply-To: <0a1b00e9-229d-a1b4-9e4a-15cc14601713@dronecode.org.uk>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q1/txt/msg00062.txt.bz2


--o7gdRJTuwFmWapyH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1848

On Mar 20 15:04, Jon Turney wrote:
> On 20/03/2017 10:37, Corinna Vinschen wrote:
> > On Mar 17 17:50, Jon Turney wrote:
> > The load average is global, non-critical data.  So what about storing it
> > in shared_info instead?  This way, only the first call of the first
> > Cygwin process returns all zero.
>=20
> Ok.
>=20
> > > +static bool load_init (void)
> > > +{
> > > +  static bool tried =3D false;
> > > +  static bool initialized =3D false;
> > > +
> > > +  if (!tried) {
> > > +    tried =3D true;
> > > +
> > > +    if ((PdhOpenQueryA (NULL, 0, &query) =3D=3D ERROR_SUCCESS) &&
> > > +	(PdhAddEnglishCounterA (query, "\\Processor(_Total)\\% Processor Ti=
me",
> > > +				0, &counter1) =3D=3D ERROR_SUCCESS) &&
> > > +	(PdhAddEnglishCounterA (query, "\\System\\Processor Queue Length",
> > > +				0, &counter2) =3D=3D ERROR_SUCCESS)) {
> > > +      initialized =3D true;
> > > +    } else {
> > > +      debug_printf("loadavg PDH initialization failed\n");
> > > +    }
> > > +  }
> > > +
> > > +  return initialized;
> > > +}
> >=20
> > How slow is that initialization?  Would it {make sense|hurt} to call it
> > once in the initalization of Cygwin's shared mem in shared_info::initia=
lize?
>=20
> I don't think that's particularly heavyweight, and I didn't see anything =
to
> suggest that PDH query handles can be shared between processes, but I'll
> look into it.

Oh, right, that might pose a problem.

But even then:

The first process creating shared_info could call this and prime the values
with a first call to getloadavg.  Each other process would have to init its
own pointers.  You just have to make sure that access to the loadavg values
from shared_info is atomic.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--o7gdRJTuwFmWapyH
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYz/fgAAoJEPU2Bp2uRE+g/D0P/3TlhgHp3Sx26li1dxnNv1y5
tqPHR12LnaR1rOkI+Y9ZEBvLgtcaM8j3j6WI7VDxkYFKLtl484jJgEfSFFxoCOn8
C4UPCWQTo4EyVHVD75b2VEaBlT8yDbw//MmCFCRtXA0hcHjYC9hPR02GfB2krYcO
l9LarEdHxUEf/RAgjtjaJutNRNqnEg17SCWhHUdC1jZZEw7mx6t3b/PYVZHcCZf0
K7rfGlbgGNhzxjfafWRuhEZNpMimCv0JMl4VHf00jyq/dhgkYDB7co6a9gRWcCN3
GFsiF/dTXCI2nA9nIr2+jWg0ESNcBNDmKFXsJUI88/0gvINZVdhMtXKZph+sJihM
abWxcCkfOQUFo0wZMYJnGIdz50cJ5qyHHCIEtQ9RQu55bLo5UMVVDHvh/11ajljw
ZvDVYIo9j/8DzrObID2XnRUpeYON7xcP8X7IY7m9HDR+5C9JVH9/l8mmE2eXAotg
38VSwvL1+2L6YWD5fWoMXbBg7KBl14217pL5dHpslOgUE6WxFvszmw0/lkKQj1km
UBT1vkpYpzk1qLQ2vRw7MvT7fL8xA9cGW1w7oawVMKsPhjI/UpvLdDZ6b4iGArNy
9D5ipq/Mpw2Y1s2oLcETKgiLWzZbF6V99IQq8n7grLvd20b7Qa15H4rNkjxVfw3c
jDbmum7BeeMTFA+dYYuN
=1ND9
-----END PGP SIGNATURE-----

--o7gdRJTuwFmWapyH--

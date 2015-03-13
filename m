Return-Path: <cygwin-patches-return-8070-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17292 invoked by alias); 13 Mar 2015 09:44:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17280 invoked by uid 89); 13 Mar 2015 09:44:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 13 Mar 2015 09:44:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E7CFDA8096D; Fri, 13 Mar 2015 10:44:12 +0100 (CET)
Date: Fri, 13 Mar 2015 09:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: braces around scalar initializer for type
Message-ID: <20150313094412.GA20626@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CABEPuQJGji9Ue5E+j55to-u+VZV_oZ5kqF6piJFjhmMR+OJbhQ@mail.gmail.com> <20150312192253.GD11522@calimero.vinschen.de> <CABEPuQ+cpnyy3Ov6XHsLoJT=RDmNZoR7RvWwz0ZoqAieowcYgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <CABEPuQ+cpnyy3Ov6XHsLoJT=RDmNZoR7RvWwz0ZoqAieowcYgg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00025.txt.bz2


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 891

Hi Alexey,

On Mar 12 22:47, Alexey Pavlov wrote:
> 2015-03-12 22:22 GMT+03:00 Corinna Vinschen:
> > I'm ok with that patch, but it's missing the ChangeLog entry,  Please
> > provide ChangeLog entries per https://cygwin.com/contrib.html.
>=20
> + * net.cc: Remove extra braces.
> +

Please send the ChangeLog as plain text, not as diff.  It's not much of
a problem in our current case, but ChangeLog diff's don't apply cleanly
most of the time.

> -const struct in6_addr in6addr_any =3D {{IN6ADDR_ANY_INIT}};
> -const struct in6_addr in6addr_loopback =3D {{IN6ADDR_LOOPBACK_INIT}};
> +const struct in6_addr in6addr_any =3D IN6ADDR_ANY_INIT;
> +const struct in6_addr in6addr_loopback =3D IN6ADDR_LOOPBACK_INIT;

Patch applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVArFsAAoJEPU2Bp2uRE+g96oP/1OJ33nRX6eQtBJiDc41AETI
rf0LHAgnbwIE9yvGoqu0SmU3I/ZSnOS+Dyzywpn7VSVGPqId3NE4nYXn6WuMpoIg
D/5moBFBq+NLmOlb8FMj2Q0I8+8SRfmXUwPKzPQSv2uGTyX/zayQ5f4lWGuwmi8A
9JPQLSBOrLQERHj1/ER68qatiJgk5ekBmlR9kNuMu6BuuepwaAPn2IAUWdI6QCYB
swWmMYfvF9Bm453Dxez6/2j6PcckqTNIPg/zvtBJjZfl6EaOVzi2wh4ZZPBTmRhK
FN3SI+/nTJDY3cqeaJV3M0quxmIttZQ7Jb9RZu8afnGCKFedlI1FXDuuY6VmKQVo
2h1H0ibxDgv8WG9UuO5UMWnuMO5rEwjaj3fRNKTpy0W2D0y3E+jv2+FOzV/Rrkk3
5jpwNgdmKAL2wEAWZjHBG/ACUNcRlaXXOzBORMGDb3Cf/vxEsFzgEJC0vdgzc81s
K479jgnJk3aj2ngWAH7yoPB08SlzTE2RwBBIzaNE3hhMTJcGJVEmJo1pkwu+qW6N
xPqxuLskQyCaS3BNlXrLrtF+muC/Oytos1qeB991oa4DisCFTHxURkC5GEfo+ioS
rFxgtf5udVUY7Udav/NG4O7U6QXY9WVQ4yxKWpeqdw5mY1DZdWUAHMzsn44/sdYp
rH7swH3fV0PT6El2cpFf
=iiF0
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

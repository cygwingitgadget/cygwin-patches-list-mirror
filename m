Return-Path: <cygwin-patches-return-8032-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18202 invoked by alias); 18 Nov 2014 20:43:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18187 invoked by uid 89); 18 Nov 2014 20:43:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 18 Nov 2014 20:43:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CD9A78E12C7; Tue, 18 Nov 2014 21:43:44 +0100 (CET)
Date: Tue, 18 Nov 2014 20:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix performance on 10Gb networks
Message-ID: <20141118204344.GJ3151@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAE3zD3WZU8ZvqwW69f4hs+vFigShstjvh9HKuHGewXTLDsx==w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="SVeEiVwWO9F1slJ8"
Content-Disposition: inline
In-Reply-To: <CAE3zD3WZU8ZvqwW69f4hs+vFigShstjvh9HKuHGewXTLDsx==w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q4/txt/msg00011.txt.bz2


--SVeEiVwWO9F1slJ8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2708

Hi Iuliu,

On Nov 18 19:30, Iuliu Rus wrote:
> Hello,
> Google is running Cygwin apps on its 10Gb networks and we are seeing
> extremely bad performance in a couple of cases. For example, iperf
> with the defaults results in only 10Mbits/sec.
> We tracked this down to a combination of non-blocking sockets with
> Nagle+delayed ack kicking in, since the apps eventually end up sending
> a very small packets (2 bytes).
> We have a case open against Microsoft but since everything is moving
> very slow we would like to work around by picking socket buffers that
> are multiple of 4k.

Thanks for the patch.  One question:

> Change log:
> 2014-11-18 Iuliu Rus <rus.iuliu@gmail.com>
>=20
> * net.cc Change default values for socket buffers to fix performance
> on 10Gb networks.
>=20
> Index: winsup/cygwin/net.cc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
> retrieving revision 1.320
> diff -u -p -r1.320 net.cc
> --- winsup/cygwin/net.cc	13 Oct 2014 08:18:18 -0000	1.320
> +++ winsup/cygwin/net.cc	18 Nov 2014 19:12:00 -0000
> @@ -621,13 +621,16 @@ fdsock (cygheap_fdmanip& fd, const devic
>       this is no problem on 64 bit.  So we set the default buffer size to
>       the default values in current 3.x Linux versions.
>=20=20
> -     (*) Maximum normal TCP window size.  Coincidence?  */
> +     (*) Maximum normal TCP window size.  Coincidence?=20=20
> +
> +     NOTE 3. Setting the window size to 65535 results in extremely
> bad performance for apps that send data in multiples of Kb, as they
> eventually end up sending 1 byte on the network and naggle + delay ack
> kicks in. For example, iperf on a 10Gb network gives only 10 Mbits/sec
> with a 65535 send buffer. We want this to be a multiple of PAGE_SIZE,
> but since 64k breaks WSADuplicateSocket we use 60Kb.

We do?  See below.

> +*/
>  #ifdef __x86_64__
>    ((fhandler_socket *) fd)->rmem () =3D 212992;
>    ((fhandler_socket *) fd)->wmem () =3D 212992;
>  #else
> -  ((fhandler_socket *) fd)->rmem () =3D 65535;
> -  ((fhandler_socket *) fd)->wmem () =3D 65535;
> +  ((fhandler_socket *) fd)->rmem () =3D 63488;
> +  ((fhandler_socket *) fd)->wmem () =3D 63488;

This is 62K, certainly not a multiple of the native PAGE_SIZE of 4K.
And this makes me wonder.  Did you intend to use 60K and ended up with
62K for a reason?  And then, why not 63K as a multiple of 1K?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--SVeEiVwWO9F1slJ8
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa6+AAAoJEPU2Bp2uRE+gm/QP/30FSYu9IHLfIFfvfTP/Vzlc
pCV4brzNtsF6BccGrKYMJlN1CAuVMvDedPgETNDHi2j7piC8wFjuGWkkfp7JBoVu
ep5yNP3qqxNyvPIVH/+ZJJONNGagS2uaBPVMMCqLprs0bKEr5EXEByu2CE+hjyMb
NvFWdGNWItIAcPEy1K7UPC3+X04SNCOdTINx/m+OpdMd3+HG40m9d98elRCc4cvk
s0fXC84kqU463j/bl6+8KriYEKKGqNrWU1SFklFBgEfObhMxyQsobU3xv15jxMqn
5UFFUrvHCgfc03d+1ZEJRSZr0hDSWMt7NT6hMZscxavFXNHwHkB6AtiPFJ6ukC0S
vLnWkO+E1rH9iHYFxPRg/W1IuAJ3Se23bf60COZ+AD9es7wok19n9tCJyNx4GKrt
aW1OZM/fxs8AqWqaM8xrM1ppxBJdTZ1uVNpAJBCEgA9zToOVJMeaEIaRY+R5tROT
vVk6Petx/rpRR1ZTr37+1iQt/zoKgayzT8Tlm5hU4HCjMux/Kpvd0kcwq9oYVjgx
SM9v8Qumd9ARWY1kMpl7yPYAt6zEELSt961pMuLleu9faPHY50pTXuxN5G++r0DU
JZBSsnd8zUB6zvYxp6dsIt0I7ml3csTG/gCKSIibov/PdDO8E6CNSESQAQ1Gu6Uh
zFWHnibC5wxauc/Dz/pb
=xs3x
-----END PGP SIGNATURE-----

--SVeEiVwWO9F1slJ8--

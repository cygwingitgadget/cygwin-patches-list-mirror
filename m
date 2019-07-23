Return-Path: <cygwin-patches-return-9515-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108956 invoked by alias); 23 Jul 2019 19:16:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108803 invoked by uid 89); 23 Jul 2019 19:16:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*f:sk:59c6529, H*i:sk:59c6529
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Jul 2019 19:16:52 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MzR0i-1icS8X1bPs-00vL46 for <cygwin-patches@cygwin.com>; Tue, 23 Jul 2019 21:16:49 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B18EEA80872; Tue, 23 Jul 2019 21:16:48 +0200 (CEST)
Date: Tue, 23 Jul 2019 19:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Cygwin: don't allow getpgrp() to fail
Message-ID: <20190723191648.GP21169@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190723161100.1045-1-kbrown@cornell.edu> <20190723161100.1045-2-kbrown@cornell.edu> <20190723165458.GM21169@calimero.vinschen.de> <59c6529d-b411-fcf5-fa82-8a681d5b6378@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="acOuGx3oQeOcSZJu"
Content-Disposition: inline
In-Reply-To: <59c6529d-b411-fcf5-fa82-8a681d5b6378@dronecode.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00035.txt.bz2


--acOuGx3oQeOcSZJu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1033

On Jul 23 19:07, Jon Turney wrote:
> On 23/07/2019 17:54, Corinna Vinschen wrote:
> > Hi Ken,
> >=20
> > On Jul 23 16:12, Ken Brown wrote:
> > > According to POSIX, "The getpgrp() function shall always be successful
> > > and no return value is reserved to indicate an error."  Cygwin's
> > > getpgrp() is defined in terms of getpgid(), which is allowed to fail.
> >=20
> > But it shouldn't fail for the current process.  Why should pinfo::init
> > fail for myself if it begins like this?
> >=20
> >    if (myself && n =3D=3D myself->pid)
> >      {
> >        procinfo =3D myself;
> >        destroy =3D 0;
> >        return;
> >      }
> >=20
> > I fear this patch would only cover up the problem still persisting
> > under the hood.
>=20
> I agree.
>=20
> There is presumably a class of programs which require getpgrp() to return
> the correct value for correct operation, which cannot be 0 (since that
> cannot be a pid).

However, did we ever see this problem outside of GDB?


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--acOuGx3oQeOcSZJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl03XSAACgkQ9TYGna5E
T6DAnQ/8DbP3TY4WmwLX3NbHr2bjEKhr3TV6bu39ZV8BLFDbAh7vFMOpevx9y+Hr
BDcqZSNHDVrmIY0BFsgWhac0qhLbpHUY7HrAcvQfaZu9aGOrUQ5ck3FJdFobfZYj
3Cok8GZ5P5IwAYdgGrSDrAeYEFgzt7CGDuVR5cZoo8tQLU/8EsyCDfrJYO6vy3uy
qp1KjWQi5ampQxnHns8FAWdX5KvU0RXp2Kp03w3aqbxUTnWrBaLZy5lUiJBQ35rD
454M7K6+AhR/7iPsKk6wKRvP2MmbkE+ueClPqfGm+9SwC7aOoWA7ytrYwCM2RTdY
KW6SitwdlFroNIWzj/TyTprYPrLgizdTMa6hjEZTE6oq/lSVKU7euW4ajxJGjMEI
V3+lqffdyrWxXeRxEIH6oQveD6i7hHLcx5odlhxYRlry9iKlm6mWfNfo6LsJWtu+
2HmHXPCbqHIl7yxmhujcCuTNo1pLOUH7fAK7dOe3rSmNSmpAivwLme5MysnwRUAq
vYKbo0iDyUfPBbtOa6+5LylQTZASeCSLTBn9NE/mUIWSSRKdqbbvpSFg5KEWCdDc
Njmz2xn+8Hqs8V7hC48USExyk7xRLmI0OBWTlfD4S6d2a3F1CYBraiHaZDsumDEQ
qo2F72KCxvSdb23YPNxEH7eU9l3HMeSVrQv8Lg8O0uogRlDimGg=
=+yzM
-----END PGP SIGNATURE-----

--acOuGx3oQeOcSZJu--

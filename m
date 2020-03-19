Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 3C21A387702F
 for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2020 15:45:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3C21A387702F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N6bwO-1jM45z1RN8-0180sp; Thu, 19 Mar 2020 16:45:01 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id DE67FA80734; Thu, 19 Mar 2020 16:45:00 +0100 (CET)
Date: Thu, 19 Mar 2020 16:45:00 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Use a separate Start Menu folder for WoW64
 installs
Message-ID: <20200319154500.GG778468@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
 cygwin-patches@cygwin.com
References: <20200319135837.2104-1-jon.turney@dronecode.org.uk>
 <20200319150249.GC778468@calimero.vinschen.de>
 <20200319150419.GD778468@calimero.vinschen.de>
 <38387a81-5368-e6ec-b653-fd6f6e05478f@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Content-Disposition: inline
In-Reply-To: <38387a81-5368-e6ec-b653-fd6f6e05478f@dronecode.org.uk>
X-Provags-ID: V03:K1:CZI2t/9qeT9E1Ykl93wJig5DIbSDQrFjQrtEXC5Q/nTbgztI+PF
 Znqv40eq9hF+kEbDfTztBVwWH1F0ZLFGGUTDbXalkLK9maM+g6bGocn5BmjHIGyfSZnYQkx
 PK8hZrMq4aV2KXs/l84NIHUafTZE602wfY6+oVn4JFWBqBqe98IQJlef9bF0IPiGQy8RHFj
 XHW3bvgcYQTz1AiNj+vlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vJqLhJBNYXg=:5/5vT/dRzVmY7G78a/sHzc
 u2WLAh/8/2J3xCnAHq9TP3CivE8iRe6cpT9d/8nXnRT+hLBQh2lsy1iBNlrahMVZKhGHQkmyv
 /lBYdWH+48cfSNPrYWZ+P2nRkr2gZZuOAvga3jWYSsgAZA5tRi4QFFlWJ3UUI7beec7vHQk9o
 TJ8IQiVGUW33n1MRSKZwiHJfjy88Y6gS7W24c1EKhWVpuzFnsFraNdabVqw0JAHdTtp1NUFKJ
 8wDOkKXkWYYBlyZmy/J0HlOkrIj/HXMananEFZeT4sR9Azgk7Ctqdb/wwC7aUFVFmSUEqsySK
 YHADaBRmFz53MLVBOPPFwtZdvoZ6bJMEgOj4GDOBFrHO1iOemiqKq50D0v3MK9eQwupT+d9pc
 KbYwymYQ6k7i5qrpnjRgM5+C3K1lWaObP7OPitIusNSPI//0B0WbpR4f/sE1oau77Dbgl0KN5
 /maIYJk/Ao5MFd44lx7B81dS8sPEk/FYc4VosSSwI9zP1Gi4XTu+sUPi2SMGLiTak5PGdhZi5
 6UzV1+NUtkSatrEKS9VOh0dz0X7+Lu8KOcee52a3sUM9wyZmfHlLqb0o3vP9B/SLB3y80z6ie
 WDIo+k/QXdlft91S+JEXXpBCcGG1u8ivQdQcJ1JqmdVjpWMTEBp7hfjhZ4OljH7tde8PhQdYo
 VsS0so5bOlcCsudkGLo+KpFp8WmyVOSJUugQ9NMNkmBbYivNooBFKxEHhFNf0Z59qSAn8Jz6C
 YTEZVGpGWpFXm5a0V0nuDy2c+lDc4CVmWaevwnuWSlV+F0odpYte4EDBk58q/DFcqNnoVgexs
 AThm0yty3WPE1c2PufCU5aVImviotjdCVXUtGZ1xzIUa5DZpM9m1tc7bHGfY0OmXDLk7xxI
X-Spam-Status: No, score=-99.2 required=5.0 tests=GOOD_FROM_CORINNA_CYGWIN,
 KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_NEUTRAL autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin-patches mailing list <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <http://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 19 Mar 2020 15:45:08 -0000


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 19 15:40, Jon Turney wrote:
> On 19/03/2020 15:04, Corinna Vinschen wrote:
> > On Mar 19 16:02, Corinna Vinschen wrote:
> > > On Mar 19 13:58, Jon Turney wrote:
> > > > This aligns the shortcuts to documentation with the setup changes in
> > > > https://sourceware.org/pipermail/cygwin-apps/2020-March/039873.html
> [...]
> > > Good idea, please push.
> >=20
> > ...this requires a new release of setup and Cygwin in lockstep, right?
>=20
> Worse than that, since this postinstall script checks if smpc_dir exists,
> and does nothing if it doesn't.
>=20
> So I think I probably want to change that to creating the smpc_dir if it
> doesn't exist, so we don't require that the updated setup has run (and
> completed, creating that directory) before we run that postinstall script.
>=20
> Sigh.

No worries.  You have free reign over that postinstall issue.  Just
go ahead as you see fit.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5zk3wACgkQ9TYGna5E
T6C1yw/9EswevZFFY8hZUDqAMpBQA4wGbrhAvmED8X9uQYNZQt56fSOdQxV3oTNk
n9X9+bC7o74Ef1PTQJTxqsyYoqWgAvTuDwxZSeFcjby46S8DIk2F9DEuALVd0jMf
IY+iRGUenPBoTsvN1bUwmdsCO6UdOCVWwSHiMjjUqsE3ABdPsIBrKqmnawkwKgvO
divuuurRqnHKtj7XpriKU2iAVMLxFIbMdYV2QBP34kCyenPNPK3jBiD42pEfYL6z
04J3AVO5RlgSgpq05/eGjyTC+M5vNAjA6odFyfwXsxaPii/Y0Tb3D9SDuSIlsQOl
t9x+u5mBYBU4XmOZCvSLFoWR1MqM7TL1C2o+h+PTO5OgnqnZ3xj0kbC1bzo+xmMg
4R/GOfZLyT6jmPgUbCX84ryutHS0DrZgvh5yFx4aKJLYtcsiLmISV8nZmOk2HcAP
TJRm8SkfuIzQtSm/sU7LK4MDMO6YdVpd/NvqTUnWZh159FaQ0Leb2chdHhIg18/U
mq/b1wCEZm6Afax1vew76Z/SvnBiBIvq8goFQVQdBY0zKHY/3ROUY8ScYn6x2EcV
UPIIVpaw5OmvN6y7ksi/ew7Z6sKa7itlujbQYvC+I5tOLqQlU4cjS+COeYq0eSWg
z9qoUk4/EB6YvE6/eYj2XuuZFVvxCKKnQwOn2Vf8E2MQqzucxB0=
=yrtk
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--

Return-Path: <cygwin-patches-return-9092-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30103 invoked by alias); 7 Jun 2018 08:20:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30064 invoked by uid 89); 7 Jun 2018 08:20:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=2128, Hx-languages-length:2143, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 07 Jun 2018 08:19:58 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis) id 0McWDw-1fiN240uQK-00Hdxa for <cygwin-patches@cygwin.com>; Thu, 07 Jun 2018 10:19:56 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B5140A804D2; Thu,  7 Jun 2018 10:19:55 +0200 (CEST)
Date: Thu, 07 Jun 2018 08:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: remove cygpid.N sharedmem on fork failure
Message-ID: <20180607081955.GB30775@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <f45c9bb0-eb52-803f-ee42-1fc52725f3b1@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <f45c9bb0-eb52-803f-ee42-1fc52725f3b1@ssi-schaefer.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q2/txt/msg00049.txt.bz2


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2631

On Jun  5 15:05, Michael Haubenwallner wrote:
> Hi,
>=20
> I'm using attached patch for a while now, and orphan cygpid.N shared memo=
ry
> instances are gone for otherwise completely unknown windows process ids.
>=20
> However, I do see defunct processes now which's PPID does not exist (any =
more),
> causing the same trouble because their windows process handle is closed b=
ut
> their cygpid.N shmem handle is not.
>=20
> For example, there is no PID 1768 anywhere, although it is the parent of =
both
> the <defunct> processes:
> $ ps -e
>       PID    PPID    PGID     WINPID   TTY         UID    STIME COMMAND
>      2416       1    1496       2416  ?         197610   May 25 /usr/bin/=
python2.7
>       560       1     560        560  ?         197613   May 25 /usr/bin/=
cygrunsrv
>      2348       1    2348       2348  ?         197612   May 25 /usr/bin/=
cygrunsrv
>      1132       1    1132       1132  ?         197612   May 16 /usr/bin/=
cygrunsrv
>       440    2028     440        740  pty0      197609   May 29 /tools/ha=
ubi/gentoo/test/usr/bin/bash
>      3664    1768    3612       3664  ?         197610 12:25:01 /usr/bin/=
python2.7 <defunct>
>      2852    2704    2852       2364  ?         197612   May 25 /usr/sbin=
/sshd
>      2268     560    2268       2128  ?         197613   May 25 /usr/libe=
xec/sendmail
>      2968    1768    3612       1500  ?         197610 12:25:01 /usr/bin/=
tail <defunct>
> S    2832     512    2832       2312  pty0      197609 10:57:51 /usr/bin/=
vim
>      2028    2852    2028       2000  pty0      197609   May 25 /usr/bin/=
bash
>      1164    1132    1164       1256  ?         197612   May 16 /usr/sbin=
/cron
>       512     440     512       1544  pty0      197609   May 29 /tools/ha=
ubi/gentoo/test/usr/bin/bash
>      3264     512    3264       1488  pty0      197609 12:43:35 /usr/bin/=
ps
>      2704    2348    2704       2856  ?         197612   May 25 /usr/sbin=
/sshd
>=20
> That missing 1768 process for sure was started as (grand) children of 241=
6.
>=20
> Problem is again that another fork'ed child processes with PID 1768, 2968=
, 3612
> and probably others fail to initialize.
>=20
> But I have no idea whether attached patch is causing or uncovering this i=
ssue...
>=20
> Any idea?

Not really.  Processes are kept around after exec to keep the PID
blocked.  Perhaps your patch is breaking an assumption there.
I wonder why you have a problem with failing forks in the first
place...?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlsY6qsACgkQ9TYGna5E
T6DvTQ//ZgH4MGjzux5+rjjGCuky7XbXg36hi7LJrP5EPy4cKMCEZpD4PTcIOwff
Q4bKduNCUGxGQC/lpt2z3glx7qjm53TKGYVxM8eQhhXXb4aqjcIP1ilKIc30dNqk
kLeiCnI/3/VLJ7pCjJOEkm1hJ+3yQJRVKGp03LVLCRy9NY1JHPfWRbXrKtS7ug49
0Hu4bVbA1G9KYaDH2jgEnHkmpc2palvMtFUNHHdhQYXv9ECQ6IfDzr2+eEXsqmu2
b5mFYrw6DaBruJXcl1IpbfvFDJoLofnm1jk3lAoSPmxnHJSPHDpTLLJy09NVky18
HTHFH5rQ8rvWouQDH+7CXbS39fQIoM2ksjD/aq0U1NbxjOoUC0coF9cP/h3hv/Z0
HmRO6PF1gqCzpmvA/SWtQJkwKfokRssonC0ivokbHAGU61jwV1wRr8tU9n48P5m5
KR0EVVPbZ74g+7VS/HQVa7eP+wL9y5Nrl29BpKyARRJqdT6BId5/z/QTIIbMdrnm
35G3zLQsSU7ho/eLNw9d/m/A7ToPiScRUXP0GvYb+lbtJbZ3tvxHlaDwsrJMxe/K
CV3HL9dXQDXEqut9UWdEYSJT5mglJddbZd31S4An8QCZVxz+dTFzRxqY+BT/GfYH
EDkD1k0pxhpaUApH46lx3EAW6iD6uVXP1BMio5LiMwiDCccJJ0I=
=fGtD
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

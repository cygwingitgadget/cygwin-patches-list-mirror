Return-Path: <cygwin-patches-return-9101-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35422 invoked by alias); 22 Jun 2018 10:25:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35335 invoked by uid 89); 22 Jun 2018 10:25:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=corner, retry
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Jun 2018 10:25:24 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LjOHr-1g2seH45Et-00dazz for <cygwin-patches@cygwin.com>; Fri, 22 Jun 2018 12:25:11 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 52DC4A807E2; Fri, 22 Jun 2018 12:25:10 +0200 (CEST)
Date: Fri, 22 Jun 2018 10:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: remove cygpid.N sharedmem on fork failure
Message-ID: <20180622102510.GO11110@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <f45c9bb0-eb52-803f-ee42-1fc52725f3b1@ssi-schaefer.com> <20180607081955.GB30775@calimero.vinschen.de> <913f9a8e-16ef-0384-6a42-d2884efa4b32@ssi-schaefer.com> <20180621072756.GF11110@calimero.vinschen.de> <197571b7-9448-4a6c-0dc7-4b2407b7f19e@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="lHuqAdgBYNjQz/wy"
Content-Disposition: inline
In-Reply-To: <197571b7-9448-4a6c-0dc7-4b2407b7f19e@ssi-schaefer.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q2/txt/msg00058.txt.bz2


--lHuqAdgBYNjQz/wy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2059

On Jun 22 11:04, Michael Haubenwallner wrote:
> On 06/21/2018 09:27 AM, Corinna Vinschen wrote:
> > On Jun 20 17:47, Michael Haubenwallner wrote:
> >> On 06/07/2018 10:19 AM, Corinna Vinschen wrote:
> >>> On Jun  5 15:05, Michael Haubenwallner wrote:
> >>>> Hi,
> >>>>
> >>>> I'm using attached patch for a while now, and orphan cygpid.N shared=
 memory
> >>>> instances are gone for otherwise completely unknown windows process =
ids.
>=20
> >>
> >> Without this patch, for the first-try child process which the
> >> cygwin1.dll fails to initialize for because of wrong dll loaded,
> >> the process handle is released but the cygpid.N shmem handle is not.
> >>
> >> Then, another completely independent process may get the same
> >> windows process id again, and cygwin1.dll fails to initialize
> >> because of the existing but orphaned cygpid.N shmem handle.
> >=20
> > This problem appear to be a non-problem in the normal code path.
>=20
> Well, the underlying OS may temporarily be low on resources,
> and the parent process may retry to fork by itself...
>=20
> Currently, when the child process can be created but not initialized
> by cygwin1.dll for whatever reason, the process handle is closed, but
> (as far as I have understood) the shmem handle actually is lost, and
> the orphaned shmem entry exists until the parent process terminates.

Actually I'm not sure about this discrepancy but I guess the shmem
was a tolerable loss at this point.

> > In case of restarting the 2nd-try child, wouldn't it make sense to reuse
> > the shmem area instead of breaking it down?
>=20
> The 2nd-try child usually does get another windows pid, and we would have
> to *rename* the shmem: *before* closing the 1st-try windows process handl=
e.

You just can reuse it in the corner case where the pid is the same.

> And when neither child can be initialized for low resource reasons?

Fork simply fails?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--lHuqAdgBYNjQz/wy
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlsszoYACgkQ9TYGna5E
T6CMtg//TgBb9mij9KUDjg7j28hne/Ss+4YzjKZon7By4d5j1nJ7V8brexahOQBu
KxiIRL2xHq4ZUPTi0PDTiOHF6b8UBcnmYPJtdZuln/pSTcVmDx+RhNWmeUweNRbV
7EjYgyBLBEZi+VhYhx1vMB8GUcSdA/AzsZv3EpbG6XVwB/vh1Lg4d05VYU8T2IH0
gK8aam/6dfZoih+I7hjAVSskLzeuJraKw3rKmtyS6MvWqth0EgxylG5mVYwDXoRf
ndBUiWKDedfyhZOrwk3UdIGtsCOuFElnbNWeMfhjz7JHK8NdYylsG30pjKFENcRI
VljRLikIM/DR2ugEKp1ZQ2VFB9dTqyKWELWGmbToXI3w0W4pLaj/7ftGZ14ZwZPP
5G8VuThwRw7bGw81oNaPLRgX1wZ+y7AjUHIONWA4D5Zt1RenK96xMEoV4fe0fj+L
EMKmHI1NrqJ4LU2dzUPLzs1neD//7dD5goKIY7ulP3g0sXZTTsvhGM1jSjUI7DOq
TD5SFiX7W3BsGSxNaIlxPDj64Npg9zjlYpbHjhPJYXrBQeBsPikwijnn8+VwqvHL
ffdHolRyFR4qAPRyvSX0A22e9AoExkP2BxN9Zy5IMVkXZLMCtuH1Lec88vLNGXtX
5rfE850LGIzZaJIJ6qRz6spyHX4ffxHigd6ABBg4KUS0lGzIBys=
=zBh/
-----END PGP SIGNATURE-----

--lHuqAdgBYNjQz/wy--

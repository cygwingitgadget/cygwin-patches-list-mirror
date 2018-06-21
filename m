Return-Path: <cygwin-patches-return-9095-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82518 invoked by alias); 21 Jun 2018 07:28:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 82359 invoked by uid 89); 21 Jun 2018 07:28:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, Hx-languages-length:2099, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 21 Jun 2018 07:27:59 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue103 [212.227.15.183]) with ESMTPSA (Nemesis) id 0Mhf9f-1fqzE72Xr9-00Mqv3 for <cygwin-patches@cygwin.com>; Thu, 21 Jun 2018 09:27:56 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 28FA1A807CB; Thu, 21 Jun 2018 09:27:56 +0200 (CEST)
Date: Thu, 21 Jun 2018 07:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: remove cygpid.N sharedmem on fork failure
Message-ID: <20180621072756.GF11110@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <f45c9bb0-eb52-803f-ee42-1fc52725f3b1@ssi-schaefer.com> <20180607081955.GB30775@calimero.vinschen.de> <913f9a8e-16ef-0384-6a42-d2884efa4b32@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline
In-Reply-To: <913f9a8e-16ef-0384-6a42-d2884efa4b32@ssi-schaefer.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q2/txt/msg00052.txt.bz2


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2100

On Jun 20 17:47, Michael Haubenwallner wrote:
> On 06/07/2018 10:19 AM, Corinna Vinschen wrote:
> > On Jun  5 15:05, Michael Haubenwallner wrote:
> >> Hi,
> >>
> >> I'm using attached patch for a while now, and orphan cygpid.N shared m=
emory
> >> instances are gone for otherwise completely unknown windows process id=
s.
> >>
> >> However, I do see defunct processes now which's PPID does not exist (a=
ny more),
> >> causing the same trouble because their windows process handle is close=
d but
> >> their cygpid.N shmem handle is not.
> >>
>=20
> >>
> >> But I have no idea whether attached patch is causing or uncovering thi=
s issue...
> >>
> >> Any idea?
> >=20
> > Not really.  Processes are kept around after exec to keep the PID
> > blocked.  Perhaps your patch is breaking an assumption there.
> > I wonder why you have a problem with failing forks in the first
> > place...?
>=20
> I'm successfully using the topic/forkables patches still, where
> fork is retried using /var/run/cygfork/ when an exe or dll was
> replaced (by some in-cygwin package manager).
>=20
> Without this patch, for the first-try child process which the
> cygwin1.dll fails to initialize for because of wrong dll loaded,
> the process handle is released but the cygpid.N shmem handle is not.
>=20
> Then, another completely independent process may get the same
> windows process id again, and cygwin1.dll fails to initialize
> because of the existing but orphaned cygpid.N shmem handle.

This problem appear to be a non-problem in the normal code path.  In
case of restarting the 2nd-try child, wouldn't it make sense to reuse
the shmem area instead of breaking it down?

> For those "Suspended" windows processes (sh.exe):
> They seem to occur eventually when a shell script was executing some
> native windows process (msvc toolchain). Interesting here is that
> I got *4* Suspended sh.exe on the *4* core VirtualBox machine...

That really sounds weird.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlsrU3sACgkQ9TYGna5E
T6ABfA/1HVYQusxjoPq4fgu/T14e85fBozl6Y15r3Rw/SlF3XoPqf3HijLtnauQc
hEpUEBL9E7r3Me8wbuEOEx2UK1+vxAv3KZId2Oge5spIrb2yhbD+pXe0O6tz+0HC
5/4jUNNvbF9KR4NlWHvK01bM2a9XaOlL+TtMrQqTjAYt6sxXXVLLBxDX2TXf3DDf
iOa0i54rmFua/SizOql5CFZ/LOW0scoj3zSHvEu5rlGEQ6FKTIN8IYFel7B0xtHR
4WMu2TsKdPHAtdWmt9FKfKKSg+KdfjYjJ0ENMCqPah1nr5KnDY/+opcCzybXH3JC
sRNj7iShJ9rmIstnqN1BIH1YL2FmC1tVcDbVBgfqywGMCn05CKw2Sv5Yok/rT7sS
KLqgWdiBhMmeRvJ91qXF0071VImj7VN+bnPOu+i8SPHC8MvwfnrUM2hQETcpBcYo
+wsPPnJyI/3PpHm6Zg2j2hJ496C0ymXF9XAt6kyaQtyzPHy5N2Y+CJgZgW6I+EP9
2TaB8GiCwTQ9BUIBMA6cXpXRAVL+q12PAr/FjoCE0TjvcpHd0PqmbKS+be8LJnmM
r5ymsUC2dmXY97hAPlYNnTz0MvnHoVwbvLUqKCkeEzWVhmz2rW6qLUMzQZgmJjql
6oo7BieZD+r7eWhmMJoV3G+fnVQBzUFvwgfwIUNU1e4sMUJLpw==
=Cbh2
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--

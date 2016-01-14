Return-Path: <cygwin-patches-return-8295-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 89168 invoked by alias); 14 Jan 2016 19:50:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89153 invoked by uid 89); 14 Jan 2016 19:50:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-92.8 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,KHOP_DYNAMIC,RCVD_IN_BRBL_LASTEXT,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=purely, jonturneydronecodeorguk, jon.turney@dronecode.org.uk, Guide
X-HELO: calimero.vinschen.de
Received: from ipbcc05c50.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.92.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 14 Jan 2016 19:50:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D47B8A8053A; Thu, 14 Jan 2016 20:49:58 +0100 (CET)
Date: Thu, 14 Jan 2016 19:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Update FAQ question and answer about gdb and signals
Message-ID: <20160114194958.GD2747@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1452794719-6124-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline
In-Reply-To: <1452794719-6124-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00001.txt.bz2


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1862

On Jan 14 18:05, Jon Turney wrote:
> Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
> ---
>  winsup/doc/faq-programming.xml | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.=
xml
> index af6102a..7f1ffd9 100644
> --- a/winsup/doc/faq-programming.xml
> +++ b/winsup/doc/faq-programming.xml
> @@ -859,15 +859,22 @@ on using <literal>strace</literal>, see the Cygwin =
User's Guide.
>  </answer></qandaentry>
>=20=20
>  <qandaentry id=3D"faq.programming.gdb-signals">
> -<question><para>Why doesn't gdb handle signals?</para></question>
> +<question><para>How does gdb handle signals?</para></question>
>  <answer>
>=20=20
> -<para>Unfortunately, there is only minimal signal handling support in gdb
> -currently.  Signal handling only works with Windows-type signals.
> -SIGINT may work, SIGFPE may work, SIGSEGV definitely does.  You cannot
> -'stop', 'print' or 'nopass' signals like SIGUSR1 or SIGHUP to the
> -process being debugged.
> +<para>
> +gdb maps known Windows exceptions to signals such as SIGSEGV, SIGFPE, SI=
GTRAP,
> +SIGINT and SIGILL.  Other Windows exceptions are passed on to the handle=
r (if
> +any), and reported as an unknown signal if an unhandled (second chance)
> +exception occurs.
>  </para>
> +
> +<para>
> +There is also an experimental feature to notify gdb of purely Cygwin sig=
nals
> +like SIGABRT, SIGHUP or SIGUSR1.  This currently has some known problems=
, for
> +example, single-stepping from these signals may not work as expected.
> +</para>
> +
>  </answer></qandaentry>
>=20=20
>  <qandaentry id=3D"faq.programming.linker">
> --=20
> 2.6.2

ACK


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWl/vmAAoJEPU2Bp2uRE+gXAUP/3Ua/QA6E2mtMoNxrUstTtIv
25EvhjBoVZAULwPNXcntJZtBWBHuaB1uoXJ3kYxBz0/Wz3W1st9twkysTusO0aYU
dXPQYzbV5DfSV9PR8OF1F9ZhXRqDCmQj6f0X1/IlAMq6rJD6qvitARCWlgaRAkd0
c2iNPRwPjS+Pj+A3XkghLHq6OVN/FQ6I6ph+XCNdHfn7VXy7hxlW4UIwMWdvvZnZ
7KSpD8VrrDxa6wOvqhjGfoZCJAzjzusSRVz+FAsb3GDGFxBnlzU2B2a+Zpm9eDCV
9kF1e+NLSmYDkOTHMcD6Pp34cdGpozPxpkEqP2CRQPxNWVmOXMC9RHhb65Yoww/m
RSr+RVvXYy/EnsCzBxu4xgS4HjWPMRiQ8wExtM68aw3Ylf9yfSVeOwr6hXykXXTY
l0ClZ/6ZD91KJvy85S7NcJaIzY3QUyPcny2F4PyfVLAVOTpG5iLbeiEgxLl2/nfs
NUgs6yF3fbY1aZWfuMpguDNBFFqakKRkWX6SC09DLT/Fw8kqK084ZsqbaXaD0QVG
Y7Kixlh9wToRyLiJRby/KjO9jif8C4/2eFZiX2NqWUQ5jPUeUbG4QdOZdNi9HlUU
GfjX4vLfKAZ/LGo142hcnNWis8+v/BMFS4YzoifZIaH/DFcJg/HFuku8zuXDdl7m
6jLZMRgwL9P3m0TTlf4p
=E0H6
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--

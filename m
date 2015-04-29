Return-Path: <cygwin-patches-return-8138-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91174 invoked by alias); 29 Apr 2015 17:44:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 91160 invoked by uid 89); 29 Apr 2015 17:44:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Apr 2015 17:44:35 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A0E28A809BC; Wed, 29 Apr 2015 19:44:32 +0200 (CEST)
Date: Wed, 29 Apr 2015 17:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix more typos in ntsec.xml
Message-ID: <20150429174432.GJ3657@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1430324556-12152-1-git-send-email-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="yrPCcEe+QcWQl/Hn"
Content-Disposition: inline
In-Reply-To: <1430324556-12152-1-git-send-email-yselkowi@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00039.txt.bz2


--yrPCcEe+QcWQl/Hn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2395

On Apr 29 11:22, Yaakov Selkowitz wrote:
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/doc/ntsec.xml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
> index b731cd0..d982867 100644
> --- a/winsup/doc/ntsec.xml
> +++ b/winsup/doc/ntsec.xml
> @@ -863,7 +863,7 @@ the old information.
>  <para>
>  So, what settings can we perform with <filename>/etc/nsswitch.conf</file=
name>?
>  Let's start with an example <filename>/etc/nsswitch.conf</filename> file
> -file set up to all default values:
> +set up to all default values:
>  </para>
>=20=20
>  <screen>
> @@ -1749,7 +1749,7 @@ The <literal>unix</literal> schema utilizes the
>  <literal>posixAccount</literal> attribute extension.  This is one of two
>  schema extensions which are connected to AD accounts, available by defau=
lt
>  starting with Windows Server 2003 R2.  They are usually
> -<literal>not set</literal>, unless used by the Active Directory
> +<emphasis role=3D'bold'>not set</emphasis>, unless used by the Active Di=
rectory
>  <literal>Server for NIS</literal> feature (deprecated since Server 2012 =
R2).
>=20=20
>  Two schemata are interesting for Cygwin, <literal>posixAccount</literal>,
> @@ -2031,7 +2031,7 @@ by child processes.
>=20=20
>  <para>
>  A fully set up Samba file server with domain integration is running winb=
indd to
> -map Window SIDs to artificially created UNIX uids and gids, and this map=
ping is
> +map Windows SIDs to artificially created UNIX uids and gids, and this ma=
pping is
>  transparent within the domain, so Cygwin doesn't have to do anything spe=
cial.
>  </para>
>=20=20
> @@ -2134,7 +2134,7 @@ met.  Later ACEs are not taken into account.</para>=
</listitem>
>=20=20
>  <listitem><para>All access denied ACEs <emphasis
>  role=3D'bold'>should</emphasis> precede any access allowed ACE.  ACLs
> -following this rule are called "canonical"</para></listitem>
> +following this rule are called "canonical".</para></listitem>
>  </itemizedlist>
>=20=20
>  <para>Note that the last rule is a preference or a definition of
> --=20
> 2.1.4

Looks fine.  Please apply (to the cygwin-2.0 branch as well, if you
don't mind).


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--yrPCcEe+QcWQl/Hn
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVQRiAAAoJEPU2Bp2uRE+gXvUP/i1zmzpkI+JMz+rgjshDseTt
HvxagxbATvInbgD5FXaaRipASMwWycyKxUcUPJxLS+OgampYG4hGR9kJcthWutMO
vJlbiZ3dQq7JtOV/wT18+PZLYd4a7MXkOQ+7jhXoYVPHRp6VSeslaKx0HxzfrE7A
1avjgExyvG8Q0LgGS1J0Ju+ZgEM3MOM6iKoOrFkWxBHRoMZdH+vlOr9uO9AJsFSY
tDtcsg74a7OdfN9lyOOba6sGwzP9UOV69jrDiEAZSMV+Cv5ek9G5qyrIyJmhfIkq
Zw0IAJFV+42yyHb8t8mIVkm8sBditYqia4723PNcLAe0KYvikqjIpnH2YWCaQyOD
NZLYFewTa9jfMKtxitVEjW0i4mb077IPvCCUx6dk+PvQzZ/HDNSBGEy8ALBlLzp0
VTKhPiqjj31CAmdvH9zbpi+eJordW80/HaM6WeFzoYqB4fGOvtHKiRaDln4BOql9
31rPEAM3+WFfUSSZj9oOAb3XCUBfGRKrWjN2DPGBV1p4axo/6viSlGwQKdzA2rT3
D4/sihF1Ss63d1NvJ3k+2HDQA954VZc9oqJsxHMbYy2XpqNcdKEPOzjHFkwtnAmy
QhrhapqacahfCdfZFQ1u0ntSRMSjdAZRgCSkkcXxgH0pL2gZ94Y7aq/EYbCCd2kN
OcCYoQ5ltlRcFYrReubS
=xHRZ
-----END PGP SIGNATURE-----

--yrPCcEe+QcWQl/Hn--

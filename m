Return-Path: <cygwin-patches-return-8773-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 43844 invoked by alias); 9 Jun 2017 09:11:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 43799 invoked by uid 89); 9 Jun 2017 09:11:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:2347
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 09 Jun 2017 09:11:55 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 51AD9721E281A	for <cygwin-patches@cygwin.com>; Fri,  9 Jun 2017 11:11:52 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id A66055E0418	for <cygwin-patches@cygwin.com>; Fri,  9 Jun 2017 11:11:51 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 86D1AA806CF; Fri,  9 Jun 2017 11:11:51 +0200 (CEST)
Date: Fri, 09 Jun 2017 09:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add COMODO Internet Security and ConEmu to BLODA
Message-ID: <20170609091151.GA22516@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <d8218978-47ae-411f-9134-fce3dfae21e1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <d8218978-47ae-411f-9134-fce3dfae21e1@gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00044.txt.bz2


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2386

On Jun  8 14:48, David Macek wrote:
> ConEmu: There has been at least one report of it causing crashes <https:/=
/github.com/Maximus5/ConEmu/issues/1158>
>=20
> COMODO Internet Security: Causing GPG failures <https://github.com/msys2/=
msys2/issues/38>
>=20
> ---
>  winsup/doc/faq-using.xml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/doc/faq-using.xml b/winsup/doc/faq-using.xml
> index c62e03996..b6b152e4e 100644
> --- a/winsup/doc/faq-using.xml
> +++ b/winsup/doc/faq-using.xml
> @@ -1273,6 +1273,8 @@ behaviour which affect the operation of other progr=
ams, such as Cygwin.
>  <listitem><para>Bufferzone from Trustware</para></listitem>
>  <listitem><para>ByteMobile laptop optimization client</para></listitem>
>  <listitem><para>COMODO Firewall Pro</para></listitem>
> +<listitem><para>COMODO Internet Security</para></listitem>
> +<listitem><para>ConEmu (try disabling "Inject ConEmuHk" or see <ulink ur=
l=3D"https://conemu.github.io/en/ConEmuHk.html#Third_party_problems">ConEmu=
Hk documentation</ulink>)</para></listitem>
>  <listitem><para>Citrix Metaframe Presentation Server/XenApp (see <ulink =
url=3D"http://support.citrix.com/article/CTX107825">Citrix Support page</ul=
ink>)</para></listitem>
>  <listitem><para>Credant Guardian Shield</para></listitem>
>  <listitem><para>Earthlink Total-Access</para></listitem>
> @@ -1298,7 +1300,7 @@ behaviour which affect the operation of other progr=
ams, such as Cygwin.
>  <listitem><para>Webroot Spy Sweeper with Antivirus</para></listitem>
>  <listitem><para>Windows Defender </para></listitem>
>  <listitem><para>Windows LiveOneCare</para></listitem>
> -<listitem><para>IBM Security Trusteer Rapport (see <ulink url=3D"http://=
www-03.ibm.com/software/products/en/trusteer-rapport">its home page</ulink>=
</para></listitem>
> +<listitem><para>IBM Security Trusteer Rapport (see <ulink url=3D"http://=
www-03.ibm.com/software/products/en/trusteer-rapport">its home page</ulink>=
)</para></listitem>
>  </itemizedlist></para>
>  <para>Sometimes these problems can be worked around, by temporarily or p=
artially
>  disabling the offending software.  For instance, it may be possible to d=
isable
> --=20

Pushed.


Thanks,
Corinna



--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOmZXAAoJEPU2Bp2uRE+gQcsP/Au0Lp9EiWNkOfDTQ2Fok1cS
o3GbCJON8BIXaChvZUJihdZfLDxVh2I/dt+GDeJ3A7swsy8/lXr0/egn+td1ZngV
zeJzhtOwHd9iJAEzolC6CzNDZwJjQYQsm/9MlSbTmhUi4rp2YXeY0iJk+nZkrGBj
yBDcifga5T8xd8s13DItS9RdngSUG2r+SHj0BSJEJsyjQOGNuuMDejTAOAEfjKLx
jgAABz3+ersY/8rXOic9FkpvuCizO9OaaKL0NMzpjmUjPqQzHDeUCNdZ31T8RwCp
7THo9sp3/FuIbXWnOwpdax4dA4Rwtb7ncH/WJLumKHkUeI6zebBfJR637EnlGQ2u
tUQOfwOpZM85Lzh1X/sqvJTz0quz+k0RqrMJ3XnW7s5X6Vm1N+K6DbRlYeO9VLf4
2QpbwQd8PDbZ7QPKC3J6zhItEe4mv7+NOomo6J7xvqt1Ltr/OXF74DQODyRZVsLF
nH81XaTvSQTxgRQeX0qnUOhSASCxwFsAE+KOJi9Cry1tri7DWinEOZ6xKMvlEHxX
h3iGTwQSziU8jaqNLD/bTLxBUaciBJlkxJH96kPzB0Oc69N41yzjR9e7MPgtltlI
JuRjCif5f+YLH3+uywT+LQMzmpjU4rn/8V0zj3XwkGXT9YYhKWNTCIPtFYtUaww3
tQMmKIX4n6KGU5xfEqJg
=k79s
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

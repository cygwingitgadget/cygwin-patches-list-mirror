Return-Path: <cygwin-patches-return-8301-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12119 invoked by alias); 12 Feb 2016 09:34:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12108 invoked by uid 89); 12 Feb 2016 09:34:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=H*F:U*corinna-cygwin, Hx-languages-length:927, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 12 Feb 2016 09:34:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EBD2BA80562; Fri, 12 Feb 2016 10:33:59 +0100 (CET)
Date: Fri, 12 Feb 2016 09:34:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: update child info magic
Message-ID: <20160212093359.GC19968@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1455244717-12688-1-git-send-email-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <1455244717-12688-1-git-send-email-yselkowi@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00007.txt.bz2


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 940

On Feb 11 20:38, Yaakov Selkowitz wrote:
> 	winsup/cygwin/
> 	* child_info.h (CURR_CHILD_INFO_MAGIC): Update.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/child_info.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/child_info.h b/winsup/cygwin/child_info.h
> index ddd5b8b..c11040c 100644
> --- a/winsup/cygwin/child_info.h
> +++ b/winsup/cygwin/child_info.h
> @@ -39,7 +39,7 @@ enum child_status
>  #define EXEC_MAGIC_SIZE sizeof(child_info)
>=20=20
>  /* Change this value if you get a message indicating that it is out-of-s=
ync. */
> -#define CURR_CHILD_INFO_MAGIC 0x30ea98f6U
> +#define CURR_CHILD_INFO_MAGIC 0xf67f938cU

This needs an explanation.  CHILD_INFO_MAGIC is still 0x30ea98f6U
for me.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWvacHAAoJEPU2Bp2uRE+guzgP/jNxJClNtowsoVWSYFbzV+o+
Wcsfx9Gt76ifdr9LN6bz/xoTLMg9ZjyuIrnrljPamVpXoqD9FnGjJAfpI5JCBNM+
pV8R7+qbGsq7Sm7BmelPl9L/BqFL3fcYSd1j+k9lX26VtTDPWckEGuAIIgYaiG37
xbsfthy+L89946IJyh8AgTN6ycZX4UOKODl7bIoisAJGMYra/zWbygKeDcrlIaJE
pS7anTd0N6gSieu8NjcN/kXAUpT2D2bCNYkVaa04a1RRHJiRUaMR6J7cSAqhCKEE
Hzu2ngBDux0DXX2o+S/Zej9fk6zwSeOLxaGKGrq/x77oKNcjGYr9zgEAFtTObYvR
i9X7UAi5Mm56lV0zCzFFWBBevzIlbrxlNkRpyk+GNal/HPZJLFWAXfRfHyyB3Pu5
wCG/DV/BVV9BPZOYptsItmOwEbYhSyHFRuxrFICr1mAlaL+liExyqgkViXlWYVC1
6vGona4rUcrdCH7FlujJreR/8Z7F3D4cmWiJhpG9msserxFNjIRdnfluEiaCweQy
DlY1A+Zz8eMgnKBWP+JntYvi1unPP+iaRGE3v89CDEsHf2f9D3JaY3didQeBklx9
LDyJLHn8hOe5hCEdjau3Z3BUx/lQkY0mnNyNR0iPLjYnMISh95nSwDgOZx/TVUeN
Wf7oIcLl7KzuMpBeJ7Wt
=r/xQ
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--

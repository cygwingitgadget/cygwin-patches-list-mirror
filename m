Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 623B0385B835
 for <cygwin-patches@cygwin.com>; Fri, 17 Apr 2020 15:34:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 623B0385B835
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N64JK-1j9u9I0Duq-016PWw for <cygwin-patches@cygwin.com>; Fri, 17 Apr 2020
 17:34:08 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7DAD6A826FB; Fri, 17 Apr 2020 17:34:07 +0200 (CEST)
Date: Fri, 17 Apr 2020 17:34:07 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] cygheap_pwdgrp: Don't keep old schemes when parsing
 nsswitch.conf
Message-ID: <20200417153407.GM3943@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200417113107.00005311@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9jHkwA2TBA/ec6v+"
Content-Disposition: inline
In-Reply-To: <20200417113107.00005311@gmail.com>
X-Provags-ID: V03:K1:MaRICpbYyb834UnquQuXJgZQH2X8G24AVg4J04crZ+XRA8eSJ93
 JvpKMkWVdUPdQRnzXy0tepwLx60xzi7nwYx9MVgPBzpK/YE2e2AOlA4v82f8M0e84QjKs17
 /2antcTzhGk27u9xn3/nwdhmACkziT2o0ZuVgyiCx3LWsMIP6B5ZOTFr2TBLXRjLW+FmDz5
 sWSkRFBvIyg6NkmXTODNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xGpA1QttYyU=:PQ7BveyDcyyKpwj5KNUXYo
 fj+y534VnVnI7QECb+7zHE4l6gXN6JTQpMG0itMizKtl5WKDksx0xfoPLBARIXi9suBq0VomX
 P0s3wXbSbmvG7Dg55bXG62gNAUaE/YktMgfePfRuOQSgV0s5LW44sqEi44t1iqzq5UDMTkLov
 zwsBVtV9iMqTsOlef8ocnL+rzxPQZyHNxrlEcSQyRZJt1oRrl932Ux0uHQxYAogkZMoey6nn9
 xbsNBfJVAEmgcgcU59CE+HzBBK+42ARGiztSuR4HFPFbGGBQSXsmT0oDm+AxlpXAF6Z0MQ9al
 e0H8Xg0iZ2OA2tO9SVDUMAcEqwNmjIwPRdBxARgRN9DYE1+gnT0cQj4tsouLt+DFBrjX87iHS
 zQpaGEsimwKjdJSXxbklTe3fEHVKNy47jGo94yW7CPCS81XlBsJucInwVhXU09zjiD51LTGM/
 +E6GeQFk7mc2cc5GD0jLvyveLa4F1v6gc46N0xNn8P0tMupRLBirKPvJOXDOMK3HcDyTKaclX
 XJYEJ8jGFEjvJlCy35MXDnYFlQ+Y0YAq0j0uEOLdLqZDas/nWtgonpm7B1SPXWbIQXNRbxQaT
 RwvHxTiLzJpAmAgSho5YAK6/8/jIT0qIAMVa7SVrtOm00FbqN59Qr2ZCQngsOweLMWEtuOQgb
 d9AVnI5ZYXSRJgPm9gL4xAMO1vwlSRLLSWEb9S0pAj8N6ENWP9ohqd7YmstzvIWr0SEKaEQ5h
 ckWzIZxHNeQjMerknPnPjT/+3zOk42kHFdoFRuVZUBTSGgCH1CUZRLava/2UqKKK/xcCdhakz
 RgEEHBpfyZc79GQHnH4KK1Li6AoepOU8MSCASqzlZqt8Hob4Ko3OM0IN+oxOMQA8jah5mOe
X-Spam-Status: No, score=-108.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3, GOOD_FROM_CORINNA_CYGWIN,
 JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 17 Apr 2020 15:34:11 -0000


--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 17 11:31, David Macek via Cygwin-patches wrote:
> The implicit assumption seemed to be that any subsequent occurence of
> the same setting in nsswitch.conf is supposed to rewrite the previous
> ones completely.  This was not the case if the third or any further
> schema was previously defined and the last line defined less than that
> (but at least 2), for example:
>=20
> ```
> db_home: windows cygwin /myhome/%U
> db_home: cygwin desc
> ```
>=20
> Let's document this behavior as well.
> ---
>  winsup/cygwin/uinfo.cc | 5 +++--
>  winsup/doc/ntsec.xml   | 5 +++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> index 227faa4248..a4fcc33d8d 100644
> --- a/winsup/cygwin/uinfo.cc
> +++ b/winsup/cygwin/uinfo.cc
> @@ -793,9 +793,10 @@ cygheap_pwdgrp::nss_init_line (const char *line)
>  	    scheme =3D gecos_scheme;
>  	  if (scheme)
>  	    {
> -	      uint16_t idx =3D 0;
> +	      for (uint16_t idx =3D 0; idx < NSS_SCHEME_MAX; ++idx)
> +		scheme[idx].method =3D NSS_SCHEME_FALLBACK;
> =20
> -	      scheme[0].method =3D scheme[1].method =3D NSS_SCHEME_FALLBACK;
> +	      uint16_t idx =3D 0;

Hmmm.  This `idx' usage is a bit puzzeling.  Here's a counter-proposal:

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 57d90189d390..9521a973803e 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -793,12 +793,12 @@ cygheap_pwdgrp::nss_init_line (const char *line)
 	    scheme =3D gecos_scheme;
 	  if (scheme)
 	    {
-	      uint16_t idx =3D 0;
+	      for (uint16_t idx =3D 0; idx < NSS_SCHEME_MAX; ++idx)
+		scheme[idx].method =3D NSS_SCHEME_FALLBACK;
=20
-	      scheme[0].method =3D scheme[1].method =3D NSS_SCHEME_FALLBACK;
 	      c =3D strchr (c, ':') + 1;
 	      c +=3D strspn (c, " \t");
-	      while (*c && idx < NSS_SCHEME_MAX)
+	      for (uint16_t idx =3D 0; *c && idx < NSS_SCHEME_MAX; ++idx)
 		{
 		  if (NSS_CMP ("windows"))
 		    scheme[idx].method =3D NSS_SCHEME_WINDOWS;
@@ -829,7 +829,6 @@ cygheap_pwdgrp::nss_init_line (const char *line)
 		    }
 		  c +=3D strcspn (c, " \t");
 		  c +=3D strspn (c, " \t");
-		  ++idx;
 		}
 	      /* If nothing has been set, revert to default. */
 	      if (scheme[0].method =3D=3D NSS_SCHEME_FALLBACK)

If that's ok with you I check it in as your patch.

Can you please send the 2-clause BSD waiver per
https://cygwin.com/contrib.html to this list, too?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl6ZzG8ACgkQ9TYGna5E
T6C2mA/9GKTjmJ6NBRF1nvgZh9hSYXyFIQF6weklYdwAa6sxpcgVJwFmsfxuBdZp
zDMewJO+gDionrj4W8XS8T+1MKgBQBSshem8pwZNCVC/AuYoRVGRinGUoU8aLQ/B
Cn3EpnQvD/l8gfNj+6dO/BfVAF5IpKzQdvtD8hKRSB3L/pF3oWdSIDmgYimA3LHw
Xm5e5uogEoYlIUw+MpsfG2DJwcjd7gXPCt9MVaYxQCkRuX66ctFNeQiwU+ivGUch
NJQGuQzfXnYbECOXEIthYYm+484anvjpn6Bwsw+521TcQ6Phjlm3DnDCeEJOnrZA
ELCZPxKDkHFmLfZaZ132WW1OOBGotvrdY5zm+T8tJ2gMQ6aRPP0EK03tsn/l1I2r
j93hQI1kKGS6N1TelGPMq3qQJfoS34M6UOzmw6ibE5Gzlf5JD6LvSJDroxD33s0r
zNYR/lmff8L0hOFTlJKnYU1eyuoFzoocuZcSZlnD/mZJbp9/x3HN5MtaZ4Zm2hN1
bKKNPDmKVeWrN/8/bEq5nR+E6P3Xt9lyylNTr+2Db4SRKP17N8TdX5ud97eRlyhd
OP61ISE/1M8EYwdvaUkdPugzUYv8s1uPW8EZ95VR2k1bVgMw5Q0tQh10/oSSAim7
9R5h77zdKipRGmu7osgnPK7mqo1HqN6X0jLM67QGSI4ObZ6PeyE=
=8txJ
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--

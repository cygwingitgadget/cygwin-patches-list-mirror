Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id DF331385C426
 for <cygwin-patches@cygwin.com>; Fri, 17 Apr 2020 08:08:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DF331385C426
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1McZfZ-1iovlC05xl-00cxDF for <cygwin-patches@cygwin.com>; Fri, 17 Apr 2020
 10:08:15 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 35CDBA826FA; Fri, 17 Apr 2020 10:08:13 +0200 (CEST)
Date: Fri, 17 Apr 2020 10:08:13 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygheap_pwdgrp: Handle invalid db_* entries correctly
Message-ID: <20200417080813.GJ3943@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200416225237.00004a1a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Content-Disposition: inline
In-Reply-To: <20200416225237.00004a1a@gmail.com>
X-Provags-ID: V03:K1:V88JR+Uvv20xCDtlYfOVyXYf0fp5TMMTTcqfVMWwpvFWoFGpHYD
 vqbwebTcno0JGUqeF3tSwHH8ShVKtrx6an4vb/HIPBaMkXCu+lqgQrJ9wBi1i3BcZEzYFpd
 QniPdgo/Dt7AtcfK3PuyL89Cj/rvfu3OVn1vM/rFQyOBgUdexMkAUBPCD8S/6b/JT7MUEbN
 KZT0p2NqcO9ira+VMumrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2/021P+JBIY=:Tzw7q03uR5zXEqEJHUfUBh
 hOsU1+DHhvRwJnozXqYU4yVleFBOD2SfBpbzQarUcM8XsskBsGYbQYmYP5mY722ryWxFNSG80
 Nj65ww92R+3EnGvXzSgpRU7GhpahBf2j7QmxOxMY9BM8HxlEDsEIy4X0v98h29JrvD4gqDw+U
 kgWti1+kAvFRy/B+G6dJ5iJAfopQTGBmTXwdWGnVv4lG9jyLFMTnSkUBtm31iKM4gretsMM8E
 np7dAbJJcMtqWMdcQdiWpvKoGxrECtVAKAaX9x7xqLy9+VDQBE/QNMhVc1DxCPhHm7Qfm6DN2
 wMrvlYetK8PiQImi94BGrjhaSYTMgAGB6TPWZffbpP1cnP6LW+5fKjIco8RlQFE3nGKHCRTdP
 lzy4YbTUnvNBYBZXli6+vgOWgdZzqqOcrBvdUvvD8C4SXNItiutzohxG9cCopqAaElnijH5jc
 ZuME63atVC/QAt4zNFaeEJ9sG7bJ+nfo3i7klk3f4DpbZM50rckx7PajtwQk+c9avSGOeSU77
 1pMMj7reXZf0KAD1ts9/NtM7esSm1rgwIHHjgjED77aexFSjUhoEkdlbpC/CSycRR3Q/3V6Ib
 KILuM4v9NprcHyYlooAOaa6dPo72AYdAv9qJnv53r8/nE7ai4H2e5I1Iu54yUNsAZ6GE40DAH
 Fwa49DdRFxqoP41oCVW4f1cxRh7tiQsrf6aBv/vlHzlMO8blaoEK/yLvfqrsUoL+bEzp00iAo
 q1aslJS4IwzY+JHjm8vz9xnayTkhuqixUHfGVOGtoMA4NYfP/pUHqDv1OG7b5GBHmDKq6JGpx
 mriT595Ik9h/i4vBX4ulkMsBja7PSaF7d40G/irNLoZDveA/UMdBprxFHAacX8u58rSYHte
X-Spam-Status: No, score=-108.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 17 Apr 2020 08:08:18 -0000


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 16 23:09, David Macek via Cygwin-patches wrote:
> If the first scheme in db_* was invalid, the code would think there
> were no schemes specified and replace the second scheme with
> NSS_SCHEME_DESC.
>=20
> Signed-off-by: David Macek <david.macek.0@gmail.com>
> ---
>  winsup/cygwin/uinfo.cc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> index bfcce00da0..be3c4855cc 100644
> --- a/winsup/cygwin/uinfo.cc
> +++ b/winsup/cygwin/uinfo.cc
> @@ -823,7 +823,10 @@ cygheap_pwdgrp::nss_init_line (const char *line)
>  					  c, e - c);
>  		    }
>  		  else
> -		    debug_printf ("Invalid nsswitch.conf content: %s", line);
> +		    {
> +		      debug_printf ("Invalid nsswitch.conf content: %s", line);
> +		      --idx;
> +		    }
>  		  c +=3D strcspn (c, " \t");
>  		  c +=3D strspn (c, " \t");
>  		  ++idx;
> --=20
> 2.26.1.windows.1

Pushed.

Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl6ZY+0ACgkQ9TYGna5E
T6APng/+K3UPaq+a/ys6Mm0a/kQhQEhCqUzq6qMRv8dnQ84iMc+cughJwAMcHq8s
uBLSn4JO1lKi5eQCsY66f8dbpgaqNOmjLDnWatzHz0XqGXLAbdMoiEOQE2TDROuE
bk+Wtv2ERsM2nHzqEavnddkuEY6psCrKtxyNyAQTeQpvzuBHgsPjXtGeadhorNCx
tmGHNG4uWAwmBUULAGGcBQWXwNIf5furmcfSiPUakanFVP3GnKamGhPOAsU/g6Hq
4HnCXdnqOK2yxtEUWhD3xjYlZ2/4pW3fWUy2XVYLUJIpKNYZZX5DQkB9AB0FECAf
+qwYoPeLzC5KgpCk3JBHcq62y/IsljZsSmOqWyKW/bws6Zw2DgqhI4v8oQkrrBZ0
Vq+ObkyOCu82ZJ7i4ukh8EvCUh1aRgI928acslygbC7EhQm+Pb0XO1jHIRPx0y+S
D7iqJl6qRv46bkYpT/zxj82kXaQyInPCH+P87JliN6W2aEuJnRmhXMVGlQbT+pBB
ZghDDWE36TCr1eCJ7ZaSqNlf4QL6ZPSjIsVuLn3iDs5tFzIaR/YOdb87LYAxZ7WM
IGHswYOaJE7wkqV41Mktqaage9Qvf73x2Unixsby/uJinyKhdBORaZdjiLwIKji+
D7BsvcqCQbxx7tI2+lF1wOGSMy0QG/Ojrw+jUp83WofU7RUJBHw=
=sGFh
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--

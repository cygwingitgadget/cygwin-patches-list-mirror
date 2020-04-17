Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 59CBF385B835
 for <cygwin-patches@cygwin.com>; Fri, 17 Apr 2020 15:19:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 59CBF385B835
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MDy54-1jZOwv0ipQ-009zjl for <cygwin-patches@cygwin.com>; Fri, 17 Apr 2020
 17:19:53 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 6BF0BA826F8; Fri, 17 Apr 2020 17:19:52 +0200 (CEST)
Date: Fri, 17 Apr 2020 17:19:52 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] cygheap_pwdgrp: Don't invent undocumented defaults
 in nsswitch.conf
Message-ID: <20200417151952.GL3943@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200417113051.000020ef@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Content-Disposition: inline
In-Reply-To: <20200417113051.000020ef@gmail.com>
X-Provags-ID: V03:K1:s9PPasoIQSuQKxoFtQ8u76h2vzzYkdnJaTQZ+HlDYCPizrxe4gv
 rbZRmZgL5/1RLgu4oFsRZndiDeh1/SHHhR0orEpx8U+coyIMUCqQ0St+w0CKFuVU9grDuJk
 BhW0cjFMD0XFiuipFElWHeR3L77W6RH3yS/ypAWReumMIqWKp6PIFlTlDFkCFRZ5IkDyZBn
 cjQ9bmYrhM8J0AhEL9vig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Z6TOIdPJfs=:E0cwsrr2yD5Q+lymfYFtd7
 zK/MoEG0xuQid+XgQzKF2FtWLokGldKyHTI6LVTPP1+o8wggeouHu91ySNXPoFLiVnl5+O6Dy
 5voQdtbmf6OkYGhqmbvIKeNHAJNSwCOtbIHYgl52yJW0Sd9XmGaA8Tgbn1YCCS9cJcTlffbKN
 sAfVhU5ySS+BURsSnE7xLtHxx2DDg7Utc9knuyqE11ZJpBM84DfN18OFTYTBpsRTqTJKovoPU
 4abcY0A0dPKwKo27vyoUaDxIKgHXk7dsGdVNOd4kGKUCu6CcCZjMTskBMQtDstjRAW4HT7113
 hmrAmhSMNcRuQOdImdKW1MmLc/Qwwz42D32ozSDCzLLhWOOLe7O+LK1Fe/MYugpKmYO4ZGfQV
 97nY4bagu4INhJdMaFq5NnGhL6nLwFCp0DHqzRgmpKelD+uQ66NSssMjD0gdQ3qbk29op6EPf
 0ed5ozrVBiBAoCdAoe+sAlDxNIdY0b30nXPCn6x1Z7FP8r34fh4bhAIBpxFYOpDJC3hc92hUw
 t//JfU1rc7yGke1eEXbRiRZybiYiQLJToe9cfZ5Ik6S2hYZ+lYZ0M+V49QyEnzovhDDxQ3YOO
 hcEBytcu19VZO5HqzRQiEvwKYiquKrjaMLe1k9F6P9aa9ktUQWVZZORzjf56J7c5MZdhwDmbj
 au7RTP1KGa6fLv+jiz3HhR9goo3EaTGlLOZuoO2e/sGV5jkGFtQ2WvvrFPAKuJjlcw6UWWuT9
 d+VN5BW7oTIdajmsSghj3Y7n88DNq5k7IDo3dRrdqcoB9FWpu15cEaqaHy6RHCnzSMOyifTv5
 npFzC8mWVqVrFCFYbksYH/wTz4C2M8sJLr8NbHx6wYvOJxODcClktud0whJJH7JAVyLCg7q
X-Spam-Status: No, score=-108.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3, GOOD_FROM_CORINNA_CYGWIN,
 KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
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
X-List-Received-Date: Fri, 17 Apr 2020 15:19:56 -0000


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 17 11:30, David Macek via Cygwin-patches wrote:
> ---
>  winsup/cygwin/uinfo.cc | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> index 57d90189d3..227faa4248 100644
> --- a/winsup/cygwin/uinfo.cc
> +++ b/winsup/cygwin/uinfo.cc
> @@ -831,12 +831,6 @@ cygheap_pwdgrp::nss_init_line (const char *line)
>  		  c +=3D strspn (c, " \t");
>  		  ++idx;
>  		}
> -	      /* If nothing has been set, revert to default. */
> -	      if (scheme[0].method =3D=3D NSS_SCHEME_FALLBACK)
> -		{
> -		  scheme[0].method =3D NSS_SCHEME_CYGWIN;
> -		  scheme[1].method =3D NSS_SCHEME_DESC;
> -		}
>  	    }
>  	}
>        break;
> --=20
> 2.26.1.windows.1

The defaults are not undocumented, see at least the source, uinfo.cc
line 629ff.  If I screwed that up somehow, the right patch is to make
sure the defaults are set right in cygheap_pwdgrp::init, rather than
removing the defaults altogether.  If it's really important, we can also
add the exact default settings to the docs.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl6ZyRgACgkQ9TYGna5E
T6CuEhAAplb0plnafoE1m+GkOev690rNWGb/iF99nwEYou2SmOz1wbAUjm3rtiQ3
/RvyLQClpPO1P5RSgbKlMqBzXqN17Ua3pPhd2fxe+EpxP94VWfp62QVMjl9qOTXK
5NZEVAO9ftY2SjpGmn+W22OLExam1Oy13c1UTY3StIgwX3A2ssTEFpsbaqZzhKJi
pdSp2R/jzLDiAxSvoh1cwxoFJORYqSh4tsA7t77Xj4hMCJCZXc+33nYWT0Yn06Vk
El9coE9C9UFrwxo/OEOpH7Seyr15fuVZWWsKFTUwlBDMramjMUWfoPhirjv9Gth6
xv9i/oiSDRsuMzmYkqAZowH2j4fQSrikDACquwqUKS0YkUsaUsdUkANUnpCxf/pf
EcNCX7/iXZZFVcrNb6zfN98x4S/gVnpaVThOb2dAWyKHvtEGxBo5OOpyZiEGC73C
yAPdIaqwUnI3F+YvSdzKR4NCtFVMfLwTAGYcWs2RlZVwjuABqjsZcyAjYtY2GQOA
WPs/crXJUMe/yg8HtosmeQ/+BEFv4+g8K/DKG04W7k270asjysl8tEw5uoDqprbt
A5AbhIIssFRXtyZQgzFO6BaFfG84VeViAcQjoNyDNAGzwWMH3cqAde5lQn3L6U0y
SYvNDWLG7XnUsMmDAHQlPdueKQTGirLqONg/K5gbVpB5tgqPzZo=
=bVzT
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--

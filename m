Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 7175A385E830
 for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2020 15:02:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7175A385E830
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N0FE1-1jSNCv2CqV-00xJNc; Thu, 19 Mar 2020 16:02:50 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E421DA80734; Thu, 19 Mar 2020 16:02:49 +0100 (CET)
Date: Thu, 19 Mar 2020 16:02:49 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Use a separate Start Menu folder for WoW64
 installs
Message-ID: <20200319150249.GC778468@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
 cygwin-patches@cygwin.com
References: <20200319135837.2104-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <20200319135837.2104-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:Ydwij+TacPEcYUiHPuQQmhsSNutlQRbWmyndsrGCauX4M3oQdBN
 r7mpOtFJdvLm8Vca0pSe9s2kqIfg8bKQ8+nxYtJoz4UPcytvUI01CyI2PVTVYZaQRu9T4BZ
 PKHT6Q8kVcW3OVMi8a8YJbZCtpz1kQOC1MPhnnLlYLJUx3AaIZQrTHWfZX4mudTwI7oSrj9
 t/u4tbcxuK1gQFdkJ+yCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tmkoYOnNhRc=:qM37UJbkhgUmwsrQsrrOya
 OZmgo+8zzPzbE7F6YyLZF+70ORuN9u52PcsGyhWZaQ+uZcl3Qp+9zCYeBW3/PJDMtFEFnWIyo
 hWfawAKGkm9uXrJ8+KBzAjqZhZNVQYWkbunt3ozEGWLTTf0MugqjwvxRMqiL2TJQ/IWvXv+sk
 oYiThKsRwG4oByDZQa7+hlJlZIjvlu6M4pWjwSCQLLNgXtU9RgD8QM/IvpYv5aL/Uxx/baZbw
 oFOwlO9T6s5I0O+c5uSUqnptb52TjzZFGdzrAr/hICMGiFPNIwcixCzx/sYzTMePFpYGyfdA1
 uN+ZhAdBv+bfhfBp6kX0mamVIDQKhGc5nT8eBA808HvatYLWPUN95M8v3VPao6b8gf2lJwTMc
 wLVAdyRoRMXhKjwaRUx8ajaUVD9rRTYJTCf/kNQnurlHN5x0cE44REKV3g/JVDpW9fou+0XZd
 OEmDk6rdUXDKbwzPnTRyO5oSQ1nQvce4RRSw8Nb7djCjd1a6svjMwbbPQMJ8xlHazwwAZ+pUF
 90p8fS1TAMivxEZc0nhzg4OsTLftpDnZXUlg6+LtoZhOHdTZGl6BInrp4TApVU235JzWFsZFJ
 n3/deTlHXgHrmnPc8k2mH94JxpOdS+QiNBXl4RMEh6vtHyI0dnBhs2kEP2zKEkkugAZ66zOLv
 Bqoc7BcstCKdXDIhgsdP5iejFrCs/CdSgVU3enZUp3jnzwS1CXA/E6IsuYbnSIGu1rKLpBzCh
 MPTUVUCXlEdc+3gRzuH9V0L8a8f1CpYJy9gw+7qM1CVnsthrahEZERAw0TmCKZn7wrvNFY0LU
 b1EnKPE3zAUsbaRyV/roDcokgftlraG7QmMGdyJX5Ecs7v6Q7+JpWdR5QFd6wULId3vznIo
X-Spam-Status: No, score=-123.7 required=5.0 tests=GIT_PATCH_0, GIT_PATCH_1,
 GIT_PATCH_2, GIT_PATCH_3, GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL,
 KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_NEUTRAL autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin-patches mailing list <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <http://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 19 Mar 2020 15:02:55 -0000


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 19 13:58, Jon Turney wrote:
> This aligns the shortcuts to documentation with the setup changes in
> https://sourceware.org/pipermail/cygwin-apps/2020-March/039873.html
> ---
>  winsup/doc/etc.postinstall.cygwin-doc.sh | 3 ++-
>  winsup/doc/etc.preremove.cygwin-doc.sh   | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/doc/etc.postinstall.cygwin-doc.sh b/winsup/doc/etc.po=
stinstall.cygwin-doc.sh
> index de7d9e0c3..65ce2ad77 100755
> --- a/winsup/doc/etc.postinstall.cygwin-doc.sh
> +++ b/winsup/doc/etc.postinstall.cygwin-doc.sh
> @@ -37,7 +37,8 @@ do
>  done
> =20
>  # Cygwin Start Menu directory
> -smpc_dir=3D"$($cygp $CYGWINFORALL -P -U --)/Cygwin"
> +case $(uname -s) in *-WOW*) wow64=3D" (32-bit)" ;; esac
> +smpc_dir=3D"$($cygp $CYGWINFORALL -P -U --)/Cygwin${wow64}"
> =20
>  # check Cygwin Start Menu directory exists
>  [ -d "$smpc_dir/" ] || exit 0
> diff --git a/winsup/doc/etc.preremove.cygwin-doc.sh b/winsup/doc/etc.prer=
emove.cygwin-doc.sh
> index 5e47eb579..f07b70c5d 100755
> --- a/winsup/doc/etc.preremove.cygwin-doc.sh
> +++ b/winsup/doc/etc.preremove.cygwin-doc.sh
> @@ -26,7 +26,8 @@ do
>  done
> =20
>  # Cygwin Start Menu directory
> -smpc_dir=3D"$($cygp $CYGWINFORALL -P -U --)/Cygwin"
> +case $(uname -s) in *-WOW*) wow64=3D" (32-bit)" ;; esac
> +smpc_dir=3D"$($cygp $CYGWINFORALL -P -U --)/Cygwin${wow64}"
> =20
>  # check Cygwin Start Menu directory still exists
>  [ -d "$smpc_dir/" ] || exit 0
> --=20
> 2.21.0

Good idea, please push.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5ziZkACgkQ9TYGna5E
T6ByJA//UDowvuV+cPFdYv29IqimqFzP5YFpBYxrm5RP2qP1XdYkJ2QAlrDiWavc
al8gfKMzCNmhdL+lNNtypGixLTe/3rbS6hdx/4T/4gNGF7gOecBBnar0mOeaX2kt
hN4BVeSXt6PGNw3KNxijYfKDVSFgnaaAipAv/WKEB3AL+6LGm6s/n5K795eMmg60
W7Gft41f9HxsMQ1EyRjmpOAJdIcDfqKnhpsTwPG1TcEUU6wN46PsTUq9AA1lcALm
zLk2Jl/f7zfdmPuvLG5nP/tSq2RBNklgfgqOfZuZmBxq3B1tZW/29KW0PRzJwO/F
aTM0fQZLBpuMFj6nnlFOmW7c6gO7Fgj1v/zOTKmXl2g1PBhkaverUFhr0w+tGaaS
DvvhjcXTH/n1IlfqCm8/buoFJtOZYSfxUPUTv4y1RC3+xXuWl9HC4qf8BALkGaAL
LZ6CePq0vfnUy858J9FFoNjFD/W+HmuHIkycaZGvysSFQqJ+7YoqsJ7tZHz57/a3
A/Li1NJZylCjdqcsVQiBNV4Rv4OKov6RijG0s9FaFHkYD1yLGABCyxaM/kiArwzz
II7RJkNAwCnsDcye8sLVqrEzTvxp1fncSxHM9A5lxvqhWYXPEzEM4humL0HfB3zr
zoYthgIa1DAMrs9hHr9HIIUFR8rd4g74W9tWi9OYwO/2MwcIYhE=
=8iFQ
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--

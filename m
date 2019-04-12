Return-Path: <cygwin-patches-return-9326-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54009 invoked by alias); 12 Apr 2019 07:55:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53714 invoked by uid 89); 12 Apr 2019 07:55:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-118.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 12 Apr 2019 07:55:21 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MnFps-1gY7oQ3RDg-00jF1U for <cygwin-patches@cygwin.com>; Fri, 12 Apr 2019 09:55:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 39BDDA806D6; Fri, 12 Apr 2019 09:55:18 +0200 (CEST)
Date: Fri, 12 Apr 2019 07:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Implement sched_[gs]etaffinity()
Message-ID: <20190412075518.GU4248@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190411040601.1222-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="++alDQ2ROsODg1x+"
Content-Disposition: inline
In-Reply-To: <20190411040601.1222-1-mark@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00033.txt.bz2


--++alDQ2ROsODg1x+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1598

On Apr 10 21:06, Mark Geisert wrote:
> ---
>  newlib/libc/include/sched.h |  4 +++
>  winsup/cygwin/sched.cc      | 68 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
>=20
> diff --git a/newlib/libc/include/sched.h b/newlib/libc/include/sched.h
> index 1016235bb..e3a5b97e5 100644
> --- a/newlib/libc/include/sched.h
> +++ b/newlib/libc/include/sched.h
> @@ -92,6 +92,10 @@ int sched_yield( void );
>=20=20
>  #if __GNU_VISIBLE
>  int sched_getcpu(void);
> +
> +typedef uint64_t cpu_set_t; /* ...until cpuset(7) exists */
> +int sched_getaffinity(pid_t, size_t, cpu_set_t *);
> +int sched_setaffinity(pid_t, size_t, const cpu_set_t *);
>  #endif
>=20=20
>  #ifdef __cplusplus
> diff --git a/winsup/cygwin/sched.cc b/winsup/cygwin/sched.cc
> index 10168e641..496e08857 100644
> --- a/winsup/cygwin/sched.cc
> +++ b/winsup/cygwin/sched.cc
> @@ -424,4 +424,72 @@ sched_getcpu ()
>    return pnum.Group * __get_cpus_per_group () + pnum.Number;
>  }
>=20=20
> +int
> +sched_getaffinity (pid_t pid, size_t cpusetsize, cpu_set_t *mask)
> +{
> +  int status =3D 0;
> +  HANDLE process =3D pid ? OpenProcess(PROCESS_QUERY_INFORMATION, FALSE,=
 pid)
> +                       : GetCurrentProcess ();

This needs to grab the pinfo(pid) aund use p->dwProcessId, as you
noted on cygwin-developers already.

Two more notes:

- You could use GetCurrentProcess() in case of pid =3D=3D myself->pid, too.

- PROCESS_QUERY_LIMITED_INFORMATION should be sufficent per MSDN.
  PROCESS_QUERY_INFORMATION was required pre-Vista only.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--++alDQ2ROsODg1x+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlywRGYACgkQ9TYGna5E
T6B0FxAApYGgh2AYVHQyXkOpJpKaxg4QW+Rkdz5ArhTi2v5lIb3YbQ083U1Jfq7g
+0/40E4eRhuvrl642am1Gpknx5sGNTnUE0/RDYKZpE1vPgo1+5Du2gsXhaXvqeVu
CtoXUCukDbzYdm2ObuFc3GBsjec/hMZK7OwWL7wL4LOPJhXok42pk/UK4tKGzpiz
LiTNk01nta9TnpPHizB5b/giDdCDdF45qkQAUiiVlxwLbvEON0tC6iC0sApxUxY5
ueDSQU+CDcLMc9GE2tuM7PD/n8ubj+f8jwu9ceZN9LLbX+J6KIDHL1hWOtyRSq0/
FYzhdaICSyi5rGQjFxc+60BBptTpp93UdyEMvsl0sBzTwdSPWUsX8+1GktFcD8Yc
UWbe9V1OdWZWtduLZFXFt/L96CL9cr/v3f+e8xtry2GuvUI0VC414XdRjOtf/yra
Wh1Bitv4DZPA90v+PCYAE8jqwGD10N/460MP5/dq7WS5qDyQMpQ7wnuIUWJ6BXUl
QIVQzeJ6zQltMdWaHYW4JqtEzdq6+iUxPHztcdkZ7CkNrhT9LfhhKS9OH3K4GL83
WLhocvZyP08QvPLbPVsLZFHV+SQ1fwm/e1SvhWDgEjP+YmoX5kgTcJuc6OC4sDNd
yhgsCuejVEycFwbZ6vxi9q/hfN+dGv/S9RZqWmdr2/MGLjbcylQ=
=MOU9
-----END PGP SIGNATURE-----

--++alDQ2ROsODg1x+--

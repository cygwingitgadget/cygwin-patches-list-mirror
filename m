Return-Path: <cygwin-patches-return-9804-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29520 invoked by alias); 6 Nov 2019 14:06:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29509 invoked by uid 89); 6 Nov 2019 14:06:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 06 Nov 2019 14:06:53 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MPp0l-1iEn0q1POd-00MtI4 for <cygwin-patches@cygwin.com>; Wed, 06 Nov 2019 15:06:51 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id ED26EA80A60; Wed,  6 Nov 2019 15:06:50 +0100 (CET)
Date: Wed, 06 Nov 2019 14:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Change how to determine if running as service or not.
Message-ID: <20191106140650.GV3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191106120843.540-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="pP0ycGQONqsnqIMP"
Content-Disposition: inline
In-Reply-To: <20191106120843.540-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00075.txt.bz2


--pP0ycGQONqsnqIMP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1449

On Nov  6 21:08, Takashi Yano wrote:
> ---
>  winsup/cygwin/fhandler_tty.cc | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index f87ac73f2..2b4ad6e58 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -3095,22 +3095,11 @@ pty_master_fwd_thread (VOID *arg)
>     the helper process is running as privileged user while
>     slave process is not. This function is used to determine
>     if the process is running as a srvice or not. */
> -static bool
> +inline static bool
>  is_running_as_service (void)
>  {
> -  DWORD dwSize =3D 0;
> -  PTOKEN_GROUPS pGroupInfo;
> -  tmp_pathbuf tp;
> -  pGroupInfo =3D (PTOKEN_GROUPS) tp.w_get ();
> -  NtQueryInformationToken (hProcToken, TokenGroups, pGroupInfo,
> -					2 * NT_MAX_PATH, &dwSize);
> -  for (DWORD i=3D0; i<pGroupInfo->GroupCount; i++)
> -    if (RtlEqualSid (well_known_service_sid, pGroupInfo->Groups[i].Sid))
> -      return true;
> -  for (DWORD i=3D0; i<pGroupInfo->GroupCount; i++)
> -    if (RtlEqualSid (well_known_interactive_sid, pGroupInfo->Groups[i].S=
id))
> -      return false;
> -  return true;
> +  return check_token_membership (well_known_service_sid)
> +    || cygheap->user.saved_sid () =3D=3D well_known_system_sid;
>  }
>=20=20
>  bool
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--pP0ycGQONqsnqIMP
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3C03oACgkQ9TYGna5E
T6Dhow/9EnNf0hsOhLHuyypvdx9Vm25oclHNI/ngBnOrJ7/6g6NoMRKkC7q3TVt5
pR/8PSI8SXzm9F1ci4h5ZUkwBecfvh/D5o7xdiTK0nKHZ7HI+A18M13mRLeJgu66
rC/9+naRij0Ll/rL3KcDiLCw1xEMPzecp3pRhc5dRb9/pLPzY0aGn6msgWwhdmU6
Lpwp6ui3bP5euwUIXisNA9Dli98yLCzx5clppDrTjUmuJnLN0pr61+NNwLSPLSg0
C+DQimfwb+pq3K14PCjcQXnMgLggTlaTuKhXhXNW0TYLN8Nr/7h+9XdDDGuVO+WY
FRjd7liPBUnPETZck3BlMyTCJaepF55X1b8ZnSqz6ahC1KzuhVTPxhx1n9Eo6ad3
Y7j7GEASvzWyUmTIosPxtHurclc+kYBa2OvETJ10fTS72D8GOipdIDNi4698oO+d
GymcOTfM9tCKl4Dv/L+72ZXKRPSa9Cbzh3ofHzEIOyD3HEs3kuEIIvOSPsWzDx1a
6tYAY37ogmY51swFaDPt72iV+cthf7FINZaIfFc4eiaH8mQveWgWUvpEvp/97L2M
cAMjFtbDEVgOoDQcIv6+/k/NPiDtLn9TwLHZBff2rLC0MsR7NlPhFrUfZnq0TZv5
/cEAw6LyJ7AG4Dkg5QEZ2FLkxAtpXMhHjbtfyBgCNAR/ddLtUJU=
=6udC
-----END PGP SIGNATURE-----

--pP0ycGQONqsnqIMP--

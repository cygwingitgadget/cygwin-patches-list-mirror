Return-Path: <cygwin-patches-return-9861-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 129390 invoked by alias); 2 Dec 2019 08:57:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 129378 invoked by uid 89); 2 Dec 2019 08:57:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-117.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, H*Ad:U*cygwin-patches, HX-Languages-Length:1949, HX-Envelope-From:sk:corinna
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Dec 2019 08:57:54 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MUpCz-1iBXqD0NOr-00QkoT for <cygwin-patches@cygwin.com>; Mon, 02 Dec 2019 09:57:52 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 441DFA8073C; Mon,  2 Dec 2019 09:57:51 +0100 (CET)
Date: Mon, 02 Dec 2019 08:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: /proc/[PID]/stat to pull process priority correctly
Message-ID: <20191202085751.GJ3312@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191201035814.1595-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Content-Disposition: inline
In-Reply-To: <20191201035814.1595-1-lavr@ncbi.nlm.nih.gov>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00132.txt.bz2


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2070

On Nov 30 22:58, Anton Lavrentiev via cygwin-patches wrote:
> Fix to prior commit 5fa9a0e7 to address https://cygwin.com/ml/cygwin/2019=
-08/msg00082.html
> ---
>  winsup/cygwin/fhandler_process.cc | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_process.cc b/winsup/cygwin/fhandler_p=
rocess.cc
> index 9527fea7d..6fc3476b2 100644
> --- a/winsup/cygwin/fhandler_process.cc
> +++ b/winsup/cygwin/fhandler_process.cc
> @@ -1076,6 +1076,7 @@ format_process_stat (void *data, char *&destbuf)
>    unsigned long fault_count =3D 0UL,
>  		vmsize =3D 0UL, vmrss =3D 0UL, vmmaxrss =3D 0UL;
>    uint64_t utime =3D 0ULL, stime =3D 0ULL, start_time =3D 0ULL;
> +  int nice =3D 0;
>=20=20
>    if (p->process_state & PID_EXITED)
>      strcpy (cmd, "<defunct>");
> @@ -1138,6 +1139,7 @@ format_process_stat (void *data, char *&destbuf)
>        if (!NT_SUCCESS (status))
>  	debug_printf ("NtQueryInformationProcess(ProcessQuotaLimits): "
>  		      "status %y", status);
> +      nice =3D winprio_to_nice (GetPriorityClass (hProcess));
>        CloseHandle (hProcess);
>      }
>    status =3D NtQuerySystemInformation (SystemTimeOfDayInformation,
> @@ -1157,7 +1159,6 @@ format_process_stat (void *data, char *&destbuf)
>    vmsize =3D vmc.PagefileUsage;
>    vmrss =3D vmc.WorkingSetSize / page_size;
>    vmmaxrss =3D ql.MaximumWorkingSetSize / page_size;
> -  int nice =3D winprio_to_nice(GetPriorityClass(hProcess));
>=20=20
>    destbuf =3D (char *) crealloc_abort (destbuf, strlen (cmd) + 320);
>    return __small_sprintf (destbuf, "%d (%s) %c "
> @@ -1169,7 +1170,7 @@ format_process_stat (void *data, char *&destbuf)
>  			  p->pid, cmd, state,
>  			  p->ppid, p->pgid, p->sid, p->ctty, -1,
>  			  0, fault_count, fault_count, 0, 0, utime, stime,
> -                         utime, stime, NZERO + nice, nice, 0, 0,
> +			  utime, stime, NZERO + nice, nice, 0, 0,
>  			  start_time, vmsize,
>  			  vmrss, vmmaxrss
>  			  );
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3k0g8ACgkQ9TYGna5E
T6CCJg/+Okfw6elsxvN36HD/eXc5SF9sGQiARG6KjFAOPN57ylxjSurHcsuAjSLB
gQ5eXsFQtgD21eCf1H5PbqDQ9KAm3DfyxOhQwRy6x6fVTqaDZvKia40qA759YYWL
i/eTnwJAS+Mv6ngDaZUDE4Ws8xboPUgjU+RvrBnDz+APWgtXdGA9ezqwZTIJkS+Y
3OH9NfDVcUw2q0w9uTdVebz8/HG8G9yey/VwWctJ7foyB5S4rU4Shev+Ds7dB/50
k7PvT+KL9q+SLHrwjiEQ754iJBMy348J1DrSyiU3vleg7OIglm9tI/HK1sBWSUgC
2VV5hjAxT603xPiA9EltfRda5LOWtCz52goiB5tylBQJVo9JdXWlTEmiQPicItyq
uhXrwSWt3/7b1k4YyBMsF9hE/BxfDWuVdqiqAuJ2wAvYMBfZ1Tab3AQ+QWsVWc7E
bUxk1woS9Z8f1B/8pzLtpLBaLTas/MJRiaXLkNELBlwFxYkoGas4dHFq9BYx3r2b
BtHgdCTw4V+h1uj1xErJe1uAHQdSGTkRALo/IeHOfP5NzxyOPJCeN3ROq0Wssye0
N6BkkO6ucbmtZopVv32KHVbTgUAv5FWO6FvZZgPgB+G+1NCF7sesIge20ArkqsUq
mebly0Oxm8tjnVPqhwWt9AAp+IxamO2rmswjBJrfVCEdVM3mlUI=
=Pe1H
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--

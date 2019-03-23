Return-Path: <cygwin-patches-return-9214-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 106737 invoked by alias); 23 Mar 2019 17:04:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 106726 invoked by uid 89); 23 Mar 2019 17:04:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-114.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=filling, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 23 Mar 2019 17:04:13 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MQusJ-1hJVWg1v67-00O2Jz; Sat, 23 Mar 2019 18:04:09 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 14151A80751; Sat, 23 Mar 2019 18:04:08 +0100 (CET)
Date: Sat, 23 Mar 2019 17:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] default ps -W process start time to system boot time when inaccessible, 0, -1
Message-ID: <20190323170408.GA3471@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>,	cygwin-patches@cygwin.com
References: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00024.txt.bz2


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1200

Hi Brian,

On Mar 22 21:45, Brian Inglis wrote:
>=20
> diff --git a/winsup/utils/ps.cc b/winsup/utils/ps.cc
> index 4fce3e0b3..c81805ab6 100644
> --- a/winsup/utils/ps.cc
> +++ b/winsup/utils/ps.cc
> @@ -337,6 +337,17 @@ main (int argc, char *argv[])
>  		p->start_time =3D to_time_t (&ct);
>  	      CloseHandle (h);
>  	    }
> +	  if (!h || 0 =3D=3D p->start_time || -1 =3D=3D p->start_time)

          if (!h || !p->start_time)

should be sufficient.  cygwin_internal(CW_GETPINFO_FULL) memsets the
struct returned to all 0 before filling it with available data.

> +	    {
> +	      SYSTEM_TIMEOFDAY_INFORMATION stodi;
> +	      status =3D NtQuerySystemInformation (SystemTimeOfDayInformation,
> +					(PVOID) &stodi, sizeof stodi, NULL);
> +	      if (!NT_SUCCESS (status))
> +		fprintf (stderr,
> +			"NtQuerySystemInformation(SystemTimeOfDayInformation), "
> +					"status %08x", status);
> +	      p->start_time =3D to_time_t ((FILETIME*)&stodi.BootTime);
> +	    }
>  	}
>=20=20
>        char uname[128];
> --=20
> 2.17.0

Wouldn't it make sense to fetch SystemTimeOfDayInformation only once
and then just set p->start_time above?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyWZwcACgkQ9TYGna5E
T6ALJA/+PYAYefK1IUfxvWgjEdMGuphaaLwQtc4s+0lNSEypJFeEoubEEazzC7+r
vKCykMsJsvH/qD5dlF2j8+gOP3FXBgqXo2LjyHF2XbVgqVHSLI1ZulOMTt/wIjpD
1V7FPqkRPVa70CafCbw9b5BO8F8DF01yj56p6SzO/gquTpWKVl/C0Cb2bzyC6lTb
0JFSHuRfUVmEgou0kqvL8Sz2mDZrGZhcktoTuPy65aWchk54M+ReZAJSHFwulFOG
Z16OJ/CoeKT6amAxSsb/u5gv7NnwjKh+ozsIbVRhQ/mNKmczKD5zuZ62Rq5CnfO8
ZO50rjKbh09GeiRL7AMqZV3bVYRol6GINa7zWxXLMbN0obTAkMTzOexr5pL8Iu6V
VLY8wcixF66uwtCQIvdCPp83nE3KmaTU8GmYUsiE5mr7C6mr5oWOneYfoWwJ7oP0
bPmLXCVj+ZI8yEb6+zLCqH13cm+69It1vT6HgIi6zLnwI6E7uhAQlLf0Yx465/QH
0k1PskjIZO5d/9PVV6TqgGuhgLrvF36ShR88BtaHEdXZZhMIKxICiJVFinn/9EF4
GvQbKueSBJCiBmx4grq5vbv7TsHrkjnM6cIUDU2nR7rJNe9Ve5sHObi/arm/phck
ezdokZApivj4861+4ImBYygWK32vbFJYoazngUSk+tl0V0Y6AdA=
=8gN8
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

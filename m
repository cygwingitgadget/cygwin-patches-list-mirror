Return-Path: <cygwin-patches-return-9384-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36051 invoked by alias); 29 Apr 2019 08:21:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36041 invoked by uid 89); 29 Apr 2019 08:21:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-115.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:4514, HTo:U*mark, H*R:D*cygwin.com, worthwhile
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 29 Apr 2019 08:21:05 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M3DFj-1hMPVH1Eej-003i6o; Mon, 29 Apr 2019 10:20:42 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6A45FA80784; Mon, 29 Apr 2019 10:20:40 +0200 (CEST)
Date: Mon, 29 Apr 2019 08:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Implement sched_[gs]etaffinity()
Message-ID: <20190429082040.GA3383@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com
References: <20190429053809.1095-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20190429053809.1095-1-mark@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00091.txt.bz2


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 4834

Hi Mark,

On Apr 28 22:38, Mark Geisert wrote:
> There are a couple of multi-group affinity operations that cannot be done
> without heroic measures.  Those are marked with XXX in the code.  Further
> discussion would be helpful to me.
>=20
> ---
>  newlib/libc/include/sched.h     |  13 ++
>  winsup/cygwin/common.din        |   4 +
>  winsup/cygwin/include/pthread.h |   2 +
>  winsup/cygwin/sched.cc          | 237 ++++++++++++++++++++++++++++++++
>  winsup/cygwin/thread.cc         |  19 +++
>  5 files changed, 275 insertions(+)
>=20
> diff --git a/newlib/libc/include/sched.h b/newlib/libc/include/sched.h
> index 1016235bb..a4d3fea6a 100644
> --- a/newlib/libc/include/sched.h
> +++ b/newlib/libc/include/sched.h
> @@ -92,6 +92,19 @@ int sched_yield( void );
>=20=20
>  #if __GNU_VISIBLE
>  int sched_getcpu(void);
> +
> +#ifdef __CYGWIN__

I don't think we really need that extra ifdef.  #if __GNU_VISIBLE
bracketing is sufficient.

> +static int
> +whichgroup (size_t sizeof_set, const cpu_set_t *set)
> +{
> +  //XXX code assumes __get_cpus_per_group() is fixed at 64

I don't understand this comment.  It could also return 48 or 36
or any other value <=3D 64.  Care to explain?

Oh and please keep in mind that 32 bit systems only support 32 CPUs, not
64 (sizeof(KAFFINITY) =3D=3D 4 on 32 bit).  I don't think this has much
influence on the code, if any, but it might be worthwhile to check the
code on any assumptions about the size of the affinity mask.

> +	  // There is no GetThreadAffinityMask() function, so simulate one by
> +	  // iterating through CPUs trying to set affinity, which returns the
> +	  // previous affinity.  On success, restore original affinity.
> +	  // This strategy is due to Damon on StackOverflow.

Can you please use /* ... */ style comments?  // style comments should
only be used for short, single-line comments after an expression.

Also, while there's no GetThreadAffinityMask() function, there is
an equivalent NT level function which allows to fetch the thread
affinity without having to manipulate it:

  THREAD_BASIC_INFORMATION tbi;
  KAFFINITY affinity_mask;

  NtQueryInformationThread (thread_handle, ThreadBasicInformation,
			    &tbi, sizeof tbi, NULL);
  affinity_mask =3D tbi.AffinityMask;

All required definitions already exist in ntdll.h and are used in
fhandler_process.cc, just for another purpose.

> +int
> +sched_getaffinity (pid_t pid, size_t sizeof_set, cpu_set_t *set)
> +{
> +  HANDLE process =3D 0;
> +  int status =3D 0;
> +
> +  //XXX code assumes __get_cpus_per_group() is fixed at 64
> +  pinfo p (pid ? pid : getpid ());
> +  if (p)
> +    {
> +      process =3D pid && pid !=3D myself->pid ?
> +                OpenProcess (PROCESS_QUERY_LIMITED_INFORMATION, FALSE,
> +                             p->dwProcessId) : GetCurrentProcess ();
> +      KAFFINITY procmask;
> +      KAFFINITY sysmask;
> +
> +      if (!GetProcessAffinityMask (process, &procmask, &sysmask))
> +        {
> +oops:
> +          status =3D geterrno_from_win_error (GetLastError (), EPERM);
> +          goto done;
> +        }
> +      memset (set, 0, sizeof_set);
> +      if (wincap.has_processor_groups ())
> +        {
> +          USHORT groupcount =3D CPU_GROUPMAX;
> +          USHORT grouparray[CPU_GROUPMAX];
> +
> +          if (!GetProcessGroupAffinity (process, &groupcount, grouparray=
))
> +            goto oops;

Uhm... that's a bit ugly, imho.  Rather than just jumping wildly to
another spot in the middle of the same function, create a matching label
at the end of the function.  Or, in a simple case like this one, just
call geterrno_from_win_error here and goto done.

> +          if (groupcount =3D=3D 1)
> +	    set[grouparray[0]] =3D procmask;
> +	  else
> +            status =3D ENOSYS;//XXX multi-group code TBD...
> +	    // There is no way to assemble the complete process affinity mask
> +	    // without querying at least one thread per group in grouparray,
> +	    // and we don't know which group a thread is in without querying
> +	    // it, so must query all threads.  I'd call that a heroic measure.

I don't understand.  GetProcessAffinityMask() exists.  Am I missing
something?  Also, if you don't like GetProcessAffinityMask(), there's an
equivalent NT function to NtQueryInformationThread:

  PROCESS_BASIC_INFORMATION pbi;
  KAFFINITY affinity_mask;

  NtQueryInformationProcess (process_handle, ProcessBasicInformation,
			     &pbi, sizeof pbi, NULL);
  affinity_mask =3D pbi.AffinityMask;

> +        }
> +      else
> +        set[0] =3D procmask;
> +    }
> +  else
> +    status =3D ESRCH;
> +
> +done:
> +  if (process && process !=3D GetCurrentProcess ())
> +    CloseHandle (process);
> +
> +  return status;
> +}
> +[...]

Other than that, the code looks good to me.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlzGs9gACgkQ9TYGna5E
T6CxHg//Wubi1+LZYQbO/IE+OLGdBaqmfgwYnFjjOXHgulzG1CTG4Dp6/b1FgpGe
YSEnR0GTtZA0yofjqEEcxFs5gh58zi0NoHZhQJhftfFxz9+98rS8NH0ChtYVGPEN
D9hzZfQeoDhIHWTTfpDV5tjze/QPwUZTuJP4uR+oqrJ27lxgBEHwzjcwXg9FEFyT
HOR67kagBkN8dsyZJO2B9uVRTcu+gyKOSho09mfnOnyCMYQDxGdMZ0Yhmm/BR2RI
YJZ9pJESKaBUWSyDL0KDUGfAvt3tdV1MQtLr3ofP1rhPnZh3StJ/wtcClarPdYEa
4GMzvzCR7MdpQdr0j5viMwZ0xoijwAdJApnKS1QsOnCSGz65Gmhq1NaC+hJlHkgh
tKGVi4DCKJbc94HggFwpAEs7jxsWkqL2IfSzETZkVnz63jz7dLL9XTf5b9JLmg95
hEWihKwf+7k7v+omh3y2piv1Q2Xc8ok/Z9k903QRzqM6gwlRkb1hhXXm8GJt4U6J
XLa80J5W4Dr+4J5AqM6/tkA/7MYwja6/xf5WnCdz7tob0sA4d4nzISnZJkqpgANc
fHeNL9MDMH5ASDRZYHiKVHINpiUjKg6jXbngipKKhpDf8Qhd085LcKre6h4vrt4p
6wqNaig4ZYLDbkHvELMhZWdBF3SDNbG+w4D0LirzUq3Mabr6kNI=
=OZLb
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

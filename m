Return-Path: <cygwin-patches-return-8608-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81968 invoked by alias); 28 Jul 2016 19:35:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81954 invoked by uid 89); 28 Jul 2016 19:35:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-94.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Wire, UD:lock, CALLBACK, sk:jontur
X-HELO: calimero.vinschen.de
Received: from ipbcc0190b.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.25.11) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Jul 2016 19:35:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 37C89A80EF9; Thu, 28 Jul 2016 21:34:58 +0200 (CEST)
Date: Thu, 28 Jul 2016 19:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Send thread names to debugger
Message-ID: <20160728193458.GB26311@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20160728114341.1728-1-jon.turney@dronecode.org.uk> <20160728114341.1728-3-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20160728114341.1728-3-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.6.2 (2016-07-01)
X-SW-Source: 2016-q3/txt/msg00016.txt.bz2


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 7293

On Jul 28 12:43, Jon Turney wrote:
> GDB with the patch from [1] can report and use these names.

This is still WIP, right?

> Add utility function SetThreadName(), which sends a thread name to the
> debugger.
>=20
> Wire this up to set the default thread name for main thread and newly
> created pthreads.
>=20
> Wire this up in pthread_setname_np() for user thread names.
>=20
> Wire this up in cygthread::create() for helper thread names.  Also wire it
> up for helper threads which are created directly with CreateThread.
>=20
> TODO: Make SetThreadName() available to libgmon.a so the profiling thread
> created by that can be named as well.
>=20
> Note that there can still be anonymous threads, created by the kernel or
> injected DLLs.
>=20
> [1] https://sourceware.org/ml/gdb-patches/2016-07/msg00307.html
>=20
> Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
> ---
>  winsup/cygwin/cygthread.cc  |  2 ++
>  winsup/cygwin/dcrt0.cc      |  1 +
>  winsup/cygwin/exceptions.cc |  2 +-
>  winsup/cygwin/miscfuncs.cc  | 28 ++++++++++++++++++++++++++++
>  winsup/cygwin/miscfuncs.h   |  2 ++
>  winsup/cygwin/net.cc        |  2 ++
>  winsup/cygwin/profil.c      |  2 ++
>  winsup/cygwin/thread.cc     |  5 +++++
>  8 files changed, 43 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/cygthread.cc b/winsup/cygwin/cygthread.cc
> index b9d706b..2f7f2a1 100644
> --- a/winsup/cygwin/cygthread.cc
> +++ b/winsup/cygwin/cygthread.cc
> @@ -213,6 +213,8 @@ cygthread::create ()
>  			    this, 0, &id);
>        if (!htobe)
>  	api_fatal ("CreateThread failed for %s - %p<%y>, %E", __name, h, id);
> +      else
> +	SetThreadName(GetThreadId(htobe), __name);
                    ^^^         ^^^
                   space?      space?

Just wondering: Wouldn't it make sense to rename the internal threads
so they either always start with "cyg_" or with double underscore or
something like that to mark them as internal?  E.g.

  new cygthread (wait_sig, cygself, "cyg_wait_sig");

>        thread_printf ("created name '%s', thread %p, id %y", __name, h, i=
d);
>  #ifdef DEBUGGING
>        terminated =3D false;
> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> index 2328411..de581c1 100644
> --- a/winsup/cygwin/dcrt0.cc
> +++ b/winsup/cygwin/dcrt0.cc
> @@ -964,6 +964,7 @@ dll_crt0_1 (void *)
>        if (cp > __progname && ascii_strcasematch (cp, ".exe"))
>  	*cp =3D '\0';
>      }
> +  SetThreadName(GetCurrentThreadId(), program_invocation_short_name);
                 ^^^                ^^^
                space?             space?

>=20=20
>    (void) xdr_set_vprintf (&cygxdr_vwarnx);
>    cygwin_finished_initializing =3D true;
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index d65f56e..1d028a7 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -1288,7 +1288,7 @@ DWORD WINAPI
>  dumpstack_overflow_wrapper (PVOID arg)
>  {
>    cygwin_exception *exc =3D (cygwin_exception *) arg;
> -
> +  SetThreadName(GetCurrentThreadId(), "dumpstack_overflow");
                 ^^^                ^^^
                space?             space?

>    exc->dumpstack ();
>    return 0;
>  }
> diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
> index d0e4bf7..353633b 100644
> --- a/winsup/cygwin/miscfuncs.cc
> +++ b/winsup/cygwin/miscfuncs.cc
> @@ -1110,3 +1110,31 @@ wmemcpy:								\n\
>  	.seh_endproc							\n\
>  ");
>  #endif
> +
> +//
> +// Signal the thread name to any attached debugger
> +//
> +// (See "How to: Set a Thread Name in Native Code"
> +// https://msdn.microsoft.com/en-us/library/xcb2z8hs.aspx)
> +//

/* */, please

> +
> +#define MS_VC_EXCEPTION 0x406D1388
> +
> +void
> +SetThreadName(DWORD dwThreadID, const char* threadName)
> +{
> +  if (!IsDebuggerPresent ())
> +    return;
> +
> +  ULONG_PTR info[] =3D
> +    {
> +      0x1000,                /* type, must be 0x1000 */
> +      (ULONG_PTR)threadName, /* pointer to threadname */
                  ^^^
                 space?

> +      dwThreadID,            /* thread ID (+ flags on x86_64) */
> +#ifdef __X86__
> +      0,                     /* flags, must be zero */
> +#endif
> +    };
> +
> +  RaiseException (MS_VC_EXCEPTION, 0, sizeof(info)/sizeof(ULONG_PTR), (U=
LONG_PTR *) &info);
                                              ^^^          ^^^
                                             space?       space?

> +}
> diff --git a/winsup/cygwin/miscfuncs.h b/winsup/cygwin/miscfuncs.h
> index a885dcf..5390dd1 100644
> --- a/winsup/cygwin/miscfuncs.h
> +++ b/winsup/cygwin/miscfuncs.h
> @@ -85,4 +85,6 @@ extern "C" HANDLE WINAPI CygwinCreateThread (LPTHREAD_S=
TART_ROUTINE thread_func,
>  					     DWORD creation_flags,
>  					     LPDWORD thread_id);
>=20=20
> +void SetThreadName(DWORD dwThreadID, const char* threadName);
                    ^^^
                   space?

> +
>  #endif /*_MISCFUNCS_H*/
> diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
> index 52b3d98..94ae604 100644
> --- a/winsup/cygwin/net.cc
> +++ b/winsup/cygwin/net.cc
> @@ -1776,6 +1776,8 @@ call_gaa (LPVOID param)
>    gaa_wa *p =3D (gaa_wa *) param;
>    PIP_ADAPTER_ADDRESSES pa0 =3D NULL;
>=20=20
> +  SetThreadName(GetCurrentThreadId(), "call_gaa");
                 ^^^                ^^^
                space?             space?



> +
>    if (!p->pa_ret)
>      return GetAdaptersAddresses (p->family, GAA_FLAG_INCLUDE_PREFIX
>  					    | GAA_FLAG_INCLUDE_ALL_INTERFACES,
> diff --git a/winsup/cygwin/profil.c b/winsup/cygwin/profil.c
> index be59b49..4b2e873 100644
> --- a/winsup/cygwin/profil.c
> +++ b/winsup/cygwin/profil.c
> @@ -91,6 +91,8 @@ static void CALLBACK
>  profthr_func (LPVOID arg)
>  {
>    struct profinfo *p =3D (struct profinfo *) arg;
> +  // XXX: can't use SetThreadName() here as it's part of the cygwin DLL
> +  // SetThreadName(GetCurrentThreadId(), "prof");
                    ^^^                ^^^
                   space?             space?

Since it's such a short function, why not just add a copy to profile.c
or just perform the RaiseException directly?

>=20=20
>    for (;;)
>      {
> diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> index e41e0c1..7f60db7 100644
> --- a/winsup/cygwin/thread.cc
> +++ b/winsup/cygwin/thread.cc
> @@ -1985,6 +1985,9 @@ pthread::thread_init_wrapper (void *arg)
>    _my_tls.sigmask =3D thread->parent_sigmask;
>    thread->set_tls_self_pointer ();
>=20=20
> +  // Give thread default name
> +  SetThreadName(GetCurrentThreadId(), program_invocation_short_name);
                 ^^^                ^^^
                space?             space?

> +
>    thread->mutex.lock ();
>=20=20
>    // if thread is detached force cleanup on exit
> @@ -2622,6 +2625,8 @@ pthread_setname_np (pthread_t thread, const char *n=
ame)
>    oldname =3D thread->attr.name;
>    thread->attr.name =3D cp;
>=20=20
> +  SetThreadName(GetThreadId(thread->win32_obj_id), thread->attr.name);
                 ^^^                ^^^
                space?             space?

> +
>    if (oldname)
>      free(oldname);
          ^^^
         space?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXml5iAAoJEPU2Bp2uRE+g+KQP/1MfMKJsNdm3RXrmnMECPNMl
RAgaA/nmYBQDu/Uj6CNHUuE0WyuY839aGzj6s6mbhtsPNqf4FCtMoVnvmXfxDv3Y
J1gACioBiPMP9SA5KxowxIaeLgbiq1ggGzibmVIeUOQaY/uCzeuWpsGGO7Qm1fAO
nilcEHQw2hLy8YcWYhsvQ+fA3/6MeRIaFXh2PAWaxHlPFY662z6BFtzc60PC6Mmv
VycKR1OEjruhBvZCvQ13TEqOnofE6VOuAIXGcZ0vKFttU74Jbmt7cmhXNRCfF+jm
5pSgIpZEZYD+OjYMlrualzd8cPqyGQJp0ExyiAW5T1HCoHDviDcGb3bqa55WBzq4
v3NDuJQs9Yo90eBq9Vh+E5LeU2GvtXmEgBThSmpq78ko3K9uHiUN9pqUogFQ3wtR
1Fert6P8W4Fser5h3SAD5AVtpPBVzjqyy8qtKQ3l3QJU236Vy5N1lbPadfPmHSQ6
/rhJe7vbwrrQuBLqLD3rTQFH8Ie56xRy9RM1XD3YVyFAwWxM/zmI4EXktY4cVRth
u1i30cWgHjcbGtmiI6iJlM4QsrR/oz+6ouj8M/dQcMQmWmZ7TnXaT/7OmpuQje4W
1LuSNY0BbnHrHFczJVSNDx82wTlFWOCY3tS++h6TMgAztKOfbubd4Q6AfOcEBJrc
Yq3xXooVWvoZvuCmmg9Y
=YHKy
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

Return-Path: <cygwin-patches-return-9123-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27222 invoked by alias); 17 Jul 2018 15:51:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27200 invoked by uid 89); 17 Jul 2018 15:51:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=Hx-languages-length:1918
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 17 Jul 2018 15:51:26 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue005 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LpAm0-1gI4rP1B5w-00esbK for <cygwin-patches@cygwin.com>; Tue, 17 Jul 2018 17:51:23 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B7F57A806DF; Tue, 17 Jul 2018 17:51:22 +0200 (CEST)
Date: Tue, 17 Jul 2018 15:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/3] POSIX Asynchronous I/O support: aio files
Message-ID: <20180717155122.GF27673@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180715082025.4920-1-mark@maxrnd.com> <20180715082025.4920-2-mark@maxrnd.com> <20180717145146.GA23667@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="bOC9TN0n4iVUZoxs"
Content-Disposition: inline
In-Reply-To: <20180717145146.GA23667@calimero.vinschen.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00018.txt.bz2


--bOC9TN0n4iVUZoxs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1993

Mark,

I think there's a bug in sigtimedwait.  I just found the problem while
looking into this aio_suspend stuff:

On Jul 17 16:51, Corinna Vinschen wrote:
> > +  res =3D sigtimedwait (&sigmask, &si, to);

You're giving the timeout value verbatim to sigtimedwait().

Let's have a look into sigtimedwait, per your original patch, commit
24ff42d79aab:

+  if (timeout)
+    {
+      if (timeout->tv_sec < 0
+           || timeout->tv_nsec < 0 || timeout->tv_nsec > (NSPERSEC * 100LL=
))
+       {
+         set_errno (EINVAL);
+         return -1;
+       }

So we're enforcing a positive timeout value.

+      /* convert timespec to 100ns units */
+      waittime.QuadPart =3D (LONGLONG) timeout->tv_sec * NSPERSEC
+                          + ((LONGLONG) timeout->tv_nsec + 99LL) / 100LL;
+    }

...which is converted to a likewise positive 100ns interval ...

+  return sigwait_common (set, info, timeout ? &waittime : cw_infinite);

...given to sigwait_common, which in turn calls

  cygwait (NULL, waittime, [flags])

cygwait uses this waittime value verbatim in a call to

  NtSetTimer (_my_tls.locals.cw_timer, timeout, [...]);

So NtSetTimer is called with a *positive* waittime value, right?

A positive value given to NtSetTimer is evaluated as a timestamp,
*not* as a time interval.  Look at the lpDueTime description of
SetWaitableTimerEx.  That's the WIN32 API function exposing the
NtSetTimer function:
https://docs.microsoft.com/en-us/windows/desktop/api/synchapi/nf-synchapi-s=
etwaitabletimerex

However, the POSIX description of sigtimedwait indicates that the
timespec value is evaluated as a time interval, which is a relative
time:

http://pubs.opengroup.org/onlinepubs/9699919799/functions/sigtimedwait.html

So bottom line is, shouldn't timeout be converted to a negative waittime
value in sigtimedwait?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--bOC9TN0n4iVUZoxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltOEHoACgkQ9TYGna5E
T6AnqhAAntdUi3CpooU7SRFuYHpLvd5xCBKDmb7nbY/D2Nw45Z3ua0Rr1O8lXqkp
Rb6dzylgoEt9pMhrSh9nI50OOGQSlxX6Xfc3s0a5eicbLcKjlDA9Pdtab6gCHGxv
/pz0uThHdnTfB0ckBvpO9GgfQi6pp7rS05uaemMyP/oRQ47tQqHUVaX/QbdkcM4X
+k1bvQtsScFhjAN0GnJaqPLOEzn87lfe8ndAsfsAdrhVscJ0w027+T3ZhrhRf5vW
GlM1mf2xdgx+8SwfJBRSeYFOqATaL/recBXqsQoEvoexJVRuWDBxRIWw4wVwtBoa
1xnG9tl1rwcon0yxsJPk6trpTDQV/gGnfRq8Kf+nwXZk0guyYYQgwgt+xdo8Hswy
8Fzx2KuFytgqnHIxTZJSl+v5R9PJXhJrDn5ofcI5kBV3VCNBhbcjRdQh/7zsKFFZ
4zRKy3YbMBT8ca+BzdnzXdwre+QRpygpBF69xe8vUdPqg9z8Il2RxxsHCV4UjXy+
3j33f8GObdS0mQkORYu87dUJzoWhl7Lcc+buiKtG3QuGhfd9pgjcvZCZDUPFA087
ln5muiOUPuIh0XwJs/KFlmsKmy04Fa+ksCZ+QnNUn2/6dJeKqy2pZ+GYU/QV8df0
iiz78jwPMR53KVMexPhZn8O8+DAArZIE9hLFCi2VQo+e8OILQBY=
=uy3W
-----END PGP SIGNATURE-----

--bOC9TN0n4iVUZoxs--

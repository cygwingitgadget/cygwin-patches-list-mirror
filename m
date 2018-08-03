Return-Path: <cygwin-patches-return-9164-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123149 invoked by alias); 3 Aug 2018 13:05:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 123139 invoked by uid 89); 3 Aug 2018 13:05:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=our
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 Aug 2018 13:05:39 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MXYso-1fOyiE3bWw-00WTen for <cygwin-patches@cygwin.com>; Fri, 03 Aug 2018 15:05:36 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A93AD12E0A3E; Fri,  3 Aug 2018 15:05:35 +0200 (CEST)
Date: Fri, 03 Aug 2018 13:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fegetenv() in winsup/cygwin/fenv.cc should not disable exceptions!
Message-ID: <20180803130535.GA985@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1533253512-1717-1-git-send-email-houder@xs4all.nl> <20180803073647.GA6347@calimero.vinschen.de> <213765cb4acd51f933201d759e2752a7@xs4all.nl> <20180803103917.GC6347@calimero.vinschen.de> <9d3b0bda096f6b7dbf5d7dd07eeb05e6@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <9d3b0bda096f6b7dbf5d7dd07eeb05e6@xs4all.nl>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00059.txt.bz2


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1245

On Aug  3 14:00, Houder wrote:
> On 2018-08-03 12:39, Corinna Vinschen wrote:
> > On Aug  3 11:27, Houder wrote:
> > > On 2018-08-03 09:36, Corinna Vinschen wrote:
> [snip]
>=20
> > > > In terms of x86_64, do we have to change the fenv stuff completely
> > > > to use only SSE opcodes?  Does that make sense at all?
> > >=20
> > > Ho! I have to disappoint you here! I am not an expert at all.
> >=20
> > Thanks all the same for your detailed description.  A quick search in
> > glibc shows that x86_64 FP exceptions in fact work somewhat different in
> > that it additionally reads and writes from the SSE control register,
> > e.g. sysdeps/x86_64/fpu/fesetenv.c:
> >=20
> >     __asm__ ("fnstenv %0\n"
> >            "stmxcsr %1" : "=3Dm" (*&temp), "=3Dm" (*&temp.__mxcsr));
> >     [...]
> >       __asm__ ("fldenv %0\n"
> >            "ldmxcsr %1" : : "m" (temp), "m" (temp.__mxcsr));
>=20
> ? ... uhm, this also happens in Korn's implementation (Cygwin). Only
> Dave Korn verifies if SSE is present (does the machine have SSE?).

Oops.  Next time I check our code first.  Promised :}


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltkUx8ACgkQ9TYGna5E
T6CKOA/8DI7JIyl5d47p3gcP3Hx+c+r/8OTyth856I2+JSRFpoIKcQV/15Y75Wwh
47xBNTzvcwqv363b8CI8ySEmaL3zEL6wCO7TX3F32rPmKG58vBqf9L3rW3mtlsll
/ykgQ5oblaJX7pt3IvIkGZAZtN/4ktRdBGzaY06tYK1fadGJ9WnKiG7vZtQX+Ufp
Z72JPtFTi9lOHBnGyFBtPBC6hjhBE07lMzXpMLWgZz/1GcqE4FVwnGKQd692nS4g
E3k6i/lE+p/gOpPUemb6paEvTaQkn3KiOCBEIiR2j6naSYAZfGU9LrUiKJQKe9R9
eF7vQ9OC+WLrG0PXypjne79RegYRkox9E5zkT5bGo8WAPj11af8v14xL1/hOzZF4
CHP3O20KayEBTqKl4t4r2j5PUB47o44IzAFYLd5RKmaex2tXkAEdn+0bKKQb8VT6
K+uu9SfCkIZv2iAYAMi8FpCSmk3OseRL+JA6eDtw1jh4SfxxLc4oudirQEHpGnPG
PRAnfHIIitiHmS16BFH9gie9tMWI0LmAspu6bAR0aS+uq7radGfytu/hTO6/ooJ0
keXol6bv2b24K9OUsMiHB/8wZOdCOaWX3GbUTYCTJLwsV/gZJnmHVAihzUEser4C
NN4LK7fIe+7nTK7PildlM0BzLG6k4sDrraoO9tMJFsfDnbcRHAs=
=XTBs
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--

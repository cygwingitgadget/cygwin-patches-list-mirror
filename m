Return-Path: <cygwin-patches-return-9161-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 105523 invoked by alias); 3 Aug 2018 10:39:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 105318 invoked by uid 89); 3 Aug 2018 10:39:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 Aug 2018 10:39:21 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue007 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LZpVp-1gDQfD1xJl-00lits for <cygwin-patches@cygwin.com>; Fri, 03 Aug 2018 12:39:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 72ACC12E0A3E; Fri,  3 Aug 2018 12:39:17 +0200 (CEST)
Date: Fri, 03 Aug 2018 10:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fegetenv() in winsup/cygwin/fenv.cc should not disable exceptions!
Message-ID: <20180803103917.GC6347@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1533253512-1717-1-git-send-email-houder@xs4all.nl> <20180803073647.GA6347@calimero.vinschen.de> <213765cb4acd51f933201d759e2752a7@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <213765cb4acd51f933201d759e2752a7@xs4all.nl>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00056.txt.bz2


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1362

On Aug  3 11:27, Houder wrote:
> On 2018-08-03 09:36, Corinna Vinschen wrote:
> > Hi J.H.,
> >=20
> > Pushed with tweaks.  The string in __asm__ statements works a
>=20
> Bah! Must be the heat! I did a compare (sdiff), but missed it. You
> are correct: the '\n' is required.
>=20
> > bit different and I made a slight change to the commit message.
>=20
> No problem! (you could have gone even further; your command of the
> English language is far better than mine).
>=20
> > In terms of x86_64, do we have to change the fenv stuff completely
> > to use only SSE opcodes?  Does that make sense at all?
>=20
> Ho! I have to disappoint you here! I am not an expert at all.

Thanks all the same for your detailed description.  A quick search in
glibc shows that x86_64 FP exceptions in fact work somewhat different in
that it additionally reads and writes from the SSE control register,
e.g. sysdeps/x86_64/fpu/fesetenv.c:

    __asm__ ("fnstenv %0\n"
           "stmxcsr %1" : "=3Dm" (*&temp), "=3Dm" (*&temp.__mxcsr));
    [...]
      __asm__ ("fldenv %0\n"
           "ldmxcsr %1" : : "m" (temp), "m" (temp.__mxcsr));

If you're still interested in this stuff, feel free to create more
patches :)


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltkMNUACgkQ9TYGna5E
T6ABJQ/+NVURyURJbF27T/aMmMXYo7dR16hB1v2e7NMGDioBy7BKGCule0C3Boh+
cOXOK6RSXfI+IRd7w16Da+AiQ8aWdysM/uR8y8k/M9SHctdvg4y6HdoGw7vLCZjc
1q5OLNp5UAqnwxRlFPOI+zWxFL+/F8o6dVcxqqXrBG48J1WRWmGwpHitOlsazZu2
mI1fKTuYYXPyopMa7bEOhwXZcKs4cJbRtWcd55U8cd0bQFiR/54ytJgsEpfkwJ9D
7f74i4tsvbYCu7fRFVDVvw+BO9TmSprf+LC7BYOurg/8hu6SV13dCavXYYGXHZRG
5cFfKicr28dNPtRgly/xrAUri1HlTiEmE8G3K7AI04NbtV2jfWADOAhmBFRiwCXw
G0iCYzv3MTm4EIw8Phg6xHKaLTrIpdEQZ8q6ueR2a+4oVvwPygYY3iJj/xSOhmUb
Y4CMuBndSvUWky7BCcNw13KZnKTLQ/uj0xhRqS0Ol1xNVzB3+AGWRvCQJ2UY5XB0
kY/XGjRCFVSdYW1Pfc4m9vkRvlul7Ns6ggZ/c9MtMAWjv5OUOUDHv+iwf3s5hE2y
c2zZ8LikQ4J1+CfPHvnjlpD6t9d114G1fI41vlwk39HOIaEEJwKo975Knfpx+rvW
L4pxIELCRKssnMMTWofBGekgCLOn1gQr+efXg0OJmUwdGuEzliY=
=fTHB
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--

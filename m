Return-Path: <cygwin-patches-return-8093-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15761 invoked by alias); 31 Mar 2015 18:46:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15747 invoked by uid 89); 31 Mar 2015 18:46:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 31 Mar 2015 18:46:45 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B7EAEA80A3F; Tue, 31 Mar 2015 20:46:42 +0200 (CEST)
Date: Tue, 31 Mar 2015 18:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Make mcontext and stack information available to signal handlers
Message-ID: <20150331184642.GB15852@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427824014-19504-1-git-send-email-jon.turney@dronecode.org.uk> <1427824014-19504-3-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <1427824014-19504-3-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00048.txt.bz2


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1522

On Mar 31 18:46, Jon TURNEY wrote:
> Add ucontext.h header, defining ucontext_t and mcontext_t types.
>=20
> Provide sigaction sighandlers with a ucontext_t parameter, containing sta=
ck and
> context information.
>=20
> XXX: How do we indicate context information is not available (si_cyg =3D=
=3D NULL)

If si_cyg is NULL, fetch the current context via RtlCaptureContext.

Two minor nits.  With the outlined changes, ok to apply.

> +      if (thissi.si_cyg)
> +        {
> +          memcpy (&context.uc_mcontext, ((cygwin_exception *)thissi.si_c=
yg)->context(), sizeof(CONTEXT));
> +        }
> +

At this point, please add a FIXME comment rambling along about
having to tweak this code when we implement sigaltstack.

> +      context.uc_stack.ss_sp =3D NtCurrentTeb ()->Tib.StackBase;
> +      context.uc_stack.ss_flags =3D 0;
> +      if (!NtCurrentTeb ()->DeallocationStack)
> +        context.uc_stack.ss_size =3D (uintptr_t)NtCurrentTeb ()->Tib.Sta=
ckLimit - (uintptr_t)NtCurrentTeb ()->Tib.StackBase;
> +      else
> +        context.uc_stack.ss_size =3D (uintptr_t)NtCurrentTeb ()->Dealloc=
ationStack - (uintptr_t)NtCurrentTeb ()->Tib.StackBase;
> +
> +#ifndef _SYS_UCONTEXT_H_
> +#define _SYS_UCONTEXT_H_
> +
> +#include <cygwin/signal.h>
> +#include <sys/signal.h>

Just include <signal.h> as on Linux, unless there's a really good reason.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVGuuSAAoJEPU2Bp2uRE+g/b4P/1GO7ioScbpsyw7FM8oAC3yp
+RzsIxyw1wVzS+LrzrYnrLGNn/deCFVbePhdoPXnqKvAqwEiyT7AzPinh8xcmqDt
N/i2te72CM6cotNnc0kQQlEyZ07B1GY2Lh8CXgySNdLhhMPv9bZmdadi6V2WzYKR
Oos4oHGF0YU7clWwtY+beO/0DlC+rCya8eCVRkSyAuMfktXMh9Z1BDpnh6iivS7k
YJRJTe0ffUt1ZoPg7IpJgg/yK90S6Nag6afT067YfjUgqGB5KpC1hlrkbihtiXxy
tdAmRXUwPJgDf7HMqw3TrtPRW01AyCUz1EDQm81SypoEYQGWk04GVOw59Lx2i9+K
nknP74HiBOO4KFxB7Yk46ltCMdaY2ERlW4yIyUKHFM00h8m8cMzo6JJaBLPk88NM
D4F6a8GqsEq4IZdthiOfb+H9R6R9WX+on74QMiqRh0NcA8JMpC/jEEp09d9xuqSE
XWfbsNLinLwBTJtlVQmrMM30bkNkAMUpe1FkPMKzSG8i6ptUX56v/cDOkOT5Hiyy
a1bFOa9GOgVr4W2nhC+W64LjP/HdnKPjJVnpHJo2A6FZQAv6+BWZAvW28jnF2u26
MISEGQaPVWGqpdcbSH8xg+V/PHn+ufpZc/67C1XRwu8SWaQWtCVnH7YE6MM1l9st
PfBm9KxyK60t4wR3Wr23
=Cndh
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--

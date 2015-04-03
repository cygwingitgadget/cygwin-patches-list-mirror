Return-Path: <cygwin-patches-return-8113-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 43267 invoked by alias); 3 Apr 2015 11:18:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 43233 invoked by uid 89); 3 Apr 2015 11:18:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 Apr 2015 11:18:08 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8DA9AA80975; Fri,  3 Apr 2015 13:18:06 +0200 (CEST)
Date: Fri, 03 Apr 2015 11:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Only construct ucontext for SA_SIGINFO signal handlers
Message-ID: <20150403111806.GO13285@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1428003041-14404-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="qJM7dOmrnYWq+SaN"
Content-Disposition: inline
In-Reply-To: <1428003041-14404-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00014.txt.bz2


--qJM7dOmrnYWq+SaN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2115

On Apr  2 20:30, Jon TURNEY wrote:
> 	* exceptions.cc (call_signal_handler): Only bother to construct
> 	the ucontext for signal handlers with SA_SIGINFO set.

Looks good, except...

> +      ucontext_t context;
> +      ucontext_t *thiscontext =3D NULL;
> +
> +      /* Only make a context for SA_SIGINFO handlers */
> +      if (this_sa_flags & SA_SIGINFO)
> +        {
> +          context.uc_link =3D 0;
> +          context.uc_flags =3D 0;
> +          if (thissi.si_cyg)
> +            memcpy (&context.uc_mcontext, ((cygwin_exception *)thissi.si=
_cyg)->context(), sizeof(CONTEXT));
> +          else
> +            RtlCaptureContext ((CONTEXT *)&context.uc_mcontext);
> +            /* FIXME: Really this should be the context which the signal=
 interrupted? */
> +
> +          /* FIXME: If/when sigaltstack is implemented, this will need t=
o do
> +             something more complicated */
> +          context.uc_stack.ss_sp =3D NtCurrentTeb ()->Tib.StackBase;
> +          context.uc_stack.ss_flags =3D 0;
> +          if (!NtCurrentTeb ()->DeallocationStack)
> +            context.uc_stack.ss_size =3D (uintptr_t)NtCurrentTeb ()->Tib=
.StackLimit - (uintptr_t)NtCurrentTeb ()->Tib.StackBase;
> +          else
> +            context.uc_stack.ss_size =3D (uintptr_t)NtCurrentTeb ()->Dea=
llocationStack - (uintptr_t)NtCurrentTeb ()->Tib.StackBase;
> +
> +          thiscontext =3D &context;
> +        }


>        sigset_t this_oldmask =3D set_process_mask_delta ();
> -      thiscontext.uc_sigmask =3D this_oldmask;
> +      context.uc_sigmask =3D this_oldmask;
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This call to set_process_mask_delta() should occur before constructing
the context, so that filling in uc_sigmask can be moved into the above
`'if' branch.

On second thought, isn't this slightly wrong anyway?  Shouldn't that be

         context.uc_sigmask =3D _my_tls.sigmask;
	 context.uc_mcontext.oldmask =3D this_oldmask;

?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--qJM7dOmrnYWq+SaN
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBAgAGBQJVHnbuAAoJEPU2Bp2uRE+gBQcP9irk5eFRzvREheoAqdgRyISn
fgopY/hjGYU2EOEbUEt0BNgw7gG+PujCHaLOP3LAbT8QsZMIcE9vfnRC9sYZ9Pg5
iWqoTyPQMcoa9SMIX0VOXio3RLUAIeRcXAcxAw7g0UzsUAqvp5pZ5kc0RICb2AgT
q+Z7k0JEi8q02N5fmleWdYTCK6cAB49ibdmmv1FfRkD9Aay+Dtt68NQj3JMisWcG
z9GDlTjSDUcptZPuFOBVPteCdtW6vmCVbUV5Q6YPHKtOqSQtc+8i9zVz3j20TAaK
lcG2fGSLXcJw5mJK/jDtaXyElOm6rXRNvR00iCCwekCjfrwAGHLK3TCGw/jBjan1
JzS16CQmDJo4aZH7/u4VIrnZm2anTJSDzA38kvKi2ol5BAX+EETe4c/PnQSIpo7p
JeUowY0K6v8o/J0eQKeLpPYHpgzTQvlLVlw+o+JZkbZoqeUf2qYr4C/f9DtQklld
Iai/K27XATVuJSqbJsZdyNvuCkBYCh8QqZ4socdzTQjanKdO5yLhqjzTOHDGQ/zU
ECVbCZETqc21X+bFlkh1HUjewVP1vBhThz/ZFkfnFZBwhG/9RT4IyVQ/9vh+r/Q8
6ccz1rseXOGbucCXuni/jTFrIH5qvuvr3DJCLiOAZZt9e39S7kE5KS3DVCLNP6Cx
SHsVcMn+62IokfKyG30=
=EHEH
-----END PGP SIGNATURE-----

--qJM7dOmrnYWq+SaN--

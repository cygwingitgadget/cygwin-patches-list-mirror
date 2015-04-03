Return-Path: <cygwin-patches-return-8114-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 112656 invoked by alias); 3 Apr 2015 12:17:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112646 invoked by uid 89); 3 Apr 2015 12:17:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 Apr 2015 12:17:10 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 91E0EA8095D; Fri,  3 Apr 2015 14:17:07 +0200 (CEST)
Date: Fri, 03 Apr 2015 12:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Only construct ucontext for SA_SIGINFO signal handlers
Message-ID: <20150403121707.GT13285@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1428003041-14404-1-git-send-email-jon.turney@dronecode.org.uk> <20150403111806.GO13285@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="agiWCrAZ2JOwsdBK"
Content-Disposition: inline
In-Reply-To: <20150403111806.GO13285@calimero.vinschen.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00015.txt.bz2


--agiWCrAZ2JOwsdBK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2553

On Apr  3 13:18, Corinna Vinschen wrote:
> On Apr  2 20:30, Jon TURNEY wrote:
> > 	* exceptions.cc (call_signal_handler): Only bother to construct
> > 	the ucontext for signal handlers with SA_SIGINFO set.
>=20
> Looks good, except...
>=20
> > +      ucontext_t context;
> > +      ucontext_t *thiscontext =3D NULL;
> > +
> > +      /* Only make a context for SA_SIGINFO handlers */
> > +      if (this_sa_flags & SA_SIGINFO)
> > +        {
> > +          context.uc_link =3D 0;
> > +          context.uc_flags =3D 0;
> > +          if (thissi.si_cyg)
> > +            memcpy (&context.uc_mcontext, ((cygwin_exception *)thissi.=
si_cyg)->context(), sizeof(CONTEXT));
> > +          else
> > +            RtlCaptureContext ((CONTEXT *)&context.uc_mcontext);
> > +            /* FIXME: Really this should be the context which the sign=
al interrupted? */
> > +
> > +          /* FIXME: If/when sigaltstack is implemented, this will need=
 to do
> > +             something more complicated */
> > +          context.uc_stack.ss_sp =3D NtCurrentTeb ()->Tib.StackBase;
> > +          context.uc_stack.ss_flags =3D 0;
> > +          if (!NtCurrentTeb ()->DeallocationStack)
> > +            context.uc_stack.ss_size =3D (uintptr_t)NtCurrentTeb ()->T=
ib.StackLimit - (uintptr_t)NtCurrentTeb ()->Tib.StackBase;
> > +          else
> > +            context.uc_stack.ss_size =3D (uintptr_t)NtCurrentTeb ()->D=
eallocationStack - (uintptr_t)NtCurrentTeb ()->Tib.StackBase;
> > +
> > +          thiscontext =3D &context;
> > +        }
>=20
>=20
> >        sigset_t this_oldmask =3D set_process_mask_delta ();
> > -      thiscontext.uc_sigmask =3D this_oldmask;
> > +      context.uc_sigmask =3D this_oldmask;
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> This call to set_process_mask_delta() should occur before constructing
> the context, so that filling in uc_sigmask can be moved into the above
> `'if' branch.
>=20
> On second thought, isn't this slightly wrong anyway?  Shouldn't that be
>=20
>          context.uc_sigmask =3D _my_tls.sigmask;
> 	 context.uc_mcontext.oldmask =3D this_oldmask;

Oh, btw., what about cr2?  Right now, with the above code, it contains
a random value.  It should at least be zero'ed out.  Alternatively:

  context.uc_mcontext.cr2 =3D (thissi.si_signo =3D=3D SIGSEGV
			     || thissi.si_signo =3D=3D SIGBUS)
			    ? (uintptr_t) thissi.si_addr : 0;


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--agiWCrAZ2JOwsdBK
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVHoTDAAoJEPU2Bp2uRE+gT5QP/2x9GTRmfPZfeRijuDlMOEJ1
vsnUOau0JmPXlIvwcf3kgF9ZQ92t3TUUOjUfOg5PepAK6gcBk9Uqzu4LUNz2vL1Q
qLPW9ropWxHe0y7X/GwX6fSodU2gcWR3yRoKhK9xGgGdlTb7SLO2THczGVoH4/FK
dGxLzulcWtxaYXiS43cKOQy7B+EEC1N7BHoiBIflZ+hXqz09YVr4Zl4F8u48wQ9p
GewOLJ/Mpqidf4DIaS0UQEkCR2hldt065b5eUHr672u+Kx9uue+Fr/mQocz3ozok
hAcUPSpAL0vKlitVLoFepjoOM3Umr/cKdX1ZfTIy3lnqAqPcO9y6SDqtE4w3dise
HtPgd8+ULU6CzCOSVKaZc/AbjN7pDGNlgjL0uDjOfx64n9poOtgXEqWY+ewyOJ2Q
QgvlL2i9tCuik+479KyFyHwaLifZAfoKgRTTc/J6dr+fP8q0RLBt0i+sP5CEzKG5
ChN/7nEpWCxNB0Of0SnM+PhHd1V//216UAlHY/FG2HULvNd+7s4s3DzJ3686h1nI
NzwHG8Gt7LUkJWQ4pVtCVAZmVL8VmVCgnj/hoYgXkFSvlTFXBF1yh4iUEO6hBPnT
GrYD6s8UG45oZmFZD7h5zG7o1ZszTUCDUKxsOGC17kdyzMIgiuzvXWXmVgWZGgsv
Jl3EQ8pm6JkVdmKDoMbT
=YG0K
-----END PGP SIGNATURE-----

--agiWCrAZ2JOwsdBK--

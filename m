Return-Path: <cygwin-patches-return-7124-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21932 invoked by alias); 8 Oct 2010 15:22:29 -0000
Received: (qmail 21915 invoked by uid 22791); 8 Oct 2010 15:22:27 -0000
X-SWARE-Spam-Status: No, hits=-0.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,TW_CG,TW_NH,TW_OJ,TW_XP,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from nm15-vm0.bullet.mail.ukl.yahoo.com (HELO nm15-vm0.bullet.mail.ukl.yahoo.com) (217.146.183.252)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Fri, 08 Oct 2010 15:22:23 +0000
Received: from [217.146.183.214] by nm15.bullet.mail.ukl.yahoo.com with NNFMP; 08 Oct 2010 15:22:20 -0000
Received: from [217.146.183.177] by tm7.bullet.mail.ukl.yahoo.com with NNFMP; 08 Oct 2010 15:22:19 -0000
Received: from [127.0.0.1] by omp1018.mail.ukl.yahoo.com with NNFMP; 08 Oct 2010 15:22:19 -0000
Received: (qmail 23858 invoked by uid 60001); 8 Oct 2010 15:22:19 -0000
Message-ID: <163573.23386.qm@web25507.mail.ukl.yahoo.com>
Received: from [57.67.164.37] by web25507.mail.ukl.yahoo.com via HTTP; Fri, 08 Oct 2010 16:22:19 BST
Date: Fri, 08 Oct 2010 15:22:00 -0000
From: Marco Atzeri <marco_atzeri@yahoo.it>
Subject: Re: patch to add C99 complex
To: cygwin-patches@cygwin.com
In-Reply-To: <20101008151733.GA23848@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q4/txt/msg00003.txt.bz2

--- Ven 8/10/10, Christopher Faylor  ha scritto:

> On Fri, Oct 08, 2010 at 12:56:56PM
> +0200, Corinna Vinschen wrote:
> >On Oct=A0 6 08:01, Marco Atzeri wrote:
> >> here is the cygwin follow up of the patch=20
> >> sent to newlib mailing list.
> >>=20
> >> Marco
> >>=20
> >> +=A0 =A0 =A0 =A0 * cygwin.din ( cacos
> cacosf cacosh cacoshf carg cargf=20
> >> +=A0=A0=A0 =A0=A0=A0casin casinf
> casinh casinhf catan catanf catanh catanhf
> >> +=A0=A0=A0 =A0=A0=A0ccos ccosf
> ccosh ccoshf cexp cexpf cimag cimagf clog clogf=20
> >> +=A0=A0=A0 =A0=A0=A0conj conjf
> cpow cpowf cproj cprojf creal crealf=20
> >> +=A0=A0=A0 =A0=A0=A0csin csinf
> csinh csinhf csqrt csqrtf=20
> >> +=A0=A0=A0 =A0=A0=A0ctan ctanf
> ctanh ctanhf): Export new complex math functions=20
> >> +
> >
> >Patch applied.=A0 I also applied the matching patch
> to the documentation
> >and bumped the API version.
> >
> >Thank you!
>=20
> I wanted to second the thanks.=A0 Cygwin has needed this
> for many years.
> I'm very glad that you took up the challenge of getting
> these functions
> into newlib.
>=20
> cgf
>=20

It was in reality much more easy than I was expecting
as netbsd had all ready for importing.

Next week I should add the documentation to complete the work.

Regards
Marco=20



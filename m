Return-Path: <cygwin-patches-return-8084-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119288 invoked by alias); 30 Mar 2015 19:12:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119254 invoked by uid 89); 30 Mar 2015 19:12:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 30 Mar 2015 19:12:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 00BC5A80975; Mon, 30 Mar 2015 21:12:17 +0200 (CEST)
Date: Mon, 30 Mar 2015 19:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Make CONTEXT available to signal handlers
Message-ID: <20150330191217.GB12442@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20150330102129.GH29875@calimero.vinschen.de> <1427736757-13884-1-git-send-email-jon.turney@dronecode.org.uk> <1427736757-13884-3-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <1427736757-13884-3-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00039.txt.bz2


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1176

On Mar 30 18:32, Jon TURNEY wrote:
> +typedef struct ucontext {
> +	mcontext_t	uc_mcontext;
> +} ucontext_t;

I liked that better as before.  Keep in mind that changing, improving
user-space provided structures practically always requires to add
code to account for old and for newly built applications, the ones
which only know the old struct layout, and the new ones knowning the
new layout.

Therefore we should define ucontext_t in a way which does not require
to change it later.  Looking at the Linux definition:

  typedef struct ucontext
  {
    unsigned long int uc_flags;
    struct ucontext *uc_link;
    stack_t uc_stack;
    mcontext_t uc_mcontext;
    __sigset_t uc_sigmask;
    struct _libc_fpstate __fpregs_mem;
  } ucontext_t;

We won't have __fpregs_mem, ever, since it's part of uc_mcontext (see
the comments in sys/ucontext.h) so this can be dropped.  But everything
else we can and should provide.  uc_link might come in handy as well at
one point, who knows?  Just set it to NULL for now.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVGaARAAoJEPU2Bp2uRE+guDIQAJllor3O5Kq5RpPnWoc21vm3
rnNgwbFV7QHbmsdUQutZ0jtIx8ZwEq6Bn6w+bUTQgTbfJ8zXcTjARZs2ynXS4ZVm
r57gv4T22NKgfItfkqrrraFsCglBBPkKm+TL00IwKsEyDjaBojND6nc2sMSl3uin
MvyKi4w42uF6Thxyn/TdqXI90iU2D9A3r+R6ov57TX/pPgyeuce5EodXxWT+UeV8
gkVM/t2D/FW4fZHtA2hNN9BCmlznRWdDFjPqslKUS6Z1vcm7bJ/PCM0rKCBjaq4+
Z0uGiwOsiCHhBRrdtgdgeiAQVZzCP6yCqM6kZ2aQlcC4XwnKlGCY3VGpAsU2Um3D
twSUsBdTh1FuNmaZVXQ3TkP0ZUybtrq3aQBo1Dd4jceGQuX/ZNBbw1QXBvJtacfR
o0K6hrXPPn+IwA6oTHkPGP3fQYlqi5615A9r64wNikqwey5Pn6Edd8vQ0RQrK5ED
nyCZeNKKfJJNPzOiYRYdObWafN8g4ih3KYCezefAwbhyE2AHIE465FqQQ7jE1fZa
L1TB7/TvqDyPjiUa9HRgoG4eeTeYWgF+ojyxkVvDp4mX/3UKLT+JNz9WrIZduRDr
5c+nsrOwlvC0TpOGBB2lmbdKHCLKYvAIJunbf+/nQkc6V6vK5R7xrqNq46QUr/zk
U1+V646oNPy/DMqlN2E7
=9XM+
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--

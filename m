Return-Path: <cygwin-patches-return-8107-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98716 invoked by alias); 1 Apr 2015 17:53:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98704 invoked by uid 89); 1 Apr 2015 17:53:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Apr 2015 17:53:35 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 792EFA8096E; Wed,  1 Apr 2015 19:53:33 +0200 (CEST)
Date: Wed, 01 Apr 2015 17:53:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Provide ucontext to signal handlers
Message-ID: <20150401175333.GA13342@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk> <1427894373-2576-3-git-send-email-jon.turney@dronecode.org.uk> <20150401142219.GY13285@calimero.vinschen.de> <551C2CB7.4@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <551C2CB7.4@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00008.txt.bz2


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1323

On Apr  1 18:36, Jon TURNEY wrote:
> On 01/04/2015 15:22, Corinna Vinschen wrote:
> >On Apr  1 14:19, Jon TURNEY wrote:
> >>Add ucontext.h header, defining ucontext_t and mcontext_t types.
> >>
> >>Provide sigaction sighandlers with a ucontext_t parameter, containing s=
tack and
> >>context information.
> >>
> >>	* include/sys/ucontext.h : New header.
> >>	* include/ucontext.h : Ditto.
> >>	* exceptions.cc (call_signal_handler): Provide ucontext_t
> >>	parameter to signal handler function.
> >
> >Patch is ok with a single change:  Please add a "FIXME?" comment to:
> >
> >   else
> >     RtlCaptureContext();
> >
> >On second thought, calling RtlCaptureContext here is probably wrong.
> >
> >What we really need is the context of the thread when calling
> >call_signal_handler I think.
>=20
> I had the same thought, but this is going to be quite tricky to achieve.
>=20
> This patch depends on the change to newlib to add stack_t, so I will wait
> for that to land before committing this patch.

I ACKed the newlib patch already.  You can simply omit the RTEMS and
Cygwin checks.  Sebastian is right, there's no good reason to guard the
definition like this.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVHDCdAAoJEPU2Bp2uRE+gjV4QAJgEyPxD8MR4tHWFy0p+cu1I
VuaDsx10cAYpokuKaYkV/5/0bVv8C6I5PI2z4CuGuowTBL+c6a7v0ssWHn3IUdGg
eutPtwofolcctwZ1CBhCyluqzw7BG57Fqe8GNTULULJYQCOrgN1VJ5KJyi6oaAq4
GgPijOdaUY6Iy05Zng2+u/16BQB5vZSALOyuVg9xMKciCh3Hp/r9TS7QFDGVq8EH
GRPz5DxelVXym2mQ9gKu2G9pBlERzYMARCWNmOQTYke/kkfsiIp1VlbrflrjJfJM
nlUkXnUg6/A8Erg2Ry0ownfXiYIWv+LfsYX/ARjCRNnc5lj3YB5QEo2s3jnOzIo6
jBPgtfiA9hFP1CcOOlqnptr3lGyYa2CdApcLNqw2ZRkDhjgKn93WeOs0C7jgLS3N
tbjPWCDAXyiYX0LLKsrRQcAN1zEDo+B6WH8YkRrPg5fEq0LYmHrtT+kokN6KSHrL
20UvDqu7Nyqrl2dOPWTDwS+DjQG9zauEZmuR1Axv3ueoFqMNlafYo8FpWPdJRRjW
g+uCvfPzmKfq6e6ZxQR7QbQ4pC2YxQy9JDwgDb8ijDWcBsuQGoQoWiryqYik1da6
7b9mOeE/rXigzZwuqjp54BX1+xJrUvJTp46Yu/PZNwkYNx47//CjoAe7oIHt2EE6
MQ4jKTRG4gHjOMdcJs5k
=sqVb
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

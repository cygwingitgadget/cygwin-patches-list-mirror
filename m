Return-Path: <cygwin-patches-return-8104-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126245 invoked by alias); 1 Apr 2015 14:22:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126233 invoked by uid 89); 1 Apr 2015 14:22:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Apr 2015 14:22:22 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9B22DA8096E; Wed,  1 Apr 2015 16:22:19 +0200 (CEST)
Date: Wed, 01 Apr 2015 14:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Provide ucontext to signal handlers
Message-ID: <20150401142219.GY13285@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk> <1427894373-2576-3-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="czRehjsqUdpaVUeF"
Content-Disposition: inline
In-Reply-To: <1427894373-2576-3-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00005.txt.bz2


--czRehjsqUdpaVUeF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1021

On Apr  1 14:19, Jon TURNEY wrote:
> Add ucontext.h header, defining ucontext_t and mcontext_t types.
>=20
> Provide sigaction sighandlers with a ucontext_t parameter, containing sta=
ck and
> context information.
>=20
> 	* include/sys/ucontext.h : New header.
> 	* include/ucontext.h : Ditto.
> 	* exceptions.cc (call_signal_handler): Provide ucontext_t
> 	parameter to signal handler function.

Patch is ok with a single change:  Please add a "FIXME?" comment to:

  else
    RtlCaptureContext();

On second thought, calling RtlCaptureContext here is probably wrong.

What we really need is the context of the thread when calling
call_signal_handler I think.  It would be better to call RtlCaptureContext
before calling call_signal_handler.  But this requires a change in how
call_signal_handler is called.

We should discuss this at one point, I think.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--czRehjsqUdpaVUeF
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVG/8bAAoJEPU2Bp2uRE+gW2QQAKKlxufBLyIc9dvEpkRewK3B
Gb+QgHADvGfTSvvCuuLgk6Vfwkbid9kQfmyOL7OAjPtBi29yQ9g1SWkS7uZ+cwwt
bw1677btMPOzbppAPIamNOzBjZl4AGqP5hbRs3NKURcRmF+ubHSmFBKD7Yjn11kq
Q/gIeccvuXDsQjO/GJL2pyq1onrvmPf8a2/Y/bFx2oIu5I4GNaTnO2NipawWIES1
Nn9WKdKe8tVkubP0sC3fmFDgccfrMdvndWZXHftNewrvVp/UtR8Ix9ODXPwADs/Q
i1zPfIq5YiKvbYd2u2l25cg334aW7zV1FM3n9bKjkNmfCRsatCfiEYhqDhoSsXY5
qJfpZMdNWFHWtyyVERX3wLk1o249pGfk6gotNCZwUSoQmf/iMXaLrgr7ZZR0jyeb
GKEsfBBRaPkra5ec2KoZYkPy30NYC5vOM/FsnwDG5v9Ksidj2wURf9Pn52WB6ofq
paXTt0MjIR5qZ+nGUeu+iPgpKtujxQ19Jfsdk0szoPb04nSzwBgsD0jOafDAY0Qc
RacphBkioaM6OTjSaCum63ppWfC4hDgQ+i3kh0p6Iq6OQvD0rqY609ckSCksmKgn
WHBUHJJkgsQ1Dr2+k9vyORAaAEsfSAbGBkeSv8dzUHaZnziD12psc/SuByHo0fpz
m5y32N6aMiepouP5Bmn+
=NdEP
-----END PGP SIGNATURE-----

--czRehjsqUdpaVUeF--

Return-Path: <cygwin-patches-return-7914-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15972 invoked by alias); 4 Dec 2013 12:04:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15957 invoked by uid 89); 4 Dec 2013 12:04:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.5 required=5.0 tests=AWL,BAYES_50,RDNS_NONE autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from Unknown (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Dec 2013 12:04:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 589201A0677; Wed,  4 Dec 2013 13:04:08 +0100 (CET)
Date: Wed, 04 Dec 2013 12:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix off-by-one in dup2
Message-ID: <20131204120408.GC29444@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52437121.1070507@redhat.com> <20131204093238.GA28314@calimero.vinschen.de> <20131204113626.GB29444@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
In-Reply-To: <20131204113626.GB29444@calimero.vinschen.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q4/txt/msg00010.txt.bz2


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 963

On Dec  4 12:36, Corinna Vinschen wrote:
> On Dec  4 10:32, Corinna Vinschen wrote:
> > Hi guys,
> > [...etc...]
> > The problem is still present in the current sources.
> > [...]

Ouch, ouch, ouch!  I tested the wrong DLL.  Actually current CVS fixes
this problem.  Duh.  Sorry for the confusion.

One question, though.  Assuming start is =3D=3D size, then the current code
in CVS extends the fd table by only 1.  If that happens often, the
current code would have to call ccalloc/memcpy/cfree a lot.  Wouldn't
it in fact be better to extend always by at least NOFILE_INCR, and to
extend by (1 + start - size) only if start is > size + NOFILE_INCR?
Something like

  size_t extendby =3D (start >=3D size + NOFILE_INCR) ? 1 + start - size : =
NOFILE_INCR;

?

Sorry again.  Fortunately it's my WJM week...


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature
Content-length: 836

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSnxo4AAoJEPU2Bp2uRE+g1iEP/3IJRqt8XxY3xaU/5oDMNyMo
okg4aCXIJuCB3V97g8D6Cv+hCyeGT1yRHxspPNVsU9m4vjp+SY8GlA+yEFR+8oBk
KWx28/gm1q+X1/1bjzJE1wvAwWhwOcSNPlzSN+FfZ/E2eYA/IhRwOy7DgYP7/4bK
UE0SCFPypo0dxrv1lAe5HNTq9IJp1gAzpIE4lC/bPtm8jNasqj6bWDOHlixbeAY5
efIgTFQJoCKt+vztwLFsGEGEKqRVn6oKHzfdtrIcwIjU7FURId+I09Pj5Ul4JBOW
T78TwMPhYuqPJcQeQTClggZt0V4dY+HQJxeNLDC/boK7PMI4/S3Gy6m3mqJMvZER
EVF2U5no89g61SaVFYfbU5RCxnS0nYNZv5MK7ECLg8FEPoKrLsk7JCHkk5He7YOk
ZwNwkNPM5sTV+MhGQMN2sQivw8MEMw51tYWgpE6tv54X4S+3xdWdr87OTRHMy7rE
9/0elSe/eYfXRHLyuGxhlzEJoIW5Fqcsmo/CngFRM4gQDoOgOgqMY4zOU4LEZo6c
oAel28UOK5n3nX+SNs4hlQTxaPBIi/UT9wyE5DeyyblKjY/Zxv4UaQesIPhLEAX+
1HIndie/zr34+qQ09dqnaTsZpzyUfjU7ZkfGoC8TqWkvM0EkZlgjquwTHPnZ/39Q
UQ47RRCWqmqLx4mFhLGI
=o/Eu
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--

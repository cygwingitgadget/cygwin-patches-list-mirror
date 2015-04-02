Return-Path: <cygwin-patches-return-8109-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32877 invoked by alias); 2 Apr 2015 17:01:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32866 invoked by uid 89); 2 Apr 2015 17:01:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Apr 2015 17:01:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BDF66A8096D; Thu,  2 Apr 2015 19:01:39 +0200 (CEST)
Date: Thu, 02 Apr 2015 17:01:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Try to make sure struct _mcontext is 16-byte aligned
Message-ID: <20150402170139.GL13285@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427991886-6156-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="nivyF5ZmfdQ/+RfC"
Content-Disposition: inline
In-Reply-To: <1427991886-6156-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00010.txt.bz2


--nivyF5ZmfdQ/+RfC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 776

On Apr  2 17:24, Jon TURNEY wrote:
> On x86_64, RtlCaptureContext() uses fxsave to save FPU/MMX/SSE state.
>=20
> fxsave requires that the destination address is 16-byte aligned, or it wi=
ll
> fault.
>=20
> CONTEXT is already annotated __attribute__ ((aligned (16))), do the same =
with
> struct _mcontext.
>=20
> Rearrange ucontext_t so that it's struct _mcontext element is also correc=
tly
> aligned.
>=20
> 	* include/cygwin/signal.h (struct __mcontext): 16-byte align.
> 	* include/sys/ucontext.h (ucontext_t): Ditto.

The __attribute__ should follow the "struct" keyword.  With this
change, ok to apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--nivyF5ZmfdQ/+RfC
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVHXXzAAoJEPU2Bp2uRE+gi/IP/1oBaD0ptqVD56jQLE+G3uaj
i9Y1oAQ2+UUt6U8x60ltL0oDJpRwaa1JONRkyH4Vk1vEdP3NrNiejv0nGSvcR0Qd
kXmhrJT7guhrG8M7CkCGz1XFRjoIUVHW0FNIV4zpxDOMgOBfSsdf7+gdnw+sLqYI
x+3DwM9m8I9n/Wrx7JYixbROQ2zWnLIA3OeEEL+jmiJ0JBDFZwUsK1AkagabQRIH
5V4JruRvHRj+qLv0spz8aOvjsjZPLW6mvbIjJJEYJhy2DkczdDrYecJV5CYD6h+Q
ty1DdPcM6x8kRpw14sEEQdpysS2+q3vVhCoJRsaDw6Bd2n2as8EM+naDDuKmYgtL
xbrQHrwpe3O+CH9B/adHhm0ZDw92dlsR3V3wo3cSAdt6VW+HwZHlTYALqbTQayoY
X+1icgntaPpP7IN9lRR4dv0KCREjQPqwF+BA9oQ4cS/MdexrVCN8UHAE3hWadF4B
3C97ai/F5OQEuqLT8VQlPN0edibTHZIxerrBclX+c5BB3PHLnpPhil4DUBxZYd8o
hfAMp8xjqGlM8sqrNme6riGa25LNfa8K2W7p+6DeuhJkw9vWXHBMetQiV3h70vBv
IxWzaaX1E76wiSJYp52Y1SmSStbm+P5T8ccx51rO5cD3DOpVCDZfbpotZ/7nfaFu
XooLet9M8/u5sbgei/W9
=2itU
-----END PGP SIGNATURE-----

--nivyF5ZmfdQ/+RfC--

Return-Path: <cygwin-patches-return-9066-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44787 invoked by alias); 1 Jun 2018 20:00:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 44661 invoked by uid 89); 1 Jun 2018 20:00:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=lot!, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Jun 2018 20:00:37 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LtAB1-1gQolm0f19-012qLd for <cygwin-patches@cygwin.com>; Fri, 01 Jun 2018 22:00:33 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7C01CA81935; Fri,  1 Jun 2018 22:00:32 +0200 (CEST)
Date: Fri, 01 Jun 2018 20:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix declaration of pthread_rwlock_* functions
Message-ID: <20180601200032.GE14289@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cfb6a3b0-57f6-8594-0872-db65d371a997@cornell.edu> <20180601101028.GC14289@calimero.vinschen.de> <eb00138e-d955-1cd6-b105-9d812de06018@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <eb00138e-d955-1cd6-b105-9d812de06018@cornell.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-UI-Out-Filterresults: notjunk:1;V01:K0:RXUshuXMdXs=:gl4mQ+cnZLMvg0C1jQ8uol FJMtAM+6BkQ1CtR5r9/WtlQbAS6N576iGPxRVyauxnaIdMXLwYn1tL+HWR/JmxhwmAhu4q1KV AJ1+Jsy2XnbIJaLc1Ba0DcRlIESaowdpcxSIh5Mj/+sSWDU6CyzlOBjCC62QcuONf9z9gEmqD GQP+EwVeH8bXpUwKH9a3fRugaCLfl6Vy1L4O7zoqlHNzuZu3K9qDTqboPrClKUTaXxXxdShRY FmD4wytDeWxHkAXkKj41VSrk6HIcIAAcf9Zbz5sq/PorxKLzobaKAQ7Sy7yIVwkEWKW3yBMNm DAW5xPWCGUxf3kbECK4kqfgCRztna0nWHnxUklw0a9rwuA+sbQiBDuM7n047lJmMAU61t8ppt ZkIKG7WlIpnpvkR1R39W7dTlXdl4vOEl8lKKUz0CeNSHrY9tJc9oVX3Hsedz38AL9RDC6k4UE zUFz2uNQO0E0LFhxmLz9DJh7888XjqjiPmfyiYX1x+tyn84ghFsBLOoI1OzSLRW2zriCtzWAv E444Mg9NSRJCToXvCUk/YORbC2pNsfjdZmhxMwUpD++P76dVD8NcaTJ/GtOs13EygTnXLLJYS bq/lNRbeWMjnNeMhXW+bqxxbLn6WU5/YOKdqpsM+9cm9trTE5ppSJaymT3Erx6EOJA/K/D3oo MY4AaPyQxao8whH4WPxXF180SnFXOHcTMSjv2bsSgHgEidewJKh5uCAOG7H39fflXyl0=
X-SW-Source: 2018-q2/txt/msg00023.txt.bz2


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 579

On Jun  1 08:33, Ken Brown wrote:
> On 6/1/2018 6:10 AM, Corinna Vinschen wrote:
> > On May 30 16:28, Ken Brown wrote:
> > > The attached patch fixes the second problem reported in
> > > https://cygwin.com/ml/cygwin/2018-05/msg00316.html, though I'm not su=
re it's
> > > the right fix.
> > [...]
> >=20
> > Pushed.  Any text for winsup/cygwin/release/2.10.1, perhaps?
>=20
> Attached.
>=20
> Ken

Thanks a lot!  Pushed.


Corinna


--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlsRpeAACgkQ9TYGna5E
T6CcCg/8D9QqgSwq6PBamT0tmicwWf2xAI709itxUnm9E+TdI2OyeKNbQktDV+W7
HsmJSIEpjOiXdoQglp78RcAKEya7dcikCnjoIb6/krZNLV71bw+KfjW3meg3qrW2
FDL3u0JZAVjOHcQ9kj5TxaJuX1et4gQq7fynev1i+Y9Yi3PkUl0QMw/H8zR2d23B
YtFqIiK02MXTMi1X6jpLkT0uglbQ4aczpa1nXvTzzsTvQ4nTFBTpfEPD6x0vpHW+
a67VkpAxBt1qklGGwgYd3C4CAh/6IeRYZFFjzHhp8isu0ZeLqlwZU44VkmbS4q/M
a6dQzDuorNsy3iHq3CjuiZfNwmxsdge48rxD1sUh6C+9q12+SfX6zWYWWCr7JmXs
FtY/pxkeJB2Z0UnnwfiLdDyRc+h8UNqm0+HDPPmEF/ERNoY7QvTZqYslMp8uBjH9
Md3JJtHsN8GdLRk/UyXoAG3M1PZNm0oMi+C7cwMLy7JTfZ7jtGvsVo3otgxd13/L
ZdZdX0RNwVhmL/dR+pGepNI+M2CHwmXOMWy/7vvvcdx+Ma87atn/K4o+WerC6S10
cx3NW0iOZjY7fZmsSIq6W5/+cKLNZtYv2B78KxyrVJfq0MbULruSAtAqWjkLC58O
570rmi52duC2E5382azVn0rkp6zpDiIIbDj29ZaIiSeCIarvgG4=
=27qG
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--

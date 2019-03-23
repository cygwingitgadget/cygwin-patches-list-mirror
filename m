Return-Path: <cygwin-patches-return-9216-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 45023 invoked by alias); 23 Mar 2019 18:37:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 45001 invoked by uid 89); 23 Mar 2019 18:37:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Gratz, gratz, HX-Languages-Length:398, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 23 Mar 2019 18:36:58 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MBV6n-1hHLVA0zLb-00Cvp8; Sat, 23 Mar 2019 19:36:55 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E11BCA80751; Sat, 23 Mar 2019 19:36:53 +0100 (CET)
Date: Sat, 23 Mar 2019 18:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Achim Gratz <Stromeko@nexgo.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] default ps -W process start time to system boot time when inaccessible, 0, -1
Message-ID: <20190323183653.GB3471@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Achim Gratz <Stromeko@nexgo.de>,	cygwin-patches@cygwin.com
References: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca> <87d0mh5x3u.fsf@Rainer.invalid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <87d0mh5x3u.fsf@Rainer.invalid>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00026.txt.bz2


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 318

On Mar 23 18:17, Achim Gratz wrote:
>=20
> Hi Brian,
>=20
> replacing one lie with another that is less easy to spot doesn't sound
> the right thing to do.  How about ps if reported "N/A" or something to
> that effect instead?

1 Jan 1970 may also be a good hint...


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyWfMUACgkQ9TYGna5E
T6A/AA//a9DKjAECnOuLK+vumvqFqocaNJbg7/x8+/UPcPUfS/s+XX99vg6B60FZ
gqdnb1SRK/JR3pyalKhy8xpRA/zfku68eapypB43mOBi5APq32PcXhOQXTjzO5pL
Jm0Y/eYALtHZfSL4BGexx/N1CADoU9D3dX1ViCpxQ2VV8aUCNfcKHfCs6vuqz7pS
nT82S8n3Otlhen9JUvBthtYytIMWENdpAiT8MoqVIBAPbHcTFAg79QnCv+YPP9Xk
SHMzamtPVsTU9bQd3/TWgHILq6B+RwZoOGpVHLMQLyghGB+a4Mq378rM5fSemspl
ZnVG/i7t/nfSecB3aul3m2bD3ybPHQFqLN0f7XBBStUI/HRSDwiVpNYeoXCgRSd3
LxiCwUDbEALVrdqOoEfWxah8/gfQFYTa32Gkceg0iYh5ZggZY3FHhaj5WOVAG3Ay
aQgKqJs9QojcqHI3asHdpXWgUuWqUPyPDvhqpb1QIEj7EsGnpm9pqcnEyqPPOtqQ
h2fUFzFbB4B1w1gm9XzOSVyeXuK6pqGXSiQNWPztvf3vhdvNx20PbUqK7lnq1RzO
10g0FFyS4SgW8+ndoHcXzw9Giv1ZWMgVm4PqVxq6wv7n3k/YK1H30p/E0xPnvF0N
vJnvdLWw/VGqGzmEe+m8Kdl0ngXGy3C9up2BoCNBVS5bcLj0kTo=
=t/7d
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--

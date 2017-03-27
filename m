Return-Path: <cygwin-patches-return-8728-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20967 invoked by alias); 27 Mar 2017 15:47:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20946 invoked by uid 89); 27 Mar 2017 15:47:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Mar 2017 15:47:16 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 34A91721E280C	for <cygwin-patches@cygwin.com>; Mon, 27 Mar 2017 17:47:15 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 8E86E5E0377	for <cygwin-patches@cygwin.com>; Mon, 27 Mar 2017 17:47:14 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6C160A80695; Mon, 27 Mar 2017 17:47:14 +0200 (CEST)
Date: Mon, 27 Mar 2017 15:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Implement getloadavg() [v3]
Message-ID: <20170327154714.GE8279@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0a1b00e9-229d-a1b4-9e4a-15cc14601713@dronecode.org.uk> <20170327151008.142972-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20170327151008.142972-1-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q1/txt/msg00069.txt.bz2


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 623

On Mar 27 16:10, Jon Turney wrote:
> v2:
> autoload PerfDataHelper functions
> Keep loadavg in shared memory
> Guard loadavg access by a mutex
> Initialize loadavg to the current load
>=20
> v3:
> Shared memory version bump isn't needed if we are only extending it
> Remove unused autoload
> Mark inititalized flags as NO_COPY for correct behaviour in fork child
>=20
> Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
> ---

Looks good, pleae apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2TQCAAoJEPU2Bp2uRE+gTWUP/01pqOerSa4dNmJafbJGFoQ/
DTlJrCl7uQMHM4iRo5xinrvMb4VMLYE2RGcYkGmESXxpeYP4i1qLr1eo/H/R4yRU
dV+tWZTZKSEo0xwaZ0RqFCrRBRU52vuRZKD3IeXsQJBCkSOPNBOX/IpZkJ1W7zwh
sR1w6u3OQf46KK+8ynVPcX3s3ze/BfSBHta1E0df8GAH5yVohUqnEMsifcIEnhLL
2jHvfatwaIDnowNLflIJUDX2eVc00yjKpUbmDMOpD2igFmj/8nfE4wi2v2zJbSaO
W5IeaZCL1XL8G3uYvX7rjsNlzgj+1zARlZpTnliRpVnRHYMYn1xTlABRfzvhry4Q
j7rt1xkP3AtJWWflLzIBG59/s0A0nawglB6aexC9EUztzZO5fDDnfPbhWwYxIKOM
N2SCNE9w+f3kiuTR0hRoeod/prt6YfllzgnANJSAhgpzQw+95CsoKdFIN8oVW9Yo
CL2KQn2lK02nctByCLTdCmZ0/eYTjfcPjZgZAEn1D6R0TOUkNnHaTvfEt9r59b9Z
jXy94rWg2JBqRjR+qa3tfYAj1ZDsU1T8d5jq82RIcC0jpEH1GKeo+2oo81PLRF3B
BHX2cH84seka6DLJHSC4U8/ofI/LNUbLWpMyPT0RYNs5RapYsFhEkgRIQK7ekGgf
JUVw2xcSF4ay2FQopqG6
=hHQ8
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--

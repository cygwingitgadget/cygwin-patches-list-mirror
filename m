Return-Path: <cygwin-patches-return-8315-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 115146 invoked by alias); 13 Feb 2016 15:59:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 115133 invoked by uid 89); 13 Feb 2016 15:59:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=H*F:U*corinna-cygwin, H*R:U*cygwin-patches, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 13 Feb 2016 15:59:37 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 217DBA804DE; Sat, 13 Feb 2016 16:59:35 +0100 (CET)
Date: Sat, 13 Feb 2016 15:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] cygwin: work around GCC 5 preprocessor changes
Message-ID: <20160213155935.GA28726@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56BE4162.3000806@redhat.com> <1455314533-11104-1-git-send-email-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <1455314533-11104-1-git-send-email-yselkowi@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00021.txt.bz2


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 493

On Feb 12 16:02, Yaakov Selkowitz wrote:
> GCC 5 adds #line directives (and hence extra newlines) for macros
> expansions, which confuses cygmagic.  Using the -P flag avoids
> them entirely.
>=20
> https://cygwin.com/ml/cygwin-patches/2016-q1/msg00016.html
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWv1LmAAoJEPU2Bp2uRE+gWoQP/2QzCKaLQLTK7h8C0rooVvUs
f3z29xuMGuVzenu/yfWbP+OQc8cTpcEbgf8qoKcEdE7Eoc6Vgif94+TmH1WafkhL
bpWTcX71xnuvGxzK0+/O35xMvmurJCCrUJGhQsqaoercKhMdS5hx6g6e/1Y23opz
lNQhanuWd6bL2y7TaPv63p4B0ceG1oC0vVYJyE/zADOMDtKBLpDHnZml7rR9QNNG
Gb/6Xuwo1tZf4GjvX9qazaxhI+EhY8BBZ0MIP33THVRt4LN8qGZulxPHCLoHfJv4
aILOXF/vpSvS4QYiB73op8RQs+k5jJ4KdB2Qn4wTccku5AZ2Ibuy/cYcQ5UyW1Jp
J6GOD8b38W2608mIFe8EUqpr7HftLS56BQDCVdQTvQsJej038DmxO7RtbZiY33Az
cDIKcZ4anD3JriBvLfJmel9r14dmOeyA1L5EPEEYb009LzrP6Q2SpMDB5Af256+e
C13scAVFlIYJ2LhaNfrAi3Wly3Yhap5pwlK7UniHHfPzNJJZURvNpZxJYqSx8G+y
QPe4fVgMEZMP11FV0JNReGw7MI/LoGVN0G/ai5zMRN9w/POyPeGxzJUoLc0XkeH7
pyVDwk0+fTv3zKQ8nFpGS26dGNy+Fb6OvTNB6s3hnZaa7tdrXJxXqJ7HgMhzjwbU
tIw6d+v8+vJHo3w1j674
=2cBQ
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

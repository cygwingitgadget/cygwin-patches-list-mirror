Return-Path: <cygwin-patches-return-8105-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126878 invoked by alias); 1 Apr 2015 14:23:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126862 invoked by uid 89); 1 Apr 2015 14:23:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Apr 2015 14:22:58 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 80D9EA8096E; Wed,  1 Apr 2015 16:22:56 +0200 (CEST)
Date: Wed, 01 Apr 2015 14:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Add cygwin_internal() operation to retrieve the EXCEPTION_RECORD from a siginfo_t *
Message-ID: <20150401142256.GZ13285@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk> <1427894373-2576-4-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="IX4edXMD7HczJcpd"
Content-Disposition: inline
In-Reply-To: <1427894373-2576-4-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00006.txt.bz2


--IX4edXMD7HczJcpd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 468

On Apr  1 14:19, Jon TURNEY wrote:
> 	* external.cc (cygwin_internal): Add operation to retrieve a copy
> 	of the EXCEPTION_RECORD from a siginfo_t *.
> 	* include/sys/cygwin.h (cygwin_getinfo_types): Ditto.
> 	* exception.h (cygwin_exception): Add exception_record accessor.

Looks good, please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--IX4edXMD7HczJcpd
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVG/9AAAoJEPU2Bp2uRE+gKQAP/iMs/3uZDof5U1FZfaCZC9A+
XqFzWv1tZS5QZQrij3MGvQDx6UUjD/MrtiC1hJHr/iAlWdsHqlAjNjE92BUcU3wY
vEQvVI/2gxQghaybHzRGuqyI30jHW6e5aBgfosBBxIiIDVyqOmAIEwzuaJE3XEEA
PD8UmJ801yOriolaWsnRCM5nz55Ot/rQf1EraWyaJFumN+hHQu3X1/uGPiE4l4ju
8a8PtbxSVb/8Tu8EgFpXwZLOzjNknU75esG6j8TxvMex+2qc+lWQ3/gMTEoOv/Yw
tauQdhHL5rX4+sD6QeBRI2aWdZMM4JDx/qQy0fUEHXkGzgrbe9FfHT2cUe+uGim+
P4tc57QvHAAMSy2OafXJqBdGreeTYcLZTrQeYm993HAZK6UM4Rcn65UEAnl8SH2g
ry052RxXQKvBKcAc7Gx5Usp5FT2VZaps89b5TdQ3BqTWGs1VqAdLcgv/Mt8iqtq9
r02CHnJODp1IIEiPch1itRn/Kk3OoK+LXzVYmNH7y1voHXmiqdWm0PZgNS0XXp8X
fHPGXHxVATZLZp3ZxXu1PXJHoCWI7kLRppNjGdTXdQuJh+ryf5JSNFQshk60hJd3
skqqYrcaPruAcoqijlTx+zC0kWcQSNejPIebfVMPAnuXeP480x8PNxRvICYeq2Hm
J3QrtoobpWl1JQAZ9Bxo
=yigS
-----END PGP SIGNATURE-----

--IX4edXMD7HczJcpd--

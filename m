Return-Path: <cygwin-patches-return-9839-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 103697 invoked by alias); 13 Nov 2019 08:46:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 103667 invoked by uid 89); 13 Nov 2019 08:46:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.0 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 13 Nov 2019 08:46:25 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N4Qg2-1hnC001noE-011P5V for <cygwin-patches@cygwin.com>; Wed, 13 Nov 2019 09:46:22 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A42BFA809F3; Wed, 13 Nov 2019 09:46:21 +0100 (CET)
Date: Wed, 13 Nov 2019 08:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] regtool: allow /proc/registry{,32,64}/ registry path prefix
Message-ID: <20191113084621.GK3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191110161445.53479-1-Brian.Inglis@SystematicSW.ab.ca> <20191111172859.39062-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="IfhPODtivl1BCmut"
Content-Disposition: inline
In-Reply-To: <20191111172859.39062-1-Brian.Inglis@SystematicSW.ab.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00110.txt.bz2


--IfhPODtivl1BCmut
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 462

Hi Brian,

On Nov 11 10:29, Brian Inglis wrote:
> The user can supply the registry path prefix /proc/registry{,32,64}/ to
> use path completion.

The git commit message does not outline why you're changing the example,

Given that the example doesn't use /proc/registry anyway, what's the
reasoning?  This should either be a patch on its own or at least this
should be mentioned in the commit message.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--IfhPODtivl1BCmut
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3Lwt0ACgkQ9TYGna5E
T6CWAhAAhonPOCV9rm6NVTbRr0yYfZfKUULBow95TP1CsNDRt/j11FiztebSEu7s
uFtomnhvm61BiCNsk9Mlwx07yJmck/P8d2tSMTpFyi+A/l5A+/+yGvKMpm+bBXFp
ZXTysIbkIONclLUqRUo4Fn7ZBApLbpligyj5+Unpm/4cjk/lUGHjpOqk/oCvfHyw
mvuC/1L+6vtGCCSD7bPO93uGtNzeh14RoX4W/vEmFJMn5Xb97niYkwHoD2bxjz2/
cC32da4FqJQduju75mE9IMXnIdotPiUijgjAuUqz2BTUKT1W3XplDBgm50c38wHZ
HFNqQZxyjtbcGPArhfvfqm4px8wsFnwI39ftIN9Mo/f/YUw3Uz7O3UWMq+Anf/Sn
GioFhYoV0hgSsjMteiX1IuHq9g1fT7Us4jF5bNfcIVCiRGcw0Summq/VNWYldNxx
DcayQoxH1sQMn6JcBIl4wmnMqb+K2+4tHhgIwgCvkqhS6kea23jvRb4mX0xXmPMP
jS6zgzS0ayGqiKIdOJssKr+zgD5CG1SHmBmqTFAItJekpfWhUpLB6J9+zTfgS3As
gUiISDuHGZJcRL9VWFeOkWkWvGEi7G2lKYlDYdKVw1Y+Odvr82Ouid+XqB3NIDog
YGEe+VLShu0+gThZerJV+2LZziy2FY3Bp7iX6OC1Qopuk8XM/No=
=/gkS
-----END PGP SIGNATURE-----

--IfhPODtivl1BCmut--

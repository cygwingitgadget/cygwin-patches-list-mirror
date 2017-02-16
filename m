Return-Path: <cygwin-patches-return-8696-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76546 invoked by alias); 16 Feb 2017 20:16:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76455 invoked by uid 89); 16 Feb 2017 20:16:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:321, Haubenwallner, haubenwallner, H*Ad:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 16 Feb 2017 20:15:58 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 3CF44721E280D	for <cygwin-patches@cygwin.com>; Thu, 16 Feb 2017 21:15:54 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id A71C45E023C	for <cygwin-patches@cygwin.com>; Thu, 16 Feb 2017 21:15:53 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 87D41A8068A; Thu, 16 Feb 2017 21:15:53 +0100 (CET)
Date: Thu, 16 Feb 2017 20:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix parallel build for version.cc and winver.o
Message-ID: <20170216201553.GG3889@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170216155740.6817-1-michael.haubenwallner@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Content-Disposition: inline
In-Reply-To: <20170216155740.6817-1-michael.haubenwallner@ssi-schaefer.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00037.txt.bz2


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 297

On Feb 16 16:57, Michael Haubenwallner wrote:
> Creating both version.cc and winver.o at once really should run once only.

Applied.

Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYpgh5AAoJEPU2Bp2uRE+gkFcP/2XRtwGabYAPpRv3/eUQR+cO
u2rHXiCwoLts5iZjLKh0GDMQB95wv/Mhy93/x6M3AxarFuAw6Y4aNJdkUdfwkT3w
/URvk/aD68Q8FryHNzkJhW4EZK7SPhOBDJIw0mBcX+QrrLKvDr1TehHdpv0LKDBt
zqLb3eLKZRce40bb+PFQED5gO6p/1lVjtRUu7t4/V0HitKqOgqeH9JmMzs9j4fJg
ap2MpBKADrIMPGGLqeTjq2m/4hd1vZjxucK9yxZSDbrPvrczBWL9S29ETDTNM9wB
0pGO5HVUqbrjWRzKh2k8CXF18StFuxWGzGKEV3SDEuN+nSTmHCZP93v1gnENV3x3
xwdjNTHq+6oe1KEJflgsvHns8kcDYlGrPVVtuPZZdEKRZ6uLkwmrOdn/Hp4OKDr5
/+1qPPDBu5M7W8gvRYj6IxiJSnyIp9/hgpIlqpbHPVMBMbImM9MoAz2AawJreCKU
uBYUFV0q5qFgUPDt/60sAwriBfRz9tUf/gVKAo2bmlRoN3Jf8y6OukNesM5Nbqwz
l3O5LlKOb1jfUM+Ush9G+UgdxeS8fPsnUkUKignFrp802fTKrGgEFzXoC3isYbCB
+MShG+4fy0Qj2fo2FutKpjDUfmdPySR1GwhALhgqyQOgVZSREp3EQO9LZ0YIDv9Z
RzWZBiwskg/fKUp5bVCf
=onI6
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--

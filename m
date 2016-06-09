Return-Path: <cygwin-patches-return-8577-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61637 invoked by alias); 9 Jun 2016 15:06:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61608 invoked by uid 89); 9 Jun 2016 15:06:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:1168, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, our
X-HELO: calimero.vinschen.de
Received: from ipbcc0227e.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.34.126) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 09 Jun 2016 15:05:59 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 50793A803D5; Thu,  9 Jun 2016 17:05:57 +0200 (CEST)
Date: Thu, 09 Jun 2016 15:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Declaration of crypt
Message-ID: <20160609150557.GA10546@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <b1986513-81eb-39a0-959f-ba9f98521e03@cornell.edu> <20160609090004.GK30368@calimero.vinschen.de> <0479db42-e977-24ae-fc35-407c5067d256@cornell.edu> <20160609123245.GL30368@calimero.vinschen.de> <4a4c8f09-9488-bb0c-7d7b-d2cb21435c2f@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <4a4c8f09-9488-bb0c-7d7b-d2cb21435c2f@cornell.edu>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q2/txt/msg00052.txt.bz2


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1193

On Jun  9 10:07, Ken Brown wrote:
> On 6/9/2016 8:32 AM, Corinna Vinschen wrote:
> > Can you please define crypt, encrypt and setkey explicitely in unistd.h
> > per POSIX, rather than including crypt.h?  This would not only be target
> > independent, it would also be more correct.  As a side effect I will
> > have to come up with a new version of the crypt package, because our
> > crypt.h is using a wrong prototypes for setkey (const is missing).
>=20
> setkey is supposed to be in stdlib.h rather than unistd.h, so I've done
> that.
>=20
> One minor question about encrypt: The Posix prototype has 'char block[64]'
> as the first argument, but Cygwin's crypt.h simply has 'char *block'.
> FreeBSD and glibc also use 'char *block', so I did the same. Or would you
> rather follow Posix here?

As Eric outlined it's the same anyway so let's just stick to char*.

> > Thanks a lot and sorry again,
>=20
> No problem.  Revised patch attached.

Applied, thank you.  I also uploaded a matching new crypt package
(version 1.4-1).


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

iQIcBAEBCAAGBQJXWYXVAAoJEPU2Bp2uRE+gfScP/iB2BAZyYA35p1OE6mLjzaxs
uNS3FJrsB6htp+gGi3vGcy+4JGYYNrDBKOYn3Jctr+XzSdhyMERlF0sEoGV1WjsU
SBpjtJ4PBtzv8kDnBuWOrqgRanhMzSzUgDQhkW2D721u4JhKUMjfP2UbsgIEYF7G
X5RHmQZHOGKryvPL3iMQZ7o5tzxhJGoBhnMwchXPwK3O6BGVM+mRVt9CPucIRg+2
dexgGKwbGdSr1lunlx2D6/OWYvFPYnYM7ZAuEWF4iYW3RACvuBcpd2lV/A4A4Nzw
uVkNB6I/6Pir0otIJA2puvdu+YcKt0RkLgg2XDhJG4zHK8aJn/ISrF6wCJO32TfZ
SIYxLfU+JI1FY7zSx2a+WZlCJAKO9rQaIDFeKjh+7q/7GFN9bvDqnQNTt99suhM7
ad/euEFeqW6kIYh1XO1RgGsB2P7fJN8kKfnJjWkkPy7uqapnf8Eta7kd9Yl7JqnS
nf1I/BwIPRmDLT5uoUpPx0mKb3Gr8/HEGIPt9Oio3Z/rS8+hqva1gXkCUSHd6fAg
+WaowOQ4SoQxmlo2zVulWSQWMOcLedwRaVMmOJ3QimuDQuoc1lQZyU/jKuR6bFYf
CQNUWMz1oQbPqco/zUaF4PScPWv6+49zgA3DPpFFMgp9r3j2ixuYZo6ibqn+tmvG
b5SLzafDkPSseUNG7w29
=5VQK
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

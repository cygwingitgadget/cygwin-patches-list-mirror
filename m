Return-Path: <cygwin-patches-return-8297-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25854 invoked by alias); 11 Feb 2016 13:57:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25843 invoked by uid 89); 11 Feb 2016 13:57:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=neat, glance, unhappy, H*F:U*corinna-cygwin
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 11 Feb 2016 13:57:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BF5AFA80591; Thu, 11 Feb 2016 14:57:46 +0100 (CET)
Date: Thu, 11 Feb 2016 13:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH][RFC] POSIX barrier implementation, take 1
Message-ID: <20160211135746.GA28321@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAKw7uVj5h7TkuN7F5xVEx+C1YAWGqvxZNH=osQ3AG3KsyutXQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <CAKw7uVj5h7TkuN7F5xVEx+C1YAWGqvxZNH=osQ3AG3KsyutXQA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00003.txt.bz2


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 886

Hi V=C3=A1clav,

On Feb 11 14:30, V=C3=A1clav Haisman wrote:
> Hi.
>=20
> I am attaching a patch that adds (or tries to) POSIX barriers
> implementation into Cygwin. I have compiled it but not actually tested
> it, yet. I am dumping it here just in case I get run over by a bus on
> my way home. :)

Uh oh, please don't do that.

I took a quick glance and your code looks pretty well.  Your
introduction of LIKELY/UNLIKELY is a neat step as well.  Shouldn't that
go into some generic header rather than just into thread.cc so we can
use it more librally throughout?

Btw., I wouldn't be unhappy if you'd have a more stern look into the
pthread implementation apart from barriers.  There are probably more
shortcomings...


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWvJNaAAoJEPU2Bp2uRE+gMDIP/iw13qoDcAp7FQwrrFpA5oJy
HYQaHD5YcOSeRBRUy/zD0V7Hbdlr473/fieUeWwv2LE0tFX6Z6cJCyCHm+krNhaY
FCzp7jbvftZ1+751noPWHPhQnI4rJlDA75kKAgUWkUOQt153l4q4trE5yPS72cCU
y7UfGEAMN0KJXP85GkazYxd4YsuoaM8hahWnx6HWurYWOvQ2Nho1dlLvHTcisyff
cZlc5MO+cNCJt8ZbhrXw7pghdjM1SwIOSbXHwytfoaBEf6zgJnm97OX4uv/vD4fk
JvcCnCm4A9Cgyd3TyqXiwtdQxfU0AmZoQ4mL99CzrdK7X42aL1nPMIlJ+mVjWjXv
UrTmq8CAckeCQ91obcZRfZ7RLpGP9tn99E9yy66l8uiSaeOuhaXRBs/raQcjzxQG
qQa4wcgdgb20T73HSYER34/+GvCL4/dkFCxol6IzXZEFBcWH8Hh3Lzc3brEC4xbq
g14aBS47OVhrC7vcd6JL8pbe+oeHH2XxvbSvKgoYdDoYS3usYFSZ6J4iiec+zIoi
WRrA9taZhPLBlQZUcABifQRmsQAyP9JAK960+zbalfTrXaIvxs9KxfPgkt4IbVf5
F19oC1tYJbO0ewzA9ONBas8f8MlrSyNtkfxb71TcjvbESK/q/jHsY1XpkZalv3k3
76170bVgukRNcfGV6WxL
=noR3
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--

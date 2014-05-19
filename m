Return-Path: <cygwin-patches-return-7982-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2990 invoked by alias); 19 May 2014 08:31:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2973 invoked by uid 89); 19 May 2014 08:31:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 19 May 2014 08:31:40 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0385C8E1572; Mon, 19 May 2014 10:31:38 +0200 (CEST)
Date: Mon, 19 May 2014 08:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Buffer over-run fix for getusershell(3)
Message-ID: <20140519083137.GB2357@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5379063B.3000101@tiscali.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <5379063B.3000101@tiscali.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q2/txt/msg00005.txt.bz2


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1534

On May 18 20:12, David Stacey wrote:
> This is the first patch resulting from the Coverity Scan analysis of the
> Cygwin source code. The patch fixes Coverity ID 59932. Note that we don't
> have that many bugs in the Cygwin source code - that's just an ID that
> Coverity assigned to this issue. The patch is only a single line, so it
> falls into our definition of 'trivial'.
>=20
> getusershell(3) returns the next line from the '/etc/shells' file [1]. Th=
is
> contains a path to an executable, so it makes sense for 'buf' to contain
> PATH_MAX characters.
>=20
> Now, the definition of PATH_MAX is the maximum length of the path, includ=
ing
> the null terminator [2]. So the for() loop should copy PATH_MAX-1
> characters, in order to allow for the null terminator.
>=20
> However, by copying PATH_MAX characters, there is a possible buffer over-=
run
> when the null terminator is applied. The patch (attached) corrects this.
>=20
> Change Log:
> 2014-05-18  David Stacey  <...>
>=20
>         * winsup/cygwin/syscalls.cc(getusershell) :
>         Fixed theoretical buffer overrun of 'buf' that would occur if
>         /etc/shells contained a line longer than 4095 characters.

Thanks, patch applied.  Just your ChangeLog needs a bit of work.  The
Cygwin dir has its own ChangeLog file so the path should be relative to
that:

	* syscalls.cc (getusershell): ...


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTecFpAAoJEPU2Bp2uRE+gJEkP/1l9qlZNY34/cBykPGM5m7i5
B2IPFv4gij3V5/DZgAkaizKdQO/Zkq3rLcCULsS9JlNiKRNHPi8WuC7uXeh4HgZO
1oGPfCGAQnWOOKM8Mq4uccXH0EQlDW3KBcYiE7xJoy/ZnOhvu31JB5F6yGPOfktN
13do1otNklCEZvceLetrbICdFUo3fZ3xpZJOZ1ytFlGWKUsuZt6UGlOMCmsNB6cb
ZbupoICZW8k9K2Kgt3iMmeePI4++whUDtIDnz2RhPraSBYKsEatgN6iLUFMfIJCM
m8X+EdCpRL0dlN16BQa1IONex6QHnRqJ/mvlVjPsdOv2Qy2/jFqip61CeBj6HPi5
vu+Qu8pOTZQA49+JbHRxk24VtKLdCyMyPecd9E2HNl6a70LF863EmqLssgrJ6ClP
aWQ9zYBWX9jHrwFGCY2FLUAVPgP4AxWfMp1bph36Rkw4mCUmygMS2wI74lqQYux6
QHtXkN20QYXYMHBNRswtT03pWnfgPyZ8aUgowQ6k4ygILnTA6tChqZA3MHS3A6Yu
tpkFm464hp8cTsk94FdcJp/+GYu2u9BOLs7XIUVetHnRDiKq7udgSmU1Cjix3UdY
XO6elwJwYxPnSqLlOZdqltbNxDPX+e29tT6XAmj8SGgajlzAzDYyHmiK5xLG6K2b
WaVe+ZscEdlM3rV4Mv5m
=RewF
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

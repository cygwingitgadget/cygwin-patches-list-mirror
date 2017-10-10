Return-Path: <cygwin-patches-return-8880-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100744 invoked by alias); 10 Oct 2017 14:02:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100728 invoked by uid 89); 10 Oct 2017 14:02:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:869, H*R:D*cygwin.com, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Oct 2017 14:02:47 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id B9D1E7193905C	for <cygwin-patches@cygwin.com>; Tue, 10 Oct 2017 16:02:44 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 09CAF5E038D	for <cygwin-patches@cygwin.com>; Tue, 10 Oct 2017 16:02:44 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E8035A80C9D; Tue, 10 Oct 2017 16:02:43 +0200 (CEST)
Date: Tue, 10 Oct 2017 14:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: fix potential buffer overflow in fork
Message-ID: <20171010140243.GE30630@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1b4e1413-fa59-a954-f839-507abce7df11@ssi-schaefer.com> <20171010114832.GB30630@calimero.vinschen.de> <e6eb270a-1819-007c-d98e-c4f79177b3f7@ssi-schaefer.com> <20171010124436.GD30630@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline
In-Reply-To: <20171010124436.GD30630@calimero.vinschen.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00010.txt.bz2


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 854

On Oct 10 14:44, Corinna Vinschen wrote:
> On Oct 10 14:26, Michael Haubenwallner wrote:
> > But wait, what's the difference between syscall_printf and system_print=
f?
>=20
> Prefixing with timestamps and stuff.

No, wait.  I mixed that up with small_printf.  syscall_printf is printed
in an strace only, while system_printf is printed on the console, too.

I'm not sure what the intention here is, except to distinguish the cases
where frok::error() isn't called when failing, two cases with error()
only called in an `#ifdef DEBUGGING'.

[...time passes...]

Ah, I understand the first case in frok::parent, just not the second one.
But, anyway, let's stick to it.

Patch pushed as is.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ3NMDAAoJEPU2Bp2uRE+gTg4P/10SNuXT2bV/5cClG/jAm3Gi
6nZly5dXF+7cNOayh40hC4QwuTCkby4FgUNn93OsYiktoVaj64XFQbjFTnaAUb9R
X431Qt4NBpNXUzcqxHEilBmST/D4+SgLLkB+v9KwlvxScvB2f03qgNcVNyarXYmw
Yqr+LfcihD7PV2ZqYdAdNF7CbSaJ+s3nOUtm2fvnzhDv64+XrboK8uRD35tPqDhV
AMhYCMkrLklJNBcHD+NG1sdfXJXYeWPQcm9xsXSp2IyimoqBdRCNEBFUAo+WmEDi
mltx7pdi5aI6M+bN0A2j1DboIwqVMXFl9ZGrrh9nhmsozKVafgzhfTMcWpVKBIWs
oJFiofPoWn77wn4rYU2G8f5acUfDxF/cSrr+5AV+gxo5CGMvTn5Ta3rGpwEEfSJR
PV9YjxNwaOghcByw0fdQkIWrEatGIGqf6a6vGORhp3rgb4Po+tyNsWIBudUA/9Dk
yrbrSw3gKR49I82lvUvjNjS0UN60NUM+vPBxgcLn8zTJgth9HrGydOJ1nWZUyBvL
afKqXUVe+cVnW2VUmyMTthAyODIs24b+CLYVl+AXxBm2VadL01et9k+LoBy+VovQ
FJaFcZGtPmoQEDZhu09A8psI4vDgmiIPwdWhQ1BsnHU6NumZYk8hW1m9dWx6JDKK
ijF43vvVJRQFcBU1YGNJ
=JhkV
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--

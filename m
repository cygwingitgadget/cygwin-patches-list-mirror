Return-Path: <cygwin-patches-return-8977-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14024 invoked by alias); 18 Dec 2017 18:49:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14011 invoked by uid 89); 18 Dec 2017 18:49:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-103.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,URIBL_BLACK autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 18 Dec 2017 18:49:57 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 3A3B472106C24	for <cygwin-patches@cygwin.com>; Mon, 18 Dec 2017 19:49:55 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id EDA795E0389	for <cygwin-patches@cygwin.com>; Mon, 18 Dec 2017 19:49:54 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6812AA805AA; Mon, 18 Dec 2017 19:49:55 +0100 (CET)
Date: Mon, 18 Dec 2017 18:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Implement sigtimedwait (revised)
Message-ID: <20171218184955.GD11285@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171215010555.2500-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <20171215010555.2500-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00107.txt.bz2


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 733

On Dec 14 17:05, Mark Geisert wrote:
> Abstract out common code from sigwait/sigwaitinfo/sigtimedwait to impleme=
nt the latter.
> ---
>  winsup/cygwin/common.din               |  1 +
>  winsup/cygwin/include/cygwin/version.h |  3 ++-
>  winsup/cygwin/signal.cc                | 36 ++++++++++++++++++++++++++++=
++++--
>  winsup/cygwin/thread.cc                |  2 +-
>  winsup/doc/posix.xml                   |  2 +-
>  5 files changed, 39 insertions(+), 5 deletions(-)

Patch pushed.  I added a small change on top, converting sigwait_common
to an inline function.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaOA3TAAoJEPU2Bp2uRE+gSp4P/RFOae8USMVnhjJGA0LpZn2E
glqd0jIW9P4tpYTdr1Thx4eVMQT8+O62ztXywPJCGn8JaqqjiUakghABpbuMn+eM
UqqFjSIshndX6BC4vQF0P3ohXGl4jp8gWkOjiLeszoZoipARrU8fg7dLwxy6/aCO
4tFN4dE+mOFzkHPKEjBwQKISl5Tgyo/hDQEOc3Fxi80gkW3cgA1+4lp1XOXhD55o
DYHWqSCKKKgdWnprsOs+3YydgTrod7m1S8k4AhnjERLnn2OryHcBkEXXrNvZh140
5AYdCMOJgSoUPkISpRTeCs8mX90U8XTQBjejQjsXvbD2GCYvZqJqhRiDbzCgsQph
9VtY5w1tGb4pCHc8ruWARCgMFsbvzHcddilimhD8EfCT/5Gj7jp09cn3xWIatiUZ
HuJwaYAGQZwfV43GzrjDjK/rHrEliSk/yBuxa7+djBE2bVr2fd8wd1Hkd58t0J1e
Q0v9lnWcGEwhriKhXkuJw4aShgrEzET3O23Drr6mtlYOFuit/B4P+EZFfcU1xqyN
pWvXWAXkLUu0NA2DEJqM6HrJMj9CcbIzaPymxzqRGfamRKP9hRfrEYMxpfE2LEv8
KGXUCYMuKoW8AWxDZKS8SZUqFJ7nZMp1Mw8HYijc77zkep16WHJkuU3ipD5rgVxr
mnIeCVgR8sNOM//LAy1C
=WHmx
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--

Return-Path: <cygwin-patches-return-8486-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98160 invoked by alias); 23 Mar 2016 10:43:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98016 invoked by uid 89); 23 Mar 2016 10:43:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 23 Mar 2016 10:43:38 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AB4E0A80643; Wed, 23 Mar 2016 11:43:36 +0100 (CET)
Date: Wed, 23 Mar 2016 10:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Use DnsFree instead of deprecated DnsRecordListFree
Message-ID: <20160323104336.GP14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-2-git-send-email-pefoley2@pefoley.com> <20160321192450.GD14892@calimero.vinschen.de> <CAOFdcFP=cJyuiB=dPEqa2XpFV5jmVoepwr0CQ1=2R0j9bA-CHA@mail.gmail.com> <20160321195244.GJ14892@calimero.vinschen.de> <CAOFdcFMbLNOXCNcMYexqqUWa5GS4CyiSgrcjPHuUr7dnnR_ifg@mail.gmail.com> <20160321203437.GN14892@calimero.vinschen.de> <1458592885-15394-1-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="eAnxKwVhzStH6fSc"
Content-Disposition: inline
In-Reply-To: <1458592885-15394-1-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00192.txt.bz2


--eAnxKwVhzStH6fSc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 694

On Mar 21 16:41, Peter Foley wrote:
> The latest version of the mingw headers have been updated to make
> DnsRecordListFree an alias of DnsFree when targeting Windows XP or later.
> Use DnsFree directly, avoiding the wrapper function.
>=20
> /home/peter/cross/src/cygwin/winsup/cygwin/libc/minires-os-if.c:289:
> undefined reference to `DnsFree'
>=20
> winsup/cygwin/ChangeLog
> autoload.cc: Load DnsFree rather then DnsRecordListFree
> libc/minires-os-if.cc (cygwin_query): Use DnsFree rather then DnsRecordLi=
stFree

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--eAnxKwVhzStH6fSc
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8nNYAAoJEPU2Bp2uRE+g8l4P/j8C6y0Ey1+D7eOaaGcBWfna
fLJG3DNHLuP7qqVsvKT04NBshHntI+SISiLE4xlRbn9sxwkuH+6w6I+2UPeGodJU
x0SdbRB7CHhpgOwMMhYOkQbWDwBxTW1LzieRCdveO/Srk4wAv2BAv5jvVZtNaESN
todTUWt6JLBHav2/1QuwLMKyaYz4UH4dhvuTaBLUolkpN2jjLxAYnuCDqcbobxX4
ZppAlyxCl5WI0LONj1mDsrtL7bxvqzDJB1+nIeHnwUuxczgbZBQ2hNUCkWe/tobn
3s9S///2xH6qEqTx1tIqMSYax2bC9vFVRFYeepucIgC9EkoQRH0K3g8RUTeUWKlo
aM40cXqzM9Ej4g9WXlbWlhGY9C6DjosJLjDXwS1gzmUn/WjKM8B561a4GVTES+tb
RT5dCbvM5OiGKpFPcOu1H1b9LxcbiYjpRH55MUSbDNeHJ1YRctzOFhjtY2b7J5KY
jlKB/QATIhOqAUXNT91U620G+mT44e2Oc648Dr33qRPeCcWo+K92+Jdsy5A1WOUR
/GgmDwwAhGGLmXC0n8JjkuT+WYqvQ62fnJvvFuAKnkaqwYgMj9RfWBuHRLp0cs+D
Jz6hDApSoPgBEQHGq4xDOFKJncu5aEe3tXLNHOpUJhd8WjbukzftwkAxROsOXLnb
bKq5hcKYht+7S64GAXpP
=3x1u
-----END PGP SIGNATURE-----

--eAnxKwVhzStH6fSc--

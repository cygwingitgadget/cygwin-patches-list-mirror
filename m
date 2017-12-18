Return-Path: <cygwin-patches-return-8972-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15763 invoked by alias); 18 Dec 2017 09:17:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14923 invoked by uid 89); 18 Dec 2017 09:17:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-104.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Abstract, UD:xml, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 18 Dec 2017 09:17:04 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 6CA1C71B18950	for <cygwin-patches@cygwin.com>; Mon, 18 Dec 2017 10:17:00 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id EC8A35E0498	for <cygwin-patches@cygwin.com>; Mon, 18 Dec 2017 10:16:59 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 51E3DA80593; Mon, 18 Dec 2017 10:17:00 +0100 (CET)
Date: Mon, 18 Dec 2017 09:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Implement sigtimedwait (revised)
Message-ID: <20171218091700.GA11071@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171215010555.2500-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20171215010555.2500-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00102.txt.bz2


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 829

Hi Mark,

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

as I wrote on Friday, the patch looks good to me.  I just need a
contributors license agreement from you per the "Before you get started"
section on https://cygwin.com/contrib.html


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaN4eMAAoJEPU2Bp2uRE+gl8kP/RQk056wRgG98nHje8Tb1zek
eZp4UT1QFj8KYXyT9jLhq16/zDO076Qh3/uaj3tKJV2NJ1VIAMTMHf7iYLYNE3HP
4ZMc0hsCNWZP6WUD1Z0T1KXlElhmRTjWNCFmHS9wJ1E2RG4sqZBhs7W7HQJh68ah
1X/YX3BfSDn4gAxayU0z8tTFq7rvKo64q5NmAhjZtbTprIK3rhYqhBh5EhahH7IN
8f8KCfwY4RNkspXej7A0l/HKxSleXS2JF6vbcuQ9DfFOT1m4BU345P76JZ/RpCKh
qjQD9TQhhbWDUMzCEXC9AbW8yuKd8s75tpau44bH/sbRE2tvk/jn7kxEBXy2jkcU
xHmL9tejuN2HDGWK+yfrmLD8whypcEf8E0Wou6f//ayCtoFLTqrDM+AXgN/HDc8z
GZwsBv3ssVslIvB4enG4tTma9xfLugeJM9v16H4zpqragR+ynYNwpx/QLPeRx4xi
qgJrQ65DQU+gAiJaHh5Kv4syXjkXaINefsnP+DpKRLEwYe/MN5zbHO9Ru0JsSqot
rQZwMsV2e+vYm20KAlkn/GZHVADvbJGYBbr/xnHDjTeegk6ewLTF8qX1r+MW+RAO
3yTJmSRjLBJXKrw0OjBUAWDPoONmRtrVNzIlU7rpQqc39BfLodK1iKEIIo4CkfP+
vjKu+aliDoyKvLNRQWPo
=kdPt
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

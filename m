Return-Path: <cygwin-patches-return-8968-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 60612 invoked by alias); 14 Dec 2017 13:03:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 60601 invoked by uid 89); 14 Dec 2017 13:03:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-122.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1657, eyes, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 14 Dec 2017 13:03:52 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id BD32E721E280C	for <cygwin-patches@cygwin.com>; Thu, 14 Dec 2017 14:03:48 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 6ECE45E0378	for <cygwin-patches@cygwin.com>; Thu, 14 Dec 2017 14:03:48 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B7AD2A8185E; Thu, 14 Dec 2017 14:03:48 +0100 (CET)
Date: Thu, 14 Dec 2017 13:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Implement sigtimedwait
Message-ID: <20171214130348.GA24531@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171214065430.4500-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20171214065430.4500-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00098.txt.bz2


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1754

Hi Mark,

Thanks for sigtimedwait!  Two questions:

On Dec 13 22:54, Mark Geisert wrote:
> diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
> index 69c5e2aad..0599d8a3e 100644
> --- a/winsup/cygwin/signal.cc
> +++ b/winsup/cygwin/signal.cc
> [...]
> +	}
> +      cwaittime.QuadPart =3D (LONGLONG) timeout->tv_sec * NSPERSEC
> +                          + ((LONGLONG) timeout->tv_nsec + 99LL) / 100LL;
> +    }
> +
> +  return sigwait_common (set, info, timeout ? &cwaittime : cw_infinite);

Would you mind to change the name of cwaittime to waittime throughout?
The leading "cw" actually puzzeled me for a while since I misinterpreted
it as one of the cw_* constants.  No idea if it's just my bad eyes, but
dropping the leading c might raise readability a bit.

> +static int
> +sigwait_common (const sigset_t *set, siginfo_t *info, PLARGE_INTEGER cwa=
ittime)
>  {
>    int res =3D -1;
>=20=20
> @@ -602,7 +630,7 @@ sigwaitinfo (const sigset_t *set, siginfo_t *info)
>        set_signal_mask (_my_tls.sigwait_mask, *set);
>        sig_dispatch_pending (true);
>=20=20
> -      switch (cygwait (NULL, cw_infinite, cw_sig_eintr | cw_cancel | cw_=
cancel_self))
> +      switch (cygwait (NULL, cwaittime, cw_sig_eintr | cw_cancel | cw_ca=
ncel_self))
>  	{
>  	case WAIT_SIGNALED:
>  	  if (!sigismember (set, _my_tls.infodata.si_signo))

What I'm missing here is the handling of WAIT_TIMEOUT.  In this case,
the default case currently tries to set errno, but no error actually
occured in cygwait, just a timeout.  However, WAIT_TIMEOUT should
explicitely set errno to EAGAIN.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaMna0AAoJEPU2Bp2uRE+gSD8P/28SEVTBrHDmnUu70O8rzkqa
CcYTwri6aBJxEiR28l4qxk12nMghXEBX+v2TDu4k2+fzDdeQDWD9BnSesnxErhd/
48HAcfd2JKyHSevYNDxLO/UndcMpdLxGnMOzhzl1NROYWA8BmSctV2fPJ94NeRFm
kokIIydrSzzTI//L7G8/ZILkstWYngls4areuHMgqXu/WiFMfIy29k+ewXclQR+4
JW3w883/lRrNAjVOFCnrWnPOqDcq9kwKyOwC6q7/TSpkL68Ij6Sl7XK1PtBSs4dC
H5vbP9vSUwbSl2rZAQOj5gF+4vF4pjTTbuXLABbK7IhwgYlIinwgGMdNerAI+pMp
4m//muwSbsaFUyQcyaJ3/dTofCh5qCdS07HoB3sa7H4DVFYTo5/iWQ7xF4ZxNcZS
c38dhiG5wIn6RFTLtaocWE66NoRAMmLhawNDfOAj+yNxEy9SNImeefBseCPTT1rF
mxC3MFQskvDFKS0hPGf6V9BJwwGr5Z9mgjoExHqXd37fZBVbqsqps1tGwH6xFlQ9
GOjbOcrSgR+8CqZGoh+BtvaWl9THCRzQ+MRsCXHjabpHcEKl4qZoOwO04S/Seuyq
sgxSauft3Hwn0Vd6BCpx43IqysDDuPRihLjkRM4jk3B7FTNmgR3MD61pfChhPEpz
BzSXiNEHy0o7D9ycGrOj
=crog
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

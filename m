Return-Path: <cygwin-patches-return-8409-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 106916 invoked by alias); 15 Mar 2016 13:47:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 106905 invoked by uid 89); 15 Mar 2016 13:47:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-93.9 required=5.0 tests=BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=consistently, H*R:U*cygwin-patches, HX-Envelope-From:sk:corinna, ssp
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 15 Mar 2016 13:47:19 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 62717A80685; Tue, 15 Mar 2016 14:47:17 +0100 (CET)
Date: Tue, 15 Mar 2016 13:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Attempt to fix Coverity issues in ssp
Message-ID: <20160315134717.GD4177@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458047571-10808-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <1458047571-10808-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00115.txt.bz2


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 458

On Mar 15 13:12, Jon Turney wrote:
> 	* ssp.c (lookup_thread_id): Consistently check if tix is a null
> 	pointer.
> 	(run_program): Annotate that STATUS_BREAKPOINT falls-through to
> 	STATUS_SINGLE_STEP case.
> 	(main): Guard against high_pc-low_pc overflow and malloc failure.

Thanks, please apply.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW6BJlAAoJEPU2Bp2uRE+gsqcQAJCozpotvRlu2vFSD0548qKJ
gvj3+PdjJoD5/NmyXcaT6ZacXQvNV+aJnpl8h3GrjbDA949yuRsoRORWGmP/oBvH
OnjWDfiGTP+Jq+NUQZ4GcjVeJnLIz4FeKctRlSxwO8Im/Yw3DBTxiQ1LBQZ5T6XM
ZD9N4c34b+dpu6GuV8ljHC/4mXfPCum+U6ZJXRvB4CjRkEVTs4srsnzcGtXgQ+H8
gpuQREOkW0/aKoocnZwnDQO66WBc3rG6RmL4feBIgEckFX3qH/9437wqIWTp9Ea0
uSXAiDcqNd6woCdTD/0H1skskW5ZSsfuicjncqP/uW6tTkuH1sRskxByjvqmghEq
ztVyHC3rjYLLO73tdg3hk3PpyoZSH3ahPwES7SvdUEcGZnLqNxD/4jTrCpBu5emY
vQbwTVpFfqDY9+ehVYe3sIbPn+RRJArZBkTImVlh+R88nIXbpWrjnPrqPoEGha2h
UzvEWUW/KFkP8zNhMzhK8VjJAFkzSzl75/oQJa3H5QmON4c9NYD59lw/S3rQzDGl
9JK9Ygq572TYUY3gB0Kx1DI/1a7WX5bF/CR+qISUKaHhA6r5PI8ytVE+AcU7y0ds
CG+Qr9MOgUDDVPNy2PlQqoAJnRRNclS2w74YUfwKpf0P1IdqVpBL1JTcGitUC4DL
Sy4SpL1FcHI1CCSSMOe0
=Gv6k
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--

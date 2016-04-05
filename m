Return-Path: <cygwin-patches-return-8551-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61000 invoked by alias); 5 Apr 2016 08:32:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 60557 invoked by uid 89); 5 Apr 2016 08:32:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Apr 2016 08:32:23 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C7088A80623; Tue,  5 Apr 2016 10:32:20 +0200 (CEST)
Date: Tue, 05 Apr 2016 08:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Refactor to avoid nonnull checks on "this" pointer.
Message-ID: <20160405083220.GA31359@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459611378-25476-1-git-send-email-pefoley2@pefoley.com> <20160404145242.GC13238@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20160404145242.GC13238@calimero.vinschen.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q2/txt/msg00026.txt.bz2


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2392

On Apr  4 16:52, Corinna Vinschen wrote:
> On Apr  2 11:36, Peter Foley wrote:
> > G++ 6.0 asserts that the "this" pointer is non-null for member
> > functions.
> > Refactor methods that check if "this" is non-null to resolve this.
> >=20
> > winsup/cygwin/ChangeLog:
> > external.cc (cygwin_internal): Check for a null pinfo before calling
> > cmdline.
> > fhandler_dsp.cc (Audio::blockSize): Make static.
> > fhandler_dsp.cc (Audio_in): add default_buf_info.
> > fhandler_dsp.cc (Audio_out): Ditto.
> > fhandler_dsp.cc (Audio_out::buf_info): Refactor method to call
> > default_buf_info if dev_ is null.
> > fhandler_dsp.cc (Audio_in::buf_info): Ditto.
> > fhandler_dsp.cc (fhandler_dev_dsp::_ioctl): Call Audio_out::default_buf=
_info if audio_out_ is null.
> > fhandler_dsp.cc (fhandler_dev_dsp::_ioctl): Call Audio_in::default_buf_=
info if audio_in_ is null.
> > fhandler_process.cc (format_process_fd): Check if pinfo is null.
> > fhandler_process.cc (format_process_root): Ditto.
> > fhandler_process.cc (format_process_cwd): Ditto.
> > fhandler_process.cc (format_process_cmdline): Ditto.
> > signal.cc (tty_min::kill_pgrp): Ditto.
> > signal.cc (_pinfo::kill0): Ditto.
> > sigproc.cc (pid_exists): Ditto.
> > sigproc.cc (remove_proc): Ditto.
> > times.cc (clock_gettime): Ditto.
> > times.cc (clock_getcpuclockid): Ditto.
> > path.cc (cwdstuff::override_win32_cwd): Check if old_cwd is null.
> > path.cc (fcwd_access_t::Free): Factor null check of "this" out to
> > caller(s).
> > pinfo.cc (_pinfo::exists): Ditto.
> > pinfo.cc (_pinfo::fd): Ditto.
> > pinfo.cc (_pinfo::fds): Ditto.
> > pinfo.cc (_pinfo::root): Ditto.
> > pinfo.cc (_pinfo::cwd): Ditto.
> > pinfo.cc (_pinfo::cmdline): Ditto.
> > signal.cc (_pinfo::kill): Ditto.
> > pinfo.cc (_pinfo::commune_request): remove non-null check on "this", as
> > this method is only called from pinfo.cc after null checks
> > pinfo.cc (_pinfo::pipe_fhandler): remove non-null check on "this", as
> > this method is only called from pipe.cc (fhandler_pipe::open) after a n=
ull check.
>=20
> Patch applied.

And reverted.  This patch is the culprit for the problem reported in
https://cygwin.com/ml/cygwin/2016-04/msg00085.html

Can you please take another look, Peter?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXA3gUAAoJEPU2Bp2uRE+gDpAP/27YT9fTuMdo955LRbpRw3B+
Ok6/fmlB7P8qcLGe5UjdEpaW1bqfnVfwcBoQ0MOOWur78FxRrnI496de+Denf7ZV
GKFiMgVBjj9T2g18nKoEL+3BEaKr8C4QffC22Ax4PlQ88gW8rdJ4aywCB8z0RzHi
Ft9zz+O9FPdcT+Kxz74QARzJN+/uR7wQ1KuMEf+zC+3SFwdV3htKhLYLqXtyHgGH
gX1RqfOS/BgNrs3zx/lQ/8FiBgIjbuSgRbVkIKc+GHLlZlXPyRc4sN3v0YdQGnYV
+KAmJ/U4np+mBV7sHkADEmGELSjNsNqx4TNUu3E94f4+eCWtkyEgHmHRcFDAkfG5
pmP3AAnpBdTUUxdooJBI/Y+XU0yaCv+EpIHFvALyFOoI2dJuBA59osYuk3NgyT7n
dkptZXwoIrnXRaUaYV69MGuymo12Kh/AZtiFatgjyjDAaTXutFKGm9RlHK1i4mMP
OcjHk5xe8aq1wnBr/w0LlNdDXioN97OlvhFr1yocM3u4M9W5m8SFu1sat/Zd8gu8
1HgwTaUla86uXsFBM17b4+oIXl5ba3HOoFg0cN7Wwr6v0I4lLhwRi7SykaAOQ2Pl
1h+o3hIUXF6cUNnKYA0fwkYBi/bngKmHZe6gvAICS2LTW1JJfVsRGCcG+uoX6iLF
g+CGqpZMUUGMmbxM3h7p
=KDMW
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

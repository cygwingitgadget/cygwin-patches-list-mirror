Return-Path: <cygwin-patches-return-8550-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21810 invoked by alias); 4 Apr 2016 14:52:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21800 invoked by uid 89); 4 Apr 2016 14:52:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 04 Apr 2016 14:52:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D02E3A80604; Mon,  4 Apr 2016 16:52:42 +0200 (CEST)
Date: Mon, 04 Apr 2016 14:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Refactor to avoid nonnull checks on "this" pointer.
Message-ID: <20160404145242.GC13238@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459611378-25476-1-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <1459611378-25476-1-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q2/txt/msg00025.txt.bz2


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2102

On Apr  2 11:36, Peter Foley wrote:
> G++ 6.0 asserts that the "this" pointer is non-null for member
> functions.
> Refactor methods that check if "this" is non-null to resolve this.
>=20
> winsup/cygwin/ChangeLog:
> external.cc (cygwin_internal): Check for a null pinfo before calling
> cmdline.
> fhandler_dsp.cc (Audio::blockSize): Make static.
> fhandler_dsp.cc (Audio_in): add default_buf_info.
> fhandler_dsp.cc (Audio_out): Ditto.
> fhandler_dsp.cc (Audio_out::buf_info): Refactor method to call
> default_buf_info if dev_ is null.
> fhandler_dsp.cc (Audio_in::buf_info): Ditto.
> fhandler_dsp.cc (fhandler_dev_dsp::_ioctl): Call Audio_out::default_buf_i=
nfo if audio_out_ is null.
> fhandler_dsp.cc (fhandler_dev_dsp::_ioctl): Call Audio_in::default_buf_in=
fo if audio_in_ is null.
> fhandler_process.cc (format_process_fd): Check if pinfo is null.
> fhandler_process.cc (format_process_root): Ditto.
> fhandler_process.cc (format_process_cwd): Ditto.
> fhandler_process.cc (format_process_cmdline): Ditto.
> signal.cc (tty_min::kill_pgrp): Ditto.
> signal.cc (_pinfo::kill0): Ditto.
> sigproc.cc (pid_exists): Ditto.
> sigproc.cc (remove_proc): Ditto.
> times.cc (clock_gettime): Ditto.
> times.cc (clock_getcpuclockid): Ditto.
> path.cc (cwdstuff::override_win32_cwd): Check if old_cwd is null.
> path.cc (fcwd_access_t::Free): Factor null check of "this" out to
> caller(s).
> pinfo.cc (_pinfo::exists): Ditto.
> pinfo.cc (_pinfo::fd): Ditto.
> pinfo.cc (_pinfo::fds): Ditto.
> pinfo.cc (_pinfo::root): Ditto.
> pinfo.cc (_pinfo::cwd): Ditto.
> pinfo.cc (_pinfo::cmdline): Ditto.
> signal.cc (_pinfo::kill): Ditto.
> pinfo.cc (_pinfo::commune_request): remove non-null check on "this", as
> this method is only called from pinfo.cc after null checks
> pinfo.cc (_pinfo::pipe_fhandler): remove non-null check on "this", as
> this method is only called from pipe.cc (fhandler_pipe::open) after a nul=
l check.

Patch applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXAn+6AAoJEPU2Bp2uRE+g3+8P/A7ZAZvUjgldavx7KNTWYm0r
eHs1R3wsiKpiwkOm8VD7Mtt3GNbGaC33pCK+plqUhDpzuLmMq2gG+HIkjysAvUbT
nGbqEcmwEOP22uToIYydDYNvJ2ZrfGfAH8IsooQlSfN9J5S9uURerR1y4kCwrZLW
EqortbkfRaPOdxYNXlA2HOULMIjSwGnbVFfXZJ6CXvK+nXlqzWvyT/Fl1H4b1R19
gIyCEsnxYHyo+o7QR+44uRvEggrTHFgZZEvBjJIIknO3WtipwUlcB4tVomElrMah
0+LY90xJa5Y6B9pIKZaMHENeE3E6Dw16SjOnz4IehhTdsEvew0dpTB+Hv57Bmtjx
lNYxVzT4PuAPD8kcRd+Cso4nx71XlB/zQ0dSJhZaKisUA3XP+JEVVuu8yGDd19HP
NsjH+Y6JfwcFUUMfKIB6aBCfQG6X79Ko7R7PaG1/ZbQDluAn2zHQU9qQw8AruKfB
rgEuJAYnCcttS5RUIyiQsTebv6jtXRLdBnCVgLHa2ZxwyRiG5Ny1T5LZ7CYAqsMX
NQFZmS6tiG+5axbqJ21Bt0YwDH8zVMKbPi+i5/ha9j9uYrE2A7sFSgwTJUwY1P9r
antLiolF135kKaMal6CrZpHFKYbr6BJ0j3MoECz+IhksSoz6h2x4I1l0CqopQoyj
8JaPl06FNksDuMgP4uSP
=WQx4
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--

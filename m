Return-Path: <cygwin-patches-return-9186-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23779 invoked by alias); 29 Oct 2018 09:09:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23301 invoked by uid 89); 29 Oct 2018 09:09:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=mails, corinna, H*Ad:U*cygwin-patches, Corinna
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 29 Oct 2018 09:09:43 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Mha0w-1fuSBy38YE-00MgQY for <cygwin-patches@cygwin.com>; Mon, 29 Oct 2018 10:09:40 +0100
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Mha0w-1fuSBy38YE-00MgQY for <cygwin-patches@cygwin.com>; Mon, 29 Oct 2018 10:09:40 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3AC0CA8187B; Mon, 29 Oct 2018 10:09:40 +0100 (CET)
Date: Mon, 29 Oct 2018 09:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/1] Fix deadlocks related to child processes
Message-ID: <20181029090940.GR3310@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20181028192244.4750-1-corngood@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <20181028192244.4750-1-corngood@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q4/txt/msg00002.txt.bz2


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1767

On Oct 28 16:22, David McFarland wrote:
> For a long time I've been struggling with intermittent deadlocks and
> segfaults in emacs, seemingly related to invoking child processes.  I
> recently found a reliable way to reproduce one such deadlock:
>=20
> - install clean cygwin with: emacs-w32, clang
> - install flycheck from elpa
> - grab some non trivial C header e.g.:
>   $ cp /usr/include/stdio.h test.h
> - $ emacs -q test.h
> - start flycheck:
>   (progn (package-initialize)
>          (require 'flycheck)
>          (flycheck-mode))
> - add a character to the start of the first line
> - wait for flygheck to complete
> - repeat the last two steps until a deadlock occurs
>=20
> Breaking in gdb showed the main thread in `cygheap_protect.acquire ()`,
> from either _cfree or _cmalloc.  The thread holding the mutex was always
> "flasio", and it would either be continually segfaulting or looping in
> _cfree.
>=20
> I added some debug prints to cygheap and determined that it flasio was
> double-freeing an atomic_write_buf.  I added some more prints and found
> that it was two different fhandler objects freeing the same buffer.
>=20
> I then found that `fhandler_base_overlapped::copyto` would clear the
> buffer pointer after the copy, but none of the derived classes (pipe,
> fifo) did.
>=20
> Attached is a patch which clears the buffer pointers when copying pipes
> and fifos.
>=20
> It would probably be safer to move the buffer clear to a `operator=3D`,
> but I wanted to keep the patch as simple as possible and avoid
> refactoring.

Excellent detective work, thanks for the patch!  Pushed.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlvWzlQACgkQ9TYGna5E
T6B92Q/+OMLrU6Xpy5TZkJKo6Lzk/so8H447T6Dhn/idbx8R/y/kbg2VSRpr79Ae
GSvfrIiHXkb2/pPrB1/3AmWReuNjXkgkNLS3f8rA0nhhGn4BDwoCyhPGulS+9epm
GEBN5471n/TFJHd+ztyBEcJbN4k9sQfLo3GPH41v/AAQuct0X/Fjuzczy6lvB3a0
62wXQBzezWycSubnf0GDS65iaOPNu6CbZGGE8/orvgqpyPXQCjJ5GaFX+kE0bPfB
IzqTnZRVqOj91lG9uSi0hTiDeavjt8aJ1/UbutXwMHCB/AeUH6ML3pcGPmxdJDD+
ac+HFI6NRAXKJXY0mXUoUE6VwGDFvlXWpdYDQRCLeoDIXSG1fDWcoyEhgr0AJtXy
R1TTW9bGjyEq+2zbixn0McLLO/70lC/LxiJxxUNHmF1c8ufa8PeacI+47PCZtUXW
oa51adCCNNCG2IeUjSWzigrHXLeZiereetIaczmQFc6tRWHFpKockG46qmEvnaxX
GClIaSPjgI0Y0U6RoOMkiKtYPq5emTus6cIQpXHEX4N9cNe2NNrXqtG8fKlO3koq
Xe7r+AfYwRkryB4pdclqJG/MAnGxPwI6bHXcz0PotcSyF+Yh36o8YsDR1FAOGlVa
NXAH+H7zjMlVzCi+gmX/NY+WZKJIpn6wjqYd8P38ZCmgT/332ac=
=+1VI
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--

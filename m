Return-Path: <cygwin-patches-return-8131-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9054 invoked by alias); 22 Apr 2015 11:28:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9043 invoked by uid 89); 22 Apr 2015 11:28:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 22 Apr 2015 11:28:12 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6477FA80970; Wed, 22 Apr 2015 13:28:10 +0200 (CEST)
Date: Wed, 22 Apr 2015 11:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin hangs up if several keys are typed during outputting a lot of texts.
Message-ID: <20150422112810.GC3657@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20150407091113.GB2819@calimero.vinschen.de> <20150413193100.a393612bde79a4ae57b8c7d9@nifty.ne.jp> <20150414073456.GY7343@calimero.vinschen.de> <20150416092618.9975c0e29b8703dbd8d4aa6a@nifty.ne.jp> <20150416090533.GB3657@calimero.vinschen.de> <20150417202746.351d90441d2d41fb316c07a9@nifty.ne.jp> <20150417121052.GY3657@calimero.vinschen.de> <20150420204015.4b03088d042dcda3774d874b@nifty.ne.jp> <20150420151230.GS3657@calimero.vinschen.de> <20150422195703.5f51c2730a86f2a3cc258a71@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="30GLzS1nLAWfoGxm"
Content-Disposition: inline
In-Reply-To: <20150422195703.5f51c2730a86f2a3cc258a71@nifty.ne.jp>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00032.txt.bz2


--30GLzS1nLAWfoGxm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 761

On Apr 22 19:57, Takashi Yano wrote:
> Hi Corinna,
>=20
> On Mon, 20 Apr 2015 17:12:30 +0200
> Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:
>=20
> > Ok.  Let's go with that.  Can you please rename handle2/master2 to
> > handle_cyg/master_cyg and resend the patch to the cygwin-patches
> > mailing list?
>=20
> Please find a patch attached. ChangeLog is as follows.

Patch applied, thank you.  Additionally I fixed a long-standing problem
in fhandler_pty_slave::fch_close_handles.  It closes handles not previously
opened by fch_open_handles.  I didn't relaize this until I saw your patch.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--30GLzS1nLAWfoGxm
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVN4XKAAoJEPU2Bp2uRE+gQfgP/jydHmF7uPIVDq+aLk3j92xf
8pBMiURosZwTcPYYjeRwCE8NBPQsP4TmekE490d/GzF+VsREZsHNfNw6fMrYl1Vs
Wm4ORDcqsaUsX0LhZIjlVsg1ifaQehM5PAcxpoRrOSWH5kNbku442ngRmSwQqWQZ
3W82PkCSZYFbW4734S9HgsVQ/adGZU8t297gincKxPKBisxCzx+nZsHU3sPDxUB1
nDNb59YEe2kl17UN+jRfQV65qg5bIhIGBst9LYgOdz9UxXVULwApojce3Ys9EewI
GtnWS7tkxI2CWq9kNLPaDBsZWfv7r1hgmS+PGtFV34GWghrAxu1VYBddkLDA4Ht6
HGq72NYOcEUvIA2z5sDtNlrAYju4nU7Kbc6+9MKAcFkNvwnDhOXLkAaC38HpsXCM
v87FHdaiqHpqmFNSgFxBokZQpSgzqbgJ8fsL9OCacc8GVS+lfdA4O7a2JkR+Mz8T
bIeMU+897gBMX3azaU7dGIiiaVTlKUM7/fNfgZuEugcPRLBtnHFN348M6Gjizcpo
uea6IebqME/JFDW8ETarznbiawx2jP5dddqPOTvTBVXY1ZiXB6DtfSEhxZSp9j0v
Lrt7wEBHoZEOVB829x0JdnitiaZKgE+DSmABSrpez26RvLLf7aRdE0NlKY1bzY3V
bCKip9OWOS5Rf+EwDUWy
=gCW7
-----END PGP SIGNATURE-----

--30GLzS1nLAWfoGxm--

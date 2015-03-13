Return-Path: <cygwin-patches-return-8073-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12618 invoked by alias); 13 Mar 2015 15:19:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12601 invoked by uid 89); 13 Mar 2015 15:19:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 13 Mar 2015 15:19:35 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4F427A8096D; Fri, 13 Mar 2015 16:19:33 +0100 (CET)
Date: Fri, 13 Mar 2015 15:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix winsup/doc to install into prefix
Message-ID: <20150313151933.GA20769@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1426256744-4184-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <1426256744-4184-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00028.txt.bz2


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 501

On Mar 13 14:25, Jon TURNEY wrote:
> By default, docdir and htmldir are defined in terms of prefix, so make su=
re to
> define it, so their values are prefix-relative.
>=20
> Without this, 'make install' installs the documentation into /share/doc/ =
unless
> configured otherwise.
>=20
> 	* Makefile.in (prefix): Define.

Please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVAwAFAAoJEPU2Bp2uRE+gUGkP/0ryFboPj6ydQMynnwprBQ7a
Q3ooJDS9a9qRoFtdfkdO+YRzXWqVfwYC+7nNK6r+DBUEV+RRD4eXNFv2tBfeiNPX
o0NsoCd9yzOWmUd8MXtjztkeF9P6JDlyWvGDuLc5GzHcuTiH64natBFe0aprO5/P
SOr6h3kvbwf/WfpsMIifNnHvEGZ/Lc4OKFcONKWYZ49QCn5H2h0DQE3Wk/wukbaK
do82m85P/jmow+wvp7szlqMvPFNBElXAO/MyQu6CPkWoFs6S5J5hm3W0xykvcPnv
GiQJjyml09sMDmE8bMuQ5mYggRlTz3sGGS6R/po5NSizv8TdQDQ6Fnr7YrFyNdy+
at/p5nlYmHVk2TA1QSEcjF7qET2AYpxYgdacM57H5l9F71dPNVWFvf9XVNHXJmIK
Ff/TA9tXvN6HkeV8YSHHuUIfypfc5yDJWgHLEYn5ZupCuoyn/YnJQbkh9NoImmP9
eq0+Mp4a6DCnyb2ZVvDEkQzIUowaRMLPYwCRESIzVlg5AxzGd6DsZTrkbcNxjZNA
72ojONOqTp1W4nIntjdozp6FiGy4B/heR33Mc04POAeY6dU/E5rDDp07bF28qKL9
JrMzJ5oSYAyA7gv/bIVxYgXIIScaGEvcwbrqXhHcTGcp9qO4OLXgJfyfS24xeJv7
v1fZJP49mHSyqa+ssJGx
=fNuE
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

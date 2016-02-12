Return-Path: <cygwin-patches-return-8305-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 112800 invoked by alias); 12 Feb 2016 17:18:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112734 invoked by uid 89); 12 Feb 2016 17:18:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=fed, H*F:U*corinna-cygwin, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 12 Feb 2016 17:18:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CBC43A80595; Fri, 12 Feb 2016 18:18:15 +0100 (CET)
Date: Fri, 12 Feb 2016 17:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: update child info magic
Message-ID: <20160212171815.GA21562@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1455244717-12688-1-git-send-email-yselkowi@redhat.com> <20160212093359.GC19968@calimero.vinschen.de> <56BE0DFC.7000702@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <56BE0DFC.7000702@cygwin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00011.txt.bz2


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1126

On Feb 12 10:53, Yaakov Selkowitz wrote:
> On 2016-02-12 03:33, Corinna Vinschen wrote:
> >On Feb 11 20:38, Yaakov Selkowitz wrote:
> >>	winsup/cygwin/
> >>	* child_info.h (CURR_CHILD_INFO_MAGIC): Update.
> >
> >This needs an explanation.  CHILD_INFO_MAGIC is still 0x30ea98f6U
> >for me.
>=20
> Hmmm, in that case it's either one of the patches I just sent or it's gcc=
-5.
> How would either of those affect this?

Off the top of my head, I don't know.  Usually only a change to
child_info.h should affect CHILD_INFO_MAGIC.  Unless the preprocessed
output of gcc differs for some reason.  You might want to compare the
output of gcc4 vs. gcc5 when called from cygmagic.  In general it
doesn't make sense if an identical structure definition results in
different checksums dependent on the compiler.  If push comes to shove
we have to change the cygmagic script to make sure the output fed to
cksum is independent on the compiler used (which I though it is, oh well).


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWvhPXAAoJEPU2Bp2uRE+goC8P+wV1BMdP/ZQ2UpLH0+v7CRNz
o3038nO0RAmx7Al/P8OdoBip2DYV5uhAyzkdVqEbk+gspg2mH82jAZF0t1fJTPSI
D5ysIpBVxOlb9DZwnDurenKRafsGFx6LcJ4+EXzElLQvsKpX3QAAmiWcPWZlOpmu
BQdMS9rXM2QYJ8XJ7hTE4LUny6D1z+gC8gXF5dlWtF+u0DJokNwaw8VyaYi5veKE
CsQ+HhHng9CA0rXIfotpq+fA9M+yBILTS84fnwAgD+b1m7HbnMLW014brSh3MC4v
B0hJNBHLEok4CbcRrEu9thc5d7/3fvwJQYLM8RhY5JC6HjVLgl6XJ7RvM7Earqti
sSPFU+wfz1PYFnQmMLK+f9lUF7IWk8+2MtjoruK3mLZ9oLYlTvQY3CdD/zDEBDnZ
01ggCDzAJEsHA8FAi+s8gvP4BXvN7okVNIAekaSG9O/apk+AnOgONFeG5e+5n8RA
jTL4/HqVVptwMo20mvbkKQcmnD7WpfLR6tzp3JXo+mF38+e5XCNRPRvsQpZZwRdi
QJuqecMFECQjfsL5yA20U9A/E5imQCH4uYV/uK6r4S85pIfgSNHe4KGfWTmPQW1r
wL332KrP6oY9FvRXHf4/DVXPq5562Rac8KvWTuFnzMWbP331cwV6Og6QwRwkhDTo
Tk8PV+cVNwKK7nTXBEhL
=0V8u
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

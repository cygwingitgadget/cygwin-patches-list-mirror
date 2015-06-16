Return-Path: <cygwin-patches-return-8174-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82378 invoked by alias); 16 Jun 2015 12:49:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 82359 invoked by uid 89); 16 Jun 2015 12:49:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jun 2015 12:49:37 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 87BCEA807DA; Tue, 16 Jun 2015 14:49:34 +0200 (CEST)
Date: Tue, 16 Jun 2015 12:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/8] winsup/doc: Convert utils.xml to using refentry
Message-ID: <20150616124934.GD31537@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk> <1434371793-3980-6-git-send-email-jon.turney@dronecode.org.uk> <20150615171147.GE26901@calimero.vinschen.de> <557FEC25.8030303@dronecode.org.uk> <20150616094501.GC31537@calimero.vinschen.de> <558003FD.8060208@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="e+JRL32uBeeWnrD4"
Content-Disposition: inline
In-Reply-To: <558003FD.8060208@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00075.txt.bz2


--e+JRL32uBeeWnrD4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1177

On Jun 16 12:09, Jon TURNEY wrote:
> On 16/06/2015 10:45, Corinna Vinschen wrote:
> >On Jun 16 10:28, Jon TURNEY wrote:
> >>On 15/06/2015 18:11, Corinna Vinschen wrote:
> >>>On Jun 15 13:36, Jon TURNEY wrote:
> >>>>Convert utils.xml from using a sect2 to using a refentry for each uti=
lity
> >>>>program.
> >>>>
> >>>>Unfortunately, using refentry seems to tickle a bug in dblatex when g=
enerating
> >>>>pdf, which appears to not escape \ properly in the latex for refentry=
, so use
> >>>>fop instead.
> >>>
> >>>Uhm... wasn't Yaakov's patch from 2014-11-28 explicitely meant to drop
> >>>the requirement to use fop andd thus java?
> >>>
> >>>Is there really no other way to handle that, rather than reverting to
> >>>fop?
> >>
> >>Now I try again --with-dblatex, it works fine, so that part of the patc=
h can
> >>be removed.
> >>
> >>I can only guess I must have had some other markup error causing me
> >>problems, which has since been fixed.
> >
> >I'm relieved :}
>=20
> Approved with that change?

Yep, thanks.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--e+JRL32uBeeWnrD4
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgBteAAoJEPU2Bp2uRE+gE4UP/1CBaDzDk3vDxtcVU3tm2VhF
hk820uVugvHCJ6A8DThm/iqaYnFBIon6WsldOqx4Pbgd7NnEmCRNWAJdP4uPHgcz
2JG1AFKxleOJTq+UsjH4fulAq4fjmsbJcEpCcd0iChPaFUXBsRSh63Ab5s6Y+fFa
G36STlorSue68xebsRVvm4yDq20AXAbpZ8Ck3w47DkBKYqc+levYnL+IRXGbomg1
BxmPNCd88/OzKgWw0f/ldwokMBSuaifMDwEY6FbunfbLQJerOpNo0Oke+s5l0eRf
bnRxMdD0xQo3+OhWIJ+//fRllELTaswXS/3GTeN6z/mTKBtufPgp0tXMa52kIUUP
mqOtedoLjZi+MZYgqBTrOLfUDjpYvyYu998IX7VYqLkXEnTN8LZvtEM7kbVYwtgo
Dt9aey/n2qy+l9e3pE/vRd0mt4JOPkRRsZGJqXe7nhsgyXHwb13aY0VWDSIc3fM+
B5AVP4lC/oi+xYtG03zHOcR5eBC0lCj0NQ7aCmLftETd4ZaqdXHLTSpRnYu+Jmz+
Dvu2Vqp0icGujigkSPkyCUcDZwQxbwDpKr571BFTOpIauodTFbleRp75XMbJQn3E
L3HZLgSiP/uFJwvRp2HLevA1gKIZM37LHhypkAYUWPmVhTHCshAaIGridO62/82H
IAHNzWOwh8EFcjnfKty9
=halg
-----END PGP SIGNATURE-----

--e+JRL32uBeeWnrD4--

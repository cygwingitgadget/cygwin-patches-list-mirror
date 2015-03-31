Return-Path: <cygwin-patches-return-8097-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 117297 invoked by alias); 31 Mar 2015 19:12:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 117271 invoked by uid 89); 31 Mar 2015 19:12:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 31 Mar 2015 19:12:13 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8FD69A80A3F; Tue, 31 Mar 2015 21:12:11 +0200 (CEST)
Date: Tue, 31 Mar 2015 19:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix documentation of cygwin_internal()'s return type.
Message-ID: <20150331191211.GF15852@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427824229-13744-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="kR3zbvD4cgoYnS/6"
Content-Disposition: inline
In-Reply-To: <1427824229-13744-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00052.txt.bz2


--kR3zbvD4cgoYnS/6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 301

On Mar 31 18:50, Jon TURNEY wrote:
> 	* misc-funcs.xml (cygwin_internal): Correct return type.

Ouch, yes.  Please apply.  Thanks for catching.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--kR3zbvD4cgoYnS/6
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVGvGLAAoJEPU2Bp2uRE+geXEP/3RrvOPjT1v2njSfpxRuJPa9
w5Koe41mcD5rR5K0zItE/FwaBaozM6KDPLBE2Tvh0LmFM57Cc3Xpuc751tx3PAAv
KYZ1+WpWPJbWu3a+gzIBPWh4UAA7T9CM1CZJnAhoXVHKtI3kIMNRkJeiP4RDoAEu
G0O2J7TQq2yvt69+5fcoe69pssda/XZH3MTLtTplJSREBH6CAPhuiT+jrxg4hpA9
zDB8NEV52y3qlAExTmW9608B5qyXxq3g1A+Byc5BjoUjX73dHo5C/0aKVEswWNWO
CqxSVe5iJR7uT/PPU5M8n6f6k+ZwSpRh6Mlxu2mF/CgDjwihT5lwVdWOvGXQsnCL
Sl7K62i5BYezPXpRL6m3dYO6wEPXEPbfm3AYQzQ3j0YY/Qo/W1JvYm+HPnEaj3sl
GJkmTYUGdmRsjrMIz7luJQ3eLIL/abGzbHu1UTD4O20P9q1f58Px2Y3Uqo1eHn6a
2lp2BSLELsMAITXnt7ivVDIW4mOHSS/RNDhIB6IRdb19NDOkFnmzbUw+NZ4ZXbdb
rnrCo4VC7iGucQpi8TxyxNwnyHUvUC3PsvXFbnnCThuqNBQHjVSh31ChanHUGpGy
xpUl/NRNv2JCs0DF3yets1iwKXeh+AYkZfoh/R2yzV7ydh6w0PSRYjVCzviu3Grm
c+f62qC2glImkQkKP8Bh
=IMqQ
-----END PGP SIGNATURE-----

--kR3zbvD4cgoYnS/6--

Return-Path: <cygwin-patches-return-8429-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 96284 invoked by alias); 20 Mar 2016 09:56:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 96259 invoked by uid 89); 20 Mar 2016 09:56:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=employer, H*R:D*cygwin.com, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 20 Mar 2016 09:56:01 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 10216A805AC; Sun, 20 Mar 2016 10:55:59 +0100 (CET)
Date: Sun, 20 Mar 2016 09:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: Re: [PATCH 01/11] Remove unused and unsafe call to __builtin_frame_address
Message-ID: <20160320095559.GB25241@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Peter Foley <pefoley2@pefoley.com>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00135.txt.bz2


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 581

Hi Peter,


thanks for the patch series.  With the exception of patch 6 all of
them are short enough to go in as trivial patches.  However, for=20
patch 6 we'd need a copyright assignment from you.  Please have a look
at the "Before you get started" section on https://cygwin.com/contrib.html
There's an assign.txt document you (and potentiall your employer) can
sign and send as PDF.  It's usually rather painless.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7nOuAAoJEPU2Bp2uRE+g65wQAKS8nl4u2lT4Oei8o+kDg8ul
xuT0+ltD0CyFQNXLq6EauW8PrJTXmtqwi/4wh+NjdFT+KeXK6gWFa3tv24jxUrCY
437NKSGFg1uRkbYiBerRJgGDNtAawOCLSG/i7f1bSfrisRZg15gHLAvKpmiClxxG
2CX+MI8I09zImXJGLnbjolBV74qemfdDRk180GdvGegdwH3Q17MR2/W9+R4ddHGl
f37lhtB7J2Rfc//Mhd95oXxqVqd54MTpir0qf02x/OnRFrWnBA6kpAVirrPQOqgw
ksKRkc7P1XBQcnoIneGGZR5Ij8c/RbPbUFP9vZKgIrSF0/cOleb8yyDUMwH2tIi5
3/kwqg8d9zwyjf+Q/JGvHT49bj5+5PF3GzQlpgXPD46bRfzPgR89bL91jaRyL1HN
F1/yrsvLInN+jaOC1dAl/LMESAFDBNmSTBluIe1aVfJ9JCxuKrnIVpDgL/CZbo9G
8s2TTVDM0hFbAdIDv/98yP0FcXCIuK4mWNTs3bLH/apyhjfT/8dBwjAKXr3a55f5
RKAHKuP7pZrtS6YDdO78qAYabHTC+6rCuroOzxC2ir0/jcySJcRQm7D3RvwowJg1
o+2f9+PJDoYZLtBDHo/ocP4vl+eVJHmJPTBOUIc7Zu/Ja7aZru2wsMNq9foDQ4Kh
6jmTjJd7kjBOn7fwySgX
=psUn
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--

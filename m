Return-Path: <cygwin-patches-return-8525-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18005 invoked by alias); 1 Apr 2016 12:13:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17982 invoked by uid 89); 1 Apr 2016 12:13:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=taste, earth, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Apr 2016 12:13:21 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5E105A8060E; Fri,  1 Apr 2016 14:13:18 +0200 (CEST)
Date: Fri, 01 Apr 2016 12:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Refactor to avoid nonnull checks on "this" pointer.
Message-ID: <20160401121318.GA16660@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459441102-19941-1-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <1459441102-19941-1-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q2/txt/msg00000.txt.bz2


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 908

On Mar 31 12:18, Peter Foley wrote:
> G++ 6.0 asserts that the "this" pointer is non-null for member functions.
> Refactor methods that check if this is non-null to be static where
> necessary, and remove the check where it is unnecessary.

No, sorry, but now.  Converting all affected functions to static
functions just because this might be null is much too intrusive for my
taste.  *If* that's really a problem going forward, I'd rather see the
pointer test moved into the caller.  But don't waste your time on a
patch yet.
=20
Let's please take a step back and look at what happens.  So, here's the
question:  What error message does G++ 6 generate in case of an `if
(this)' test in a member function, and why on earth should it care and
do that?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/mXeAAoJEPU2Bp2uRE+g3QsP/imJshNueh1ioLqtA14ataQd
17NbMDlO47tukkQPQQH27ABiesvwJ4CThvGA3qhzD7P4J/CZRhXN20dQQ9yimIQX
q4DMZBzFN9kcAvfYATTTv78mpZMVK9NJ49R6fjHvUqBNcjxXtvS3g4IMxA7hGiAq
Xtft/dwpfRj/OceONJf+lsK9VHuXHrbm19PRObsGsW/nmDIWVZTYX7wFvg9XxIMq
7s9bkfhG3AWL14Ywjpgoyhfpk3KUZ88N39lKGdX7VkgXrH/s42D77SFID7RO9BPw
oa+nUqm5Hnn/8SqnFqFUv/JwAU+4LEV5fLMSdk+CqLeYDIiRi6g/si76pcVo3rKo
6f6pbhpqG1KpLnG7XG0Cys8kDVVUyVu9PW6JeZFlqZEp0X7kgf7KoIA/U2e8iOwC
3CHvI7iS/hXHLjtWcELrA5MPgEjjXss9uKqfsM/sJZ/ZN//sU5mx7kO3p/WBr6tM
pjIgjxXG45kuqG63vgwb6azFBBnqLe2HQgAkiTiNYvr0qva/EGl1iQd9+Im1tUji
/IAt5cAM+zQb0FcCGs1l1GRjg9S2A6IK8n+peHz+ML791/jNey20t1HAFTuyYbt6
ACf/dfCCfD58Za27W5BXo9NrQbThfzZNAg6Ig1yDURGlfJy3+ZXUkVrYKeWAb8De
goKnxOoztbU8iwASCpIZ
=retG
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

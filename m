Return-Path: <cygwin-patches-return-8697-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 49074 invoked by alias); 23 Feb 2017 14:03:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48753 invoked by uid 89); 23 Feb 2017 14:03:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=ntfs, NTFS, inclined, bumping
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Feb 2017 14:03:50 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id F10F1721E281A;	Thu, 23 Feb 2017 15:03:47 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 5CF0F5E00CD;	Thu, 23 Feb 2017 15:03:47 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 416DBA805E1; Thu, 23 Feb 2017 15:03:47 +0100 (CET)
Date: Thu, 23 Feb 2017 14:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: Re: (fixup) [PATCH] forkables: use dynloaded dll's IndexNumber as dirname
Message-ID: <20170223140347.GK23946@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
References: <9f8649cf-0293-cce7-f4a1-84433d62152d@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <9f8649cf-0293-cce7-f4a1-84433d62152d@ssi-schaefer.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00038.txt.bz2


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1214

Hi Michael,


I'm inclined to promote the "forkables" code to master.  I just have a
few points before we do that:

- Revert bumping of CYGWIN_VERSION_SHARED_DATA.  We only have to do that
  if the shared region changes in an incompatible way.  But this is just
  adding a member to the end.

- I'm looking a bit cross-eyed on the usage of forkables_needs and
  cygwin_shared->prefer_forkable_hardlinks.  It seems to me as if the
  split between those two isn't quite right and the fact that both
  share information seems error prone.
=20=20
  IMHO prefer_forkable_hardlinks should actually be the single marker
  for the per-installation state.  After startup of the first process it
  should be "unknown" (0) by default.  At startup it's set to one of

    "disabled"   (-1)	no NTFS or dir is missing
    "enabled"    (+1)	NTFS and dir exists

  That sets the state once and for all by the first Cygwin process in
  the system.

  Consequentially, forkables_needs should only reflect the per-process
  states

    "needless"
    "needed"
    "created"

- Shouldn't forkables_needs be renamed to forkables_needed?

That's all.  There are a few minor formatting issues, but they are
negligible.


Thanks,
Corinna

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYruvDAAoJEPU2Bp2uRE+gycgP/RHX6nkoIWbbNnGr1NotOhxi
+iaJ5Lpz9F5yua2U44r5Ju7eGwLTIZIsjXdULC33xzVvp43mOJvOptV9ZrhP01S+
1COSQ9QMO5HfNaV4GmxStYnP7Vb3TUW9kMnNutr/ny8axL8dXVf9tnHu/cSaqmuZ
xwWyTqVyt3imSqotQ9QOZGmqSemqNja4096XEIyd4JTYSLXUc6daMsGsHiL0edTx
NzidDsh7GADfQxU8F36YFBnWw1mNbShk5OWEo++LPXz6smClxaj+kNWeqrv5QLcq
uqoMoVNXclgsCkDN0z3UMVzDBdRpKnRWbQu+4i0xED9pJPpF0lcrA89VZrsGMOTs
eIsAHrVvMdDxd0AeDFbWdi7yNkWVYHZ8/2et+0uQdekVzXslcnK01FyToDF3F1V0
wg0r1ZaMiQ2b79pSAhafWbP/9cOKTzDbT5g2spFRcbCHfoSsDdqf5XCcLkkJl6KG
pS6p/g+iXxSaTBaleHk3v7C8U8p0zB3HpXuraAq5L7dgWPdVfBtVwI0AXYvi0GOB
NJ8y983pLdBGSXz05tGwBF2UllNCeIt0qtZ7IpcjBfQnKipbsrYYVZcRqAN8PNHR
iMk6d+GFuqfG8ymErPf1cbsPB5CKjiGNEvYl2Nxyl1LAXEMNRO4rwaMCMzNjI1tg
i6ImXT2mdYYatYoZUoE0
=2PUo
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--

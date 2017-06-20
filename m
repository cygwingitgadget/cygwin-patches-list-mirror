Return-Path: <cygwin-patches-return-8791-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63312 invoked by alias); 20 Jun 2017 08:17:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63278 invoked by uid 89); 20 Jun 2017 08:17:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*c:application, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, among
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 20 Jun 2017 08:17:33 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 62625721E282F	for <cygwin-patches@cygwin.com>; Tue, 20 Jun 2017 10:17:29 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id BB4715E03D0	for <cygwin-patches@cygwin.com>; Tue, 20 Jun 2017 10:17:28 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A2701A80648; Tue, 20 Jun 2017 10:17:28 +0200 (CEST)
Date: Tue, 20 Jun 2017 08:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Compatibility improvement to reparse point handling, v3
Message-ID: <20170620081728.GB8342@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <594199C4.9080804@pismotec.com> <20170619114532.GC26654@calimero.vinschen.de> <59481C4D.5030206@pismotec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <59481C4D.5030206@pismotec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00062.txt.bz2


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2359

On Jun 19 11:47, Joe Lowe wrote:
>=20
> On 2017-06-19 04:45, Corinna Vinschen wrote:> Hi Joe,
> >=20
> > As discussed in the previous iteration of this patch, this change
> > results in nuking DT_UNKNOWN for reparse points we don't handle.  Still,
> > IMHO, if we have reparse points we know nothing about, they should stay
> > DT_UNKNOWN.
> >=20
> > Why is changing them to DT_DIR/DT_REG a good idea?  Please convince me.
>=20
> As coded, the patch makes the dentry.d_type field consistent with
> S_ISREG and S_ISDIR on the results of lstat-ing the same name. This
> seems correct to me, from the standpoint of avoiding compatibility
> issues with any *nix application code that may look at the d_type
> value and make some inference from it. I do not know of any specific
> application examples where this is actually a problem.
>=20
> My concern with DT_UNKNOWN for unknown reparse tags: it indicates
> to cygwin applications and developers that reparse tags are an
> extended file system node type enumeration. In general this is
> incorrect. Reparse tags are a type of extended attribute that can be
> attached to any regular NTFS file or directory. Reparse tags do not
> necessarily do anything to prevent normal access to the
> file/directory.

Actually, DT_UNKNOWN indicates nothing.  The sole purpose of this
value is to tell the application that the information is not readily
available without having to perform costly operations, which often
is the case for remote filesystems.  From the Linux man page:

  DT_UNKNOWN  The file type could not be determined.

  Currently, only some filesystems (among them: Btrfs, ext2, ext3,
  and ext4) have full support  for  returning  the  file  type  in
  d_type.   All  applications  must  properly  handle  a return of
  DT_UNKNOWN.

> If you like, I will redo the patch to return dentry.d_type of
> DT_UNKNOWN for files/directories with unknown reparse tags.
> Let me know.

No, it's ok.  Let's go with this as you wrote it.

I pushed your patch, plus a follow-up patch to handle remote reparse
points correctly, as outlined in my previous reply.

I uploaded new developer snapshots to https://cygwin.com/snapshots/
Please give them a try.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZSNoYAAoJEPU2Bp2uRE+g44AP/RCYf+XlcIruW7BxZBBFDzJ6
JuPE4gWiuKAhVC2CFCodkdtKugx6HTJK1TNfAkvI/cRyA/8Z0ZLeFwLW+WO4RfXZ
ncA45WPdHuD7bEWUDrVVw+JrdN9o7zzyKylXo0TsZM0OE+pc2dCPU/AEf2PAy29r
10bVV3WqQFMUZn4cgWgsjDTqXZj8Vlfx4BXD9bGw3yf65uwyyQ/avU3fgL61GYRT
IyK995udrQsLTEjdkJv8VzYnNAmK6mdEU/wNaHzaBER/Z3vagkOCntes4Uohf4RK
kVSb2FB+tKA/X/cBpud1yKWJhxFpvoviUNsy236J9PBM8O9/RbVYgDITpalOJ+2O
ADESHQU2IgdeVJIsMDPnUEyNNBrg3dtP1uJKjc7J65H56nITes2L/ifSUvtCMpdD
LHGW+c6K4fPl/wBKnuAmj4seD9vTe6KsNyxNp1SPbNBKdH5tah5D/NBl0bNGhOBT
OLdXoKNu9tjLaiR3Cj9Zh/wLTK1HEy7UbMF6bMBYCsDjY+6N5OupOEUlKJq9gL4q
VPvtGroR7wVPbWjY22OynlnM5tic+ZKEBHOw/t7R8XtFDm+C3podDQ6Vv/5g3YMg
JOA8x3SnvWh8SogChUXU5/Iswn3/gTCDZQaexZngXLAiXn5dNK/qtrBvska2gT0b
+G0khVtIMITp6CaOKj46
=b6us
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

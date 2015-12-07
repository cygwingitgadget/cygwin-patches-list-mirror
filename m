Return-Path: <cygwin-patches-return-8282-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50511 invoked by alias); 7 Dec 2015 16:42:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50495 invoked by uid 89); 7 Dec 2015 16:42:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-3.3 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from ipbcc02fe8.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.47.232) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 07 Dec 2015 16:42:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id F3A01A8061B; Mon,  7 Dec 2015 17:42:27 +0100 (CET)
Date: Mon, 07 Dec 2015 16:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Introduce the 'usertemp' filesystem type
Message-ID: <20151207164227.GA28971@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0MIuft-1ZZdDB2IaP-002Y2r@mail.gmx.com> <3ddcb7adf1004c146964beda2f90521bb1c19d4a.1448978434.git.johannes.schindelin@gmx.de> <20151201142725.GY2755@calimero.vinschen.de> <alpine.DEB.1.00.1512011550290.1686@s15462909.onlinehome-server.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1512011550290.1686@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00035.txt.bz2


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 953

On Dec  1 15:50, Johannes Schindelin wrote:
> Hi Corinna,
>=20
> On Tue, 1 Dec 2015, Corinna Vinschen wrote:
>=20
> > On Dec  1 15:02, Johannes Schindelin wrote:
> > > 	* mount.cc (mount_info::from_fstab_line): support mounting the
> > > 	current user's temp folder as /tmp/. This is particularly
> > > 	useful a feature when Cygwin's own files are write-protected.
> > >=20
> > > 	* pathnames.xml: document the new usertemp file system type
> >=20
> > patch looks good.  We just have to wait for the ok in terms of the
> > copyright assignment.  Might take a day or two.
>=20
> Sure thing. Thank you for your patience!

Thank you in return!  Patch applied.  I'm just going to create a
developer snapshot which should be up at https://cygwin.com/snapshots/
in half an hour at the latest.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZbbzAAoJEPU2Bp2uRE+gs/YP/RgcdcCW1cgD5cxsEWJstPyC
4byCVyBdw84KicWezvbFb3Lg7ULu/C0zLVi1f5I62j9E0I72xwBwcs5ZIhWYss9a
mweNRQqyFYBiz2ayG25stwDfSafrTe6Oy1Mjf8n6LCCrRlxe0bYKFG9SnFPg4EZy
6bekKJNfFI9JC6SyQk1ohDWdzyxc2MbopuEwoaM/El7o+l7BQUCcAyAj7bEPdzbo
Umgzx4QdMYo6+n5i9a40i2YmPekfH8zsOLhkAh4ocNJcR9O+kVxE+8CFIXu3OSg9
36gfyiQn2TtBgcK+cUZupGwSgxaTj6d1PNn0V1B5vBcP53VYP/rmWDdHrzSISTnT
TFaB04Dwiq0okA6kai1UkFvUlylDhR/nmAxcsno7kSeZHl6okw3m7q/eQtdtbyGi
fgaJv1M3QV1FTZosG4FA+75+StWIWQ1rR6f/KzHBS3ha5SGicGdPTg7B/Nb9D/Sq
/aQlqCNBvPmy3hVXeSgCdptEXZ0SbIzXc0wO6piKoCZfrS4ojR0JLYiuqBtEjWp/
SCGlmNK7A2DrNIdRtmLJAUc3TmLDxlI4ywXugXAWcHWZft5SssV/zqJoxnpfmIZb
oOxoAY4Fg2V8BbQkokEGHEPvRNC7w9d2/KezrKhbaCufQJERX0Z1CJsoG9TuMoXq
AmvmPigQvhd1lsIdENSJ
=rmx7
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

Return-Path: <cygwin-patches-return-8528-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 46906 invoked by alias); 1 Apr 2016 12:20:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 46886 invoked by uid 89); 1 Apr 2016 12:20:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=UD:local, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Apr 2016 12:20:27 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0256DA8060E; Fri,  1 Apr 2016 14:20:25 +0200 (CEST)
Date: Fri, 01 Apr 2016 12:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/6] forkables: Protect fork against dll-, exe-updates.
Message-ID: <20160401122024.GD16660@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1459364024-24891-5-git-send-email-michael.haubenwallner@ssi-schaefer.com> <56FC232D.4090006@cygwin.com> <56FC2500.4080909@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <56FC2500.4080909@ssi-schaefer.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q2/txt/msg00003.txt.bz2


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1247

On Mar 30 21:12, Michael Haubenwallner wrote:
> On 03/30/2016 09:04 PM, Yaakov Selkowitz wrote:
> > On 2016-03-30 13:53, Michael Haubenwallner wrote:
> >> To support in-cygwin package managers, the fork() implementation must
> >> not rely on .exe and .dll files to stay in their original location, as
> >> the package manager's job is to replace these files.  Instead, we use
> >> the hardlinks to the original binaries in /var/run/cygfork/ to create
> >> the child process during fork, and let the main.exe.local file enable
> >> the "DotLocal Dll Redirection" feature for dlls.
> >>
> >> The (probably few) users that need an update-safe fork manually have to
> >> create the /var/run/cygfork/ directory for now, using:
> >> mkdir --mode=3Da=3Drwxt /var/run/cygfork
> >=20
> > Have the security implications of this been considered?
>=20
> Which security implications do you think of?
>=20
> Removed but in-use binaries are available in the recycle bin anyway,
> and can manually be hardlinked to wherever one likes...

Permissions on the parent dirs and the files are always an issue...


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/meIAAoJEPU2Bp2uRE+gqZ8P/0aYCIDU9MgOelMnzZq9ZpTw
eZDplADj50hBqsxem6yLGtqHZWX5bol9nP4Ko4ObbzOnKMbCS4rGmkBuw95XjpmP
bu/WhZZiLaQsDx9R3H2PzIOIRIKiRaQ5uuZ0jjDCut705R5kZE8EPOXUIY0MlMCf
HRm/cjWvQz2NPMTBXjzTd1RjqAZ51yM1j0YX13FHECC4kJTjHZvflVDB1VRGz96t
/g1yQXszlq13SZdeBeSYp7VsghGj5nbI0Pvig9qd9yXBh1MOl6rWRnwDvNxWq/1x
VMmghGCDv5peiClis1810IwF0G3cJOx4+5ZL7kaknejooLTIeR4e8hxQA3K5ajsK
dPoK49WnD4Xg/cfcD88aHV+SdZIM/+DxyJbp6vjk8fOTJJ2skedYwmzhkaM9lAmG
Inr5+270luI5YAAlWBLKF+ZmhxdnWU5L5Qtr9TarE7g6684nyjvkb3Ouh90KYiZe
IJWLDxsClF4te9F7czwi4wSO4b4j9YaAcDz07+J8gTx0hqycogghgjUI4HlbTny/
1raNvuM8+fC+vJDK3gsDQmTiagq2mYjQSIbi4PR1b1Qhxxvwroi3IZg2GwDDvhwb
Fxwso+ZBhn5C0WZ6fliclFEZwGuWjMQdUSJotLicl3XmUDhGv+MXkn8XqO0JUES0
4Ckiw7wS/1DcEz1ykaTB
=rynH
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--

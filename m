Return-Path: <cygwin-patches-return-8254-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 72234 invoked by alias); 21 Oct 2015 18:23:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 72212 invoked by uid 89); 21 Oct 2015 18:23:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 21 Oct 2015 18:23:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B5096A803D5; Wed, 21 Oct 2015 20:23:46 +0200 (CEST)
Date: Wed, 21 Oct 2015 18:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Introduce the 'usertemp' filesystem type
Message-ID: <20151021182346.GE17374@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0MIuft-1ZZdDB2IaP-002Y2r@mail.gmx.com> <20151020093741.GA17374@calimero.vinschen.de> <alpine.DEB.1.00.1510201251140.31610@s15462909.onlinehome-server.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1510201251140.31610@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00007.txt.bz2


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 4240

Hi Johannes,

On Oct 20 13:47, Johannes Schindelin wrote:
> On Tue, 20 Oct 2015, Corinna Vinschen wrote:
> > On Sep 16 09:35, Johannes Schindelin wrote:
> > > 	* mount.cc (mount_info::from_fstab_line): support mounting the
> > > 	current user's temp folder as /tmp/. This is particularly
> > > 	useful a feature when Cygwin's own files are write-protected.
> > >=20
> > > 	* pathnames.xml: document the new usertemp file system type
>=20
> BTW I thought this would be the preferred form of the ChangeLog entry: as
> part of the commit message. At least that is how I interpreted this part:
>=20
> 	ChangeLogs should not be sent as "diffs". Just send the complete
> 	ChangeLog entry, which is ideally part of the output of
> 	`git format-patch' anyway.
>=20
> of https://cygwin.com/contrib.html

Duh, I missed that from your OP.  Somehow I started reading with
"Detailed explanation:".  Sorry about that.

> > > By specifying
> > >=20
> > > 	none /tmp usertemp binary,posix=3D0 0 0
> > >=20
> > > in /etc/fstab, the /tmp/ directory gets auto-mounted to the directory
> > > specified by the %TEMP% variable.
> >=20
> > In theory you could also utilize /etc/fstab.d/$USER, without the need to
> > implement a usertemp mount type.
>=20
> This is unfortunately not possible. The use case that triggered this patch
> is Git for Windows (which does not use Cygwin directly, but the MSys2
> runtime which is derived from Cygwin).

Editorial note:=20

It's a bit hard to understand why we need Git for Windows while there's
a full fledged git available as part of the Cygwin distro.  It's also
very frustrating that a Git for Windows standalone tool gets a lot of
press coverage while nobody seems to care that Git for Windows under
Cygwin exists for ages.  Sigh.

> Indeed. In Git for Windows' case, this is actually a feature. That way,
> different users' files are encapsulated from each other.
> [...]
> As I said, in a multi-user setting, or even worse: in a portable
> application, this is simply not possible other than via the strategy
> implemented by this patch.

Here's a question.  If it's really only about git, why do you need
to redirect /tmp, rather than having git use $TMP directly?  That would
be much less intrusive than having to change the underlying POSIX
layer, isn't it?

> > - The ChangeLog entry is missing.
>=20
> See above. Do you want me to include the diff to winsup/cygwin/ChangeLog?

No, my bad, sorry.

> [...]
> > > +          char mb_tmp[len =3D sys_wcstombs (NULL, 0, tmp)];
> >=20
> > - len =3D sys_wcstombs() + 1
>=20
> Whoops. I always get that wrong.
>=20
> But... actually... Did you know that `sys_wcstombs()` returns something
> different than advertised? The documentation says:
>=20
> 	- dst =3D=3D NULL; len is ignored, the return value is the number
> 	  of bytes required for the string without the trailing NUL, just
> 	  like the return value of the wcstombs function.
>=20
> But when I call
>=20
> 	small_printf("len of 1: %d\n", sys_wcstombs(NULL, 0, L"1"));
>=20
> it prints "len of 1: 2", i.e. the number of bytes requires for the string
> *with* the trailing NUL, disagreeing with the comment in strfuncs.cc.

Drat.  You're right.  As usual I wonder why nobody ever noticed this.
As soon as the nwc parameter is larger than the number of non-0 wchars
in the source string, sys_cp_wcstombs returns the length including the
trailing NUL.

And looking through the Cygwin sources the usage is rather erratic,
sometimes with, sometimes without + 1 :(

> How do you want to proceed from here? Should I fix sys_wcstombs() when the
> fourth parameter is -1? Or is this not a fix, but I would rather break
> things?

No, this needs fixing, but it also would break things.  I have to take
a stab at fixing this throughout Cygwin first.

> > - What about adding a mount flags to allow fillout_mntent to print out
> >   the mount type?  This isn't essential, I'm just wondering if there
> >   might be a good reason to see the type in mount(1) output.
>=20
> You mean something like this?
>=20
> -- snip --

Yes, that's what I had in mind.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWJ9gyAAoJEPU2Bp2uRE+gDRwP/A6aWN63JtjJpisMyryN3cOi
MICm0E+gES4Oiac+u7X92hmHb/gRvFOBi+Omn+NeMtjhxor1L+DyGkxwctdu38JH
FUItnPVCCow0c4dPuzuAG1A2v7nRzgXG2VqpUwVNPTX25/q6hUM9TNSAGcfMN+FT
foVstUOCAx7KyhXkiEu199S5byMAypQYkrgC95J3Xzxn2eqPH+49kRI9tv5OorEF
GGLm5oNIcFmw0MgJYBuuPpgefTttE9AkJ+viAn91mEJ7x2/24hhV7zkMiGZWDt2H
aV1eA1BzizwkoQ8VdWTnrST68cMRGBO0gQGvLi1ZPpv9Q4dMRt+d+C3bow1RXk7L
xQUkfcOLWNHTie7Xbu6yksbmncLhNQ11iblGRv6y5DGlV1XOhyZEKGNU2SaGJY9d
uQ74I+X3T0WYY92F/wLUZCUJakhVLAdR215aBfK2kj+0ON7DPSUhrE/6VQAcFt23
q4BDtz+NqL5SiOQArxkoszkT3gjEPSeCTTisUzjEIx7InscYiPfsJf/HNI8MJ/0o
I8QMrDTAaDb5Ao2/9J5Mbk0XrhTNpEfQRyciboI5zG+aH9H2ERKT5Ha8fiFyC0t4
VJUgXTEqTXM6ai52UlhnbHRU818VvcHBIjIajyMzZ7LzICS/LDZCuHOb3A2BsqYB
cyPb2aOZrZP3682laawR
=MrN8
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--

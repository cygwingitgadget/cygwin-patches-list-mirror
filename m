Return-Path: <cygwin-patches-return-8216-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 55818 invoked by alias); 22 Jun 2015 18:40:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 55803 invoked by uid 89); 22 Jun 2015 18:40:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jun 2015 18:40:38 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 23C09A8094D; Mon, 22 Jun 2015 20:40:36 +0200 (CEST)
Date: Mon, 22 Jun 2015 18:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] winsup/doc: Create info pages from cygwin documentation
Message-ID: <20150622184036.GN28301@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk> <1434983976-3612-2-git-send-email-jon.turney@dronecode.org.uk> <20150622145553.GH28301@calimero.vinschen.de> <558842B7.3080207@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline
In-Reply-To: <558842B7.3080207@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00117.txt.bz2


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2682

On Jun 22 18:15, Jon TURNEY wrote:
> On 22/06/2015 15:55, Corinna Vinschen wrote:
> >On Jun 22 15:39, Jon TURNEY wrote:
> >>v2:
> >>Updated to use docbook2x-texi not docbook2texi, since source is now doc=
book XML.
> >>Tweak DocBook XML so info directory entry has a description.
> >>
> >>v3:
> >>Use a custom charmap to handle &reg;
> >>
> >>v4:
> >>Proper build avoidance
> >>texinfo node references may not contain ':', so provide alternate text =
for a few
> >>xref targets
> >>
> >>2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
> >>
> >>	* Makefile.in (install-info, cygwin-ug-net.info)
> >>	(cygwin-api.info): Add.
> >>	* cygwin-ug-net.xml: Add texinfo-node.
> >>	* cygwin-api.xml: Ditto.
> >
> >This is fine.
> >
> >>	* ntsec.xml (db_home): Add texinfo-node for titles containing a
> >>	':' which are the targets of an xref.
> >
> >This... not so much.  Let's simply remove the colons instead:
> >
> >-<sect4 id=3D"ntsec-mapping-nsswitch-home"><title id=3D"ntsec-mapping-ns=
switch-home.title">The <literal>db_home:</literal> setting</title>
> >+<sect4 id=3D"ntsec-mapping-nsswitch-home"><title id=3D"ntsec-mapping-ns=
switch-home.title">The <literal>db_home</literal> setting</title>
> >[...]
>=20
> I did consider this, but to be consistent it would needs to be removed fr=
om
> all section titles:
>=20
> ><sect4 id=3D"ntsec-mapping-nsswitch-pwdgrp"><title id=3D"ntsec-mapping-n=
sswitch-pwdgrp.title">The <literal>passwd:</literal> and <literal>group:</l=
iteral> settings</title>
> ><sect4 id=3D"ntsec-mapping-nsswitch-enum"><title id=3D"ntsec-mapping-nss=
witch-enum.title">The <literal>db_enum:</literal> setting</title>
> ><sect4 id=3D"ntsec-mapping-nsswitch-home"><title id=3D"ntsec-mapping-nss=
witch-home.title">The <literal>db_home:</literal> setting</title>
> ><sect4 id=3D"ntsec-mapping-nsswitch-shell"><title id=3D"ntsec-mapping-ns=
switch-shell.title">The <literal>db_shell:</literal> setting</title>
> ><sect4 id=3D"ntsec-mapping-nsswitch-gecos"><title id=3D"ntsec-mapping-ns=
switch-gecos.title">The <literal>db_gecos:</literal> setting</title>

I missed something, apparently.  From where are these three referenced,
but not the others?

> Even then, it's not consistent with the text, which always treats : as pa=
rt
> of the keyword.

Yeah.  I'm not overly happy with this myself.  I didn't know how better
I could make clear that the colon is part of the keyword.

So, ok.  Please apply.  Maybe it makes sense to add texinfo-nodes for
the others in the list above as well?  Just in case?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJViFakAAoJEPU2Bp2uRE+gRQEP/2cYGpKgJ1bLSpOwMwaVQebK
ehGai15zKMZgx3xpRevXBHNZX/kExYHFvRQobiaGgrJZZtwr2IZy+Y/q1cdb6rwp
HdO1tuhB4N+BwMCV1oJzZzeuL/LEvYm0J63T8HHahGZqwCTdW8AMnBVUHM7XM7pa
cdgO2zPd6zI1bgx6kmpAsKd5Io2jb688xHZGmmbhMBZNci538UfcZc4TzBrnKFt3
DG8S4KdqTBRniRolUPi2Kju3OnqYSR8YHXkJI9fA+0llE2TkdldO60MrGG0Snrh1
cbWt5f7hJE6aBm51zpZ6BNZ0hlRejtwu81nAuViHx99QRc3Gi0Odj9/iN+7jBNM8
kbWB0EP0d3G28A7F60NK5FMD9QDYPlB3n9FYnrL1I8YHT+8i8A2x+q0WaIdL6oG3
jgKp88IufZZ2HEj4R0iufBFDH43x8u4d4phO1mvGHSY/6kb5AchNHGW1xV8kpZ9n
vSOFebUU0mrxgTHMCAR3uO/4dGI4NSPv3GKnrlHKpOJGv29EKoiPzwmwgChKtSUf
e1l/Fs97Fs+2EgFePXqy4EE+2h3aHNAS5miS65N1lX21cG/I+3a8vEA00x8r9Kpi
yRTQdLW0CQx1pVcZuQSTBy/qQqcnGPm6jGbiivJm4m2AdJEWzakjHSyXWP2AcHwS
LJCwKg3uIthHCalKWZ6x
=6ouZ
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--

Return-Path: <cygwin-patches-return-3861-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6330 invoked by alias); 19 May 2003 22:03:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6298 invoked from network); 19 May 2003 22:03:49 -0000
Subject: Re: [PATCH] fix for process virtual size display
From: Robert Collins <rbcollins@cygwin.com>
To: jbuehler@hekimian.com
Cc: cygwin-patches@cygwin.com
In-Reply-To: <3EC953C6.7040908@hekimian.com>
References: <ICEBIHGCEJIPLNMBNCMKOEFACGAA.chris@atomice.net>
	 <3EC953C6.7040908@hekimian.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cSuHY1TRikf/ZxCndkOK"
Organization: 
Message-Id: <1053381824.957.39.camel@localhost>
Mime-Version: 1.0
Date: Mon, 19 May 2003 22:03:00 -0000
X-SW-Source: 2003-q2/txt/msg00088.txt.bz2


--=-cSuHY1TRikf/ZxCndkOK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 745

On Tue, 2003-05-20 at 07:59, Joe Buehler wrote:
> Chris January wrote:
>=20
> > I'm actually inclined to keep vmc.VirtualSize instead of vmc.PagefileUs=
age.
> > However I found this formula cited in one of the Linux man pages:
> >           vsize=3D(brk-start_code+PAGE_SIZE-1)+(TASK_SIZE-esp)
> > which would seem to indicate vmsize actually refers to committed memory.
> > With this in mind, I'm happy for this patch to be committed. Further wo=
rk
> > may be
> > needed to include DLLs in that figure, however that would be a separate
> > patch.
>=20
> Does anyone on the list know what "reserved" memory means in Windows?=20

reserved in the backing storage.

Rob
--=20
GPG key available at: <http://users.bigpond.net.au/robertc/keys.txt>.

--=-cSuHY1TRikf/ZxCndkOK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+yVTAI5+kQ8LJcoIRApgHAJ98mCP1PMHh3ALtcrTYqa/mjy4vKwCfatzV
w3WxMIc3rFWQ3cAnRoGJDBQ=
=RlDN
-----END PGP SIGNATURE-----

--=-cSuHY1TRikf/ZxCndkOK--

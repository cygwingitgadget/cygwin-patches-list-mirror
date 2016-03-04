Return-Path: <cygwin-patches-return-8372-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90699 invoked by alias); 4 Mar 2016 08:58:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90680 invoked by uid 89); 4 Mar 2016 08:58:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-94.7 required=5.0 tests=BAYES_20,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=DOT, vista, waited, accessible
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 04 Mar 2016 08:58:45 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 99902A80633; Fri,  4 Mar 2016 09:58:43 +0100 (CET)
Date: Fri, 04 Mar 2016 08:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: john hood <cgull@glup.org>
Subject: Re: Cygwin select() issues and improvements
Message-ID: <20160304085843.GB8296@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, john hood <cgull@glup.org>
References: <56C03624.1030703@glup.org> <20160215125703.GE8374@calimero.vinschen.de> <56C66DDE.9070509@glup.org> <20160219104641.GA5574@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <20160219104641.GA5574@calimero.vinschen.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00078.txt.bz2


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3891

John,


Ping?  I'd be interested to get your patches into Cygwin.  select
really needs some kicking :)


Thanks,
Corinna


On Feb 19 11:46, Corinna Vinschen wrote:
> On Feb 18 20:20, john hood wrote:
> > On 2/15/16 7:57 AM, Corinna Vinschen wrote:
> > > On Feb 14 03:09, john hood wrote:
> > >> Various issues with Cygwin's select() annoyed me, and I've spent some
> > >> time gnawing on them.
> > > One of them is that they are not trivial enough to be acceptable with=
out
> > > copyright assignment (except patch 3, but see below).  Please have a
> > > look at https://cygwin.com/contrib.html, the "Before you get started"
> > > section.  There's a link to an "assign.txt" file with instructions.
> > >=20
> > > The other one is just this:  Can you please describe each change in t=
he
> > > accompanying patch comment so that it's accessible from the git log?
> >=20
> > Sorry for the slow response here.  I have a bad cold and I'm not getting
> > to things quickly.
>=20
> I know what you mean.  I'm still coughing badly from the flu I catched
> lately.
>=20
> > Microsoft official documentation:
> >=20
> > <https://msdn.microsoft.com/en-us/library/windows/desktop/ms687069%28v=
=3Dvs.85%29.aspx#waitfunctionsandtime-outintervals>
> >=20
> > <https://msdn.microsoft.com/en-us/library/windows/hardware/jj602805%28v=
=3Dvs.85%29.aspx>
> >=20
> > Try running my socket-t program in
> > <https://github.com/cgull/cygwin-timeouts> as 'socket-t 10000'; it will
> > report the actual time waited.  On Windows 10, you will see lots of
> > variation in timeouts, with some of them shorter than the requested
> > time.  My ancient Vista laptop has much less variation and is never
> > shorter.  Win7 is similar.
>=20
> In the second link it sounds like a change in W8 might causing this.
>=20
> > The thing that I think should happen there is that fhandlers'
> > select_{read,write,except}() functions should go away, and an fhandler
> > should only have a poll() function that indicates what's available, and
> > a get_waitable_object() function, that gives sel.wait() something to
> > sleep on.  The select_{read,write,except}() functions, and the
> > always_ready state variables, partially implement both of these pieces
> > of functionality, and really complicate the implementation for select().
> >=20
> > I'm not sure I'll ever get to it, these Cygwin issues are very much a
> > side project for me.
>=20
> That's ok, but the idea is nice.  It would be cool if we could improve
> select.  From my POV it has at least three downsides.  It's pretty slow,
> the code is complicated, and it's badly commented.  Also, IIRC, the number
> of descriptors is restricted to 63 due to WFMO restricted to this number
> of handles.  This is not a restriction for sockets since sockets are
> using threads per each 63 objects, but the other objects are not doing
> that.  So, yeah, there's a lot to improve on select alone.
>=20
> > The last patch in my series reverts from the documented
> > CreateWaitableTimer() interfaces to the ancient, undocumented
> > NTCreateTimer() interfaces only for consistency with the rest of the
> > Cygwin codebase, which only uses NTCreateTimer().  The documented
> > interfaces are all present in XP.  The undocumented interfaces have all
> > the functionality this code needs.
>=20
> Using NtCreateTimer is perfectly fine and I think the API is cleaner
> than the CreateWaitableTimer API.
>=20
> > I'm on #cygwin and #cygwin-dev, ask questions there if you want.
>=20
> Not ATM, but feel free to contact me on the dev channel.
>=20
>=20
> Thanks,
> Corinna
>=20
> --=20
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Maintainer                 cygwin AT cygwin DOT com
> Red Hat



--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2U5DAAoJEPU2Bp2uRE+g4QMP/iiS1zCCPfmsUwn9A5JbOmKs
0CLNXgmnb/mnLuzhJ80Y9KJpIR4L8gGB5iA3zoyW2G8/pOILqFaxftGLhWF/dl3M
C0JpnB+6HXsxcJ9VgfeL2jVEbZH3t4i4a/17wZyQGsjpdLYmfFEAdoLH84IUWXyl
ZovpQNkqP+GmSGvKZiOjqQ0v4hsvUUMLmYldzQMTtk+PlU07+mvWEgY6LyJ9cdM+
XokIgDi1oey46Hp5mPtYWVkmuGq7c8lmRteKb2FCCSnFlV2aUJKSPH8Bb9VtG5MK
J3F+jbHm+Cbz8RPrCA7NfOsf3sRuUgds9WXIgf/ooyG6JIQGWknKGvJWUuIojpRP
XH+qc0HDYrMYiKSiXV7hIEamjsz6oRXdKbTcoxkYnDYMfF290gxvgcusxQRMVPSO
EKcjRLDXEeTbrvZe7o3fa9FiEPas1t29K3PHdtnRC1qJGF7xcrkfreGDiqyY+8vO
ZTBDyJHKy/fUV50ZAzlQzNFwZBXoVADahYBkmusnceLM78SUGa9NjN/bY6/sLFb7
dPAQ/n5k9eXqpCxTLzF3YikThSmOJwXxrdeLsq110GZwLG6SvvnQKAKwhBw/s5iX
PFaeKu8rddK3sH3MZnCaygKftPtUi13EEf7tAfOW+CqJdb/zais+3W6ePJLeAwTx
hk5EVsE7+5ZqbkJW9xMV
=fhqH
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--

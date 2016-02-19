Return-Path: <cygwin-patches-return-8342-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30623 invoked by alias); 19 Feb 2016 10:46:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30527 invoked by uid 89); 19 Feb 2016 10:46:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=HX-Envelope-From:sk:corinna, H*R:U*cygwin-patches, H*F:U*corinna-cygwin, flu
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Feb 2016 10:46:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 18BE8A80306; Fri, 19 Feb 2016 11:46:41 +0100 (CET)
Date: Fri, 19 Feb 2016 10:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin select() issues and improvements
Message-ID: <20160219104641.GA5574@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C03624.1030703@glup.org> <20160215125703.GE8374@calimero.vinschen.de> <56C66DDE.9070509@glup.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <56C66DDE.9070509@glup.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00048.txt.bz2


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3400

On Feb 18 20:20, john hood wrote:
> On 2/15/16 7:57 AM, Corinna Vinschen wrote:
> > On Feb 14 03:09, john hood wrote:
> >> Various issues with Cygwin's select() annoyed me, and I've spent some
> >> time gnawing on them.
> > One of them is that they are not trivial enough to be acceptable without
> > copyright assignment (except patch 3, but see below).  Please have a
> > look at https://cygwin.com/contrib.html, the "Before you get started"
> > section.  There's a link to an "assign.txt" file with instructions.
> >=20
> > The other one is just this:  Can you please describe each change in the
> > accompanying patch comment so that it's accessible from the git log?
>=20
> Sorry for the slow response here.  I have a bad cold and I'm not getting
> to things quickly.

I know what you mean.  I'm still coughing badly from the flu I catched
lately.

> Microsoft official documentation:
>=20
> <https://msdn.microsoft.com/en-us/library/windows/desktop/ms687069%28v=3D=
vs.85%29.aspx#waitfunctionsandtime-outintervals>
>=20
> <https://msdn.microsoft.com/en-us/library/windows/hardware/jj602805%28v=
=3Dvs.85%29.aspx>
>=20
> Try running my socket-t program in
> <https://github.com/cgull/cygwin-timeouts> as 'socket-t 10000'; it will
> report the actual time waited.  On Windows 10, you will see lots of
> variation in timeouts, with some of them shorter than the requested
> time.  My ancient Vista laptop has much less variation and is never
> shorter.  Win7 is similar.

In the second link it sounds like a change in W8 might causing this.

> The thing that I think should happen there is that fhandlers'
> select_{read,write,except}() functions should go away, and an fhandler
> should only have a poll() function that indicates what's available, and
> a get_waitable_object() function, that gives sel.wait() something to
> sleep on.  The select_{read,write,except}() functions, and the
> always_ready state variables, partially implement both of these pieces
> of functionality, and really complicate the implementation for select().
>=20
> I'm not sure I'll ever get to it, these Cygwin issues are very much a
> side project for me.

That's ok, but the idea is nice.  It would be cool if we could improve
select.  From my POV it has at least three downsides.  It's pretty slow,
the code is complicated, and it's badly commented.  Also, IIRC, the number
of descriptors is restricted to 63 due to WFMO restricted to this number
of handles.  This is not a restriction for sockets since sockets are
using threads per each 63 objects, but the other objects are not doing
that.  So, yeah, there's a lot to improve on select alone.

> The last patch in my series reverts from the documented
> CreateWaitableTimer() interfaces to the ancient, undocumented
> NTCreateTimer() interfaces only for consistency with the rest of the
> Cygwin codebase, which only uses NTCreateTimer().  The documented
> interfaces are all present in XP.  The undocumented interfaces have all
> the functionality this code needs.

Using NtCreateTimer is perfectly fine and I think the API is cleaner
than the CreateWaitableTimer API.

> I'm on #cygwin and #cygwin-dev, ask questions there if you want.

Not ATM, but feel free to contact me on the dev channel.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxvKQAAoJEPU2Bp2uRE+gx44P/0zi/vVc5i4xF2EOMt2bpNz2
UvpJvP7IndwHTBlerSKsxsYWDt8Y6l+rqT/BTehItUsP3/04X+Gh1RDBAtWpC+s7
phFyMiYN4vaQ+PHja2cxFO7xEUEbcBg//dP3C6v0BWNWJmYoovotZ5QmncP2ld1w
OSNOlG8WQR37x3eWGRutw3Q0xlqudd018LHIiq3tu0kAD9p5Tod0cH44AYy/oMoO
t72UUv0Ho08UbBAc3914v6wvC9sacl3rIpj3ltGm+tJAHKI1vYW14UKkNOhtdSYn
FyZQ3V1EPhsULtpszXfPvWPmUA/ev1uRlkTTYcLcTEZH8lU/AR+BsS31OayZUCl4
rnuhO1TLenYmoacqQ6Ai0Kt1SvycDR1L3/E2HhIU7L8LVpHw33WXgnODRvr4U9AT
cax4yZfuVvKadB/UWBFBuRdds6FVtlfT0io75jerI69hQSMOJLry6TiHzS9N7D5+
rcfrzC/kEV2fV5f5cDHiQhzkg9UI8W89Hg8bb1ZauJ4zzo7RhQEWwyXcoELLErTh
AdBTeZ6PPsE1cFqP1d8HRFsTF5S3wRuijlKghB6mjk6Dxp7xqdXO5UfOm5ceCiKI
svc7vtH4UEEUS1hYRABmkSL5nECIyCZpZ+1U5rA/aDMJolwj9vDbMycxgqh2bZhs
r4TsjAhvOpq0dvJYd1xZ
=/5FA
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

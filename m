Return-Path: <cygwin-patches-return-8355-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 52225 invoked by alias); 23 Feb 2016 10:56:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 52202 invoked by uid 89); 23 Feb 2016 10:56:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=caution, PID, 100000, HX-Envelope-From:sk:corinna
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Feb 2016 10:56:17 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7C7ECA805D5; Tue, 23 Feb 2016 11:56:15 +0100 (CET)
Date: Tue, 23 Feb 2016 10:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] gprof profiling of multi-threaded Cygwin programs, ver 2
Message-ID: <20160223105615.GA5618@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C820D8.4010203@maxrnd.com> <20160222101224.GA29199@calimero.vinschen.de> <Pine.BSF.4.63.1602222243530.88046@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1602222243530.88046@m0.truegem.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00061.txt.bz2


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1699

On Feb 22 22:58, Mark Geisert wrote:
> On Mon, 22 Feb 2016, Corinna Vinschen wrote:
> >One is, for completeness it would be nice if you could add a
> >description to the git comment along the lines of your original
> >comment so we have a description in the log.
>=20
> Sorry, can't parse this; git newbie here.  Did you mean the 'git commit' =
I'm
> doing to my private repository and the message associated with the commit?

Yes, exactly.

> And by "original comment" do you mean what I called the change log in the
> text of my v2 email we're discussing (i.e., not the patch attachment but =
the
> email body)?

No, I mean the first patch submission.  Your v1 patch submission had a
nice explaining text.  It might be helpful to have this text (tweaked to
the v2 changes) in the git log, together with the ChangeLog.

> >The other point is:
> >>+		long divisor =3D 100000;	// the power of 10 bigger than PID_MAX
> >
> >I've seen 6 digit PIDs.  In fact, we're not that tight on space here
> >so we should err on the side of caution and leave room for the entire
> >possible size of a Windows PID.  That's a LONG, 32 bit, 10 decimal
> >digits.
>=20
> Yikes.  I'd seen large 5-digit pids but could not find a definitive symbol
> defining Windows' maximum pid value.  So I will change divisor's init val=
ue
> to 1000*1000*1000 which will allow the conversion loop to support 10-digit
> pids.

ACK.

> >Other than that, the patch looks good to me.
>=20
> Great!  I'll follow up with Jon separately (to the list) on his comments.

Yup.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWzDrPAAoJEPU2Bp2uRE+g1OsP/1M7Tc8jm9V3uVY2PSPwpG72
ukuEJV4sDcS++LSF9PAF/s0kCJ90LYp94Uznpnc12Qn6UBqLgKY1WHZ6Ifz69j7T
TuHJWPVVODpO2CmtjuAPs2LtiRwEj066FMl6PiKw4XeHRAB6V/AH3UYViwVLju4T
FTINN8+pR1eR8tCCp+/b6R884JMRsq2TEdjimyysQa0CzT+jtIo2aVaGKw7q5Grd
76MYYNL9P81yoCko6CaUzXORIJSkcTT/wcKTVz2WhwPg6yZJGzWwnYqujef+w5cV
Mx3WdSBOeduYb5/DRhcGI/vX56H2HqFeRMx3sQfR8MnmXaKdM+pmG8TyJm9+iQaH
3nvGXAgzoBYtrDZYc5L23sjnyqcl4tTSylx6TRrO1feD3vfjUOKbAyspBwjJJToc
Miv0uuiqPUkJ3BXaH6Eg0aJcFUbMq1RYP4FQFg4Tt9fKEB/LHKK0RSnjdQ+DZUoN
2TaqWo4eE6s9baB5tkFeN81NQZHqVJCzSsTPq0CB0clHSpyacy8/6NTnRcUzaJxP
yllunKo18+om5QpaZHwJA/F/tw0RdA/T0a9uCnlFDZNlvUYycMqcCNoI/dzv+eWV
33XE1oYMj3UFrZJYo0aLIw1cPjc/3piHdUtq60rVh0yAxsLr+IW4UdttAk/5FdAh
urA0bWD1YeTTnvanhu7X
=/nXY
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

Return-Path: <cygwin-patches-return-5308-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17142 invoked by alias); 16 Jan 2005 17:15:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17107 invoked from network); 16 Jan 2005 17:15:21 -0000
Received: from unknown (HELO exgate.steeleye.com) (209.192.50.48)
  by sourceware.org with SMTP; 16 Jan 2005 17:15:21 -0000
Received: from steelpo.steeleye.com ([172.17.4.222]) by exgate.steeleye.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Sun, 16 Jan 2005 12:15:20 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: Control auto-uppercasing of environment variables
Date: Sun, 16 Jan 2005 17:15:00 -0000
Message-ID: <76CBF6B36306884D835E33553572BE52059ED0@steelpo>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Ernie Coskrey" <Ernie.Coskrey@steeleye.com>
To: "Cygwin Patches" <cygwin-patches@cygwin.com>
X-OriginalArrivalTime: 16 Jan 2005 17:15:20.0690 (UTC) FILETIME=[F525CD20:01C4FBEE]
X-SW-Source: 2005-q1/txt/msg00011.txt.bz2

No, I haven't done that.  If anybody knows of any specific tests that I nee=
d to try on a Win9X box, I'll do that.  Otherwise I'll just check general s=
hell (bash) and some utility functionality.

Ernie Coskrey

> -----Original Message-----
> From: Larry Hall [mailto:no-personal-replies-please-lh@cygwin.com]
> Sent: Friday, January 14, 2005 11:31 PM
> To: Ernie Coskrey; cygwin-patches@cygwin.com
> Subject: RE: Control auto-uppercasing of environment variables
>=20
>=20
> At 03:28 PM 1/14/2005, you wrote:
> >Well, I suppose there are some similarities between what the=20
> uppercase_env and check_case options are used for, but=20
> check_case is specifically targeted at handling case=20
> sensitivity with regard to filenames, not environment=20
> variables.  The subvalues of check_case are specified as=20
> "levels" (relaxed, adjust, and strict), so I don't think=20
> there's a clean way to use this unless we completely changed=20
> the meaning of what check_case is intended to do.
> >
> >You'd also have to be able to combine subvalues - for=20
> example, some users might want strict file checking and no=20
> environment variable uppercasing, others might want relaxed=20
> file checking and uppercasing of environment variables.  A=20
> separate CYGWIN option seems cleaner.
>=20
>=20
> I agree.=20=20
>=20
> I only glanced quickly at your patch but the new behavior=20
> doesn't distinguish
> between 9x and NT platforms.  As I recall, and I may be=20
> mistaken, 9x needed
> the environment upper-cased to work.  Did you try your patch on a 9x=20
> platform?
>=20
>=20
>=20
> --
> Larry Hall                              http://www.rfk.com
> RFK Partners, Inc.                      (508) 893-9779 - RFK Office
> 838 Washington Street                   (508) 893-9889 - FAX
> Holliston, MA 01746=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
>=20
>=20

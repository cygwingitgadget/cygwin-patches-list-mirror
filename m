Return-Path: <cygwin-patches-return-4168-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6364 invoked by alias); 6 Sep 2003 00:53:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6298 invoked from network); 6 Sep 2003 00:53:55 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Sat, 06 Sep 2003 00:53:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: don't fail integrity check on empty package
In-Reply-To: <Pine.GSO.4.56.0309052041170.7348@slinky.cs.nyu.edu>
Message-ID: <Pine.GSO.4.56.0309052046590.7348@slinky.cs.nyu.edu>
References: <Pine.GSO.4.56.0309052041170.7348@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-559023410-824023566-1062809053=:7348"
Content-ID: <Pine.GSO.4.56.0309052046591.7348@slinky.cs.nyu.edu>
X-SW-Source: 2003-q3/txt/msg00184.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-824023566-1062809053=:7348
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.56.0309052046592.7348@slinky.cs.nyu.edu>
Content-length: 904

On Fri, 5 Sep 2003, Igor Pechtchanski wrote:

> Hi,
>
> This patch fixes the erroneous failure of "cygcheck -c" when the package
> is empty (and thus the file list for it is missing), e.g., XFree86-base.
> 	Igor

Sorry, I've messed up the ChangeLog entry.  The correct one is included
below.

> ==============================================================================
> ChangeLog:
2003-09-05  Igor Pechtchanski  <pechtcha@cs.nyu.edu>

	* dump_setup.cc (check_package_files): Don't fail on empty package.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
---559023410-824023566-1062809053=:7348
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="cygcheck-verify-packages-empty.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.56.0309052044130.7348@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="cygcheck-verify-packages-empty.patch"
Content-length: 915

SW5kZXg6IHdpbnN1cC91dGlscy9kdW1wX3NldHVwLmNjDQo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC91
dGlscy9kdW1wX3NldHVwLmNjLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4x
Mg0KZGlmZiAtdSAtcCAtcjEuMTIgZHVtcF9zZXR1cC5jYw0KLS0tIHdpbnN1
cC91dGlscy9kdW1wX3NldHVwLmNjCTE3IEF1ZyAyMDAzIDE3OjI2OjA4IC0w
MDAwCTEuMTINCisrKyB3aW5zdXAvdXRpbHMvZHVtcF9zZXR1cC5jYwk2IFNl
cCAyMDAzIDAwOjM5OjQwIC0wMDAwDQpAQCAtMjY2LDkgKzI2Niw4IEBAIGNo
ZWNrX3BhY2thZ2VfZmlsZXMgKGludCB2ZXJib3NlLCBjaGFyICoNCiAgIGlm
ICghZnApDQogICAgIHsNCiAgICAgICBpZiAodmVyYm9zZSkNCi0JcHJpbnRm
ICgiQ2FuJ3Qgb3BlbiBmaWxlIGxpc3QgL2V0Yy9zZXR1cC8lcy5sc3QuZ3og
Zm9yIHBhY2thZ2UgJXNcbiIsDQotICAgICAgICAgICAgICAgIHBhY2thZ2Us
IHBhY2thZ2UpOw0KLSAgICAgIHJldHVybiBmYWxzZTsNCisJcHJpbnRmICgi
RW1wdHkgcGFja2FnZSAlc1xuIiwgcGFja2FnZSk7DQorICAgICAgcmV0dXJu
IHRydWU7DQogICAgIH0NCiANCiAgIGJvb2wgcmVzdWx0ID0gdHJ1ZTsNCg==

---559023410-824023566-1062809053=:7348--

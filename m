Return-Path: <cygwin-patches-return-5398-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22218 invoked by alias); 30 Mar 2005 18:51:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22128 invoked from network); 30 Mar 2005 18:51:37 -0000
Received: from unknown (HELO slinky.cs.nyu.edu) (128.122.20.14)
  by sourceware.org with SMTP; 30 Mar 2005 18:51:37 -0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id j2UIpaW3008484
	for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2005 13:51:37 -0500 (EST)
Date: Wed, 30 Mar 2005 18:51:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH] Problem with filenames ending in "." with check_case:strict
Message-ID: <Pine.GSO.4.61.0503211850270.8708@slinky.cs.nyu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1297389768-1111452904=:8708"
Content-ID: <Pine.GSO.4.61.0503211956340.8708@slinky.cs.nyu.edu>
X-SW-Source: 2005-q1/txt/msg00101.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1297389768-1111452904=:8708
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.61.0503211956341.8708@slinky.cs.nyu.edu>
Content-length: 1416

Hi,

I noticed that my Makefiles that tack on a "." to the filename to
differentiate no-ext targets from .exe targets stopped working with the
update from 1.5.12 to latest CVS (yes, I know, a little late).  I've
tracked it down to
<http://cygwin.com/ml/cygwin-cvs/2004-q4/msg00145.html>.

Basically, the trailing spaces and dots used to be stripped always, and
now they're only stripped if raw WinNT names are used.  This breaks
symlink_info::case_check, since the name returned by FindFirstFile and the
name extracted from the path parameter are different (the path has
trailing dots and spaces).  Thus, "touch a." doesn't work anymore with
check_case:strict.

The attached (trivial, IMO) patch fixes this issue.
	Igor
P.S. Corinna, Rose should have the corresponding FAX already.
==============================================================================
ChangeLog:
2005-03-21  Igor Pechtchanski  <pechtcha@cs.nyu.edu>

	* path.cc (symlink_info::case_check): Ignore trailing characters
	in paths when comparing case.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
---559023410-1297389768-1111452904=:8708
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="path-ccstrict-trailing.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.61.0503211955040.8708@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="path-ccstrict-trailing.patch"
Content-length: 1164

SW5kZXg6IHdpbnN1cC9jeWd3aW4vcGF0aC5jYw0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2lu
L3BhdGguY2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjM1NQ0KZGlmZiAt
dSAtcCAtcjEuMzU1IHBhdGguY2MNCi0tLSB3aW5zdXAvY3lnd2luL3BhdGgu
Y2MJMTIgTWFyIDIwMDUgMDI6MzI6NTkgLTAwMDAJMS4zNTUNCisrKyB3aW5z
dXAvY3lnd2luL3BhdGguY2MJMjIgTWFyIDIwMDUgMDA6NDY6MjMgLTAwMDAN
CkBAIC0zMjE3LDYgKzMyMTcsNyBAQCBzeW1saW5rX2luZm86OmNhc2VfY2hl
Y2sgKGNoYXIgKnBhdGgpDQogICBXSU4zMl9GSU5EX0RBVEEgZGF0YTsNCiAg
IEhBTkRMRSBoOw0KICAgY2hhciAqYzsNCisgIGludCBsZW47DQogDQogICAv
KiBTZXQgYSBwb2ludGVyIHRvIHRoZSBiZWdpbm5pbmcgb2YgdGhlIGxhc3Qg
Y29tcG9uZW50LiAqLw0KICAgaWYgKCEoYyA9IHN0cnJjaHIgKHBhdGgsICdc
XCcpKSkNCkBAIC0zMjMwLDcgKzMyMzEsOCBAQCBzeW1saW5rX2luZm86OmNh
c2VfY2hlY2sgKGNoYXIgKnBhdGgpDQogICAgICAgRmluZENsb3NlIChoKTsN
CiANCiAgICAgICAvKiBJZiB0aGF0IHBhcnQgb2YgdGhlIGNvbXBvbmVudCBl
eGlzdHMsIGNoZWNrIHRoZSBjYXNlLiAqLw0KLSAgICAgIGlmIChzdHJjbXAg
KGMsIGRhdGEuY0ZpbGVOYW1lKSkNCisgICAgICBsZW4gPSBzdHJsZW4oZGF0
YS5jRmlsZU5hbWUpOw0KKyAgICAgIGlmIChzdHJuY21wIChjLCBkYXRhLmNG
aWxlTmFtZSwgbGVuKSkNCiAJew0KIAkgIGNhc2VfY2xhc2ggPSB0cnVlOw0K
IA0K

---559023410-1297389768-1111452904=:8708--

Return-Path: <cygwin-patches-return-4811-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8291 invoked by alias); 3 Jun 2004 20:24:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8273 invoked from network); 3 Jun 2004 20:24:37 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 03 Jun 2004 20:24:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Pierre.Humblet@ieee.org
cc: David Fritz <zeroxdf@att.net>, cygwin-patches@cygwin.com
Subject: Re: [Patch]: NUL and other special names
In-Reply-To: <40BF870A.B42E5C3E@phumblet.no-ip.org>
Message-ID: <Pine.GSO.4.58.0406031617240.24345@slinky.cs.nyu.edu>
References: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net>
 <40BF81C4.1020105@att.net> <40BF870A.B42E5C3E@phumblet.no-ip.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.39
X-SW-Source: 2004-q2/txt/msg00163.txt.bz2

On Thu, 3 Jun 2004, Pierre A. Humblet wrote:

> David Fritz wrote:
>
> [snip]
> > Also, from the patch:
> >
> >           /* COM and LPT must be followed by a single digit */
> >
> > The code in src/winsup/cygwin/devices.cc would seem to indicate that
> > the number is not limited to a single digit.
>
> From my tests that's the behavior on 9x, so it's appropriate code for
> managed mounts.
>
> Today on the list Igor indicated that PRN would soon regain its old
> behavior.  My patch was more modest, just forbid using PRN (and creating
> a hard to delete file).
>
> Do we want to do what Igor suggested, although it's not Posix?
> Pierre

Well, if you intend to forbid the use of PRN, NUL, LPT*, COM*, etc, you
should probably modify the User's Guide section on DOS devices
<http://cygwin.com/cygwin-ug-net/using-specialnames.html#AEN796>, which
explicitly states that the previous behavior is allowed/expected.

IMO, either the names should be special DOS devices (and allow full
functionality), or they should be non-special names that are treated just
like any other files (e.g., allowing the "aux" directory, etc).  The prior
choice follows the principle of least surprise; the latter may eliminate
the need for managed mounts (eventually).
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton

Return-Path: <cygwin-patches-return-4814-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11809 invoked by alias); 3 Jun 2004 20:56:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11799 invoked from network); 3 Jun 2004 20:56:31 -0000
Message-ID: <40BF907E.58513677@phumblet.no-ip.org>
Date: Thu, 03 Jun 2004 20:56:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
CC: David Fritz <zeroxdf@att.net>
Subject: Re: [Patch]: NUL and other special names
References: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net>
	 <40BF81C4.1020105@att.net> <40BF870A.B42E5C3E@phumblet.no-ip.org> <Pine.GSO.4.58.0406031617240.24345@slinky.cs.nyu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00166.txt.bz2



Igor Pechtchanski wrote:
> 
> On Thu, 3 Jun 2004, Pierre A. Humblet wrote:
> 
> > David Fritz wrote:
> >
> > [snip]
> > > Also, from the patch:
> > >
> > >           /* COM and LPT must be followed by a single digit */
> > >
> > > The code in src/winsup/cygwin/devices.cc would seem to indicate that
> > > the number is not limited to a single digit.
> >
> > From my tests that's the behavior on 9x, so it's appropriate code for
> > managed mounts.
> >
> > Today on the list Igor indicated that PRN would soon regain its old
> > behavior.  My patch was more modest, just forbid using PRN (and creating
> > a hard to delete file).
> >
> > Do we want to do what Igor suggested, although it's not Posix?
> > Pierre
> 
> Well, if you intend to forbid the use of PRN, NUL, LPT*, COM*, etc, you
> should probably modify the User's Guide section on DOS devices
> <http://cygwin.com/cygwin-ug-net/using-specialnames.html#AEN796>, which
> explicitly states that the previous behavior is allowed/expected.
> 
> IMO, either the names should be special DOS devices (and allow full
> functionality), or they should be non-special names that are treated just
> like any other files (e.g., allowing the "aux" directory, etc).  The prior
> choice follows the principle of least surprise; the latter may eliminate
> the need for managed mounts (eventually).
>         Igor

I was going to suggest making it a non-special name (on NT only,
so there is still a surprise effect)
That's easy, just prefix the path with //./ or //./unc/
But it's getting costly because we would need to:
- detect that the path is special initially, and each time a symlink is met
  (the outer loop of ::check)
- process the mount table normally during the inner loop of ::check
  and prefix as needed with //./ or //./unc/ (if not already there). 
Also that can push a path length past the limit.

That doesn't help for the lower/upper case issue.

Not sure if it's worth it.

Pierre

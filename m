Return-Path: <cygwin-patches-return-1897-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27657 invoked by alias); 25 Feb 2002 18:15:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27592 invoked from network); 25 Feb 2002 18:15:18 -0000
Message-ID: <20020225181508.5528.qmail@web20006.mail.yahoo.com>
Date: Mon, 25 Feb 2002 10:23:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: help/version patches 
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q1/txt/msg00255.txt.bz2

> Adding version numbers is not a bad idea (although, I can't honestly
> think of a time when it would have helped to have this information).
> Adding version numbers in the middle of the program, in the middle of a
> text string is, IMO, a bad idea.  The version number should be at
> the top of the program in a
>
> const char version[] = "something";
> 
> and referenced in the version string.
> 
> As Robert indicated, using the CVS version number is probably the best
> way to handle this.  setup.exe currently uses the CVS version.  Use that
> as an example.

I was trying to avoid doing what setup.exe does. In the Makefile.in there
is a grep/sed combo that grabs the version from the Changelog and creates
a file to include. This is fine for a lot of files that compile into one
(setup.exe) but is it really necessary for 13 utils, most of which take 
only one file of code? What about a sed script that takes that CVS/Entries
file and creates something like versions.c with:

const char cygcheck_version[]= "1.23";
const char cygpath_version[]= "4.56";

which could then be #include'd in each file? Then at least no one would have
to edit the version code; it would just make. (BTW, I used cygpath.cc as a 
reference point for the version code; it is currently in a hard-coded printf.)


__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com

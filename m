Return-Path: <cygwin-patches-return-1900-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2466 invoked by alias); 25 Feb 2002 18:23:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2414 invoked from network); 25 Feb 2002 18:23:40 -0000
Date: Mon, 25 Feb 2002 11:09:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: help/version patches
Message-ID: <20020225182351.GA12748@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020225181506.62853.qmail@web20001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020225181506.62853.qmail@web20001.mail.yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00257.txt.bz2

On Mon, Feb 25, 2002 at 10:15:06AM -0800, Joshua Daniel Franklin wrote:
>>Adding version numbers is not a bad idea (although, I can't honestly
>>think of a time when it would have helped to have this information).
>>Adding version numbers in the middle of the program, in the middle of a
>>text string is, IMO, a bad idea.  The version number should be at the
>>top of the program in a
>>
>>const char version[] = "something";
>>
>>and referenced in the version string.
>>
>>As Robert indicated, using the CVS version number is probably the best
>>way to handle this.  setup.exe currently uses the CVS version.  Use
>>that as an example.
>
>I was trying to avoid doing what setup.exe does.  In the Makefile.in
>there is a grep/sed combo that grabs the version from the Changelog and
>creates a file to include.  This is fine for a lot of files that
>compile into one (setup.exe) but is it really necessary for 13 utils,
>most of which take only one file of code?  What about a sed script that
>takes that CVS/Entries file and creates something like versions.c with:
>
>const char cygcheck_version[]= "1.23"; const char cygpath_version[]=
>"4.56";

Most of the utilities in winsup/utils consist of just one file.  So, there
is no reason to introduce a separate "version" file.  You just use the
cvs version of the file.

For multi-file programs like dumper and cygcheck, it's probably enough
just to use the same technique in the source file which contains main()
and let the person who checks stuff in remember to force a checkin for
the main file.

>which could then be #include'd in each file?  Then at least no one
>would have to edit the version code; it would just make.  (BTW, I used
>cygpath.cc as a reference point for the version code; it is currently
>in a hard-coded printf.)

Well, cygpath is wrong.  cygcheck is wrong too, under this scenario, but
not quite as wrong since it at leasts puts the version in its own
string.  I believe, it used to do something similar to cygpath but I
changed it, intending to, someday, make it use cvs versions.

cgf

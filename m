Return-Path: <cygwin-patches-return-3645-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22105 invoked by alias); 28 Feb 2003 05:11:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22094 invoked from network); 28 Feb 2003 05:11:31 -0000
Date: Fri, 28 Feb 2003 05:11:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: access () and path.cc
Message-ID: <20030228051131.GB23995@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030227230453.007d3a60@mail.attbi.com> <3.0.5.32.20030227230453.007d3a60@mail.attbi.com> <3.0.5.32.20030227235437.0080a480@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030227235437.0080a480@incoming.verizon.net>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00294.txt.bz2

On Thu, Feb 27, 2003 at 11:54:37PM -0500, Pierre A. Humblet wrote:
>At 11:36 PM 2/27/2003 -0500, you wrote:
>>Pierre,
>>You and Corinna are giving me a headache.  :-)
>
>My immediate access () problem can be fixed by replacing 
>real_path by fn in the stat_worker call.
>
>Problem #1 is a real bug, should be easy to fix, and may not
>show up anywhere anyway, so not urgent.

I've known about this for a while and I have never considered it a bug
worth fixing.  It should disappear in my branch since the code which
causes it to happen should also disappear.  Hmm.  I guess I'd better
make sure that's true now that I've said this.

>Problems #2 & 3 can be solved by 
>>For instance, wouldn't all this be alleviated just by using
>>cfg->get_name() rather than cfg->get_win32_name in the stat functions?
>at the expense of efficiency (most of the time).
>But efficiency can be revisited after you integrate your changes.

Right.  That call disappears in my code.

>BTW, I was looking at the path/fhandler code and came to the tentative
>conclusion that it shouldn't be necessary to keep both a Windows path 
>and a Unix path in the fhandler structures.
>For the files understood by Windows, I think the Windows path is enough.
>For the other files (most /dev, /proc), the Posix path should be OK.

The path_conv structure is passed around in fhandler_base in my code so
it's very different.  I'd have to check but I think that devices always
just show up as \dev\whatever.  hash_path_name sort of relies on windows
path names but that is not a huge deal.  It may not even be applicable
to devices.

Please remind me about all of this when I merge my branch to the trunk.
I think that some of these changes should probably be reverted in the
name of efficiency at that time.

cgf

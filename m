Return-Path: <cygwin-patches-return-3532-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6489 invoked by alias); 6 Feb 2003 18:51:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6472 invoked from network); 6 Feb 2003 18:51:58 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 06 Feb 2003 18:51:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: ntsec odds and ends
In-Reply-To: <20030206182837.GI21655@redhat.com>
Message-ID: <Pine.GSO.4.44.0302061349130.24824-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00181.txt.bz2

On Thu, 6 Feb 2003, Christopher Faylor wrote:

> On Thu, Feb 06, 2003 at 07:24:13PM +0100, Corinna Vinschen wrote:
> >On Thu, Feb 06, 2003 at 01:10:33PM -0500, Igor Pechtchanski wrote:
> >> No problem, I'll rewrite this (after actually looking at the code this
> >> time).  However, at least on my machine, most of the files, especially in
> >> /cygdrive/c, are owned by the Administrators group.  If it's not in
> >> /etc/passwd, most files show up with "????????" for the user, which is not
> >> very informative...
> >
> >Sure but in this case the admins group is treated as a user since it's
> >in the user entry of the file's security descriptor.
> >
> >I think we never get that right.  The problem is that the ls entries
> >only are 8 chars long, not enough to be really informative.  Whatever
> >you put in there ("unknown", "????????", "mkpasswd", "run mkpa",
> >"dumbass"), you will deterministically get confused users.
>
> Hey.  "dumbass".  That may be the best suggstion yet.  I'd definitely
> want to get rid of that if I saw it!  I'd probably spend some time
> researching how to do it.
>
> I like it!
> cgf

Hey, getting back to my "ls" idea - how about a flashing bright white
"dumbass" on a red background?  That's bound to get anyone's attention :-D
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Oh, boy, virtual memory! Now I'm gonna make myself a really *big* RAMdisk!
  -- /usr/games/fortune


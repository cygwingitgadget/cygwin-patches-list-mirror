Return-Path: <cygwin-patches-return-3529-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17544 invoked by alias); 6 Feb 2003 18:10:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17516 invoked from network); 6 Feb 2003 18:10:33 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 06 Feb 2003 18:10:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: ntsec odds and ends
In-Reply-To: <20030206174750.GK5822@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.44.0302061302440.16397-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00178.txt.bz2

On Thu, 6 Feb 2003, Corinna Vinschen wrote:

> On Thu, Feb 06, 2003 at 11:37:16AM -0500, Igor Pechtchanski wrote:
> > +<para>
> > +If a user or group is not present in <filename>/etc/passwd</filename> (or
> > +if a group is not present in <filename>/etc/group</filename>), it will have
> > +a special user/group id of -1 (which would be shown by <command>ls</command>
> > +as 65535).  In releases of Cygwin before 1.3.20, the user/group name shown
> > +was '????????'.  Since Cygwin release 1.3.20, the name of a user with no
> > +entry in <filename>/etc/passwd</filename> will be shown as `mkpasswd', and
> > +the name of a group not in <filename>/etc/group</filename> will be shown as
> > +`mkgroup', indicating the commands that should be run to alleviate the
> > +situation.
>
> Weeell... that's not quite correct, unfortunately.
>
> - If the current user doesn't show up in /etc/passwd, it's *group* will
>   be named "mkpasswd".
>
> - Otherwise, if the login group of the current user isn't in /etc/group,
>   it will be named "mkgroup".
>
> - otherwise a group not in /etc/group will be shown as "????????"
>   and a user not in /etc/passwd will be shown as "????????".
>
> Nevertheless, thanks for the effort :-)
> Corinna

Corinna,

No problem, I'll rewrite this (after actually looking at the code this
time).  However, at least on my machine, most of the files, especially in
/cygdrive/c, are owned by the Administrators group.  If it's not in
/etc/passwd, most files show up with "????????" for the user, which is not
very informative...
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Oh, boy, virtual memory! Now I'm gonna make myself a really *big* RAMdisk!
  -- /usr/games/fortune

Return-Path: <cygwin-patches-return-3523-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23640 invoked by alias); 6 Feb 2003 14:49:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23622 invoked from network); 6 Feb 2003 14:49:33 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 06 Feb 2003 14:49:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: ntsec odds and ends
In-Reply-To: <20030206140616.GF5822@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.44.0302060941150.15853-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00172.txt.bz2

On Thu, 6 Feb 2003, Corinna Vinschen wrote:

> On Wed, Feb 05, 2003 at 11:41:59AM -0500, Pierre A. Humblet wrote:
> > 2003-02-05  Pierre Humblet  <pierre.humblet@ieee.org>
> >
> > 	* security.h: Introduce names UNKNOWN_UID and UNKNOWN_GID and delete
> > 	declaration of is_grp_member.
> > 	* uinfo.cc (internal_getlogin): Use UNKNOWN_GID.
> > 	* passwd.cc (pwdgrp::read_passwd): Use UNKNOWN_UID.
> > 	* grp.cc (pwdgrp::read_group): Change group names to provide better
> > 	feedback.
> > 	(getgrgid): Use gid16togid32.
> > 	* sec_helper.cc (is_grp_member): Delete.
>
> Applied with changes:
>
> > -      char group_name [UNLEN + 1] = "mkgroup";
> > +      char group_name [UNLEN + 1] = "run mkgroup";
>
> I didn't commit this change.
>
> > +      if (myself->uid == UNKNOWN_UID)
> > +	strcpy (group_name, "run mkpasswd"); /* Feedback... */
>
> I've changed that to just "mkpasswd".
>
> I don't like to introduce group names with spaces in it.  And since they
> are longer than 8 chars, they'd get truncated by ls anyway.
>
> Thanks,
> Corinna

Umm, Corinna, suppose some misguided soul would actually create a user
named "mkpasswd" (or a group called "mkgroup")?  What then?  Perhaps a
note in the User Guide's ntsec section is in order?  Or an FAQ?

<WILD>
I just had another really wild idea (feel free to ignore): since we want
this visible in the "ls" output, suppose ls recognized these special names
you are going to use (whatever they are), and used the existing
"--color=auto" mechanism to output them in red to the terminal (and same
with numeric values, I guess)?  I mean, ls *never* colors the user and
group names, so it would be immediately visible...  Of course, the
drawback is that we might need to allow the user to customize this (the
color and all)...  Once the names for unknown user/group is decided, I
might take a stab at making this patch to "ls".
</WILD>
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Oh, boy, virtual memory! Now I'm gonna make myself a really *big* RAMdisk!
  -- /usr/games/fortune

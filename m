Return-Path: <cygwin-patches-return-1649-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12324 invoked by alias); 3 Jan 2002 09:41:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12306 invoked from network); 3 Jan 2002 09:41:13 -0000
Message-ID: <08dd01c1943a$cdbc5390$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	<cygwin-patches@sourceware.cygnus.com>
References: <NCBBIHCHBLCMLBLOBONKAEDICIAA.g.r.vansickle@worldnet.att.net>
Subject: Re: [PATCH] Setup.exe "other URL" functionality
Date: Thu, 03 Jan 2002 01:41:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 03 Jan 2002 09:41:12.0178 (UTC) FILETIME=[C7A81520:01C1943A]
X-SW-Source: 2002-q1/txt/msg00006.txt.bz2


===
----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
> > You should be ok with text mounts now, I think this problem cropped
up
> > due to the CRLF's in the repository. I'm checking in a new version
asap.
> >
>
> Ok, thanks.  As of this writing I don't see it yet - did you want me
to re-diff
> now that I'm able to cvs update (and have done so)?

No.. I'm waiting for your missing changelog smippet to do the checkin.

Rob

> > I'd like to point something out to you:
> > ==
> > - "\n%%% $Id: choose.cc,v 2.82 2002/01/01 12:32:36 rbcollins Exp
$\n";
> > + "\n%%% $Id: choose.cc,v 2.81 2001/12/23 12:13:28 rbcollins Exp
$\n";
> > ==
> >
> > Is a sure sign that your repository is out of date. (That's one
reason
> > those lines exist :]).
>
> Oh I know it is (well, was).  With cvs in a not-working-for-me state I
figured
> trying to sync up would be futile at best and counterproductive at
worst.  I had
> been monitoring the cygwin-cvs list and only saw Chris' Makefile.in
patches
> since my last patch, which I figured since my change was so minimal
would not
> cause too much trauma.
>
> BTW, you mentioned I should add this to my new files - what's being
keyed off of
> here (i.e. what do I put in the first one?)?  I didn't see anything in
man cvs
> or /usr/doc/cvs-whatever/ explaining this.

"\n%%% $Id$\n" is the string constant.

> > Another is to put your ChangeLog into the
> > ChangeLog file - if it shows anything other than your changelog when
you
> > create the diff, something has been checked in and raced with you.
> >
>
> Right, but I thought diffed ChangeLogs were taboo?

Yeah well, I'm not Chris :]. You do need to send in a straight forward
separate file with the ChangeLog regardless (for posterity), but I'll
never reject a patch for diffing ChangeLog itself.

> > I *think* I've got every change I committed eliminated from your
patch,
...
> Yeah, and I apologize if this is causing you a bunch of grief.  I
certainly had
> no intention of sloughing off a bunch of work onto you or anybody
else.

Apology accepted - no big deal.

> I did in fact review the patch, clearly not as thouroughly as I should
have, in
> addition to writing the ChangeLog in parallel with the code changes.
Again
> about all I can do is apologize; but hey, you did notice the strict
> 80-columness, right?  Oh yeah, that journey of a thousand miles just
got 80
> columns shorter ;-).

Woohoo! I should remember the Ass-U-Me rule of assumptions :}. Thanks
for going through these hoops - I do try to keep them as low to the
ground as possible.

> > Also, please get it the habit of
> > cvs -z3 update -Pd && cvs -z3 diff -up > foo.patch
> > to reduce the chances of diffing against an old sandbox from
happening.
> >
>
> At the risk of sounding even more defensive ;-), I am in that habit
(at least
> since the last patch), but again with cvs broke and me not knowing
what the heck
> was going on etc etc... well, second verse, same as the first. ;-)

You have a good excuse there :]. We'll just get CVS patched to handle
this....

> > Another way to prevent this is to checkout with -D 'now' (or if that
> > barfs -D '1 minute ago') which will cause the sandbox to be diffed
> > against the version you checked out, not the HEAD tag.
> >
>
> Oh, um, ok, for some reason I got the idea that on this one HEAD was
where the
> action was.  Right now I'm seeing no difference, but will do from now
on.

HEAD is where the action is. There are 2 main routes to clean patches:
1) An up to date sandbox (w.r.t. whatever tag you are tracking - ie
HEAD).
2) A point-in-time sandbox (-D "point in time").

2) is ideal if you are making major changes that you expect I might
break, or need a stable environment yourself for a while. Your diff when
it's created will occasionally fail to apply due to bad context (if the
context changes from -D"point in time" to HEAD, but if you tell me
the -D "point in time" you used (GMT required!) I can zip to that point
in time, apply your patch, and roll it forward easily.

Rob

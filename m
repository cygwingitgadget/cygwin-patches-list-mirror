Return-Path: <cygwin-patches-return-1648-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10861 invoked by alias); 3 Jan 2002 09:32:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10805 invoked from network); 3 Jan 2002 09:32:38 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] Setup.exe "other URL" functionality
Date: Thu, 03 Jan 2002 01:32:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKAEDICIAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <036901c19365$654f99a0$0200a8c0@lifelesswks>
Importance: Normal
X-SW-Source: 2002-q1/txt/msg00005.txt.bz2

> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com
> [mailto:cygwin-patches-owner@cygwin.com]On Behalf Of Robert Collins
>
> ----- Original Message -----
> From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
> > Yep, it looks like that combined with me now using binary mounts will
> work
> > around this.  For reasons I don't quite understand though, I couldn't
> simply do
> > a "cvs diff", but had to move my file (now with LFs-only), do a "cvs
> update" to
> > re-get the cvs version (which also has LFs-only now), replace that
> with the file
> > I just moved, and *then* it works.  I have no idea what to make of
> that.
>
> You should be ok with text mounts now, I think this problem cropped up
> due to the CRLF's in the repository. I'm checking in a new version asap.
>

Ok, thanks.  As of this writing I don't see it yet - did you want me to re-diff
now that I'm able to cvs update (and have done so)?

> I'd like to point something out to you:
> ==
> - "\n%%% $Id: choose.cc,v 2.82 2002/01/01 12:32:36 rbcollins Exp $\n";
> + "\n%%% $Id: choose.cc,v 2.81 2001/12/23 12:13:28 rbcollins Exp $\n";
> ==
>
> Is a sure sign that your repository is out of date. (That's one reason
> those lines exist :]).

Oh I know it is (well, was).  With cvs in a not-working-for-me state I figured
trying to sync up would be futile at best and counterproductive at worst.  I had
been monitoring the cygwin-cvs list and only saw Chris' Makefile.in patches
since my last patch, which I figured since my change was so minimal would not
cause too much trauma.

BTW, you mentioned I should add this to my new files - what's being keyed off of
here (i.e. what do I put in the first one?)?  I didn't see anything in man cvs
or /usr/doc/cvs-whatever/ explaining this.

> Another is to put your ChangeLog into the
> ChangeLog file - if it shows anything other than your changelog when you
> create the diff, something has been checked in and raced with you.
>

Right, but I thought diffed ChangeLogs were taboo?

> I *think* I've got every change I committed eliminated from your patch,
> but it adds an element of risk (backing out an important change) and
> plain old time-consumption I'd rather avoid. Having said that your patch
> is kinda important so I'm spending that time and updating your patch by
> hand. (in this case you missed Chris's Makefile fix as well and your
> patch backs it out :}.)
>

Yeah, and I apologize if this is causing you a bunch of grief.  I certainly had
no intention of sloughing off a bunch of work onto you or anybody else.

> I'm sure you would have caught this with a visual review of the patch
> (you don't recall changing io_stream.cc for instance do you :})... so
> can I suggest that you do such reviews in future? (I often catch last
> minute errors with such self-QA). Also in the line of visual reviews,
> propsheet.cc is in the diff (non ^M issue) but not the ChangeLog. Please
> send me the relevant 'bit' and I'll check the lot in (I have everything
> in my sandbox... just ned this one missing bit).
>

Grrrrrrrrrrr, how the heck did I miss that?!  Ok, I see, I sort of didn't, but I
only got ~1/3rd of it.  Dag nabbit, I'm this close to pounding out a Perl script
to either check these godforsaken things, or generate at least a skeleton for
them.

I did in fact review the patch, clearly not as thouroughly as I should have, in
addition to writing the ChangeLog in parallel with the code changes.  Again
about all I can do is apologize; but hey, you did notice the strict
80-columness, right?  Oh yeah, that journey of a thousand miles just got 80
columns shorter ;-).

> Also, please get it the habit of
> cvs -z3 update -Pd && cvs -z3 diff -up > foo.patch
> to reduce the chances of diffing against an old sandbox from happening.
>

At the risk of sounding even more defensive ;-), I am in that habit (at least
since the last patch), but again with cvs broke and me not knowing what the heck
was going on etc etc... well, second verse, same as the first. ;-)

> Another way to prevent this is to checkout with -D 'now' (or if that
> barfs -D '1 minute ago') which will cause the sandbox to be diffed
> against the version you checked out, not the HEAD tag.
>

Oh, um, ok, for some reason I got the idea that on this one HEAD was where the
action was.  Right now I'm seeing no difference, but will do from now on.

> > But there's a few more files that need this treatment (it looks like
> they're
> > still CRLF in the repository database):
> .
> > So almost but not quite every new file I sent you (or maybe that is
> all of
> > them).  And these were all CRLFs.
>
> Fixed. (I noticed you'd patched that after... doh!)
>

Great, thanks.  I can verify that I'm getting cvs diffs that look sane now.  I
still have the cygwin tree on a binary mount for the time being, and I think
I'll stay that way for a while until I feel like flirting with disaster again
;-).

[snip]

>
> So in short, please run indent, and I'll abide by it's output.

Ok, sounds good.

But guess what doesn't?  I'm all updated now, everything's building fine (one
change in Makefile.in though), it runs... and now it's not completing the
setup.ini download.

Uff da.

--
Gary R. Van Sickle
Brewer.  Patriot.

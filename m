Return-Path: <cygwin-patches-return-1641-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17108 invoked by alias); 31 Dec 2001 10:55:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17094 invoked from network); 31 Dec 2001 10:55:39 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] Setup.exe "other URL" functionality
Date: Fri, 09 Nov 2001 07:13:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKOECACIAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <0a2c01c191ab$3629f8c0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/txt/msg00173.txt.bz2

[snip]

> - are you perhaps saying site.cc when you mean window.{cc,h},
> which have
> > the "every line though identical is different to CVS" problem?
>
> No, I mean site.cc. At the top in save_dialog, there is a new if
> construct you've added, and at the end of it is visible
>     }
>     }
>
> (thats two  curly brackets at the same indent).

Ah, ok.  If you already hadn't noticed, indent's "Midas Touch" is doing that to
me in every file I send to you (dives for cover ;-)).

Actually, it looks like it's not just me either; take a look at this from
log.cc/log_save:

"
  for (l = first_logent; l; l = l->next)
    {
      if (babble || !(l->flags & LOG_BABBLE))
	{
	  fputs (l->msg, f);
	  if (l->msg[strlen (l->msg) - 1] != '\n')
	    fputc ('\n', f);
	}
    }
"

This may or may not look OK to you, but what's happening is that it's mixing
tabs and spaces for some reason: "for" is spaced, "if" is tabbed.  With tabs==4
spaces, they'll line right up.

> Where you added the if,
> the body thereof hasn't been indented. Running it through indent here
> fixed it.
>

"Here" being indent 2.2.7 on Linux, or on Cygwin?  I just changed my Cygwin
source dir to binary mounts, d2u'ed site.cc, and indent produces exactly the
same results.  Worse yet, so does CVS - d2u'ing window.cc *still* results in
every line showing up as changed.  I know for a fact that the binary mounts
took, since I had to d2u the files in the /CVS/ directories or it couldn't read
the Repository etc files and was giving me errors.

I tried simply checking out a file, touching it, and then "cvs diff"ing it.  No
problems there.  I did notice that on at least two files, window.cc and
threebar.cc, they check out as CRLF files even though I'm now on binary mounts,
and "cvs diff"ing against CRLF files on a binary mount seems to work.  But then
when I run indent on them they get changed back into LF-only, and then every
line cvs diff's as different.

BUT, log.cc checks out as LF-only.  Completely wiping out the formatting in
Textpad (which preserves LF-onlys) and indenting leaves the file as LF-only, and
surprise, surprise, "cvs diff" now works.  So it looks to me like the immediate
problem is CRLF files in the repository, and the long-term solution to not have
CVS care what the line endings of text files in its repository are.

I'll copy this to the cygwin list in the hope it will help Charles and anybody
else struggling with this.

[snip]

> The ones that are downloaded fresh will eventually not get downloaded.
> See README - it's in there.
> Long term what will happen is:
> 1) A new user downloads the mirror.lst to bootstrap their local list.
> 2) Special sites - like sources.redhat.com are trimmed.
> 3) The user adds any sites.
> 4) The known list is stored on disk, as well as the users selections.
> 5) The user does an install/download, and _setup.ini_ contains an
> additional list of known mirror sites, (and potentially a list of known
> dead sites) that gets merged into the known list.
> 6) On subsequent runs 1) is skipped.
>
> At the moment, 2,3,4 (minus storing the known list) are complete. I
> don't see any point in indicating the difference in the list. Think of
> apt, or rpm-find. The user should be able to do _anything_ they want to
> that list. Remove ALL the sites if they desire (although setup.ini
> contained ones would repopulate every run).
>

Without thinking about it too hard, this sounds both very cool and a potential
nightmare.  What happens if a "malicious mirror" somehow makes it onto the
distributed list and starts spreading trojans or something?

> As far as UI goes, I think the combobox + a text box for the new site is
> fine. But rather than a radio button to choose which is used, have an
> Add button to the right of the textbox, and also make Enter in the
> textbox trigger an add. Remove can be done by a button 'Delete selected
> sites' that does just that.
>

Yeah, that's what I'm thinking (and working on) right now.  How about an "Are
you sure you want to add <Insert URL here>?" MessageBox at least until "Remove"
is implemented (assuming "Remove" is more work than I want to do for this
patch)?

--
Gary R. Van Sickle
Brewer.  Patriot.

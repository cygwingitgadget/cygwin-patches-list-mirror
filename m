Return-Path: <cygwin-patches-return-4867-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17106 invoked by alias); 21 Jul 2004 00:39:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17097 invoked from network); 21 Jul 2004 00:39:04 -0000
Date: Wed, 21 Jul 2004 00:39:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix dup for /dev/dsp
Message-ID: <20040721003817.GB14953@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01C46EB5.719F55A0.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01C46EB5.719F55A0.Gerd.Spalink@t-online.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00019.txt.bz2

On Tue, Jul 20, 2004 at 11:58:23PM +0200, Gerd Spalink wrote:
>Yes, I have had a look at archetypes, and I just checked again.
>What I see is one instance counter (usecount) and a pointer (archetype)
>and a dependency into cygheap (cygheap->fdtab.find_archetype and others).
>My patch needs two additional pointers, so in terms of member variables,
>it is cheap.
>Also, I don't understand why archetypes work for any close sequence of
>duped instances?

Given that there have been no complaints about memory corruption, or whatever
you're anticipating here, I think it is safe to assume that it is working
ok.

A dup is basically an increment of a use count and a copy of a pointer.
A close is a decrement of a use count.

>Is the archetype pointer always valid?

As long as the usecount is > 0, yes.

>It it pointing to the heap? and where/when is it freed?

It's pointing into the same place most fhandler objects live -- the
cygheap.

It's freed (i.e., you free it) when the usecount reaches 0.

>Is the fhandler object's data in the object or on the heap?

See above.

>How to keep consistency after a state change?

Too generic a question.  Can't answer.

>I also found discouraging comments in the code, like
>  // FIXME: Do this better someday

There are discouraging statements throughout cygwin.  That doesn't mean
that we stop using signals because sigproc.cc has a couple of FIXMEs.

>Personally, I prefer not to spread dependencies too much, so I would 
>suggest to leave fhandler_dsp as I suggested in the patch. Most of the
>changes were done in the ioctl function, which is not affected whether
>we use archetypes or a linked list.

I don't entirely understand what you are talking about wrt dependencies.
fhandler_dsp.cc does not exist in an island.  It is part of the rest
of the cygwin source code base.

I'd rather not have islands of code within cygwin where one person
decided they could ignore much of the rest of the code.  There have been
a couple of sections in cygwin like this where a developer didn't really
understand how the rest of cygwin operated and ended up writing their
own methods for doing things.  That is something that should be avoided,
especially since developers drop out from time to time and leave the
rest of us to scratch our heads over their ideas of how things should be
done.

cgf

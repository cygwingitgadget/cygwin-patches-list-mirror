From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: fhandler_console
Date: Fri, 02 Mar 2001 04:24:00 -0000
Message-id: <20010302132358.Q5481@cygbert.vinschen.de>
References: <16286062992.20010216183758@logos-m.ru> <20010219214951.A23483@redhat.com> <7888578378.20010220130012@logos-m.ru> <17613156858.20010223151715@logos-m.ru> <20010226191432.E6209@redhat.com> <20010228182620.R8464@cygbert.vinschen.de> <109112986916.20010228215037@logos-m.ru> <20010228203308.V8464@cygbert.vinschen.de> <83117508187.20010228230559@logos-m.ru> <20010301101600.C874@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00140.html

Egor,

the problem disappeared after a full rebuild of Cygwin today.
I fear I have created the problem by myself for some reason.
The rebuild solved the problem immediately. Is it possible
that you always need a full rebuild after there's a change
in class hierarchies? Your change has moved some class members
in the fhandler class hierarchy, so...

Sorry for making trouble,
Corinna

On Thu, Mar 01, 2001 at 10:16:00AM +0100, Corinna Vinschen wrote:
> On Wed, Feb 28, 2001 at 11:05:59PM +0300, Egor Duda wrote:
> > Hi!
> > 
> > Wednesday, 28 February, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:
> > 
> > CV> On Wed, Feb 28, 2001 at 09:50:37PM +0300, Egor Duda wrote:
> > >> Wednesday, 28 February, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:
> > >> 
> > >> CV> your patch seems to have some problems on the local console window
> > >> CV> at least on W2K.
> > >> 
> > >> CV> When I open a console window with
> > >> 
> > >> CV> tcsh, CYGWIN=tty: Only the first line is used at all. The background
> > >> CV>                   color of the prompt is correct, behind the cursor
> > >> CV>                   it's inverted.
> > >> 
> > >> CV> bash, CYGWIN=tty: The first line is inverted, no cursor, no interaction.
> > >> 
> > >> CV> tcsh, CYGWIN=notty: Crash, ia message box tells me that an instruction
> > >> CV>                     at address x61061d48 points to 0x00000068.
> > >> 
> > >> CV> bash, CYGWIN=notty: Same behaviour as tcsh with CYGWIN=tty, really!
> > >> 
> > >> CV> When I revert the patch to fhandler_console.cc, everything is ok.
> > >> 
> > >> hmm.  i  cannot test in on win2k right now, but can you please test it
> > >> with  attached terminfo entry? 
> > 
> > CV> No avail.
> > 
> > >>  Would you mind sending me bash and tcsh rc  files?
> > 
> > CV> I'll send them with private email.
> > 
> > tested  them  with  your  rc files, it still works ok. can you send me
> > strace for first and/or second case?
> 
> Ok. With private mail.
> 
> Corinna
> 
> -- 
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Developer                                mailto:cygwin@cygwin.com
> Red Hat, Inc.

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

Return-Path: <cygwin-patches-return-1494-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 22999 invoked by alias); 14 Nov 2001 15:09:37 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 22985 invoked from network); 14 Nov 2001 15:09:37 -0000
Date: Wed, 10 Oct 2001 19:25:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: [PATCH] Mask mnemonics and expressions, help, getopts_long() for strace - current diff
Message-ID: <20011114160931.B27452@cygbert.vinschen.de>
Mail-Followup-To: Corinna Vinschen <cygwin-patches@cygwin.com>,
	cygwin-patches@sourceware.cygnus.com
References: <20011114124520.A27350@cygbert.vinschen.de> <NCBBIHCHBLCMLBLOBONKOEFDCHAA.g.r.vansickle@worldnet.att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NCBBIHCHBLCMLBLOBONKOEFDCHAA.g.r.vansickle@worldnet.att.net>; from g.r.vansickle@worldnet.att.net on Wed, Nov 14, 2001 at 08:59:18AM -0600
X-SW-Source: 2001-q4/txt/msg00026.txt.bz2

On Wed, Nov 14, 2001 at 08:59:18AM -0600, Gary R. Van Sickle wrote:
> > > +  -f, --fork-debug              ???\n\
> >
> > The usage information for -f is missing.  -f means, trace not only
> > the application on the command line but also child apps forked by
> > the originally traced app.
> >
> 
> Ok, thanks, yeah, I forgot to ask what that did.  In light of that, perhaps the
> long option would be better if it was something like "--trace-children" or
> "--trace-forked-children"?

Hmm,  --trace-forkee?  --trace-over-fork?  I'm not sure either.

Would be better if english would be my first language, I guess.

> > > +  -d, --delta                   Add a delta-t timestamp to each
> > output line.\n\
> >
> > Giving the -d option doesn't show the delta but removes it from the output.
> > That should be the other way around.
> >
> 
> So it does (well, more precisely it appears to switch from delta to absolute).
> I thought sure I checked that.  I'll change the longopt to "--absolute" and
> update the usage text.  Is "-d" too entrenched at this point to change it to
> "-a" at the same time and make things a little more consistent?

Uhm, from what I could see it actually just removes the delta from
the output.  Since there is already an absolute stamp,  I don't
think changing the option to -a,--absolute makes sense.  Just
use -d,--no-delta and stuck with the current behaviour.

> > > +  -u, --usecs                   Add a microsecond-resolution
> > timestamp to each
> > > +                                output line.\n\
> >
> > -u seem to have no effect on the output.
> >
> 
> It appears that this option is either being ignored by the rest of the code or
> isn't implemented properly, I can't tell which.  The 'usecs' global switch
> variable is used only in syst(), and even there apparently not as a switch.
> Then in handle_output_debug_string() there's a local of the same name declared.
> 
> I think what I'll do is just remove this from the usage text until I can figure
> this out and/or somebody can explain it to me.  Maybe this option should just be
> removed completely.

Yeah, from that point of view...  FWIW, it could make sense to remove
the output... Hmm, dunno. 

Any other opinion on that?

> Done and done.  I'll generate a new diff tonight.  Sorry about the problems,
> thanks for catching them.

Sure.  You're welcome.  I recall that my first patches back in 1998
weren't clean either :-)

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

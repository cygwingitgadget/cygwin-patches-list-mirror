From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] Mask mnemonics and expressions, help, getopts_long() for strace - current diff
Date: Wed, 14 Nov 2001 06:59:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKOEFDCHAA.g.r.vansickle@worldnet.att.net>
References: <20011114124520.A27350@cygbert.vinschen.de>
X-SW-Source: 2001-q4/msg00221.html
Message-ID: <20011114065900.T4CR9Ofkl2fGwbWA6jYEybqqFmP1gDPLcSZ0qAF_KzA@z>

> On Wed, Nov 14, 2001 at 03:59:13AM -0600, Gary R. Van Sickle wrote:
> > Patch of 11-4 diffed against current CVS.
>
> Thanks, Gary.
>
> I applied the patch locally but I'm somewhat reluctant to apply it
> to the repository.  I found some flaws:
>
> The indenting isn't according to the GNU rules:
>

[snip]

Ok, fixed with a little help from indent.  Sorry about that.

>
> > +  -f, --fork-debug              ???\n\
>
> The usage information for -f is missing.  -f means, trace not only
> the application on the command line but also child apps forked by
> the originally traced app.
>

Ok, thanks, yeah, I forgot to ask what that did.  In light of that, perhaps the
long option would be better if it was something like "--trace-children" or
"--trace-forked-children"?

> > +  -n, --error-number            Also output associated Windows
> error number.\n\
>
> Giving the -n option doesn't show the error number but removes it in
> favor of the error text.  That should be the other way around.  Is it
> intended that the error text completely removes the output of the
> error number?  The help text is talking about `also output ...'.
>

Your right, I got this exactly backwards.  I'll clear that up.

> > +  -d, --delta                   Add a delta-t timestamp to each
> output line.\n\
>
> Giving the -d option doesn't show the delta but removes it from the output.
> That should be the other way around.
>

So it does (well, more precisely it appears to switch from delta to absolute).
I thought sure I checked that.  I'll change the longopt to "--absolute" and
update the usage text.  Is "-d" too entrenched at this point to change it to
"-a" at the same time and make things a little more consistent?

> > +  -u, --usecs                   Add a microsecond-resolution
> timestamp to each
> > +                                output line.\n\
>
> -u seem to have no effect on the output.
>

It appears that this option is either being ignored by the rest of the code or
isn't implemented properly, I can't tell which.  The 'usecs' global switch
variable is used only in syst(), and even there apparently not as a switch.
Then in handle_output_debug_string() there's a local of the same name declared.

I think what I'll do is just remove this from the usage text until I can figure
this out and/or somebody can explain it to me.  Maybe this option should just be
removed completely.

> > +  -t, --timestamp               Add an hhmmss timestamp to each
> output line.\n\
>
> -t shows the hhmmss timestamp but also removes both, delta and usecs output.
> Is that intended?

From what I can tell, yes.  I didn't change any of the option semantics or
output logic.

>  The help text suggests that it's just added.
>

Ok, I'll clarify that.

> About the version information... What about adding an SCCSid to the
> source which then is used by the version output?  We could begin
> with version 1.0:
>
>   static char *SCCSid = "@(#)strace V1.0, Copyright (C) 2001 Red Hat
> Inc., " __DATE__ "\n";
>
>   static void version ()
>   {
>     printf ("%s", SCCSid + 4);
>   }
>

Done and done.  I'll generate a new diff tonight.  Sorry about the problems,
thanks for catching them.

--
Gary R. Van Sickle
Brewer.  Patriot.

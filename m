From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: [PATCH] Mask mnemonics and expressions, help, getopts_long() for strace - current diff
Date: Wed, 14 Nov 2001 03:45:00 -0000
Message-ID: <20011114124520.A27350@cygbert.vinschen.de>
References: <NCBBIHCHBLCMLBLOBONKIEFCCHAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00220.html
Message-ID: <20011114034500.U1PbPY3dX-bSGAwNL3nvt9GcN6jsDb_rN1Y-fEccErI@z>

On Wed, Nov 14, 2001 at 03:59:13AM -0600, Gary R. Van Sickle wrote:
> Patch of 11-4 diffed against current CVS.

Thanks, Gary.

I applied the patch locally but I'm somewhat reluctant to apply it
to the repository.  I found some flaws:

The indenting isn't according to the GNU rules:

Each block is indented by 2 more spaces, that's not given in version()
and mnemonic2ul().  Each parenthesis gets a leading space, even
function paren's.  Except it's leaded by another paren.

Your mnemonic2ul():

  while(mnp->text != NULL)
  {
        if(strcmp(mnp->text, nptr) == 0)
        {
          // Found a match.
          if(endptr != NULL)
          {
            *endptr = ((char*)nptr) + strlen(mnp->text);
          }
          return mnp->val;
    }
    mnp++;
  }
  [...] 

Correctly indented and correctly usage of spaces:

  while (mnp->text != NULL)
    {
      if (strcmp (mnp->text, nptr) == 0)
        {
          // Found a match.
          if (endptr != NULL)
            {
              *endptr = ((char*)nptr) + strlen(mnp->text);
            }
          return mnp->val;
        }
      mnp++;
    }
  [...]

> +  -f, --fork-debug              ???\n\
 
The usage information for -f is missing.  -f means, trace not only
the application on the command line but also child apps forked by
the originally traced app.
 
> +  -n, --error-number            Also output associated Windows error number.\n\

Giving the -n option doesn't show the error number but removes it in
favor of the error text.  That should be the other way around.  Is it
intended that the error text completely removes the output of the
error number?  The help text is talking about `also output ...'.

> +  -d, --delta                   Add a delta-t timestamp to each output line.\n\

Giving the -d option doesn't show the delta but removes it from the output.
That should be the other way around.

> +  -u, --usecs                   Add a microsecond-resolution timestamp to each
> +                                output line.\n\

-u seem to have no effect on the output.

> +  -t, --timestamp               Add an hhmmss timestamp to each output line.\n\

-t shows the hhmmss timestamp but also removes both, delta and usecs output.
Is that intended?  The help text suggests that it's just added.

About the version information... What about adding an SCCSid to the
source which then is used by the version output?  We could begin
with version 1.0:

  static char *SCCSid = "@(#)strace V1.0, Copyright (C) 2001 Red Hat Inc., " __DATE__ "\n";

  static void version ()
  {
    printf ("%s", SCCSid + 4);
  }


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

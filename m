From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: setup's list of sites
Date: Thu, 18 May 2000 14:45:00 -0000
Message-id: <20000518174513.A18088@cygnus.com>
References: <200005181954.PAA26096@envy.delorie.com>
X-SW-Source: 2000-q2/msg00063.html

On Thu, May 18, 2000 at 03:54:53PM -0400, DJ Delorie wrote:
>
>Objections?  Comments?
>
>2000-05-18  DJ Delorie  <dj@cygnus.com>
>
>	* setup.c (optionprompt): allow multi-column, clean up message
>	about more options, be more robust about user input.
>	(getdownloadsource): make the mirror URL a macro.
>	(main): do mounts after done prompting user.

Looks good except that isn't this construction:

  for (n=0; n<options->count; n++)

not in compliance with the FSF coding style?

I also have some changes that I have been meaning to check in which
deal with fixing some C warnings and adding the ability to run a .bat
file after a package has been extracted.

cgf


>Index: setup.c
>===================================================================
>RCS file: /cvs/src/src/winsup/cinstall/setup.c,v
>retrieving revision 1.43
>diff -p -3 -r1.43 setup.c
>*** setup.c	2000/05/02 05:00:22	1.43
>--- setup.c	2000/05/18 19:53:10
>***************
>*** 36,45 ****

From: Brian Keener <bkeener@thesoftwaresource.com>
To: DJ Delorie <dj@delorie.com>
Cc: cygwin patches <cygwin-patches@sources.redhat.com>
Subject: Re: [patch] Setup.exe choose.cc selection enhancement based on file existence
Date: Tue, 06 Feb 2001 19:41:00 -0000
Message-id: <VA.0000062f.02ffe21e@thesoftwaresource.com>
References: <200102070226.VAA23607@envy.delorie.com>
X-SW-Source: 2001-q1/msg00051.html

DJ Delorie wrote:
> This is big enough to require legal papers.  Chris, do we have them
> from Brian?

Probably not - you only ever asked for a verbal okay from me about my self employment and that no 
employer would object.

> 80 colums or so?  Use a helper macro if that makes it more readable.

I will work on it and see about shortening them.  Being that I am a newbie though, and I hate to admit 
this, but I don't know how to use a helper macro.  And I hate to break this into a bunch of nested 
ifs.

> I suggest "check_src" instead of "which_file".  It's more intuitive
> that way.

I can do that - makes sense to me

> > + /*  TRUST_PREV=0, TRUST_CURR=1,TRUST_TEST=2,NTRUST=3 and TRUST_UNKNOWN =3 (deliberately left out 
> > of NTRUST */
> 
> Why is this comment here?

Was a reminder for me what the values were - I can remove it.

> > +                package[i].info[t].in_partial_list = 1-package[i].info[t].install_exists;
> 
> Use !, not 1-, for boolean inversion.  Don't rely on the value being 0 or 1.
> 
Actually - would you believe I had it that way at first and then ended up changing it because of some 
bug I was chasing which this probably wasn't related to anyway

> 
> More wrapping.  Check them all; I won't comment on any others I find.
> 
I'll work on them.

> > -        /* we intentionally skip TRUST_PREV */
> > -        if (t != TRUST_PREV || !extra[i].installed_ver)
> > -   extra[i].in_partial_list = 1;
> > - 
> 
> Nearly all packages have a previous version available.  If you don't
> skip TRUST_PREV (at least, in the old source), all packages end up
> being listed in the partial list, because there's always something the
> user can do.  This wasn't the "right thing" to do for most people.
> What happens with your changes?
> 
Actually,  my version bases it on what is installed and which is selected (Prev, Curr, and Test) and 
whether we selected to do a net install, download or installed from a local directory.  My trust is 
only based what they selected (IE: Prev, Curr, Test) and then if the file exist and we selected 
install from local directory or doesn't exist and we selected download or if we selected install from 
net.  Based on the installation method and what trust we selected will dictate what files will be 
displayed in the partial list.  If I selected Download - only files which do not already exist are 
displayed and if I selected install from local directory then only files which do exist are displayed.
Based on which I selected (curr,prev,test) then I will display and select the appropriate caption by 
default those file which currently do not have that version installed.  You really need to give it a 
try.

> >       Char *install; /* file name to install */
> >       int install_size; /* in bytes */
> > +     int install_exists; /* install file exists on disk */
> 
> You shouldn't need this.  If the install file doesn't
> exist, then 'char *install' would be NULL.

I do a little more with *install and there may be a name there but the install_exists is actually 
telling me do I have a file on disk or not so I know what to do in a download or install from local 
directory scenario.

> 
> > +     int source_exists;  /* source file exists on disk */
> 
> Ditto here.

Ditto - see previous answer.
> 
> > +     int in_partial_list;/* display this version in partial list */
> 
> This shouldn't be here; it's private to the chooser.  It
> should go in chooser's corresponding struct.

This is new.  It is still in both places - in chooser it pertains to the different versions whereas 
this one I added pertains to the package as a whole.



From: DJ Delorie <dj@delorie.com>
To: bkeener@thesoftwaresource.com
Cc: cygwin-patches@sources.redhat.com
Subject: Re: [patch] Setup.exe choose.cc selection enhancement based on file existence
Date: Tue, 06 Feb 2001 20:37:00 -0000
Message-id: <200102070436.XAA24544@envy.delorie.com>
References: <VA.0000062f.02ffe21e@thesoftwaresource.com>
X-SW-Source: 2001-q1/msg00053.html

> DJ Delorie wrote:
> > This is big enough to require legal papers.  Chris, do we have them
> > from Brian?
> 
> Probably not - you only ever asked for a verbal okay from me about my self employment and that no 
> employer would object.

Oh, right.

> > 80 colums or so?  Use a helper macro if that makes it more readable.
> 
> I will work on it and see about shortening them.  Being that I am a
> newbie though, and I hate to admit this, but I don't know how to use
> a helper macro.  And I hate to break this into a bunch of nested
> ifs.

At least put in a newline here and there ;-)

> and if I selected install from local directory then only files which do exist are displayed.

Um, even if they're already installed?

> > > +     int in_partial_list;/* display this version in partial list */
> > 
> > This shouldn't be here; it's private to the chooser.  It
> > should go in chooser's corresponding struct.
> 
> This is new.  It is still in both places - in chooser it pertains to
> the different versions whereas this one I added pertains to the
> package as a whole.

Then you need to change the comment to reflect that.

I'd also recommend using a different name to prevent confusion.

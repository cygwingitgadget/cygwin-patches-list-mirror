From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches@cygwin.Com, Christopher Faylor <cgf@redhat.com>
Subject: Re: [Patch] setup.exe - no skip/keep option buggyness
Date: Mon, 12 Nov 2001 18:11:00 -0000
Message-ID: <VA.000009d3.0210da6e@thesoftwaresource.com>
References: <OE65oDk9X2VFyBUMeEk0000ecac@hotmail.com> <01fe01c16916$a920a350$0200a8c0@lifelesswks> <3BEBC8F6.3B150BA3@yahoo.com> <021401c16976$7a591380$0200a8c0@lifelesswks> <3BEFCB8E.C0507FBD@yahoo.com> <02c901c16bca$1a7e5fa0$0200a8c0@lifelesswks> <20011112224913.GA25415@redhat.com>
X-SW-Source: 2001-q4/msg00208.html
Message-ID: <20011112181100.Mof4XS1h3T-2LxG6-0GprkuqpUlvi2yLgocBTQDzBFE@z>

Christopher Faylor wrote:
> On Tue, Nov 13, 2001 at 09:33:50AM +1100, Robert Collins wrote:
> >I'm happy for this to be debated to death for the HEAD branch though.
> >I'm not convinced that having a separate skip/keep for the user makes
> >sense, but then I'm not convinced that a spin control is best their
> >either..
> 
> FWIW, I agree on both counts.
> 
> cgf
>

Just to throw my two cents worth in - I kind of like the keep/skip and the spin 
control.  The keep/skip makes perfect sense to me - I have a package listed in 
the installed column of choose and I select keep - I want to keep that version 
installed.  I have nothing displayed in the installed column - I select skip - 
I still want nothing installed, in my way of thinking.  I would not select 
"keep" if I had nothing of that package installed anyways.  I am not saying you 
should ever have both options, that is a definite no-no but one or the other in 
the right cases makes seems right to me.  I would/could select "skip" if I did 
have the package installed and it would make sense but I think if something is 
installed then "keep" really makes better sense.  It is still all semantics - 
ultimately behind the scenes they accomplish the same thing, but we do need to 
think of the clarity for the novice.

As to the spin control, I like it - but everyone elses discontent with it makes 
me ask - what do you envision in its place - I might like that better.

bk


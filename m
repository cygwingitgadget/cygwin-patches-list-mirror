From: Robert Collins <robert.collins@itdomain.com.au>
To: Warren Young <warren@etr-usa.com>
Cc: Cygwin Patches <cygwin-patches@sourceware.cygnus.com>
Subject: Re: *.cwp file recognistion patch for setup
Date: Tue, 11 Sep 2001 06:36:00 -0000
Message-id: <1000215434.7293.235.camel@lifelesswks>
References: <999956948.9501.93.camel@lifelesswks> <3B9DD027.7C8A87A8@etr-usa.com>
X-SW-Source: 2001-q3/msg00125.html

On Tue, 2001-09-11 at 18:49, Warren Young wrote:
> Robert Collins wrote:
> > 

> > 3) You've got magic numbers in the code (*groan*). 
> 
> I agree that unexplained magic numbers are bad.  However, hiding them
> behind a const or #define declaration isn't the right thing in this
> case.  Perhaps a comment would be better, like "// Check for gzip magic
> number".  It would be different if the constants were used in more than
> one place, but they're not -- they're used once each, within a
> well-named function.  

Yes. I agree, one can go to far with defines. 
 
> > GZ_MAGIC vs \037\213; they become centralised (easily accessible list of
> > known identifiers, even if the code is more spread out), and they can
> > get reused, if the same test needs to be made in different contexts and
> > a function isn't appropriate.  
> 
> This is the real problem: that setup has file type recognition logic
> spread about through the code.  There should be one
> function/object/whatever that setup.exe code can ask "what kind of file
> is this?".  Then concerns over magic numbers don't matter -- the whole
> purpose of the recognizer is to recognize special constants like magic
> numbers and file name extensions.
> 
> I think the gzbz class is a good start towards this.  The class factory
> I added is a necessary procedural extension to that, since C++ doesn't
> have "virtual constructors".

Sure, A class factory approach is good way to do it. Thats really what I
meant by "magic constructor". OOP terminology is not my friend. I guess
What I'm really saying is that the class hierarchy is still too disjoint
and procedure based for this to fit in cleanly. 

> > 5) in find_tar_ext, you shouldn't need to copy the path, strrchr is non
> > dsestructive.
> 
> Strrchr() isn't destructive, but _I_ am.  :)  I have to replace the last
> dot with a null character so I can call strrchr again.  Unfortunately,
> that's the only way -- strrchr isn't like strchr, which effectively lets
> you tell it where to begin looking.  Strrchr() only begins looking at
> the end of the string, so I have to modify the string to redefine where
> the "end" is.

My bad. Anyway, as we seem to agree that pathnames should be irrelevant
the class factory should not be taking pathnames but a stream (whatever
gzbz output today, not necessarily a C++ "stream", so that it can be fed
internet data/local files/compressed files.

> > 1) just _ignore_ the file extention. 
> 
> I agree.  My original patch was a trivial patch to add this
> functionality -- this was one of the design goals, if you saw the
> argument in the "press for cygwin" thread.  :)  Now it seems the Cygwin
> team wants it done right, and not just "done".  Okay, I can do that
> instead, now that the point has been made.  :)

Yes, I recall Chris's comment about non-trivial. This is really the
point - "we" can put a trivial patch into setup, but peer review means
that "we" will all pull it to pieces. So a non-trivial, done the "Right
Way" patch is needed... 
 
> I will have to mull the rest of your comments over and to study the
> code, to ask setup.exe what it wants to become.

Depends who you ask :}. More flexibility and OOP designed in my view
will let it grow smoothly as needed...

> All I ask is that, if I'm going to make a serious code cleanup effort
> here, that the result will be accepted.  Does the Cygwin team really
> want this done, or am I just hearing "wouldn't it be nice if..."?

I would dearly love to be able to "trivially" add code to support
deb/rpm style metadata in the actual package archives, to make local
package scanning more robust (imagine if setup can read in the category
from the package). That requires that we can read multiple files from a
package file - 1 tar with the content, and 1 or more control files. And
if they can be (t)ar files as well, well so much the better for clarity.

So the rationalisation of setup is needed. The magic file detection IMO
is needed for that rationalisation to work robustly. So yes I think it
is much needed and will be a valued contribution.

Thats not to say it won't get picked at until it's "Right". My category
and dependency stuff went through quite a few iterations. The bits that
looked right at each point went in if they weren't disruptive, and round
we went.

Thanks again for taking the time to do this.

Rob

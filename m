From: Warren Young <warren@etr-usa.com>
To: Cygwin Patches <cygwin-patches@sourceware.cygnus.com>
Subject: Re: *.cwp file recognistion patch for setup
Date: Tue, 11 Sep 2001 01:49:00 -0000
Message-id: <3B9DD027.7C8A87A8@etr-usa.com>
References: <999956948.9501.93.camel@lifelesswks>
X-SW-Source: 2001-q3/msg00124.html

Robert Collins wrote:
> 
> 1) the #if 1...#else...#endif's. 

Terribly sorry about that.  I didn't mean to slip that out, and should
have caught it while checking the patch.  I had that stuff in there just
while I was working on it, and intended to remove it once I was happy
with my changes, before submitting diffs.

> 3) You've got magic numbers in the code (*groan*). 

I agree that unexplained magic numbers are bad.  However, hiding them
behind a const or #define declaration isn't the right thing in this
case.  Perhaps a comment would be better, like "// Check for gzip magic
number".  It would be different if the constants were used in more than
one place, but they're not -- they're used once each, within a
well-named function.  

Constants are for when you're using the magic values in multiple places,
or at least intend that they may be used elsewhere.  The rest of your
comments tell me that that shouldn't happen here.

> GZ_MAGIC vs \037\213; they become centralised (easily accessible list of
> known identifiers, even if the code is more spread out), and they can
> get reused, if the same test needs to be made in different contexts and
> a function isn't appropriate.  

This is the real problem: that setup has file type recognition logic
spread about through the code.  There should be one
function/object/whatever that setup.exe code can ask "what kind of file
is this?".  Then concerns over magic numbers don't matter -- the whole
purpose of the recognizer is to recognize special constants like magic
numbers and file name extensions.

I think the gzbz class is a good start towards this.  The class factory
I added is a necessary procedural extension to that, since C++ doesn't
have "virtual constructors".

> 5) in find_tar_ext, you shouldn't need to copy the path, strrchr is non
> dsestructive.

Strrchr() isn't destructive, but _I_ am.  :)  I have to replace the last
dot with a null character so I can call strrchr again.  Unfortunately,
that's the only way -- strrchr isn't like strchr, which effectively lets
you tell it where to begin looking.  Strrchr() only begins looking at
the end of the string, so I have to modify the string to redefine where
the "end" is.

> 1) just _ignore_ the file extention. 

I agree.  My original patch was a trivial patch to add this
functionality -- this was one of the design goals, if you saw the
argument in the "press for cygwin" thread.  :)  Now it seems the Cygwin
team wants it done right, and not just "done".  Okay, I can do that
instead, now that the point has been made.  :)

I will have to mull the rest of your comments over and to study the
code, to ask setup.exe what it wants to become.

All I ask is that, if I'm going to make a serious code cleanup effort
here, that the result will be accepted.  Does the Cygwin team really
want this done, or am I just hearing "wouldn't it be nice if..."?
-- 
= Warren -- ICBM Address: 36.8274040 N, 108.0204086 W, alt. 1714m

From: "Gerrit P. Haase" <gp@familiehaase.de>
To: cygwin-apps@cygwin.com
Cc: cygwin-patches@cygwin.com
Subject: setup.exe crashs / setup.ini patch for perl
Date: Wed, 26 Sep 2001 01:00:00 -0000
Message-id: <3BB1A27D.4773.50774CA1@localhost>
X-SW-Source: 2001-q3/msg00200.html

Hi,

I will be OOO (out of office:) the next week, unfortunately I will not
be able to do more debugging on setup.exe <-> choose.cc, it just starts
making fun:)

But some hints:
===============
The original (CVS) setup.exe crashes only if you have some packages with
dependencies NOT installed.

Another (the same?) problem causes that not all categories gets into the 
list.  I never saw entries for 'Doc' or 'Mail' up to now.
The package 'newlib-man' never shows up (also not in 'full' list mode), 
I think there is the 'setup.hint' file in latest/cygwin is wrong.

The setup choose dialog pops up with some categories in and some packages
in this categories, with the tree expanded.  After collapsing Shells or
Interpreters (both entries), it was not able to open this part again, 
just like there were no packages in this category.
See attached .jpeg for details.

It crashes not if I remove one line, but then there are not all packages
categories listed.  I removed line 814:
	  if (n == nlines)
	    {
	      /* the category wasn't visible - insert at the end */
	      insert_category (cat, CATEGORY_COLLAPSED);
	      insert_pkg (pkg);
	    }
So it looks like:
	  if (n == nlines)
	    {
	      /* the category wasn't visible - insert at the end */
	      insert_category (cat, CATEGORY_COLLAPSED);
	    }
But that is no solution, was only a help for me to see what is happening
inside the program if it doesn't crash.

With the last change from Robert Collins, there are no more crashes:-)
but still the same other problems:-(

New problem: there are some category duplicates.

So I think, there is a problem in the logic somewhere I did not found yet.

Rob Collins wrote:
>> 		  {
>       insert_under (n, line);
>strange. ok, well how about this then...
>
>- 	        n++;
>+		n = nlines;
>
>        }
>> 	      n++;

That is a step forward now. It seems to work better. No more crashes.

The 'no crash'-patch for this is also attached.

I'm no C++ programmer, so I hope this helps someone who is a better coder.

The patch for the perl entry is attached.

Gerrit


-- 
=^..^=

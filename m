Return-Path: <cygwin-patches-return-5305-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16254 invoked by alias); 14 Jan 2005 19:52:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16137 invoked from network); 14 Jan 2005 19:52:26 -0000
Received: from unknown (HELO slinky.cs.nyu.edu) (128.122.20.14)
  by sourceware.org with SMTP; 14 Jan 2005 19:52:26 -0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id j0EJqPan014923;
	Fri, 14 Jan 2005 14:52:25 -0500 (EST)
Date: Fri, 14 Jan 2005 19:52:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Ernie Coskrey <Ernie.Coskrey@steeleye.com>
cc: cygwin-patches@cygwin.com
Subject: Re: Control auto-uppercasing of environment variables
In-Reply-To: <76CBF6B36306884D835E33553572BE52059ECB@steelpo>
Message-ID: <Pine.GSO.4.61.0501141446580.14405@slinky.cs.nyu.edu>
References: <76CBF6B36306884D835E33553572BE52059ECB@steelpo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q1/txt/msg00008.txt.bz2

On Fri, 14 Jan 2005, Ernie Coskrey wrote:

> Cygwin automatically converts all Windows environment variable names to
> uppercase.  The attached patch allows users to control this behavior by
> specifying an option in the CYGWIN environment variable:
> (no)uppercase_env.  The default for this option will be "SET", so that
> Cygwin's default behavior is the same as always.  Adding
> "nouppercase_env" to the CYGWIN environment variable will cause Cygwin
> to leave environment variable names in the same state as they are
> defined in the Windows environment (except for PATH, which will be
> uppercased as before).
>
> My company has a product which includes a number of shell scripts.
> We've bundled our product with a commercial product which provided the
> shell functionality, and this product did not uppercase environment
> variables.  We'd like to rebase our product on Cygwin, and the ability
> to turn off the auto-uppercase behavior would make this a much easier
> prospect.  While it would be possible to port the scripts and change
> variable names, there are issues that make this more complicated than it
> first seems.  For instance, we remotely execute scripts on other systems
> running our product, so during an upgrade it's possible that the shell
> would be running in the old environment.  Referring to uppercase
> variable names would break in this case.  Again, we could do something
> to check the environmnent and use the correct version of the variable
> name, but making Cygwin understand our existing scripts is a more
> desirable solution.
>
> I have briefly discussed this with Christopher Faylor, who has some
> reservations about this functionality.  His comments were:
>
> =============
>
> I should point out that a few people have submitted similar patches over
> the years and they have been rejected.  There are other ways to do what
> you want to do which do not involve adding an option and slowing down
> cygwin's startup.  We tend to be pretty stingy when it comes to adding
> new options to the CYGWIN environment variable.
>
> But, if you want to discuss this, then cygwin-patches would be the place
> to do so.  You can quote this email there, if you want.
>
> ==============
>
> I can understand the reluctance to add more and more options to the
> CYGWIN environment variable.  I hope that the Cygwin community sees
> enough value in the ability to control this aspect of Cygwin that this
> modification is accepted.  I don't believe that there is any real
> performance impact with this change - at most the code costs a few extra
> machine cycles, but certainly nothing noticeable.
>
> Thanks for considering this modification.

Ernie,

I have no comments on the functionality of the patch, but it seems that
since Cygwin already parses $CYGWIN for the check_case option, adding your
option as a suboption of check_case instead of a brand new option might be
the way to go, especially since the intent is similar.  There's still the
overhead of checking the setting, but that might be less of an obstacle
than adding a new $CYGWIN top-level option.

Also, it might be easier to review if you sent the patch in Unidiff
format, rather than the context diff (use "diff -up" instead of "diff
-c").
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT

From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sources.redhat.com
Subject: Re: cinstall contribution
Date: Fri, 14 Jul 2000 10:50:00 -0000
Message-id: <20000714134933.A15089@cygnus.com>
References: <Pine.SGI.4.10.10007111450500.361924-100000@cystine.cs.unc.edu> <396B7FC4.188536DC@delorie.com> <200007112129.RAA03821@envy.delorie.com> <396F377E.F3ADDEF6@cs.unc.edu> <200007141712.NAA14485@envy.delorie.com>
X-SW-Source: 2000-q3/msg00013.html

On Fri, Jul 14, 2000 at 01:12:55PM -0400, DJ Delorie wrote:
>A note on coding style:  I prefer that when you test for an error
>(like the results of fopen), you test for the error case,
>not the success case.  That way you don't end up indenting a lot.
>For example, your code is like this:

Also, take a look at:

http://www.gnu.org/prep/standards_toc.html

The standards that we follow are based on GNU coding practices.

cgf

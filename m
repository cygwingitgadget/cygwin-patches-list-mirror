From: David Sainty <David.Sainty@optimation.co.nz>
To: "'Jason Gouger'" <cygwin@jason-gouger.com>
Cc: cygwin-patches@cygwin.com
Subject: RE: PATCH: getcwd() pathstyle
Date: Thu, 11 Jan 2001 19:06:00 -0000
Message-id: <30E7BC40E838D211B3DB00104B09EFB7795411@delorean.optimation.co.nz>
X-SW-Source: 2001-q1/msg00033.html

> Unfortunately the "problem" would be across many scripts 
> (sh/perl/make).
> The scripts are all part of a common development environment 
> which is used
> on both UNIX and NT.  Under UNIX the scripts build options for gcc and
> compile the application.  Under NT the same is true, except 
> for the fact
> that the scripts drive MSDev compilers which require native 
> win32 paths...

I can see the incentive, but I don't think it is the responsibility of
Cygwin to resolve this if it risks breaking the Unix-style interface that
Cygwin is attempting to provide.

The problem you are trying to solve is not (directly) "OS" related, but is
really related to the command you are using.  The MS compilers require
filenames in a certain format, the Cygwin and Unix compilers require them in
a different format (although it just so happens that the Cygwin utilities
have a compatibility mode too).

You must agree that changing the output of getcwd() is not a general
solution.  If you are calling programs from Cygwin that require non-Cygwin
pathnames, you will also potentially need to know the native DOS directory
delimiter to work with some utilities.

> Some examples assuming pathstyle=win32
> 
> 1. User cd's to 'C:/cygwin' getcwd will return 'C:/cygwin'
> 2. User cd's to '/usr/local' getcwd will return '/usr/local'
> 3. User cd's to '//C/cygwin' getcwd will return '//C/cygwin'
> 4. User cd's to '/cygdrive/c/cygwin' getcwd will return
'/cygdrive/c/cygwin'

If this is the case, then your build scripts must still rely on you making
the "right" style of chdir() in order for it to work.  That is fairly
fragile...

The general solution (although not convenient) is to use 'cygpath.exe'
within your scripts, or wrap the non-Cygwin utilities in scripts that
provide the appropriate abstraction layer.
The latter is probably the cleanest, and will always work correctly.  ...and
is also the most work :)

But it has never been easy getting the same scripts to work under Windows
and Unix, it only seems that way if you have Cygwin :)

Cheers,

Dave

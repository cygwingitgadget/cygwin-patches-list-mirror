From: "Jason Gouger" <cygwin@jason-gouger.com>
To: "David Sainty" <David.Sainty@optimation.co.nz>
Cc: <cygwin-patches@cygwin.com>
Subject: RE: PATCH: getcwd() pathstyle
Date: Mon, 08 Jan 2001 00:37:00 -0000
Message-id: <GIEAKOJACGCDOHKHFLIHKEIECAAA.cygwin@jason-gouger.com>
References: <30E7BC40E838D211B3DB00104B09EFB77953EF@delorean.optimation.co.nz>
X-SW-Source: 2001-q1/msg00016.html

> my many varied shell scripts may throw up their hands in horror if they
don't
> receive a cwd in the normal format.  Does this now mean I need to modify
all
> my scripts to parse CYGWIN and determine the selected format?

This change only is visible if the pathstyle CYGWIN option is specified, and
if the user specifically cd's to a windows style path, i.e. cd C:/ ...

Some examples assuming pathstyle=win32

1. User cd's to 'C:/cygwin' getcwd will return 'C:/cygwin'
2. User cd's to '/usr/local' getcwd will return '/usr/local'
3. User cd's to '//C/cygwin' getcwd will return '//C/cygwin'
4. User cd's to '/cygdrive/c/cygwin' getcwd will return '/cygdrive/c/cygwin'

So as you can see the change only kicks in when a windows path is requested.

> It seems like this change also has little chance of helping.  Either a
> program is win32 aware, or it isn't [...] It would be much safer to do a
> little porting exercise on the program in question

Unfortunately the "problem" would be across many scripts (sh/perl/make).
The scripts are all part of a common development environment which is used
on both UNIX and NT.  Under UNIX the scripts build options for gcc and
compile the application.  Under NT the same is true, except for the fact
that the scripts drive MSDev compilers which require native win32 paths...

So this patch is very useful if the user plans on using unix shell/perl
scripts to interact with win32 programs.  It does not require the script to
constantly convert to different pathstyles.

-Jason

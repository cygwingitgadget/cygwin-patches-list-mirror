From: David Sainty <David.Sainty@optimation.co.nz>
To: "'cygwin@jason-gouger.com'" <cygwin@jason-gouger.com>
Cc: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: PATCH: getcwd() pathstyle
Date: Sun, 07 Jan 2001 21:52:00 -0000
Message-id: <30E7BC40E838D211B3DB00104B09EFB77953EF@delorean.optimation.co.nz>
X-SW-Source: 2001-q1/msg00014.html

On Sun, Jan 07, 2001 at 07:38:16PM -0800, Jason Gouger wrote:
>Below is a small patch which adds a "pathstyle" to the CYGWIN options. This
>option controls the format of the string returned by the low-level getcwd()
>function.  The options are 'posix', 'win32', and 'dos'.  The 'posix' option
>causes getcwd to return the traditional cygwin path, i.e. /usr/local/bin.
>The 'win32' option causes getcwd to return a win32 compatible path, i.e.
>C:/cygwin/usr/local/bin.  The 'dos' option causes getcwd to return a dos
>compatible path, i.e. C:\cygwin\usr\local\bin.
>
>The 'pathstyle=win32' option allows cygwin programs to more easily interact
>with win32 types of programs when the cygwin program builds
>arguments/envvars based off of the cwd.

This has (I think) some undesirable side-effects.  In particular, it risks
breaking the principle of least surprise.  For example, my many varied shell
scripts may throw up their hands in horror if they don't receive a cwd in
the normal format.  Does this now mean I need to modify all my scripts to
parse CYGWIN and determine the selected format?  It does if I want them to
work in all situations.  But that isn't enough by itself, because I don't
know if the environment variable my shell sees is actually in the processes
environment, so really I'm just screwed :)

It seems like this change also has little chance of helping.  Either a
program is win32 aware, or it isn't, and if it isn't then it will make
assumptions like '^/' = root and '/' = directory separator.

It would be much safer to do a little porting exercise on the program in
question, and for that reason there is probably a very good argument for
including all of:

- getcwd()
- getcwd_win32()
- getcwd_dos()

... in the Cygwin API, to make porting trivial.  After all, most programs
probably wouldn't have more than one call to getcwd(), and if the program
really needs one of the non-standard formats then it would be better to fix
it right at the source of the problem, not rely on the environment being set
correctly before it is run.

For the benefit of shell scripts, adding options to '/bin/pwd' would be a
simpler solution.

Maybe I'm just missing the case where this change has an essential benefit?

I'm not trying to say the patch is bad, I just think it'd be bad if it was
merged into the release code.

Cheers,

Dave

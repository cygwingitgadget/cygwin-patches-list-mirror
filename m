From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH: getcwd() pathstyle
Date: Sun, 07 Jan 2001 20:11:00 -0000
Message-id: <20010107231202.A24911@redhat.com>
References: <GIEAKOJACGCDOHKHFLIHIEIDCAAA.cygwin@jason-gouger.com>
X-SW-Source: 2001-q1/msg00013.html

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
>
>Sun Jan 7 18:45:22 2001  Jason Gouger <cygwin@jason-gouger.com>
>
>	* environ.cc: Added new configuration entry (pathstyle) to
>	              'struct parse_thing .. known[]'
>	* winsup.h: Added header definition for new function
>	            pathstyle_start_init
>	* path.cc: New function to initialize pathstyle configuration
>	           named pathstyle_start_init
>	           Modified 'getcwd' to return different pathstyles
>	           + pathstyle=posix (default), getcwd returns
>	               the traditional path, i.e. /usr/local/bin
>	           + pathstyle=win32, getcwd returns a win32
>	               type of path, i.e. C:/cygwin/usr/local/bin
>	           + pathstyle=dos, getcwd returns a dos
>	               type of path, i.e. C:\cygwin\usr\local\bin

This looks interesting but I'd like you to do two things:

1) Check out this link for the correct formatting of ChangeLog entries:
http://www.gnu.org/prep/standards_39.html

2) Fill out the assignment form so that we can incorporate your change
   into cygwin.  I don't think you've done this yet, have you?

    http://cygwin.com/assign.txt

cgf

Return-Path: <cygwin-patches-return-6264-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9787 invoked by alias); 9 Mar 2008 09:28:35 -0000
Received: (qmail 9777 invoked by uid 22791); 9 Mar 2008 09:28:34 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sun, 09 Mar 2008 09:28:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 270BD6D430A; Sun,  9 Mar 2008 10:28:06 +0100 (CET)
Date: Sun, 09 Mar 2008 09:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
Message-ID: <20080309092806.GW18407@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47D36406.F7D7AB61@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00038.txt.bz2

Hi Brian,

Thanks for your patch.  I have a few nits, sorry.

On Mar  8 20:13, Brian Dessent wrote:
> Index: cygcheck.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
> retrieving revision 1.97
> diff -u -p -r1.97 cygcheck.cc
> --- cygcheck.cc	13 Jan 2008 13:41:45 -0000	1.97
> +++ cygcheck.cc	9 Mar 2008 03:52:07 -0000
> @@ -807,6 +807,31 @@ ls (char *f)
>      display_error ("ls: CloseHandle()");
>  }
>  
> +/* If s is non-NULL, save the CWD in a static buffer and set the CWD
> +   to the dirname part of s.  If s is NULL, restore the CWD last
> +   saved.  */
> +static
> +void save_cwd_helper (const char *s)
> +{
> +  static char cwdbuf[MAX_PATH + 1];
> +  char dirnamebuf[MAX_PATH + 1];
> +
> +  if (s)
> +    {
> +      GetCurrentDirectory (sizeof (cwdbuf), cwdbuf);
> +
> +      /* Remove the filename part from s.  */
> +      strncpy (dirnamebuf, s, MAX_PATH);
> +      dirnamebuf[MAX_PATH] = '\0';   // just in case strlen(s) > MAX_PATH
> +      char *lastsep = strrchr (dirnamebuf, '\\');
> +      if (lastsep)
> +        lastsep[1] = '\0';
> +      SetCurrentDirectory (dirnamebuf);
> +    }
> +  else
> +    SetCurrentDirectory (cwdbuf);
> +}

Given that Cygwin changes to support long path names, I don't really
like to see new code still using MAX_PATH and Win32 Ansi functions
in the utils dir.  I know that the Win32 cwd is always restricted to
259 chars.  However, there *is* a way to recognize the current working
directory of the parent Cygwin application.

Bash as well as tcsh, as well as zsh (and probbaly pdksh, too) create an
environment variable $PWD.  Maybe Cygwin should create $PWD for native
apps if it's not already available through the parent shell.  I'd
suggest that the Cygwin utils first try to fetch $PWD from the
environment and use that as cwd.  Only if that fails, use
GetCurrentDirectory.

Never use SetCurrentDirectory, rather convert the path to an absolute
path, prepend \\?\ and call the Win32 unicode functions (CreateFileW,
etc).

>  // Find a real application on the path (possibly following symlinks)
>  static const char *
>  find_app_on_path (const char *app, bool showall = false)
> @@ -822,25 +847,27 @@ find_app_on_path (const char *app, bool 
>    if (is_symlink (fh))
>      {
>        static char tmp[4000] = "";

SYMLINK_MAX is PATH_MAX - 1 == 4095.

I'm wondering if you would like to tweak the readlink functions, too.
Cygwin shortcuts can now have the path name appended to the actual
shortcut data.  This hack was necessary to support pathnames longer than
2000 chars.  See the comment and code in cygwin/path.cc, line 3139ff.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

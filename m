Return-Path: <cygwin-patches-return-4680-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8510 invoked by alias); 13 Apr 2004 12:43:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8499 invoked from network); 13 Apr 2004 12:43:07 -0000
Date: Tue, 13 Apr 2004 12:43:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Last path.cc
Message-ID: <20040413124306.GD26558@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040410233707.00846910@incoming.verizon.net> <3.0.5.32.20040410233707.00846910@incoming.verizon.net> <3.0.5.32.20040412192958.0080cab0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040412192958.0080cab0@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00032.txt.bz2

On Apr 12 19:29, Pierre A. Humblet wrote:
> At 11:45 PM 4/10/2004 -0400, Christopher Faylor wrote:
> >On Sat, Apr 10, 2004 at 11:37:07PM -0400, Pierre A. Humblet wrote:
> >>This should take care of the issues I listed yesterday evening.
> >>
> >>I simply don't understand the logic in normalize_win32_path
> >>well enough to touch it intelligently. 
> >>So I removed the final . in the dumbest way possible
> >
> >Why do we have to remove the final dot?
> >
> >How does that jive with the goal of munging windows paths as little
> >as possible.
> 
> Windows paths go through the symlink evaluation and path existence
> loops as all others. Keeping the final /. causes abnormal behavior
> with some symlinks (Cygwin looks for /..lnk).
> Also the non-uniform normalization complicates other routines. For
> example hash_path_name() contains special code to detect and remove
> the final /. 
> 
> About the "normalized_path", I would still recommend replacing
> get_name() by get_win32_name() in fchown32, fchmod, fstat64, facl32
                                                      ???????

> and perhaps fhandler_disk_file::mmap. Otherwise making changes to the
> mounts can cause calls on opened files to fail. It's also faster.

I think the better approach is to change all these functions to
work on handles instead of filenames.  The current implementation
works basically like this:

  fbaz (int fd)
  {
    Get fhandler
    baz (fhandler->posix_name);
  }

  baz(char *posix_name)
  {
    Get_Win32_name(posix_name);
    Win32_baz_equivalent (Win32_name);
  }

  Win32_baz_equivalent (Win32_name)
  {
    handle = NtCreateFile (Win32_name);
    NT_baz_equivalent (handle);
    NtCloseHandle (handle);
  }

Which results in the system always having to open a file twice when
these functions are called by an application.

What I'm up to is to change all the affected functionality to what's
already working fine in case of stat/fstat:

  baz (char *posix_name)
  {
    Create fhandler
    fhandler->fbaz (fd);
  }

  fbaz (int fd)
  {
    Get fhandler
    fhandler->fbaz (fd);
  }

  fhandler::fbaz ()
  {
    NT_baz_equivalent (handle);
  }

That shouldn't take too long, since using the already available handle
is already implemented for *getting* security information.  What needs
to be implemented is just to use the appropriate function when *setting*
security attributes.
    
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

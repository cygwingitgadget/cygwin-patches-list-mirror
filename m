Return-Path: <cygwin-patches-return-4088-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2219 invoked by alias); 15 Aug 2003 20:26:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2188 invoked from network); 15 Aug 2003 20:26:22 -0000
Date: Fri, 15 Aug 2003 20:26:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Package content search and listing functionality for cygcheck
Message-ID: <20030815202621.GG3101@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030815091732.GA3101@cygbert.vinschen.de> <Pine.GSO.4.44.0308151532550.1848-200000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0308151532550.1848-200000@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00104.txt.bz2

On Fri, Aug 15, 2003 at 03:38:30PM -0400, Igor Pechtchanski wrote:
> > On Cygwin:
> >
> >   $ cygcheck -f /usr/bin/tcsh.exe
> >   /usr/bin/tcsh.exe: found in package tcsh-6.12.00-6
> >
> > On Linux:
> >
> >   $ rpm -qf /usr/bin/tcsh
> >   tcsh-6.12.00-134
> >
> > Shouldn't we also just print the package name?  It doesn't really matter,
> > just a question...
> 
> Fixed.

I'm happy!  Another difference to Linux is when using -l.  rpm -ql doesn't
prepend the package version to each file list, it just prints a list of
files of all packages on the command line:

  $ rpm -ql bash tcsh
  /bin/bash
  [more bash files]
  /usr/bin/tcsh
  [more tcsh files]
  $

On Cygwin:

  $ cygcheck -l bash tcsh
  Package: bash-2.05b-12
      /usr/bin/bash.exe
      [more bash files]
  Package: tcsh-6.12.00-7
      /usr/bin/tcsh.exe
      [more tcsh files]
  $

Should we do it also like rpm or do you like it better as it is?

> Well, I agree with all the above points, so here's another iteration.
> Same ChangeLog (except for the date -- reposting just in case).
> 	Igor
> ==============================================================================
> ChangeLog:
> 2003-08-15  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
> 
> 	* cygcheck.cc (find_package,list_package): New global
> 	variables.
> 	(usage): Add "--find-package" and "--list-package" options,
> 	reformat output.
> 	(longopts, opts): Add "--find-package" and "--list-package"
> 	options.
> 	(main): Process the "--find-package" and "--list-package"
> 	flags.  Add new semantic checks.  Add calls to find_package()
> 	and list_package().
> 	* dump_setup.cc: Fix header comment.
> 	(match_argv): Change return type to int to distinguish
> 	between real matches and default ones.
> 	(open_package_list): New static function.
> 	(check_package_files): Factor out opening the package list
> 	file into open_package_list().
> 	(get_packages): New static function.
> 	(dump_setup): Factor out getting a list of packages into
> 	get_packages().
> 	(package_list, package_find): New global functions.

I've checked it in and added some formatting changes.  I removed most
of the `puts("");' lines and the "Use -h to see..." is now only printed
where it belongs to, to the end of a sysinfo dump.  Oh, and the other
helptext ("Here is where the OS will...") would have been printed also
on -f -h or -l -h, I've fixed the if clause appropriately.

Thanks for the patch, it's really cool,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

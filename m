Return-Path: <cygwin-patches-return-4086-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18899 invoked by alias); 15 Aug 2003 09:17:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18883 invoked from network); 15 Aug 2003 09:17:34 -0000
Date: Fri, 15 Aug 2003 09:17:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Package content search and listing functionality for cygcheck
Message-ID: <20030815091732.GA3101@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.44.0308141521250.13708-200000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0308141521250.13708-200000@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00102.txt.bz2

On Thu, Aug 14, 2003 at 03:30:44PM -0400, Igor Pechtchanski wrote:
> This patch adds the functionality to cygcheck to list (using the "-l" or
> "--list-package" flag) the contents of and search (using the "-f" or
> "--find-package" flag and passing the absolute paths to the files) for
> files in the *installed* packages.  Please test this and feel free to give
> feedback.  I've done some refactoring of the code in dump_setup.cc as

Cool, especially the -f which allows the same as `rpm -qf'.  However,
you asked for feedback... (I dropped the "Use -h to see..." from below
examples, we should get rid of it anyway)

On Cygwin:

  $ cygcheck -f /usr/bin/tcsh.exe
  /usr/bin/tcsh.exe: found in package tcsh-6.12.00-6

On Linux:

  $ rpm -qf /usr/bin/tcsh
  tcsh-6.12.00-134

Shouldn't we also just print the package name?  It doesn't really matter,
just a question...

But we have two problems which are no problems in Linux and it would be
nice(TM) to have a neat solution for them.  Example:

$ cygcheck -f /usr/bin/tcsh
$

Huh?  No .exe, no package :-(

$ cygcheck -f /bin/tcsh
$

Do you see what I mean?  Since /bin and /usr/bin (same for /lib) are
the same directory, one could ask for the same file in /bin and would
not get the package reply.  Bummer.  I don't see that as a big problem
for files in /lib but I guess you should expect that a good bunch of
people don't get the idea to ask for the same file in /usr/bin again.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

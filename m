Return-Path: <cygwin-patches-return-2149-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8960 invoked by alias); 4 May 2002 03:24:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8946 invoked from network); 4 May 2002 03:24:31 -0000
Date: Fri, 03 May 2002 20:24:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fixes for miscellaneous bugs in /proc patch
Message-ID: <20020504032437.GA32261@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <005d01c1f2ae$8aafc190$0100a8c0@advent02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005d01c1f2ae$8aafc190$0100a8c0@advent02>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00133.txt.bz2

On Fri, May 03, 2002 at 03:26:40PM +0100, Chris January wrote:
>2002-05-03  Christopher January <chris@atomice.net>
>
> * fhandler_proc.cc (fhandler_proc::open): Change use of mode to flags.
> If the file does not exist already, fail with EROFS if O_CREAT flag is
> set.
> Use cmalloc to allocate memory for filebuf.
> * fhandler_process.cc (fhandler_process::open): Ditto.
> * fhandler_registry.cc (fhandler_registry::open): Ditto.
> Move check for open for writing before open_key.
> * path.cc (path_conv::check): Do not return ENOENT if a file is not found
> in /proc.
> * fhandler_virtual.cc (fhandler_virtual::write): Change EROFS error to
> EACCES error.
> * fhandler_virtual.cc (fhandler_virtual::open): Set the NOHANDLE flag.
> * fhandler_virtual.cc (fhandler_virtual::dup): Add call to
> fhandler_base::dup.
> Allocate child's filebuf using cmalloc.
> Copy filebuf from parent to child.
> * fhandler_virtual.cc (fhandler_virtual::close): Use cfree to free filebuf.
> * fhandler_proc.cc: Add '.' and '..' to directory listing.
> * fhandler_process.cc: Ditto.
> * fhandler_registry.cc: Ditto.
> * fhandler_registry.cc (fhandler_registry::readdir): Add support for '.'
> and '..' files in subdirectories of /proc/registry.
> * fhandler_registry.cc (fhandler_registry::telldir): Use lower 16 bits
> of __d_position as position in directory.
> * fhandler_registry.cc (fhandler_registry::seekdir): Ditto.

Committed after formatting fixes, ChangeLog reorg, and minor change to
make fhandler_virtual::~fhandler_virtual use cfree to free filebuf.

Thanks.
cgf

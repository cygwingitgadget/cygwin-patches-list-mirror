Return-Path: <cygwin-patches-return-2214-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21449 invoked by alias); 23 May 2002 23:26:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21418 invoked from network); 23 May 2002 23:26:26 -0000
Date: Thu, 23 May 2002 16:26:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: /dev patch
Message-ID: <20020523232638.GA31888@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <001701c201aa$9cca0ab0$0100a8c0@advent02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001701c201aa$9cca0ab0$0100a8c0@advent02>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00198.txt.bz2

Could you subscribe to cygwin-developers so that we could discuss this
patch?  I think we need to lay more groundwork before we do something
like this and cygwin-patches is not the place for discussing this.

cgf

On Wed, May 22, 2002 at 05:06:19PM +0100, Chris January wrote:
>I've had this patch kicking about for a while and I was going to merge it
>with the next /proc patch but I remembered that separate patches are
>generally preferred on this list and the /proc stuff has been delayed
>somewhat.
>This patch adds support for a virtual /dev which just lists the devices that
>cygwin currently supports. The /dev prefix is read from the mount_table, as
>is now the /proc prefix. I haven't added a mechanism to read these from the
>registry or allow them to be changed using mount since most programs expect
>to find these directories at a fixed location.
>
>Regards
>Chris
>
>---
>2002-05-22  Christopher January <chris@atomice.net>
>
> * Makefile.in: Add fhandler_dev.o.
> * dtable.cc (dtable::build_fhandler): Add entry for FH_DEV.
> * fhandler.h: Add constant for FH_DEV. Add class declaration for
> fhandler_dev. Update fhandler_union accordingly. Remove global declarations
> for proc and proc_len.
> * fhandler_proc.cc: Remove global definitions for proc and proc_len.
> * fhandler_proc.cc (fhandler_proc::get_proc_fhandler): Use proc prefix from
> mount_table.
> (fhandler_proc::exists): Ditto.
> (fhandler_proc::fstat): Ditto.
> (fhandler_proc::open): Ditto.
> * fhandler_process.cc (fhandler_process::exists): Use proc prefix from
> mount_table.
> (fhandler_proc::fstat): Ditto.
> (fhandler_proc::open): Ditto.
> * fhandler_registry.cc (fhandler_registry::exists): Use proc prefix from
> mount_table.
> (fhandler_registry::readdir): Ditto.
> (fhandler_registry::open): Ditto.
> * fhandler_virtual.cc (fhandler_virtual::close): Remove call to
> delqueue.process_queue().
> * path.cc: Add is_dev macro. Use proc prefix from mount_table in is_proc
> macro. Add FH_DEV to isvirtual_dev macro.
> (path_conv::check): Add FH_DEV support.
> (path_conv::get_device_number): Use dev prefix from mount_table.
> (mount_info::init): Initialise default prefixes for /proc and /dev.
> (mount_info::conv_to_win32_path): Add support for /dev.
> * shared_info.h: Add dev, dev_len, proc and proc_len members to
> mount_table class.
> * fhandler_dev.cc: New file.
>


>2002-05-22  Christopher January <chris@atomice.net>
>
>	* Makefile.in: Add fhandler_dev.o.
>	* dtable.cc (dtable::build_fhandler): Add entry for FH_DEV.
>	* fhandler.h: Add constant for FH_DEV. Add class declaration for
>	fhandler_dev. Update fhandler_union accordingly. Remove global declarations
>	for proc and proc_len.
>	* fhandler_proc.cc: Remove global definitions for proc and proc_len.
>	* fhandler_proc.cc (fhandler_proc::get_proc_fhandler): Use proc prefix from
>	mount_table.
>	(fhandler_proc::exists): Ditto.
>	(fhandler_proc::fstat): Ditto.
>	(fhandler_proc::open): Ditto.
>	* fhandler_process.cc (fhandler_process::exists): Use proc prefix from
>	mount_table.
>	(fhandler_proc::fstat): Ditto.
>	(fhandler_proc::open): Ditto.
>	* fhandler_registry.cc (fhandler_registry::exists): Use proc prefix from
>	mount_table.
>	(fhandler_registry::readdir): Ditto.
>	(fhandler_registry::open): Ditto.
>	* fhandler_virtual.cc (fhandler_virtual::close): Remove call to
>	delqueue.process_queue().
>	* path.cc: Add is_dev macro. Use proc prefix from mount_table in is_proc
>	macro. Add FH_DEV to isvirtual_dev macro.
>	(path_conv::check): Add FH_DEV support.
>	(path_conv::get_device_number): Use dev prefix from mount_table.
>	(mount_info::init): Initialise default prefixes for /proc and /dev.
>	(mount_info::conv_to_win32_path): Add support for /dev.
>	* shared_info.h: Add dev, dev_len, proc and proc_len members to
>	mount_table class.
>	* fhandler_dev.cc: New file.

Return-Path: <cygwin-patches-return-2173-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30973 invoked by alias); 12 May 2002 01:36:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30956 invoked from network); 12 May 2002 01:36:01 -0000
Date: Sat, 11 May 2002 18:36:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: /proc improvements
Message-ID: <20020512013620.GA31044@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <05cd01c1f7b1$aa451250$0100a8c0@advent02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05cd01c1f7b1$aa451250$0100a8c0@advent02>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00157.txt.bz2

On Fri, May 10, 2002 at 12:31:37AM +0100, Chris January wrote:
>This is first of two patches adding a number of extra files to the /proc
>virtual file system.
>The main aim of this patch was to add compatibility with the procps tools,
>which has been achieved. Specifically, both top and ps are working.
>A lot of the process-specific information and some global information is
>only available on Windows NT. This isn't because I'm mean, but simply
>because I know no way of retrieving this information under Windows 95/98/me.
>In fact the operating system doesn't bother recording most of the
>information required.
>Please test extensively. I've only tested it under Windows 2000 and Windows
>98. In particular I need to know whether the patch works with NT 4.

Committed with a couple of very minor ChangeLog tweaks and one change to
remove an is_winnt test.  We prefer to minimize that kind of check as
much as possibility in favor of either adding a capability or just allowing
the error routine from an NT-specific routine to control execution flow.

Thanks.

cgf

>2002-05-10  Christopher January <chris@atomice.net>
>
>	* autoload.cc: Add dynamic load statements for 'ZwQueryInformationProcess'
>	and 'ZwQueryVirtualMemory'.
>	* fhandler.h: Change type of bufalloc and filesize members of
>	fhandler_virtual from int to size_t.
>	Change type of position member from __off32_t to __off64_t.
>	Add new fileid member to fhandler_virtual class.
>	Make seekdir take an __off64_t argument.
>	Make lseek take an __off64_t argument.
>	Add fill_filebuf method to fhandler_virtual.
>	Add fill_filebuf method to fhandler_proc.
>	Add fill_filebuf method to fhandler_registry.
>	Add fill_filebuf method to fhandler_process.
>	Add saved_pid and saved_p members to fhandler_process.
>	* fhandler_proc.cc: Add 'loadavg', 'meminfo', and 'stat' files to
>	proc_listing array.
>	Add corresponding entries in proc_fhandlers array.
>	(fhandler_proc::open): Use fill_filebuf to flesh out the file contents.
>	(fhandler_proc::fill_filebuf): New method.
>	(fhandler_proc::format_proc_meminfo): Ditto.
>	(fhandler_proc::format_proc_stat): Ditto.
>	(fhandler_proc::format_proc_uptime): Ditto.
>	* fhandler_process.cc: Add 'stat' and 'statm' files to process_listing
>	array.
>	(fhandler_process::fstat): Find the _pinfo structure for the process
>	named in the filename. Return ENOENT if the process is no longer around.
>	Set the gid and uid fields of the stat structure.
>	(fhandler_process::open): Store pid and pointer to _pinfo structure in
>	saved_pid and saved_p respectively. Use fill_filebuf to flesh out file
>	contents.
>	(fhandler_proc::fill_filebuf): New method.
>	(format_process_stat): New function.
>	(format_process_status): Ditto.
>	(format_process_statm): Ditto.
>	(get_process_state): Ditto.
>	(get_mem_values): Ditto.
>	* fhandler_registry.cc (fhandler_registry::seekdir): Change argument type
>	from __off32_t to __off64_t.
>	(fhandler_registry::fill_filebuf): New method.	
>	* fhandler_virtual.cc (fhandler_virtual::seekdir): Change argument type
>	from __off32_t to __off64_t. 
>	(fhandler_virtual::lseek): Ditto.
>	(fhandler_virtual::fill_filebuf): New method.
>	(fhandler_virtual::fhandler_virtual): Initialise fileid to -1.
>	* wincap.cc: Set flag has_process_io_counters  appropriately.
>	* wincap.h: Add flag has_process_io_counters.
>	

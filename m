Return-Path: <cygwin-patches-return-4220-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12897 invoked by alias); 16 Sep 2003 01:34:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12887 invoked from network); 16 Sep 2003 01:34:46 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: Fixing the delete queue security
Date: Tue, 16 Sep 2003 01:34:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKKECGEJAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <3.0.5.32.20030915211808.0081d6d0@incoming.verizon.net>
Importance: Normal
X-SW-Source: 2003-q3/txt/msg00236.txt.bz2

You are a *God*, Pierre. ;-)

-- 
Gary R. Van Sickle
Brewer.  Patriot. 


> Cygwin uses a "delete queue" in a shared file mapping to hold
> the names of files that could not be deleted on unlink, usually
> because they were still opened. The queue is scanned by all
> processes so that the files eventually get deleted after they 
> are closed.
> 
> Because Everyone has write access to the file mapping, any user
> can add names to the delete queue, and thus any user can trick
> other processes into deleting any and all files on a PC where a cygwin 
> daemon is running as SYSTEM.
> 
> The solution is simple: create per user delete queues. They are
> placed in the same mapping as the mount table. So the change
> is extremely straightforward. The length of the change log comes
> from renaming many variable to have names reflect functions.
> 
> There will be a follow up patch with the following cleanup:
> remove now unneeded fields from the mount_info and shared_info and 
> run the "magic" on the new/modified structures.
> 
> Pierre
> 
> 
> 2003-09-15  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* shared_info.h (class user_info): New.
> 	(cygwin_user_h): New.
> 	(user_shared): New.
> 	(enum shared_locations): Replace SH_MOUNT_TABLE by SH_USER_SHARED;
> 	(mount_table): Change from variable to macro.
> 	* shared.cc: Use sizeof(user_info) in "offsets".
> 	(user_shared_initialize): Add "reinit" argument to indicate need
> 	to reinitialize the mapping. Replace "mount_table" by "user_shared"
> 	throughout. Call user_shared->mountinfo.init and 
> 	user_shared->delqueue.init.
> 	(shared_info::initialize): Do not call delqueue.init.
> 	(memory_init): Add argument to user_shared_initialize.
> 	* child_info.h (child_info::mount_h): Delete. 
> 	(child_info::user_h): New.	
> 	* sigpproc.cc (init_child_info): Use user_h instead of mount_h.
> 	* dcrt0.cc (_dll_crt0): Ditto.
> 	* fhandler_disk_file.cc (fhandler_disk_file::close): Use 
> 	user_shared->delqueue instead of cygwin_shared->delqueue.
> 	* fhandler_virtual.cc (fhandler_virtual::close): Ditto.
> 	* syscalls.cc (close_all_files): Ditto.
> 	(unlink): Ditto.
> 	(seteuid32): Add argument to user_shared_initialize.
> 

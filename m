Return-Path: <cygwin-patches-return-4232-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12511 invoked by alias); 25 Sep 2003 00:44:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12502 invoked from network); 25 Sep 2003 00:44:01 -0000
Date: Thu, 25 Sep 2003 00:44:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fixing the delete queue security
Message-ID: <20030925004355.GA13801@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030915211808.0081d6d0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030915211808.0081d6d0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00248.txt.bz2

On Mon, Sep 15, 2003 at 09:18:08PM -0400, Pierre A. Humblet wrote:
>2003-09-15  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* shared_info.h (class user_info): New.
>	(cygwin_user_h): New.
>	(user_shared): New.
>	(enum shared_locations): Replace SH_MOUNT_TABLE by SH_USER_SHARED;
>	(mount_table): Change from variable to macro.
>	* shared.cc: Use sizeof(user_info) in "offsets".
>	(user_shared_initialize): Add "reinit" argument to indicate need
>	to reinitialize the mapping. Replace "mount_table" by "user_shared"
>	throughout. Call user_shared->mountinfo.init and 
>	user_shared->delqueue.init.
>	(shared_info::initialize): Do not call delqueue.init.
>	(memory_init): Add argument to user_shared_initialize.
>	* child_info.h (child_info::mount_h): Delete. 
>	(child_info::user_h): New.	
>	* sigpproc.cc (init_child_info): Use user_h instead of mount_h.
>	* dcrt0.cc (_dll_crt0): Ditto.
>	* fhandler_disk_file.cc (fhandler_disk_file::close): Use 
>	user_shared->delqueue instead of cygwin_shared->delqueue.
>	* fhandler_virtual.cc (fhandler_virtual::close): Ditto.
>	* syscalls.cc (close_all_files): Ditto.
>	(unlink): Ditto.
>	(seteuid32): Add argument to user_shared_initialize.

This is ok.

Please check in.  You'll have to accommodate the new layout after my
checkin but it should apply with only minor problems.

cgf

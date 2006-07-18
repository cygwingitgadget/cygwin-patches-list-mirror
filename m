Return-Path: <cygwin-patches-return-5926-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26373 invoked by alias); 18 Jul 2006 12:31:46 -0000
Received: (qmail 26253 invoked by uid 22791); 18 Jul 2006 12:31:33 -0000
X-Spam-Check-By: sourceware.org
Received: from natlemon.rzone.de (HELO natlemon.rzone.de) (81.169.145.170)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 18 Jul 2006 12:31:13 +0000
Received: from [192.168.0.11] (p5080D1AF.dip.t-dialin.net [80.128.209.175]) 	(authenticated bits=0) 	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k6ICUvIj023187 	for <cygwin-patches@cygwin.com>; Tue, 18 Jul 2006 14:30:57 +0200 (MEST)
Message-ID: <44BCD49A.10701@data-al.de>
Date: Tue, 18 Jul 2006 12:31:00 -0000
From: Silvio Laguzzi <slaguzzi@data-al.de>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: 1.5.20: acltotext32 - fix of error when handling default ACL types
Content-Type: multipart/mixed;  boundary="------------090301000004080602020704"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00021.txt.bz2

This is a multi-part message in MIME format.
--------------090301000004080602020704
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2132

Hi, all

when I tested Joerg Schily's star under cygwin the acltotext() call
failed with an >Invalid Argument< error under Win2k.

Here's a sample code that reproduces this error:

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/acl.h>


int main(void)
{
    int aclcount;
    aclent_t *aclp;
    char *fname = "/home/slaguzzi/src/star-1.5";

    if( (aclcount = acl(fname, GETACLCNT, 0, NULL)) < 0 ) {
      perror("Error getting ACL info for ~/src/star-1.5/");
    }
    if (aclcount <= MIN_ACL_ENTRIES) {
      /* Only traditional UNIX access list */
      printf( "Only traditional UNIX access lists\n" );
    }
    printf( "ACL count: %d\n", aclcount );
    if ( (aclp = (aclent_t *)calloc(aclcount, sizeof( aclent_t ) )) ==
NULL ) {
      perror( "Error allocating memory for ACL struct" );
    }
    if( acl(fname, GETACL, aclcount, aclp) < 0 ) {
      perror( "Cannot get ACL entries" );
    }
    errno = 0;
    int idx = 0;
    if( aclcheck( aclp, aclcount, &idx ) ) {
      perror( "Invalid aclp" );
      printf( "Invalid entry number: %d\n", idx );
    }
    char *acltext = acltotext(aclp, aclcount);

    free(aclp);
    if( !acltext ) {
      perror( "Error converting ACL to text" );
    }
    printf( "acltotext: %s", acltext );

    return( 0 );
}

I tracked down the problem to the implementation of
acltotext32 (__aclent32_t *aclbufp, int aclcnt) in
src/winsup/cygwin/sec_acl.cc.

The prefix "default" was correctly added to the output string in buf for
a default ACL entry type.
But the following switch(aclbuf[pos].a_type) statement did not handle
these default ACL entry types and stopped with EINVAL.

I changed line 731 in sec_acl.cc to

switch(aclbuf[pos].a_type & ~ACL_DEFAULT)

and everything went fine.

An unified diff for the code, the output of the 'cygcheck -s -v -r'
command and the corresponding ChangeLog is included in this message.

I hope that this fix may contribute to improve Win32 ACL handling under
Cygwin.


Best regards
Silvio Laguzzi

---
Silvio Laguzzi
Zimmer-AL GmbH
Junkersstr. 9
89231 Neu-Ulm (Germany)
Internet: http://www.data-al.de


--------------090301000004080602020704
Content-Type: text/plain;
 name="sec_acl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sec_acl.patch"
Content-length: 507

--- cygwin-snapshot-20060714-1/winsup/cygwin/sec_acl-orig.cc	2005-06-07 21:42:06.000000000 +0200
+++ cygwin-snapshot-20060714-1/winsup/cygwin/sec_acl.cc	2006-07-18 12:50:47.812500000 +0200
@@ -728,7 +728,7 @@ acltotext32 (__aclent32_t *aclbufp, int 
       first = false;
       if (aclbufp[pos].a_type & ACL_DEFAULT)
 	strcat (buf, "default");
-      switch (aclbufp[pos].a_type)
+      switch (aclbufp[pos].a_type & ~ACL_DEFAULT)
 	{
 	case USER_OBJ:
 	  __small_sprintf (buf + strlen (buf), "user::%s",


--------------090301000004080602020704
Content-Type: text/plain;
 name="ChangeLog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog"
Content-length: 86498

2006-07-18  Silvio Laguzzi  <slaguzzi@data-al.de>

	* sec_acl.cc (acltotext32): Add missing handling of default ACL entry
	types.

2006-07-14  Christopher Faylor  <cgf@timesys.com>

	* fork.cc (fork): Lock the process before forking to prevent things
	like new fds from being opened, etc.
	* sync.h (lock_process::dont_bother): New function.

2006-07-14  Christopher Faylor  <cgf@timesys.com>

	* include/cygwin/types.h: Update copyright.

2006-07-14  Christopher Faylor  <cgf@timesys.com>

	* cygwin.sc: Make sure there's something in the cygheap.
	* dllfixdbg: Accommodate newer binutils which put the gnu_debuglink at
	the end rather than at the beginning.

2006-07-13  Christopher Faylor  <cgf@timesys.com>

	* sigproc.cc (waitq_head): Don't initialize to zero.
	* sigproc.h: Update copyright, fix whitespace.

2006-07-13  Christopher Faylor  <cgf@timesys.com>

	* fhandler.cc (fhandler_base::raw_read): Only return EISDIR when we're
	really trying to read a directory.

	* sigproc.cc: Use "Static" where appropriate.

2006-07-13  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_socket.cc: Update copyright.
	* include/pthread.h: Ditto.

2006-07-13  Corinna Vinschen  <corinna@vinschen.de>

	* mmap.cc (mmap64): Drop MAP_NORESERVE flag for non-anonymous,
	non-private mappings.
	(mmap_record::unmap_pages): Only check noreserve flag which now implies
	anonymous and private.
	(mprotect): Ditto.
	(fixup_mmaps_after_fork): Ditto.

2006-07-13  Corinna Vinschen  <corinna@vinschen.de>

	* mmap.cc (mmap64): Drop MAP_RESERVED flag for all non-anonymous,
	non-private mappings.

2006-07-13  Corinna Vinschen  <corinna@vinschen.de>

	* exceptions.cc (_cygtls::handle_exceptions): Call new
	mmap_is_attached_or_noreserve_page function in case of access violation
	and allow application to retry access on noreserve pages.
	* mmap.cc (mmap_is_attached_or_noreserve_page): Changed from
	mmap_is_attached_page.  Handle also noreserve pages now.  Change
	comment accordingly.
	* winsup.h (mmap_is_attached_or_noreserve_page): Declare instead of
	mmap_is_attached_page.

2006-07-12  Corinna Vinschen  <corinna@vinschen.de>

	* mmap.cc (mmap_record::alloc_page_map): Don't call VirtualProtect
	on maps created with MAP_NORESERVE.

2006-07-12  Corinna Vinschen  <corinna@vinschen.de>

	* include/pthread.h: Define PTHREAD_PRIO_NONE, PTHREAD_PRIO_INHERIT and
	PTHREAD_PRIO_PROTECT only if _POSIX_THREAD_PRIO_INHERIT is defined.

2006-07-10  Corinna Vinschen  <corinna@vinschen.de>

	* libc/inet_addr.c: Define __INSIDE_CYGWIN_NET__.
	* libc/inet_network.c: Ditto.

2006-07-07  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_socket.cc (fhandler_socket::wait): Disable SA_RESTART
	handling for now.

2006-07-07  Corinna Vinschen  <corinna@vinschen.de>

	* Makefile.in (DLL_OFILES): Add inet_addr.o and inet_network.o.
	* autoload.cc (inet_addr): Drop definition.
	(inet_ntoa): Ditto.
	* net.cc: Forward declare cygwin_inet_aton and cygwin_inet_ntop.
	(cygwin_inet_ntoa): Call cygwin_inet_ntop instead of Winsock inet_ntoa.
	(cygwin_inet_addr): Remove here.
	(cygwin_inet_aton): Ditto.
	(cygwin_inet_network): Ditto.
	* libc/inet_addr.c: New file implementing cygwin_inet_aton and
	cygwin_inet_addr.
	* libc/inet_network.c: New file implementing cygwin_inet_network.

2006-07-06  Christopher Faylor  <cgf@timesys.com>

	* hookapi.cc: Add comment header
	(putmem): Make static.
	(get_export): Ditto.
	(rvadelta): Ditto.  Don't assume that a section which ends where the
	import_rva begins is the import list.

	* child_info.h: Update copyright.
	* fork.cc: Ditto.

2006-07-05  Christopher Faylor  <cgf@timesys.com>

	* sortdin: Ignore all leading underscores when deriving a sort key.
	* cygwin.din: Resort.

2006-07-05  Christopher Faylor  <cgf@timesys.com>

	* sortdin: New program.
	* cygwin.din: Sort.

2006-07-05  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler.h (fhandler_socket::wait): Reset default timeout to 10ms.

2006-07-05  Corinna Vinschen  <corinna@vinschen.de>

	* path.cc (path_conv::check): Ignore has_ea setting, it's always unset
	at this point anyway.
	(get_symlink_ea): Remove.
	(set_symlink_ea): Remove.
	(symlink_worker): Drop writing symlink into NTFS extended attributes.
	(symlink_info::check): Drop reading symlinks from NTFS extended
	attributes.

2006-07-04  Christopher Faylor  <cgf@timesys.com>

	* libc/rexec.cc (cygwin_rexec): Obvious (?) fix to correct a gcc
	warning - set port to zero first thing in the function.

2006-07-04  Corinna Vinschen  <corinna@vinschen.de>

	* signal.cc (signal): Set sa_mask to sig.

2006-07-04  Corinna Vinschen  <corinna@vinschen.de>

	* Makefile.in (DLL_OFILES): Add rexec.o.
	* autoload.cc (inet_network): Drop definition.
	(rexec): Ditto.
	* net.cc (rexec): Drop extern declaration.
	(inet_network): Ditto.
	(cygwin_inet_network): Implement using inet_addr.
	(cygwin_rexec): Remove.
	* libc/rexec.cc: New file.

2006-07-04  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_socket.cc (fhandler_socket::listen): Allow listening on
	unbound INET socket.

2006-07-04  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler.h (fhandler_socket::wait): Set default timeout to INFINITE.

2006-07-03  Corinna Vinschen  <corinna@vinschen.de>

	* autoload.cc (NtQueryEaFile): Define.
	(NtSetEaFile): Define.
	* fhandler.cc (fhandler_base::open): Use appropriate open flags
	in query case when allow_ntea is set.
	* ntdll.h (struct _FILE_GET_EA_INFORMATION): Define.
	(struct _FILE_FULL_EA_INFORMATION): Define.
	(NtQueryEaFile): Declare.
	(NtSetEaFile): Declare.
	* ntea.cc (read_ea): Rename from NTReadEA and rewrite using
	NtQueryEaFile.
	(write_ea): Rename from NTWriteEA and rewrite using NtSetEaFile.
	* path.cc (get_symlink_ea): Make static.  Add handle parameter to
	accomodate new read_ea call.
	(set_symlink_ea): Make static.  Add handle parameter to accomodate new
	write_ea call.
	(symlink_worker): Call set_symlink_ea while file is still open.
	(symlink_info::check): Call get_symlink_ea after file has been opened.
	* security.cc (get_file_attribute): Accomodate new read_ea call.
	(set_file_attribute): Accomodate new write_ea call.
	* security.h (read_ea): Change declaration accordingly.
	(write_ea): Ditto.

2006-07-03  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* fhandler.h (class dev_console): Add `metabit' indicating the
	current meta key mode.
	* fhandler_console.cc (fhandler_console::read): Set the top bit of
	the character if metabit is true.
	* fhandler_console.cc (fhandler_console::ioctl): Implement
	KDGKBMETA and KDSKBMETA commands.
	* fhandler_tty.cc (process_ioctl): Support KDSKBMETA.
	(fhandler_tty_slave::ioctl): Send KDGKBMETA and KDSKBMETA to the
	master.
	* include/cygwin/kd.h: New file for the meta key mode.
	* include/sys/kd.h: New file.

2006-07-03  Eric Blake  <ebb9@byu.net>

	* include/stdint.h (UINT8_C, UINT16_C): Unsigned types smaller
	than int promote to signed int.

2006-07-03  Corinna Vinschen  <corinna@vinschen.de>

	* net.cc (cygwin_sendto): Define appropriate parameters using
	socklen_t type according to SUSv3.
	(cygwin_recvfrom): Ditto.
	(cygwin_setsockopt): Ditto.
	(cygwin_getsockopt): Ditto.
	(cygwin_connect): Ditto.
	(cygwin_accept): Ditto.
	(cygwin_bind): Ditto.
	(cygwin_getsockname): Ditto.
	(cygwin_getpeername): Ditto.
	(cygwin_recv): Ditto.
	(cygwin_send): Ditto.
	* include/cygwin/socket.h (socklen_t): Typedef and define.
	* include/sys/socket.h: Declare socket functions using socklen_t type.

2006-07-02  Christopher Faylor  <cgf@timesys.com>

	* include/cygwin/version.h: Bump DLL minor version number to 21.

2006-06-30  Corinna Vinschen  <corinna@vinschen.de>

	* net.cc (cygwin_sendto): Allow zero-sized packets.
	(cygwin_sendmsg): Ditto.

2006-06-26  Corinna Vinschen  <corinna@vinschen.de>

	Revert patches from 2005-10-22 and 2006-06-14 to use event driven
	accept and connect back to using select:
	* fhandler.h (class fhandler_socket): Remove accept_mtx.
	* fhandler_socket.cc (fhandler_socket::fhandler_socket): Drop
	initializing accept_mtx.
	(fhandler_socket::accept): Drop event handling.
	(fhandler_socket.cc (fhandler_socket::connect): Ditto.
	(fhandler_socket::dup): Drop accept_mtx handling.
	(fhandler_socket::listen): Ditto.
	(fhandler_socket::prepare): Ditto.
	(fhandler_socket::release): Ditto.
	(fhandler_socket::close): Ditto.
	* net.cc (cygwin_accept): Revert to calling cygwin_select to
	implement interuptible accept.
	(cygwin_connect): Ditto for connect.

2006-06-22  Christopher Faylor  <cgf@timesys.com>

	* fhandler_fifo.cc (fhandler_fifo::open): Release process lock and grab
	a system-wide mutex to prevent a deadlock and a race.
	* sync.h (lock_process): Make fhandler_fifo a friend.

	* smallprint.c (__small_vsprintf): Cosmetic change.

2006-06-15  Corinna Vinschen  <corinna@vinschen.de>

	* cygwin.din: Export __srget_r, __swbuf_r.
	* include/cygwin/version.h: Bump API minor number to 156.

2006-06-14  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler.h (class fhandler_socket): Add private mutex handle
	accept_mtx.
	* fhandler_socket.cc (fhandler_socket::fhandler_socket): Initialize
	accept_mtx to NULL.
	(fhandler_socket::dup): Duplicate accept_mtx, if available.
	(fhandler_socket::listen): Create accept_mtx before trying to listen.
	(fhandler_socket::prepare): Wait for accept_mtx if available to
	serialize accepts on the same socket.
	(fhandler_socket::release): Release accept_mtx.
	(fhandler_socket::close): Close accept_mtx on successful closesocket.

2006-06-12  Christopher Faylor  <cgf@timesys.com>

	* fhandler_tty.cc (fhandler_pty_master::close): Always close
	from_master/to_master since we always have copies of these handles.

2006-06-12  Corinna Vinschen  <corinna@vinschen.de>

	* include/sys/wait.h: Move definition of wait constants from here...
	* include/cygwin/wait.h: ...to here.  New file.
	* include/cygwin/stdlib.h: Include cygwin/wait.h to conform with SUSv3.

2006-06-12  Pierre Humblet  Pierre.Humblet@ieee.org

	* heap.cc (heap_init): Only commit if allocsize is not zero.

2006-06-12  Corinna Vinschen  <corinna@vinschen.de>

	* net.cc (fdsock): Disable raising buffer sizes.  Add comment to
	explain why.

2006-06-04  Christopher Faylor  <cgf@timesys.com>

	* ioctl.cc (ioctl): Accommodate change in reported pty master device
	number.
	* select.cc (peek_pipe): Ditto.

2006-06-04  Christopher Faylor  <cgf@timesys.com>

	* cygtls.h (CYGTLS_PADSIZE): Reset to a size that XP SP1 seems to like.
	* tlsoffsets.h: Regenerate.

2006-06-03  Christopher Faylor  <cgf@timesys.com>

	* cygthread.cc (cygthread::terminate_thread): In debugging output, use
	name of thread being terminated rather than thread doing the
	terminating.

	* fhandler.h (fhandler_pty_master::slave): Delete.
	(fhandler_pty_master::get_unit): Ditto.
	(fhandler_pty_master::setup): Change argument declaration to
	accommodate new usage.
	* fhandler_tty.cc (fhandler_tty_master::init): Remove obsolete slave
	assignment.  Pass argument to setup indicating that this is a tty.
	(fhandler_tty_slave::open): Use dev() method rather than referencing
	pc.dev directly.
	(fhandler_pty_master::open): Don't create archetype based on ptym
	device number.  Set device number to use DEV_TTYM_MAJOR and tty number.
	Pass argument to setup indicating that this is a pty.
	(fhandler_pty_master::setup): Change single argument to a flag
	indicating whether we're creating a pty and use appropriately.
	Calculate 't' variable here rather than in caller.

	* fhandler_dsp.cc (fhandler_dev_dsp::open): Use dev() method rather
	than referencing pc.dev directly.

2006-06-03  Christopher Faylor  <cgf@timesys.com>

	* dcrt0.cc (dll_crt0_0): Call tty_list::init_session here.
	(dll_crt0_1): Reflect renaming from tty_init to tty::init_session.
	(do_exit): Reflect moving of tty_terminate into tty_list.
	* exceptions.cc (events_init): Move tty_mutex stuff elsewhere.
	* fhandler_console.cc (set_console_title): Use lock_ttys class.
	* fhandler_termios.cc (fhandler_termios::bg_check): Make debug output
	more accurate.
	* fhandler_tty.cc (fhandler_tty_slave::open): Reflect move of
	attach_tty into tty_list class.  Don't attempt to grab master end of
	pty if master doesn't exist.
	(fhandler_pty_master::open): Reflect move of allocate_tty into tty_list
	class.  Use lock_ttys::release to release mutex.  Improve debugging
	output.
	(fhandler_pty_master::setup): Remove if 0'ed block.  Fix argument to
	SetNamedPipeHandleState.
	* pinfo.cc (_pinfo::set_ctty): Lock ttys before setting sid/pgid.
	Improve debugging.  Add temporary debugging.
	* tty.cc (tty_list::init_session): New function.
	(tty::init_session): Rename from tty_init.  Reflect move of attach_tty
	to tty_list class.
	(tty::create_master): Rename from create_tty_master.
	(tty_list::attach): Rename from attach_tty.  Reflect renaming of
	connect_tty to connect.  Ditto for allocate_tty.
	(tty_terminate): Delete.
	(tty_list::terminate): Subsume tty_terminate.  Use lock_ttys rather
	than manipulating mutex directly.
	(tty_list::allocate): Rename from allocate_tty.  Use lock_ttys rather
	than manipulating mutex directly.  Don't set sid here since linux
	apparently doesn't do this.  Reflect move of create_tty_master into
	tty.
	(lock_ttys::lock_ttys): Define new constructor.
	(lock_ttys::release): New function.
	* tty.h (tty::exists): Return false immediately if !master_pid.
	(tty::set_master_closed): Define new function.
	(tty::create_master): Ditto.
	(tty::init_session): Ditto.
	(tty_list::mutex): New field.
	(tty_list::allocate): Define new function.
	(tty_list::connect): Ditto.
	(tty_list::attach): Ditto.
	(tty_list::init_session): Ditto.
	(lock_ttys): New class.
	(tty_init): Delete declaration.
	(tty_terminate): Ditto.
	(attach_tty): Ditto.
	(create_tty_master): Ditto.

2006-06-03  Christopher Faylor  <cgf@timesys.com>

	* Makefile.in (libdl.a): New library.

2006-06-03  Christopher Faylor  <cgf@timesys.com>

	* fhandler_tty.cc (fhandler_pty_master::close): Don't close handles if
	we don't own them.
	(fhandler_pty_master::setup): Make sure that original handle is closed
	when changing inheritance.
	(fhandler_pty_master::fixup_after_fork): Set from_master/to_master to
	arch value always.
	(fhandler_pty_master::fixup_after_exec): Clear from_master/to_master
	when close_on_exec.

2006-06-03  Christopher Faylor  <cgf@timesys.com>

	* cygheap.cc (init_cygheap::close_ctty): Remove obsolete code.
	* dcrt0.cc (child_info_spawn::handle_spawn): Signal ready after we've
	run fixup_after_exec.
	* dtable.cc (dtable::fixup_after_exec): Add debugging output.
	* fhandler_tty.cc (fhandler_pty_master::doecho): Use class version of
	to_master.
	(fhandler_tty_common::close): Remove obsolete code.
	(fhandler_tty_slave::fixup_after_exec): Don't close, since this is done
	in dtable's fixup_after_exec.  (revisit later?)
	(fhandler_pty_master::fixup_after_exec): Ditto.

2006-06-02  Christopher Faylor  <cgf@timesys.com>

	* cygtls.h (CYGTLS_PADSIZE): Bump up or suffer a regrettable collision
	with the call chain.
	* tlsoffsets.h: Regenerate.

	* dcrt0.cc (break_here): Define unconditionally for use elsewhere.
	Call DebugBreak, if appropriate.
	(initial_env): Rely on break_here() to call DebugBreak.
	* exceptions.cc (try_to_debug): Ditto.

2006-06-02  Christopher Faylor  <cgf@timesys.com>

	* fhandler.cc (fhandler_base::fixup_after_exec): Declare here.
	* fhandler.h (fhandler_base::fixup_after_exec): Make non-inline.
	(fhandler_termios::fixup_after_fork): Delete declaration.
	(fhandler_termios::fixup_after_exec): Ditto.
	(fhandler_tty_common::inuse): Remove.
	(fhandler_tty_common::dup): Delete declaration.
	(fhandler_tty_common::fixup_after_fork): Ditto.
	(fhandler_tty_slave::fixup_after_exec): Declare new function.
	(fhandler_pty_master::dwProcessId): New variable.
	(fhandler_pty_master::from_master): Ditto.
	(fhandler_pty_master::to_master): Ditto.
	(fhandler_pty_master::setup): New function.
	(fhandler_pty_master::fixup_after_fork): Ditto.
	(fhandler_pty_master::fixup_after_exec): Ditto.
	* fhandler_termios.cc (fhandler_termios::fixup_after_exec): Delete
	definition.
	(fhandler_termios::fixup_after_fork): Ditto.
	* fhandler_tty.cc (fhandler_tty_master::init): Use fhandler_pty_master
	setup function rather than obsolete tty::common_init.  Delete obsolete
	inuse setting.
	(fhandler_tty_slave::fhandler_tty_slave): Set inuse to NULL here.
	(fhandler_tty_slave::open): Change debugging output for clarity.  Check
	for different things when doing a sanity check on the tty.  Reflect the
	fact that master_pid now is the cygwin pid rather than the windows pid.
	Use "arch" rather than "archetype" for consistency.
	(fhandler_tty_slave::close): Close inuse here.
	(fhandler_tty_slave::dup): Remove old if 0'ed code.
	(fhandler_pty_master::dup): New function.  Handles pty master
	archetype.
	(fhandler_pty_master::fhandler_pty_master): Zero pty_master specific
	fields.
	(fhandler_pty_master::open): Implement using archetypes, similar to
	slave.  Use fhandler_pty_master setup function rather than obsolete
	tty::common_init.  Don't set inuse.
	(fhandler_tty_common::close): Don't deal with inuse.  Delete old if
	0'ed code.
	(fhandler_pty_master::close): Implement using archetypes.  Close
	from_master and to_master.
	(fhandler_tty_common::set_close_on_exec): Just set close_on_exec flag
	here since everything uses archetypes now.
	(fhandler_tty_common::fixup_after_fork): Delete definition.
	(fhandler_tty_slave::fixup_after_exec): Define new function.
	(fhandler_pty_master::setup): New function, derived from
	tty::common_init.
	(fhandler_pty_master::fixup_after_fork): New function.
	(shared_info.h): Reset SHARED_INFO_CB to reflect new tty size.
	* tty.cc (tty_list::terminate): Close individual handles from
	tty_master.
	(tty::master_alive): Delete.
	(tty::make_pipes): Ditto.
	(tty::common_init): Ditto.
	* tty.h (tty::from_slave): Delete.
	(tty::to_slave): Ditto.
	(tty::common_init): Delete declaration.
	(tty::make_pipes): Ditto.
	(tty::master_pid): Define as pid_t since it is now a cygwin pid.

2006-06-01  Christopher Faylor  <cgf@timesys.com>

	* cygheap.cc (cygheap_fixup_in_child): Don't close parent handle here.
	Let the caller do that.
	* dcrt0.cc (child_info_spawn::handle_spawn): Close parent handle here
	to allow fixup_after_exec functions to use it.

	* cygtls.cc (_cygtls::call2): Avoid calling exit thread if called with
	*crt0_1 functions.
	* cygtls.h (_cygtls::isinitialized): Check that we actually have a tls
	before seeing if it is initialized.
	* gendef (_sigfe_maybe): Ditto.
	* dcrt0.cc (dll_crt0_1): Remove static, use just one argument.
	* dll_init.cc (dllcrt0_info): New structure.
	(dll_dllcrt0): Change into a front-end to renamed dll_dllcrt0_1 so that
	we'll always be assured of having something like a tls.
	(dll_dllcrt0_1): New function, basically renamed from from dll_dllcrt0.
	Unconditionally call _my_tls.init_exception_handler now that we are
	assured of having a tls.  Change variable name from "linking" to "linked".
	* winsup.h (dll_crt0_1): Declare.
	(dll_dllcrt0_1): Ditto.

2006-05-30  Christopher Faylor  <cgf@timesys.com>

	* cygtls.cc (_cygtls::call2): Don't call ExitThread on the main thread.

2006-05-29  Christopher Faylor  <cgf@timesys.com>

	* winf.h (MAXCYGWINCMDLEN): Set down size to 30000 or suffer fork
	errors.

2006-05-28  Christopher Faylor  <cgf@timesys.com>

	* sigproc.cc (child_info::proc_retry): Mask all of the bits we're
	interested in, which includes bits above and below 0xc0000000.

2006-05-27  Christopher Faylor  <cgf@timesys.com>

	* dll_init.cc (dll_dllcrt0): Previous change didn't work very well with
	fork.  Semi-revert it but change name of variable to something that
	makes better sense.

2006-05-27  Christopher Faylor  <cgf@timesys.com>

	* thread.cc (verifyable_object_isvalid): Check for NULL specifically.

2006-05-27  Christopher Faylor  <cgf@timesys.com>

	* dll_init.cc (dll_dllcrt0): Call _my_tls.init_exception_handler if
	we've finished initializing (Thanks to Gary Zablackis for noticing this
	problem).  Just use cygwin_finished_initializing rather than defining a
	separate variable.

2006-05-25  Christopher Faylor  <cgf@timesys.com>

	* debug.h (ModifyHandle): Define new macro.
	(modify_handle): Declare new function.
	* debug.cc (modify_handle): Define new function.
	* fhandler.h (fhandler_base::fork_fixup): Change return value from void
	to bool.
	* fhandler.cc (fhandler_base::fork_fixup): Return true if fork fixup has
	been done.
	* pipe.cc (fhandler_pipe::set_close_on_exec): Set inheritance of
	protected handle via ModifyHandle if DEBUGGING.
	(fhandler_pipe::fixup_after_fork): Protect guard handle if fork fixup
	has been done.

2006-05-24  Christopher Faylor  <cgf@timesys.com>

	* cygtls.cc (_cygtls::call): Call call2 using _my_tls.
	(_cygtls::init_exception_handler): Always replace existing exception
	handler with cygwin exception handler.
	* cygtls.h (_cygtls::call2): Remove static designation.
	* dcrto.cc (dll_crt0_1): Define in a way that allows calling via
	_cygtls::call.
	(_initialize_main_tls): Delete.
	(_dll_crt0): Call dll_crt0_1 via cygtls::call.  Set _main_tls here.
	* external.cc (cygwin_internal): Implement CW_CYGTLS_PADSIZE.
	* include/sys/cygwin.h (CW_CYGTLS_PADSIZE): Define.
	* tlsoffsets.h: Regenerate.

2006-05-24  Christopher Faylor  <cgf@timesys.com>

	* configure.in: Update to newer autoconf.
	(thanks to Steve Ellcey)
	* configure: Regenerate.
	* aclocal.m4: New file.

2006-05-23  Lev Bishop  <lev.bishop+cygwin@gmail.com>

	* fhandler.cc (readv): Remove nonsensical assert.

2006-05-23  Christopher Faylor  <cgf@timesys.com>

	* select.cc (start_thread_socket): Delay setting thread local exitsock
	until we know it's correct.  Return correct value on error.

2006-05-23  Lev Bishop  <lev.bishop+cygwin@gmail.com>
	    Christopher Faylor  <cgf@timesys.com>

	* select.cc (start_thread_socket): Clean up exitsock in case of error.
	Use si->exitcode consistently.

2006-05-21  Christopher Faylor  <cgf@timesys.com>

	* child_info.h (_CI_SAW_CTRL_C): New enum.
	(CURR_CHILD_INFO_MAGIC): Reset.
	(saw_ctrl_c): New function.
	(set_saw_ctrl_c): Ditto.
	* sigproc.cc (child_info::proc_retry): Return EXITCODE_OK if we get
	STATUS_CONTROL_C_EXIT and we actually saw a CTRL-C.
	* spawn.cc (dwExeced): Delete.
	(chExeced): New variable.
	(spawn_guts): Set chExeced;
	* exceptions.cc (dwExeced): Delete declaration.
	(chExeced): Declare.
	(ctrl_c_handler): Detect if we're an exec stub process and set a flag,
	if so.

	* fhandler_tty.cc (fhandler_tty_common::__release_output_mutex): Add
	extra DEBUGGING test.

	* pinfo.cc: Fix comment.

2006-05-21  Christopher Faylor  <cgf@timesys.com>

	* fhandle.h (fhandler_pipe::create_guard): Revert change which
	eliminated SECURITY_ATTRIBUTES argument.
	* pipe.cc (fhandler_pipe::open): Duplicate guard from other process and
	protect it appropriately.  Eliminate unneeded writepipe_exists
	temporary variable.  Set inheritance appropriately.
	(fhandler_pipe::set_close_on_exec): Revert change which eliminated
	handling guard inheritance.
	(fhandler_pipe::fixup_after_fork): Ditto.  Use correct name of entity
	being checked by fork_fixup.
	(fhandler_pipe::fixup_after_exec): Don't bother with guard here.
	(fhandler_pipe::dup): Cosmetic changes and revert creation of
	writepipe_exists as noninheritable.
	(fhandler_pipe::create): Revert change which eliminated
	SECURITY_ATTRIBUTES argument.  Revert change which always made
	writepipe_exists noninheritable.

2006-05-21  Christopher Faylor  <cgf@timesys.com>

	* debug.cc (add_handle): Print handle value when collision detected.
	* dtable.cc (dtable::stdio_init): Cosmetic change.
	* fhandler.h (fhandler_base::create_read_state): Protect handle.
	(fhandler_pipe::create_guard): Ditto.  Always mark the handle as
	inheritable.
	(fhandler_pipe::is_slow): Return boolean value rather than numeric 1.
	* pipe.cc (fhandler_pipe::fhandler_pipe): Always flag that we need fork
	fixup.
	(fhandler_pipe::open): Don't pass security attributes to create_guard.
	(fhandler_pipe::set_close_on_exec): Don't handle guard here.
	(fhandler_pipe::close): Accommodate now-protected guard handle.
	(fhandler_pipe::fixup_in_child): Don't protect read_state here.
	(fhandler_pipe::fixup_after_exec): Close guard handle if close_on_exec.
	(fhandler_pipe::fixup_after_fork): Don't bother with guard here.
	(fhandler_pipe::dup): Don't set res to non-error prematurely.  Use
	boolean values where appropriate.  Protect guard and read_state.
	(fhandler_pipe::create): Don't call need_fork_fixup since it is now the
	default.  Don't protect read_state or guard.

	* pipe.cc (fhandler_base::ready_for_read): Use bool values for "avail".

	* spawn.cc (spawn_guts): Set cygheap->pid_handle as inheritable when
	protecting.

2006-05-15  Lev Bishop  <lev.bishop+cygwin@gmail.com>
	    Christopher Faylor  <cgf@timesys.com>

	* select.cc (fhandler_pipe::ready_for_read): Actually get the guard
	mutex for blocking reads.

2006-05-20  Christopher Faylor  <cgf@timesys.com>

	* fhandler_tty.cc (fhandler_tty::close): Remove problematic hExeced guard.

2006-05-20  Christopher Faylor  <cgf@timesys.com>

	* fhandler_tty.cc (fhandler_tty_slave::open): Reinstate call to
	need_invisible on first pty open.

2006-05-18  Christopher Faylor  <cgf@timesys.com>

	* fhandler_console.cc (fhandler_console::need_invisible): Allocate an
	invisible window station when ctty != TTY_CONSOLE.

2006-05-16  Christopher Faylor  <cgf@timesys.com>

	* cygtls.cc (_cygtls::remove): Don't test for initialization since
	this function will always be called when _my_tls is initialized.
	* init.cc (dll_entry): Don't attempt to remove tls info if _my_tls is
	obviously not even available.

2006-05-15  Christopher Faylor  <cgf@timesys.com>

	* sigproc.cc (no_signals_available): Detect hwait_sig ==
	INVALID_HANDLE_VALUE.
	(wait_sig): Set hwait_sig to INVALID_HANDLE_VALUE on __SIGEXIT.

2006-05-15  Christopher Faylor  <cgf@timesys.com>

	* cygtls.cc (_cygtls::init_thread): Zero entire _my_tls structure and
	no more.
	* cygtls.h (_my_tls::padding): Delete.
	(CYGTLS_PADSIZE): Redefine concept of padding to mean padding at the
	end of the stack.
	* dcrt0.cc (initialize_main_tls): Change return to void.
	* gentls_offsets: Treat const specially, too.  Keep going after a '}'
	is found.  Change negative offset calculation to use CYGTLS_PADSIZE.
	* init.cc (_my_oldfunc): New variable.
	(threadfunc_fe): Use stored tls value for oldfunc rather than blindly
	writing to the stack.
	(munge_threadfunc): Set oldfunc in tls.
	(dll_entry): Initialize tls allocation.
	* tlsoffsets.h: Regenerate.

2006-05-13  Christopher Faylor  <cgf@timesys.com>

	* ntdll.h (STATUS_INVALID_INFO_CLASS): Conditionalize.

2006-05-10  Brian Dessent  <brian@dessent.net>

	* Makefile.in (clean): Also delete *.dbg.

2006-05-08  Christian Franke  <Christian.Franke@t-online.de>

	* fhandler_disk_file.cc (fhandler_disk_file::readdir): Fix typo which
	caused test for ".." to be skipped.

2006-05-02  Christopher Faylor  <cgf@timesys.com>

	* external.cc (cygwin_internal): Set errno on failure.

2006-04-27  Corinna Vinschen  <corinna@vinschen.de>

	* pipe.cc (DEFAULT_PIPEBUFSIZE): Raise to 64K.

2006-04-26  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler.h (fhandler_base): Change fstat_helper prototype
	to take file size and inode number as 64 bit values.
	* fhandler_disk_file.cc (FS_IS_SAMBA): Move to path.cc
	(FS_IS_SAMBA_WITH_QUOTA): Ditto.
	(path_conv::hasgood_inode): Delete.
	(path_conv::is_samba): Delete.
	(path_conv::isgood_inode): Centralized function to recognize
	a good inode number.
	(fhandler_base::fstat_by_handle): Constify fvi_size and fai_size.
	Accomodate argument change in fstat_helper.
	(fhandler_base::fstat_by_name): Ditto.
	(fhandler_base::fstat_helper): Accomodate argument change.  Call
	path_conv::isgood_inode to recognize good inodes.
	(fhandler_disk_file::opendir): Explain Samba weirdness here.
	Call path_conv::fs_is_samba instead of path_conv::is_samba.
	(fhandler_disk_file::readdir): Add STATUS_INVALID_INFO_CLASS
	as valid return code from NtQueryDirectoryFile to indicate that
	FileIdBothDirectoryInformation is not supported.
	Call path_conv::isgood_inode to recognize good inodes.
	* ntdll.h (STATUS_INVALID_INFO_CLASS): Define.
	* path.cc (fs_info::update): Rework file system recognition
	and set appropriate flags.
	* path.h (struct fs_info): Add is_ntfs, is_samba and is_nfs flags.
	Constify pure read accessors.

2006-04-24  Christopher Faylor  <cgf@timesys.com>

	* environ.cc (getearly): Force correct dereference order when
	inspecting environ table.

2006-04-24  Corinna Vinschen  <corinna@vinschen.de>

	* select.cc (thread_pipe): Raise sleep time only every 8th iteration.
	(thread_mailslot): Ditto.

2006-04-23  Corinna Vinschen  <corinna@vinschen.de>
	    Christopher Faylor  <cgf@timesys.com>

	* select.cc (thread_pipe): Raise sleep time dynamically to speed up
	select on pipes when copying lots of data.
	(thread_mailslot): Ditto for mailslots.

2006-04-22  Christopher Faylor  <cgf@timesys.com>

	* signal.cc (abort): On second thought, just set incyg once.

2006-04-22  Christopher Faylor  <cgf@timesys.com>

	* signal.cc (abort): Set incyg manually to help get a reliable gdb
	stack trace.
	* cygwin.din (abort): Make NOSIGFE.

2006-04-21  Pierre Humblet Pierre.Humblet@ieee.org
	    Christopher Faylor  <cgf@timesys.com>

	* environ.cc (getearly): Use GetEnvironmentVariable and cmalloc instead
	of GetEnvironmentStrings.
	(environ_init): Revert rawenv stuff.

2006-04-21  Christopher Faylor  <cgf@timesys.com>

	* environ.cc (rawenv): Make this variable a file-scope static.
	(getearly): Rename 's' variable to 'len' since 's' is used fairly
	consistently throughout cygwin as a string variable.  Remove rawenv
	declaration.  Perform other minor cleanups.
	(environ_init): Remove rawenv declaration.  Only set rawenv to
	GetEnvironmentStrings() if it has not already been set.  Properly free
	rawenv in all cases.

2006-04-21  Christopher Faylor  <cgf@timesys.com>

	* tty.h (tty::hwnd): Move to tty_min.
	(tty::gethwnd): Ditto.
	(tty::sethwnd): Ditto.
	(tty_min::hwnd): Receive variable from tty class.
	(tty_min::gethwnd): Receive function from tty classs.
	(tty_min::sethwnd): Ditto.
	* dtable.cc (dtable::stdio_init): Only call init_console_handler when
	we actually own the console.
	* fhandler_console.cc (fhandler_console::get_tty_stuff): Set tty's hwnd
	to non-zero value.
	* fhandler_termios.cc (fhandler_termios::tcsetpgrp): Semi-reinstate
	handling of console when pgrp is set.

2006-04-21  Pierre Humblet  <Pierre.Humblet@ieee.org>
	    Corinna Vinschen  <corinna@vinschen.de>

	* environ.cc (getearly): New function.
	(findenv_func): New function pointer, predefined to getearly.
	(getenv): Call findenv function over the findenv_func pointer.
	(environ_init): Change findenv_func pointer to my_findenv after Cygwin
	environment is initialized.

2006-04-21  Lars Munch  <lars@segv.dk>

	* include/asm/byteorder.h (__ntohl): Fix the missing uint32_t.

2006-04-21  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_socket.cc (fhandler_socket::wait): Reorder setting
	WSAError to avoid spurious errors with WSAError set to 0.

2006-04-21  Corinna Vinschen  <corinna@vinschen.de>

	* include/asm/byteorder.h: Include stdint.h.  Per standard, change
	datatypes in ntohX and htonX functions to uintXX_t types.

2006-04-18  Christopher Faylor  <cgf@timesys.com>

	* exceptions.cc (ctrl_c_handler): Only exit TRUE on CTRL_LOGOFF_EVENT
	when we have actually handled the event.

2006-04-17  Eric Blake  <ebb9@byu.net>

	* mktemp.cc (_gettemp): Open temp files in binary mode.

2006-04-14  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (fhandler_disk_file::readdir): Use UINT32_MAX
	instead of UINT_MAX.

2006-04-14  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (path_conv::hasgood_inode): Make inline.
	Drop remote fs handling entirely since unreliable inode numbers
	are now recognized differently.
	(path_conv::is_samba): Make inline.
	(fhandler_disk_file::opendir): Reformat comment.
	(fhandler_base::fstat_helper): Special case remote file systems
	returning (unreliable) 32 bit inode numbers.
	(fhandler_disk_file::readdir): Ditto.
	* fhandler_netdrive.cc (fhandler_netdrive::readdir): Ditto.

2006-04-13  Christopher Faylor  <cgf@timesys.com>

	* spawn.cc (spawn_guts): Move ch.set() call back to where it was
	supposed to be.

2006-04-13  Corinna Vinschen  <corinna@vinschen.de>

	* sysconf.cc (sysconf): Add _SC_THREADS, _SC_THREAD_ATTR_STACKSIZE,
	_SC_THREAD_PRIORITY_SCHEDULING, _SC_THREAD_PROCESS_SHARED,
	_SC_THREAD_SAFE_FUNCTIONS, _SC_TIMERS handling.

2006-04-12  Corinna Vinschen  <corinna@vinschen.de>
	    Christopher Faylor  <cgf@timesys.com>

	* spawn.cc (spawn_guts): Revert patch which treated derived cygwin
	programs differently from those which are mounted with -X.  Pass extra
	argument to linebuf::fromargv.
	* winf.h (MAXCYGWINCMDLEN): New define.
	(linebuf::finish): Add a new argument denoting when command line
	overflow is ok.
	(linebuf::fromargv): Ditto.
	* winf.cc (linebuf::finish): Implement above change.
	(linebuf::fromargv): Ditto.

2006-04-11  Christopher Faylor  <cgf@timesys.com>

	* Makefile.in (DLL_OFILES): Add winf.o.
	* spawn.cc: Move command line handling stuff into winf.cc.
	* winf.h: New file.
	* winf.cc: New file.

2006-04-05  Christopher Faylor  <cgf@timesys.com>

	* fhandler_socket.cc: Move iptypes.h include after winsock2 since it
	now relies on it.
	* net.cc: Ditto.

2006-04-05  Christopher Faylor  <cgf@timesys.com>

	* dcrt0.cc (dll_crt0_0): Move user_data->{resourcelocks,threadinterface}
	initialization here from dll_crt0_1.
	(dll_crt0_1): See above.

2006-04-04  Corinna Vinschen  <corinna@vinschen.de>

	* net.cc (fdsock): Raise default SO_RCVBUF/SO_SNDBUF buffer sizes to
	the same values as on Linux.

2006-04-03  Christopher Faylor  <cgf@timesys.com>

	* child_info.h (CURR_CHILD_INFO_MAGIC): Update.
	(child_info_fork::alloc_stack): Move into this class.
	(child_info_fork::alloc_stack_hard_way): Ditto.
	* dcrt0.cc (child_info_fork::alloc_stack): Ditto.
	(child_info_fork::alloc_stack_hard_way): Ditto.
	(_dll_crt0): Reference alloc_stack via fork_info.

2006-04-03  Corinna Vinschen  <corinna@vinschen.de>

	* spawn.cc (linebuf::finish): Drop argument.  Don't check command line
	length.
	(spawn_guts): Remove wascygexec.  Check real_path.iscygexec instead.
	Accommodate change to linebuf::finish.

2006-04-03  Christopher Faylor  <cgf@timesys.com>

	* dcrt0.cc (sm): Delete.
	(alloc_stack_hard_way): Figure out where the stack lives here rather
	than relying on previously filled out information which has been
	invalid since 1.5.19.

2006-03-31  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (FS_IS_SAMBA_WITH_QUOTA): New define.
	(path_conv::hasgood_inode): Recognize Samba with quota support
	compiled in.
	(path_conv::is_samba): Ditto.  Fix comment to include Samba version
	numbers for later reference.

2006-03-30  Corinna Vinschen  <corinna@vinschen.de>

	* security.h (sec_user_nih): Make sid1 argument mandatory.
	(sec_user): Ditto.

2006-03-29  Christopher Faylor  <cgf@timesys.com>

	* sigproc.cc (wait_for_sigthread): Use the current user sid when
	setting up the signal pipe rather than relying on (eventually) the
	effective sid.

2006-03-29  Christopher Faylor  <cgf@timesys.com>

	* dcrt0.cc (child_info_fork::handle_fork): Set uid/gid in myself so
	that it can be used by subsequent startup functions.
	(dll_crt0_0): Issue a warning if DuplicateTokenEx fails and DEBUGGING.
	(dll_crt0_1): Move user_data->{resourcelocks,threadinterface}
	initialization here from dll_crt0_0.
	* fork.cc (frok::child): Tell wait_for_sigthread that this is fork.
	(frok::parent): Only initialize start_time once.  Tighten time when
	we're "deimpersonated".
	* sigproc.cc (signal_fixup_after_exec): Rework (futiley) sa_buf stuff.
	Add debugging output.
	(wait_for_sigthread): Accept an argument which illustrates whether we
	are forked or not.
	(wait_sig): Avoid using myself pointer.
	* winsup.h ((wait_for_sigthread): Reflect change to argument.

2006-03-26  Christopher Faylor  <cgf@timesys.com>

	* spawn.cc (spawn_guts): Close handles if we know that we will not be
	seeing a sync event from the child.

2006-03-26  Christopher Faylor  <cgf@timesys.com>

	* sigproc.cc (wait_sig): Move myself manipulation...
	(wait_for_sigthread): ...to here.

2006-03-24  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_floppy.cc: Include ntdef.h and ntdll.h.
	(fhandler_dev_floppy::get_drive_info): Rearrange so that now
	NtQueryVolumeInformationFile is called on drives which don't support
	IOCTL_DISK_GET_DRIVE_GEOMETRY.
	* ntdll.h (struct _FILE_FS_SIZE_INFORMATION): Add.
	(enum _FSINFOCLASS): Add missing values.

2006-03-23  Christopher Faylor  <cgf@timesys.com>

	* fhandler_console.cc (fhandler_console::fixup_after_fork_exec): Make
	error message more explicit.
	* pinfo.cc (_pinfo::commune_request): Don't lock process unless we're
	looking for fifos.

2006-03-23  Christopher Faylor  <cgf@timesys.com>

	* dcrt0.cc (child_info_spawn::handle_spawn): Don't initialize the
	console handler here.
	* dtable.cc (dtable::stdio_init): Initialize console handler here.

2006-03-23  Christopher Faylor  <cgf@timesys.com>

	* sigproc.cc (sigalloc): Don't set SA_RESTART here.
	* signal.cc (_SA_NORESTART): New flag.
	(sigaction_worker): New function, derived from sigaction.  Don't set
	internal flags unless called internally.
	(sigaction): Use sigaction_worker.
	(signal): Honor new _SA_NORESTART flag.
	(siginterrupt): Set _SA_NORESTART flag appropriately.  Use
	sigaction_worker to set flags.
	* include/cygwin/signal.h: Define _SA_INTERNAL_MASK here.

2006-03-22  Corinna Vinschen  <corinna@vinschen.de>

	* thread.cc (pthread_mutex::is_good_initializer_or_bad_object): Delete.
	(pthread_cond::is_good_initializer_or_bad_object): Delete.
	(pthread_rwlock::is_good_initializer_or_bad_object): Delete.
	(pthread_cond::init): Remove disabled code.  Guard assignment to
	object to initialize against access violation.
	(pthread_rwlock::init): Ditto.
	(pthread_mutex::init): Ditto.

2006-03-22  Eric Blake  <ebb9@byu.net>

	* fhandler.cc (fcntl): Print flags in hex.

2006-03-22  Christopher Faylor  <cgf@timesys.com>

	* dcrt0.cc (dll_crt0_0): Semi-revert 2006-03-14 change which moved
	pinfo_init and uinfo_init here.
	(dll_crt0_1): Ditto.
	(__dll_crt0): Ditto. Don't call update_envptrs here.
	(dll_crt0_1): Ditto. Move wait_for_sigthread call here from dll_crt0_0.
	* environ.cc (environ_init): Call it here instead.
	* sigproc.cc (my_readsig): New static variable.
	(wait_for_sigthread): Set up read pipe here since we are assured that
	we have the proper privileges when this is called.
	(talktome): Eliminate second argument since it is available as a global
	now.
	(wait_sig): Reflect use of my_readsig.

2006-03-22  Corinna Vinschen  <corinna@vinschen.de>

	* thread.cc (pthread_cond::init): Disable validity test of object
	to initialize since test of uninitialized content is unreliable.
	(pthread_rwlock::init): Ditto.
	(pthread_mutex::init): Ditto.

2006-03-21  Christopher Faylor  <cgf@timesys.com>

	* signal.cc (signal): Don't set SA_RESTART here.
	(siginterrupt): White space.
	* sigproc.cc (sigalloc): Set SA_RESTART here, on initialization.

2006-03-21  Christopher Faylor  <cgf@timesys.com>

	* child_info.h (child_status): Fix typo which made it impossible to set
	iscygwin.
	(child_info::isstraced): Booleanize.
	(child_info::iscygwin): Ditto.
	* sigproc.cc (child_info::child_info): Minor cleanup of flag setting.
	* spawn.cc (spawn_guts): Only close_all_files when we know the process
	has started successfully.

	* exceptions.cc (init_console_handler): Fix indentation.

2006-03-20  Christopher Faylor  <cgf@timesys.com>

	* dcrt0.cc (dll_crt0_0): Call SetErrorMode earlier.
	* pinfo.cc (_pinfo::dup_proc_pipe): Reset wr_proc_pipe on failure.
	Return previous pipe handle.
	* pinfo.h (_pinfo::dup_proc_pipe): Reflect change to return value.
	* spawn.cc (spawn_guts): Restore previous proc pipe on retry or if
	process exits before synchronization.

2006-03-20  Christopher Faylor  <cgf@timesys.com>

	* child_info.h (child_status): New enum.
	(child_info::flag): Rename from 'straced'.
	(child_info::isstraced): New function.
	(child_info::iscygwin): Ditto.
	(child_info_fork::handle_fork): Reparmize.
	(child_info_fork::handle_failure): Ditto.
	(child_info_spawn::handle_spawn): New function.
	* dcrt0.cc (get_cygwin_startup_info): Use isstraced method.
	(child_info_spawn::handle_spawn): Define new function from code
	previously in dll_crt0_0.
	(dll_crt0_0): Move spawn stuff into handle_spawn.  Only call
	init_console_handler for fork case.
	* sigproc.cc (child_info::child_info): Set flag appropriately.
	(child_info::proc_retry): Treat exit code as "funny" if it's a cygwin
	process.
	* spawn.cc (spawn_guts): Remove commented out flag setting.

2006-03-19  Christopher Faylor  <cgf@timesys.com>

	* pinfo.cc (commune_process): Fix randomly invalid pointer which caused
	fifos to work incorrectly.

2006-03-19  Christopher Faylor  <cgf@timesys.com>

	* dcrt0.cc (dll_crt0_0): Oops.  We need to bother with setting
	init_console_handler in the fork/exec case.

2006-03-19  Christopher Faylor  <cgf@timesys.com>

	* dcrt0.cc (dll_crt0_0): Don't bother with setting init_console_handler
	here since it will be set later when we discover if we have a ctty or
	not.
	* exceptions.cc (init_console_handler): Properly remove NULL handler.

2006-03-18  Christopher Faylor  <cgf@timesys.com>

	* pinfo.h (EXITCODE_OK): Define new constant.
	* sigproc.cc (child_info::sync): Return EXITCODE_OK if entering with
	exit_code == 0.
	(sig_send): Don't complain if sending signals while blocked if the
	sender isn't in the main thread.

2006-03-18  Christopher Faylor  <cgf@timesys.com>

	* child_info.h (CURR_CHILD_INFO_MAGIC): Regenerate.
	(child_info::retry): Move here from fork subclass.
	(child_info::exit_code): New field.
	(child_info::retry_count): Max retry count for process start.
	(child_info::proc_retry): Declare new function.
	(child_info_fork::retry): Move to parent.
	(child_info_fork::fork_retry): Ditto.
	* dcrt0.cc (child_info::fork_retry): Rename and move.
	(child_info_fork::handle_failure): Move.
	(dll_crt0_0): Initialize console handler based on whether we have a
	controlling tty or not.  Avoid nonsensical check for fork where it can
	never occur.
	* environ.cc (set_proc_retry): Rename from set_fork_retry.  Set
	retry_count in child_info.
	(parse_thing): Reflect above change.
	* exceptions.cc (dummy_ctrl_c_handler): Remove unused variable name.
	(ctrl_c_handler): Always return TRUE for the annoying
	CTRL_LOGOFF_EVENT.
	* fhandler_termios.cc (fhandler_termios::tcsetpgrp): Remove call to
	init_console_handler.
	* fhandler_tty.cc (fhandler_tty_slave::open): Just call
	mange_console_count here and let it decide what to do with initializing
	console control handling.
	* fork.cc (fork_retry): Remove definition.
	(frok::parent): Define static errbuf and use in error messages (not
	thread safe yet).  Close pi.hThread as soon as possible.  Protect
	pi.hProcess as soon as possible.  Don't set retry_count.  That happens
	automatically in the constructor now.  Accommodate name change from
	fork_retry to proc_retry.
	* init.cc (dll_entry): Turn off ctrl-c handling early until we know how
	it is supposed to be handled.
	* pinfo.cc (_pinfo::dup_proc_pipe): Remember original proc pipe value
	for failure error message.  Tweak debug message slightly.
	* sigproc.cc (child_info::retry_count): Define.
	(child_info::child_info): Initialize retry count.
	(child_info::sync): Set exit code if process dies before
	synchronization.
	(child_info::proc_retry): Rename from child_info_fork::fork_retry.  Use
	previously derived exit code.  Be more defensive about what is
	classified as an error exit.
	(child_info_fork::handle_failure): Move here from dcrt0.cc.
	* spawn.cc (spawn_guts): Maintain error mode when starting new process
	to avoid annoying pop ups.  Move deimpersonate call within new loop.
	Move envblock freeing to end.  Loop if process dies prematurely with
	bad exit code.
	* syscalls.cc (setpgid): Remove hopefully unneeded call to
	init_console_handler.

2006-03-15  Christopher Faylor  <cgf@timesys.com>

	* cygheap.cc (init_cygheap::manage_console_count): Turn console control
	handler on/off depending on whether we have allocated a console or not.
	* dcrt0.cc (child_info_fork::fork_retry): Add more potential retry
	statuses.
	(dll_crt0_0): Turn on/off console control depending on whether we have
	a controlling tty or not.
	* exceptions.cc (init_console_handler): Change BOOL to bool.
	* fhandler_console.cc (fhandler_console::need_invisible): Cosmetic
	change.
	* winsup.h (init_console_handler): Reflect argument type change.

	* wincap.h (supports_setconsolectrlhandler_null): Remove duplicate
	capability throughout.
	* wincap.cc: Ditto.

2006-03-14  Christopher Faylor  <cgf@timesys.com>

	* child_info.h (child_info_fork::fork_retry): Declare new function.
	* dcrt0.cc (child_info_fork::fork_retry): Define new function.
	* fork.cc (frok::parent): Move retry decision into
	child_info_fork::fork_retry and honor what it tells us to do.
	* sigproc.cc (sig_send): Unhold signals on __SIGEXIT.

2006-03-14  Christopher Faylor  <cgf@timesys.com>

	* fork.cc (frok::parent): Improve error message.

2006-03-14  Christopher Faylor  <cgf@timesys.com>

	* dcrt0.cc (main_environ): Initialize to &__cygwin_environment.
	(dll_crt0_1): Move resourcelocks, thread interface, pinfo_init, and
	uinfo_init...
	(dll_crt0_0): ...to here.
	(_dll_crt0): Call update_envptrs here after setting main_environ.
	* environ.cc (environ_init): Eliminate initted variable.  Don't call
	update_envptrs here.
	* sigproc.cc (wait_sig): Use my_sendsig when calling CreatePipe to
	avoid a dereference.

2006-03-13  Christopher Faylor  <cgf@timesys.com>

	* child_info.h (child_info_fork::handle_failure): Declare new function.
	(child_info_fork::retry): New field.
	* dcrt0.cc (__api_fatal_exit_val): Define.
	(child_info_fork::handle_failure): Define new function.
	(__api_fatal): Exit using __api_fatal_exit_val value.
	* environ.cc (set_fork_retry): Set fork_retry based on CYGWIN
	environment variable.
	(parse_thing): Add "fork_retry" setting.
	* fork.cc (fork_retry): Define.
	(frok::parent): Reorganize to allow retry of failed child creation if
	child signalled that it was ok to do so.
	* heap.cc (heap_init): Signal parent via handle_failure when
	VirtualAlloc fails.
	* pinfo.h (EXITCODE_RETRY): Declare.
	* sigproc.cc (child_info::sync): Properly exit with failure condition
	if called for fork and didn't see subproc_ready.
	* spawn.cc (spawn_guts): Use windows pid as first argument.
	* winsup.h: Remove obsolete NEW_MACRO_VARARGS define.
	(__api_fatal_exit_val): Declare.
	(set_api_fatal_return): Define.
	(in_dllentry): Declare.
	* exceptions.cc (inside_kernel): Remove unneeded in_dllentry
	declaration.

2006-03-13  Christopher Faylor  <cgf@timesys.com>

	* dcrt0.cc (dll_crt0_0): Reorganize so that sigproc_init is called a
	little later.  Add a comment.
	* fork.cc (resume_child): Make void.
	(frok::parent): Only zero pi when necessary.  Explicitly zero si.  Set
	this_errno when child_copy fails.  Accommodate change to resume_child.
	* sigproc.cc (sigalloc): Move global_sigs initialization here.
	(sigproc_init): Move global_sigs.
	(sig_send): Just check for flush signals once.

	* wincap.h: Define supports_setconsolectrlhandler_null throughout.
	* wincap.cc: Ditto.

2006-03-13  Corinna Vinschen  <corinna@vinschen.de>

	* autoload.cc (LoadDLLfuncNt): New define to wrap NT native functions.
	Use for NT native functions throughout.
	* dtable.cc (handle_to_fn): Treat return value of NtQueryObject as
	NTSTATUS value.

2006-03-12  Christopher Faylor  <cgf@timesys.com>

	* cygtls.cc (_cygtls::remove): Reset initialized flag right away if we
	were previously initialized.
	* cygtls.h (_cygtls::initialized): Move nearer to the end to catch
	situation when Windows 98 mysteriously changes parts of _my_tls when
	thread is detaching.
	* gendef (__sigfe_maybe): Simplify slightly.
	* tlsoffsets.h: Regenerate.

2006-03-12  Christopher Faylor  <cgf@timesys.com>

	* cygtls.h (CYGTLS_INITIALIZED): Change to a little more unlikely value.
	(CYGTLSMAGIC): Delete.
	* dcrt0.cc (dll_crt0_0): Call sigproc_init during init startup.
	(_dll_crt0): Don't worry about sync_startup.  Just wait for sigthread here.
	* dll_init.cc (cygwin_detach_dll): Only pick up tls version of retaddr
	if we have a valid tls.
	* fork.cc (frok::child): Remove sigproc_init initialization since it
	happens much earlier now.
	* gendef: Recognize SIGFE_MAYBE.
	(fefunc): Generate calls to _sigfe_maybe, if appropriate.
	(_sigfe_maybe): New function.
	* init.cc (search_for): Always initialize search_for, even on fork.
	(calibration_thread): Delete.
	(calibration_id): Delete.
	(prime_threads): Delete.
	(munge_threadfunc): Remove calibration_thread special case.  Avoid
	calling thread function if we haven't yet hit the "search_for" thread.
	(dll_entry): Remove prime_threads call.  Only call munge_threadfunc
	when hwait_sig is active.  Ditto. for _my_tls.remove ();
	* sigproc.cc (hwait_sig): Make global.
	(sigproc_init): Don't bother with sync_startup.
	(sig_send): Treat flush as a no-op when signals are held.
	(wait_sig): Cause signals to be held after fork.

2006-03-09  Corinna Vinschen  <corinna@vinschen.de>

	* syscalls.cc (rename): Move existance check for oldpath further up
	to the start of the function.  Avoid another case of a name collision
	if oldpath is a shortcut and a file or directory newpath already exists.

2006-03-09  Corinna Vinschen  <corinna@vinschen.de>

	* autoload.cc (NtClose): Define.
	(NtOpenDirectoryObject): Define.
	(NtQueryDirectoryObject): Define.
	* fhandler_proc.cc: Include ctype.h and wchar.h.
	(format_proc_partitions): Revamp loop over existing harddisks by
	scanning the NT native \Device object directory and looking for
	Harddisk entries.
	* ntdll.h: Rearrange system call declarations alphabetically.
	(DIRECTORY_QUERY): Define.
	(struct _DIRECTORY_BASIC_INFORMATION): Define.
	(NtOpenDirectoryObject): Declare.
	(NtQueryDirectoryObject): Declare.

2006-03-08  Christopher Faylor  <cgf@timesys.com>

	* cygtls.h (_cygtls::retaddr): New method.
	* dll_init.cc (cygwin_detach_dll): Use new tls method to find return
	address since this function is now signal guarded.
	(update_envptrs): Remove unneeded braces.
	* syscalls.cc (statvfs): Coerce full_path to avoid a gcc warning.

2006-03-08  Corinna Vinschen  <corinna@vinschen.de>

	* syscalls.cc (statvfs): Simplify path name expression.

2006-03-08  Corinna Vinschen  <corinna@vinschen.de>

	* syscalls.cc: Include winioctl.h.
	(statvfs): Request correct volume size using DeviceIoControl if
	quotas are enforced on the file system.

2006-03-03  Corinna Vinschen  <corinna@vinschen.de>

	* dir.cc (opendir): Fix indentation.
	* fhandler_disk_file.cc (fhandler_disk_file::opendir): Move storing
	fhandler in file descriptor table to some point very late in function
	to avoid double free'ing.  Add comment to explain what happens.
	Add label free_mounts and don't forget to delete __DIR_mounts structure
	if NtOpenFile fails.

2006-03-02  Corinna Vinschen  <corinna@vinschen.de>

	* syscalls.cc (chroot): Disallow chroot into special directories.
	Return EPERM instead.

2006-03-02  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (__DIR_mounts::check_missing_mount): Check
	cygdrive string length for those who have cygdrive mapped to "/".

2006-03-01  Corinna Vinschen  <corinna@vinschen.de>

	* sec_helper.cc (set_cygwin_privileges): Request SE_BACKUP_NAME
	privileges.

2006-03-01  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_proc.cc (fhandler_proc::fstat): Always return fixed link
	count of 1 for /proc directory instead of incorrect PROC_LINK_COUNT.

2006-03-01  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler.h (enum dirent_states): Remove dirent_saw_cygdrive,
	dirent_saw_dev and dirent_saw_proc.
	(fhandler_cygdrive::open): Declare.
	(fhandler_cygdrive::close): Declare.
	* fhandler_disk_file.cc (class __DIR_mounts): Move to beginning of file.
	(__DIR_mounts::check_mount): New parameter to indicate if inode number
	is needed in calling function or not. Add /proc and /cygdrive handling.
	(__DIR_mounts::check_missing_mount): Ditto.
	(path_conv::ndisk_links): Use __DIR_mounts class to create correct
	hardlink count for directories with mount points in them.
	(fhandler_disk_file::readdir_helper): Remove /dev, /proc and /cygdrive
	handling.
	(fhandler_cygdrive::open): New method.
	(fhandler_cygdrive::close): New method.
	(fhandler_cygdrive::fstat): Always return fixed inode number 2 and
	fixed link count of 1. Drop call to set_drives.
	(fhandler_cygdrive::opendir): Drop call to get_namehash.
	(fhandler_cygdrive::readdir): Handle "." entry to return fixed inode
	number 2.

2006-03-01  Christopher Faylor  <cgf@timesys.com>

	* cygwin.din: Fix some erroneous SIGFE/NOSIGFE settings.

2006-03-01  Christopher Faylor  <cgf@timesys.com>

	* cygthread.cc (cygthread::callfunc): Revert below change.  Make ev a
	manual reset event again.  so that it will be reset by WaitFor*Object
	as appropriate.
	(cygthread::stub): Ditto.
	(cygthread::terminate_thread): Reset ev if it was found to have been
	set.

2006-03-01  Christopher Faylor  <cgf@timesys.com>

	* analyze_sigfe: New script.
	* dllfixdbg: Add copyright.
	* gendef: Ditto.
	* gendevices: Ditto.
	* gentls_offsets: Ditto.

2006-03-01  Christopher Faylor  <cgf@timesys.com>

	* cygthread.cc (cygthread::callfunc): Create ev as an auto-reset event
	so that it will be reset by WaitFor*Object as appropriate.
	(cygthread::stub): Ditto.
	(cygthread::terminate_thread): Remove forced setting of thread
	termination.

2006-03-01  Corinna Vinschen  <corinna@vinschen.de>

	* include/sys/dirent.h (struct __DIR): Rename __d_unused to
	__d_internal.
	* fhandler_disk_file.cc (struct __DIR_cache): Remove useless "typedef".
	(d_dirname): Remove useless "struct".
	(d_cachepos): Ditto.
	(d_cache): Ditto.
	(class __DIR_mounts): New class, implementing mount point tracking
	for readdir.
	(d_mounts): New macro for easy access to __DIR_mounts structure.
	(fhandler_disk_file::opendir): Allocate __DIR_mounts structure and
	let __d_internal element of dir point to it.
	(fhandler_disk_file::readdir_helper): Add mount points in the current
	directory, which don't have a real directory backing them.
	Don't generate an inode number for /dev.  Add comment, why.
	(fhandler_disk_file::readdir): Move filling fname to an earlier point.
	Check if current entry is a mount point and evaluate correct inode
	number for it.
	(fhandler_disk_file::readdir_9x): Ditto.
	(fhandler_disk_file::rewinddir): Set all mount points in this directory
	to "not found" so that they are listed again after calling rewinddir().
	(fhandler_disk_file::closedir): Deallocate __DIR_mounts structure.
	* path.cc (mount_info::get_mounts_here): New method to evaluate a list
	of mount points in a given parent directory.
	* shared_info.h (class mount_info): Declare get_mounts_here.

2006-02-28  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (fhandler_disk_file::opendir): Use iscygdrive
	instead of isspecial.
	* path.h (path_conv::iscygdrive): New method.

2006-02-28  Christopher Faylor  <cgf@timesys.com>

	* exceptions.cc (_cygtls::interrupt_now): Remove "inside cygwin" check
	since some cygwin functions are meant to be interrupted.

2006-02-28  Corinna Vinschen  <corinna@vinschen.de>

	* cygwin.din: Export __isinff, __isinfd, __isnanf, __isnand.
	* include/cygwin/version.h: Bump API minor number to 155.

2006-02-28  Corinna Vinschen  <corinna@vinschen.de>

	* dir.cc (readdir_worker): Use slash as path separator when evaluating
	namehash for paths below /proc.
	* fhandler_netdrive.cc (fhandler_netdrive::readdir): Use expensive
	inode number evaluation on share names.

2006-02-27  Christopher Faylor  <cgf@timesys.com>

	* fhandler_disk_file.cc (fhandler_disk_file::opendir): Only set
	d_cachepos under NT or suffer memory corruption.
	(fhandler_disk_file::readdir_helper): Avoid else with a return.  Just
	calculate extension location once when doing symlink checks.
	(fhandler_disk_file::readdir): Make debug output more useful.
	(fhandler_disk_file::readdir_9x): Ditto.  Eliminate redundant variable.

2006-02-27  Christopher Faylor  <cgf@timesys.com>

	* include/sys/termios.h (cfsetispeed): Just define as a function rather
	than resorting to a macro.
	(cfsetospeed): Ditto.

2006-02-27  Christopher Faylor  <cgf@timesys.com>

	* sigproc.cc: Fix a comment.

2006-02-27  Christopher Faylor  <cgf@timesys.com>

	* cygthread.cc (cygthread::release): Add a comment.

2006-02-27  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_netdrive.cc (fhandler_netdrive::fstat): Create unambiguous
	inode number.
	(fhandler_netdrive::readdir): Ditto.

2006-02-24  Christopher Faylor  <cgf@timesys.com>

	* sigproc.cc (sigheld): Define new variable.
	(sig_dispatch_pending): Don't check sigq since that's racy.
	(sig_send): Set sigheld flag if __SIGHOLD is specified, reset it if
	__SIGNOHOLD is specified.  Ignore flush signals if we're holding
	signals.

2006-02-23  Christopher Faylor  <cgf@timesys.com>

	* cygwin.din (_exit): Use signal front end.
	(exit): Ditto.

2006-02-23  Christopher Faylor  <cgf@timesys.com>

	* winsup.h (cygwin_hmodule): Declare.
	* exceptions.cc (inside_kernel): Reverse return values to reflect
	function name.  Return true if we're in cygwin1.dll or if we're
	executing in dll_entry.
	(_cygtls::interrupt_now): Reflect reversal of inside_kernel return
	value.
	* hookapi.cc (cygwin_hmodule): Remove declaration.
	* init.cc (dll_entry): Use in_dllentry global to record that we are
	executing in dllentry.

2006-02-22  Corinna Vinschen  <corinna@vinschen.de>

	* exceptions.cc (_cygtls::interrupt_now): Reorder conditional
	to call inside_kernel only if this isn't locked.

2006-02-22  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler.cc (fhandler_base::open): Add FILE_READ_ATTRIBUTES to
	access flags in case of query_read_control case, add FILE_READ_DATA
	in case of query_stat_control.

2006-02-20  Christopher Faylor  <cgf@timesys.com>

	* spawn.cc (av::fixup): Check for .bat and friends specifically now
	since these extensions are no longer automatically detected.

2006-02-19  Christopher Faylor  <cgf@timesys.com>

	* exceptions.cc (stackdump): Avoid dumping more than once.

2006-02-19  Christopher Faylor  <cgf@timesys.com>

	* fhandler_disk_file.cc (fhandler_disk_file::opendir): Use NtOpenFile
	to open the directory.
	(fhandler_disk_file::readdir): Use NT_SUCCESS to determine if status
	represents success.

2006-02-19  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (fhandler_disk_file::opendir): Drop generating
	path_conv for root.

2006-02-18  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (FS_IS_SAMBA): Move out of
	path_conv::hasgood_inode.
	(path_conv::is_samba): New method.
	(fhandler_base::fstat_by_handle): Don't even try to use
	FileIdBothDirectoryInformation on Samba.
	* path.h (class path_conv): Declare is_samba method.

2006-02-17  Christopher Faylor  <cgf@timesys.com>

	* path.cc (conv_path_list): Eat empty paths when converting to POSIX.
	(cygwin_conv_to_win32_path): Deal with Cygwin's necessity of adding a
	'/' to the end of a path ending in '.'.

2006-02-16  Corinna Vinschen  <corinna@vinschen.de>

	* cygwin.din: Export sigignore and sigset.
	* exceptions.cc (sigset): New function.
	(sigignore): New function.
	* include/cygwin/signal.h (SIG_HOLD): Define.
	(sigignore): Declare.
	(sigset): Declare.
	* include/cygwin/version.h: Bump API minor number to 154.

2006-02-13  Igor Peshansky  <pechtcha@cs.nyu.edu>

	* include/mntent.h: Add missing #include.

2006-02-13  Igor Peshansky  <pechtcha@cs.nyu.edu>

	* gentls_offsets: Fix typo in error message.

2006-02-10  Christopher Faylor  <cgf@timesys.com>

	* fhandler_process.cc (format_process_stat): Use cygwin-derived start
	time even on NT since it is the logical start time of the "process".
	* pinfo.cc (set_myself): Don't set start time when it should have
	already been set previously.

2006-02-10  Brian Ford  <Brian.Ford@FlightSafety.com>

	* times.cc (clock_getres): Use correct conversion from milliseconds to
	seconds/nanoseconds.
	(clock_setres): Use correct conversion to nanoseconds.

2006-02-10  Christopher Faylor  <cgf@timesys.com>

	* external.cc (sync_winenv): Rename from "setup_winenv".  Use same
	mechanism as spawn to determine environment variables which should be
	converted back to windows form.
	(cygwin_internal): Reflect setup_winenv -> sync_winenv name change.
	* include/sys/cygwin.h: Ditto.

2006-02-09  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (fhandler_disk_file::opendir): Only set
	the dirent_get_d_ino flag on filesystems having useful File IDs.
	Add comment explaining why.

2006-02-07  Corinna Vinschen  <corinna@vinschen.de>

	* dtable.cc (handle_to_fn): Accommodate new argument order in call to
	sys_wcstombs.
	* fhandler_disk_file.cc (fhandler_disk_file::readdir): Call sys_wcstombs
	instead of just wcstombs to accommodate OEM codepages.
	* miscfuncs.cc (sys_wcstombs): Split len argument in source and target
	length.  Always 0-terminate result in target string.
	* security.cc (lsa2wchar): Remove unused function.
	(lsa2str): Ditto.
	(get_lsa_srv_inf): Ditto.
	(get_logon_server): Accommodate new argument order in call to
	sys_wcstombs.
	(get_user_groups): Ditto.
	(get_user_local_groups): Ditto.
	(get_priv_list): Call sys_wcstombs directly instead of lsa2str.
	* uinfo.cc (cygheap_user::ontherange): Accommodate new argument order
	in call to sys_wcstombs.
	* winsup.h (sys_wcstombs): Change prototype to match new argument order.

2006-02-07  Corinna Vinschen  <corinna@vinschen.de>

	* init.cc (respawn_wow64_process): Exit with the exit code returned
	by the respawned process.

2006-02-06  Christopher Faylor  <cgf@timesys.com>

	Always zero all elements of siginfo_t throughout.
	* cygtls.h (_cygtls::thread_context): Declare new field.
	(_cygtls::thread_id): Ditto.
	(_cygtls::signal_exit): Move into this class.
	(_cygtls::copy_context): Declare new function.
	(_cygtls::signal_debugger): Ditto.
	* cygtls.cc (_cygtls::init_thread): Fill out thread id field.
	* exceptions.cc (exception): Change message when exception info is
	unknown.  Copy context to thread local storage.
	(_cygtls::handle_exceptions): Avoid double test for fault_guarded.
	Reflect move of signal_exit to _cygtls class.
	(sigpacket::process): Copy context to thread local storage.
	(_cygtls::signal_exit): Move to _cygtls class.  Call signal_debugger to
	notify debugger of exiting signal (WIP).  Call stackdump here (WIP).
	(_cygtls::copy_context): Define new function.
	(_cygtls::signal_debugger): Ditto.
	* tlsoffsets.h: Regenerate.
	* include/cygwin.h (_fpstate): New internal structure.
	(ucontext): Declare new structure (WIP).
	(__COPY_CONTEXT_SIZE): New define.

	* exceptions.cc (_cygtls::interrupt_setup): Clear "threadkill" field
	when there is no sigwaiting thread.
	(setup_handler): Move event handling into interrupt_setup.

2006-02-06  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_socket.cc (fhandler_socket::connect): Fix formatting.
	(fhandler_socket::wait): Handle SA_RESTART when signal arrives.

2006-02-06  Corinna Vinschen  <corinna@vinschen.de>

	* include/cygwin/socket.h (CMSG_FIRSTHDR): Avoid compiler warning.

2006-02-05  Corinna Vinschen  <corinna@vinschen.de>

	* include/features.h: Add comment to explain what's going to happen
	here at one point.
	* include/sys/stdio.h: Guard getline and getdelim prototypes with
	_GNU_SOURCE to avoid collision with old-style declarations.

2006-02-05  Corinna Vinschen  <corinna@vinschen.de>

	* environ.cc (struct parse_thing): Add transparent_exe option.
	* fhandler_disk_file.cc (fhandler_disk_file::link): Accommodate
	transparent_exe option.  Add .exe suffix for links to executable files,
	if transparent_exe is set.
	* fhandler_process.cc (fhandler_process::fill_filebuf): Remove .exe
	suffix if transparent_exe option is set.
	* path.cc (symlink_worker): Accommodate transparent_exe option.
	(realpath): Don't tack on .exe suffix if transparent_exe is set.
	* syscalls.cc (transparent_exe): New global variable.
	(unlink): Accommodate transparent_exe option.
	(open): Ditto.
	(link): Ditto.
	(rename): Ditto. Maybe add .exe suffix when renaming executable files.
	(pathconf): Accommodate transparent_exe option.
	* winsup.h: Declare transparent_exe.

2006-02-05  Christopher Faylor  <cgf@timesys.com>
	    Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (fhandler_disk_file::readdir_9x): Remove
	useless code.

2006-02-05  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (fhandler_disk_file::rewinddir): Remove label
	"out".  Move test for NULL __handle ...
	(fhandler_disk_file::rewinddir_9x): ... here.

2006-02-05  Corinna Vinschen  <corinna@vinschen.de>

	* dir.cc (rewinddir): Keep dirent_get_d_ino and dirent_set_d_ino flags.

2006-02-05  Christopher Faylor  <cgf@timesys.com>

	* fhandler_disk_file.cc (fhandler_disk_file::readdir): Don't close dir
	handle when we hit EOF since rewwindir may reactivate it.
	(fhandler_disk_file::readdir_9x): Eliminate superfluous temporary
	variable.
	(fhandler_disk_file::closedir): Return EBADF when trying to close
	unopened DIR.  Reorganize slightly.  Return actual derived error value
	rather than always returning 0.

2006-02-04  Christopher Faylor  <cgf@timesys.com>

	* dir.cc (rmdir): Reorganize check for trailing dot to return correct
	error when directory does not exist.

2006-02-03  Christopher Faylor  <cgf@timesys.com>

	* dir.cc (mkdir): Reorganize check for trailing dot to return correct
	error when directory exists.
	* fhandler_disk_file.cc (fhandler_disk_file::mkdir): Remove special
	test for path ending in '.'.

2006-02-03  Corinna Vinschen  <corinna@vinschen.de>

	* path.cc (suffix_scan::lnk_match): Return true beginning with
	SCAN_APPENDLNK.
	(suffix_scan::next): Rearrange code to make .lnk append order slightly
	more deterministic.
	* spawn.cc (exe_suffixes): Try no suffix before .exe suffix to align
	evaluation with stat_suffixes.
	(dll_suffixes): Ditto.

2006-02-02  Christopher Faylor  <cgf@timesys.com>

	* cygwin/version.h: Mention CW_SETUP_WINENV in comment for API minor
	153.

2006-02-02  Corinna Vinschen  <corinna@vinschen.de>

	* cygwin.din (updwtmpx): Export.
	* syscalls.cc (updwtmpx): New function.
	* include/utmpx.h (updwtmpx): Declare.
	* include/cygwin/version.h: Bump API minor number to 153.

2006-02-02  Christopher Faylor  <cgf@timesys.com>

	* external.cc (setup_winenv): New function.
	(cygwin_internal): Implement CW_SETUP_WINENV.
	* sys/cygwin.h (cygwin_getinfo_types): Define CW_SETUP_WINENV.

2006-02-02  Corinna Vinschen  <corinna@vinschen.de>

	* security.cc (is_group_member): Fix comment.

2006-02-02  Corinna Vinschen  <corinna@vinschen.de>

	* security.cc (is_group_member): Use local group info type 1.  Test
	group for being a global group or a well-known SID before adding it
	to the group list.  Add comment.

2006-02-01  Corinna Vinschen  <corinna@vinschen.de>

	* autoload.cc  (GetTcpTable): Define.
	* fhandler_socket.cc (address_in_use): New function to check if
	sockaddr_in address is already in use.
	(fhandler_socket::bind): Check if address is alreay in use in case of
	SO_REUSEADDR, to circumvent WinSock non-standard behaviour.

2006-02-01  Corinna Vinschen  <corinna@vinschen.de>

	* spawn.cc (dll_suffixes): Add .exe and "no suffix" to the list.

2006-01-31  Corinna Vinschen  <corinna@vinschen.de>

	* dlfcn.cc (check_path_access): Call find_exec with FE_DLL option.
	* path.h (enum fe_types): Add FE_DLL value.
	* spawn.cc (std_suffixes): Remove.
	(exe_suffixes): New suffix_info for executing files.
	(dll_suffixes): New suffix_info for searching shared libraries.
	(perhaps_suffix): Add opt argument.  Use dll_suffixes if FE_DLL
	option is given, exe_suffixes otherwise.
	(find_exec): Propagate opt argument to perhaps_suffix.  Drop suffix
	check when testing execute permission.
	(spawn_guts): Call perhaps_suffix with FE_NADA opt argument.

2006-01-31  Christopher Faylor  <cgf@timesys.com>

	* spawn.cc (av::fixup): Remove unused argument.
	(spawn_guts): Remove capitalization in debugging.

2006-01-31  Corinna Vinschen  <corinna@vinschen.de>

	* spawn.cc (find_exec): Only return files with execute permission set
	if ntsec is on.  Don't check execute permission of Windows batch files.
	(av::fixup): Handle empty files gracefully.  Drop execute permission
	test here.
	* path.cc (suffix_scan::next): Don't skip any suffix on first run.

2006-01-31  Corinna Vinschen  <corinna@vinschen.de>

	* path.cc (cwdstuff::set): Don't set win32 error, only POSIX errno.

2006-01-31  Corinna Vinschen  <corinna@vinschen.de>

	* path.cc (cwdstuff::set): When SetCurrentDirectory returns
	ERROR_INVALID_FUNCTION, bend it over to ERROR_FILE_NOT_FOUND.  Add
	comment to explain why.

2006-01-31  Corinna Vinschen  <corinna@vinschen.de>

	* dir.cc (readdir_worker): Add comment about writing old 32 bit d_ino.
	* include/cygwin/version.h: Bump API minor number to 152.
	(CYGWIN_VERSION_CHECK_FOR_NEEDS_D_INO): Remove.

2006-01-30  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (fhandler_disk_file::rewinddir): Simplify
	conditional.

2006-01-30  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (d_cachepos): Rename from d_pos to distinct
	clearly from __d_position.  Change throughout.
	(fhandler_disk_file::rewinddir): Reset readdir cache on NT.

2006-01-29  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (readdir_get_ino): Don't follow symlinks.

2006-01-29  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler.h (class fhandler_socket): Add saw_reuseaddr status flag.
	* fhandler_socket.cc (fhandler_socket::bind): Set socket to
	SO_EXCLUSIVEADDRUSE if application didn't explicitely set SO_REUSEADDR
	socket option, on systems supporting SO_EXCLUSIVEADDRUSE.
	* net.cc (cygwin_setsockopt): Set fhandler's saw_reuseaddr status flag
	if SO_REUSEADDR socket option has been successsfully set.
	* wincap.h (wincaps::has_exclusiveaddruse): New element.
	* wincap.cc: Implement above element throughout.

2006-01-28  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (fhandler_disk_file::mkdir): In case or error,
	check for existance explicitely and set errno to EEXIST.

2006-01-28  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (DIR_NUM_ENTRIES): New define determining
	minimum number of dir entries which fit into the readdir cache.
	(DIR_BUF_SIZE): Define globally as size of readdir cache.
	(struct __DIR_cache): New structure used for readdir caching on NT.
	(d_dirname): Accessor for struct __DIR_cache, use throughout.
	(d_pos): Ditto.
	(d_cache): Ditto.
	(fhandler_disk_file::opendir): Allocate __d_dirname to contain readdir
	cache on NT.
	(fhandler_disk_file::readdir): Use buf as pointer into readdir cache.
	Implement readdir caching.

2006-01-28  Corinna Vinschen  <corinna@vinschen.de>

	* include/sys/dirent.h (struct dirent): Revert misguided attempt to
	rename __d_unused1 to __d_fd.

2006-01-27  Corinna Vinschen  <corinna@vinschen.de>

	* autoload.cc (NtQueryDirectoryFile): Define.
	* dir.cc (__opendir_with_d_ino): Just call opendir.
	(opendir): Remove CYGWIN_VERSION_CHECK_FOR_NEEDS_D_INO handling.
	(readdir_worker): Only try generating d_ino if it's 0.
	Utilize namehash of directories fhandler.  Call readdir_get_ino to
	generate d_ino for "..".
	(seekdir64): Keep dirent_set_d_ino flag.
	* fhandler.h (enum dirent_states): Add dirent_get_d_ino.
	(class fhandler_disk_file): Declare new private methods readdir_helper
	and readdir_9x.
	* fhandler_disk_file.cc (path_conv::hasgood_inode): New method to
	evaluate if a filesystem has reliable inode numbers.
	(fhandler_base::fstat_by_handle): Accommodate structure member name
	change from IndexNumber to FileId.
	(fhandler_base::fstat_helper): Call hasgood_inode here.
	(fhandler_disk_file::opendir): Call fhaccess only for real files.
	Don't append '*' to __d_dirname here, move to readdir_9x.  On NT,
	open directory handle here.  Set dirent_get_d_ino and dirent_set_d_ino
	flags according to wincap and filesystem.
	(fhandler_disk_file::readdir_helper): New method to implement readdir
	postprocessing only once.
	(readdir_get_ino_by_handle): New static function.
	(readdir_get_ino): New function to centralize inode number evaluation
	in case inode number hasn't been returned by NtQueryDirectoryFile.
	(fhandler_disk_file::readdir): Move old functionality to readdir_9x.
	Call readdir_9x when on 9x/Me.  Implement NT specific readdir here.
	(fhandler_disk_file::readdir_9x): Move 9x specific readdir here.
	(fhandler_disk_file::seekdir): Accommodate new NT readdir method.
	(fhandler_disk_file::closedir): Ditto.
	(fhandler_cygdrive::fstat): Set d_ino to namehash. Add comment.
	(fhandler_cygdrive::opendir): Call get_namehash to prepare later
	correct evaluation of d_ino.
	(fhandler_cygdrive::readdir): Replace recursion with loop. Evaluate
	drive's d_ino by calling readdir_get_ino.
	* fhandler_proc.cc (fhandler_proc::readdir): Set dirent_saw_dot and
	dirent_saw_dot_dot to avoid seeing . and .. entries twice.
	* fhandler_process.cc (fhandler_process::readdir): Ditto.
	* fhandler_registry.cc (fhandler_registry::readdir): Ditto.
	* ntdll.h (STATUS_INVALID_PARAMETER): New define.
	(STATUS_INVALID_LEVEL): New define.
	(struct _FILE_INTERNAL_INFORMATION): Rename member IndexNumber to
	FileId (as in Nebbitt).
	* path.h (path_conv::hasgood_inode): Now implemented in
	fhandler_disk_file.cc.
	* wincap.h (wincaps::has_fileid_dirinfo): New element.
	* wincap.cc: Implement above element throughout.
	* winsup.h (readdir_get_ino): Add declaration.
	* include/sys/dirent.h (struct dirent): Slightly rename structure
	members to accommodate changes.
	Remove __USE_EXPENSIVE_CYGWIN_D_INO handling and declaration of
	__opendir_with_d_ino.

2006-01-27  Christopher Faylor  <cgf@timesys.com>

	* spawn.cc (spawn_guts): Fix potential handle leak when failing exec.

2006-01-27  Christopher Faylor  <cgf@timesys.com>

	* exceptions.cc (inside_kernel): Fix to return true if we can't get the
	name of the DLL for the given memory block since we are not in kernel
	code.

2006-01-26  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler.cc (fhandler_base::open): Fix bug in argument order to
	InitializeObjectAttributes call.

2006-01-25  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (fhandler_disk_file::readdir): Fix test for
	dirent_isroot to use the correct boolean operator.

2006-01-25  Christopher Faylor  <cgf@timesys.com>

	* ntdll.h: (temporarily?) Add more functions for querying directory.

2006-01-24  Christopher Faylor  <cgf@timesys.com>

	* dir.cc (readdir_worker): Turn off expensive inode calculation.

2006-01-24  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_process.cc (fhandler_process::fill_filebuf): Disable
	stripping the .exe suffix from the link target in PROCESS_EXE and
	PROCESS_EXENAME case.
	* path.cc (realpath): Tack on .exe suffix if necessary.

2006-01-24  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_disk_file.cc (fhandler_base::fstat_helper): Try harder
	to determine remote file systems with reliable inode numbers.  Add
	longish comment.

2006-01-23  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_socket.cc (fhandler_socket::fixup_after_fork): Reset
	inheritance for duplicated socket.

2006-01-20  Christopher Faylor  <cgf@timesys.com>

	* include/cygwin/version.h: Bump API minor number to 151.
	* dir.cc (__opendir_with_d_ino): New function.
	(opendir): Set flag if we should be calculating inodes.
	(readdir_worker): Calculate d_ino by calling stat if the user has asked
	for it.
	(seekdir64): Maintain all persistent flag settings.
	* fhandler.h (dirent_states): Add dirent_set_d_ino.
	* fhandler_disk_file.cc (fhandler_disk_file::opendir): Reflect changes
	to dirent structure.
	* fhandler_virtual.cc (fhandler_virtual::opendir): Ditto.
	* include/sys/dirent.h (struct dirent): Coalesce two similar
	structures.  Remove all shreds of the apparently highly confusing
	references to inodes.  Add support for calculating a real inode if
	__USE_EXPENSIVE_CYGWIN_D_INO is defined.

2006-01-20  Christopher Faylor  <cgf@timesys.com>

	* include/sys/dirent.h: Add comments for people who are REALLY confused
	about whether they should be using something called __invalid_d_ino or
	not.

2006-01-20  Corinna Vinschen  <corinna@vinschen.de>

	* fhandler_socket.cc (fhandler_socket::prepare): Fix debug output.
	(fhandler_socket::release): Add debug output for WSAEventSelect failure.
	(fhandler_socket::ioctl): Always cancel WSAEventSelect before switching
	to blocking mode.  Only set nonblocking flag if ioctlsocket call
	succeeded.  Only print new socket state if ioctlsocket call succeeded.

2006-01-19  Christopher Faylor  <cgf@timesys.com>

	* fhandler_disk_file.cc (fhandler_disk_file::opendir): Check posix path
	for root rather than windows path.

2006-01-19  Christopher Faylor  <cgf@timesys.com>

	* dir.cc (readdir_worker): Fill in invalid fields with -1.  Accommodate
	name change from __ino32 to __invalid_ino32.
	* include/sys/dirent.h (__invalid_ino32): Rename from __ino32.  Don't
	define unused d_type macros.

2006-01-18  Christopher Faylor  <cgf@timesys.com>

	* heap.cc (heap_init): Remove Sleep.

2006-01-18  Corinna Vinschen  <corinna@vinschen.de>

	* net.cc (rresvport): Remove extern declaration.

2006-01-18  Corinna Vinschen  <corinna@vinschen.de>

	* autoload.cc (rresvport): Remove.
	* net.cc (last_used_rrecvport): New global shared variable.
	(cygwin_rresvport): Implement rresvport without using rresvport from
	wsock32.

2006-01-18  Corinna Vinschen  <corinna@vinschen.de>

	* include/cygwin/socket.h (struct sockaddr_storage): Fix typo in
	ss_family member name.

2006-01-16  Christopher Faylor  <cgf@timesys.com>

	* include/cygwin/version.h: Bump DLL minor version number to 20.

2006-01-13  Corinna Vinschen  <corinna@vinschen.de>

	* uname.cc (uname): Concatenate a "-WOW64" to utsname's sysname
	member to see when running under WOW64.

2006-01-13  Corinna Vinschen  <corinna@vinschen.de>

	* net.cc (cygwin_setsockopt): Ignore errors when setting IP_TOS on
	Windows 2000 and above. Clarify the comment about IP_TOS and move
	to the place where the magic happens.
	(get_ifconf): Remove unused code.
	* wincap.h (wincaps::has_disabled_user_tos_setting): New element.
	* wincap.cc: Implement above element throughout.

2006-01-12  Christopher Faylor  <cgf@timesys.com>

	* fhandler_console.cc (set_console_state_for_spawn): Fix to recognize
	ttys >= 0.

2006-01-12  Christopher Faylor  <cgf@timesys.com>

	* fhandler.h (set_console_state_for_spawn): Whackamole the argument
	back to a bool.
	* spawn.cc (spawn_guts): Ditto, i.e., once again call
	set_console_state_for_spawn with an indication of whether we're about
	to start a cygwin process.
	* fhandler_console.cc (set_console_state_for_spawn): Don't set the
	console state if we know we're starting a cygwin process or if we're
	using a "real" tty.

2006-01-10  Corinna Vinschen  <corinna@vinschen.de>

	* dcrt0.cc (dll_crt0_0): Remove call to wincap.init.
	* init.cc (dll_entry): Rename is_wow64_proc to wow64_test_stack_marker.
	Call wincap.init here before doing anything else.  Use wincap.is_wow64
	to determine if we're running in a WOW64 emulator.
	* mmap.cc (MapViewNT): Don't use AT_ROUND_TO_PAGE in WOW64, it's
	apparently not supported.
	(mmap64): Don't create mappings beyond EOF, which would need to use
	AT_ROUND_TO_PAGE, on WOW64.
	* wincap.cc (wincap): Throw into the .cygwin_dll_common section.
	(wincapc::init): Determine if running in WOW64 and set wow_64 flag.
	* wincap.h (class wincapc): Add wow64 member.
	(wincapc::is_wow64): New method.

2006-01-10  Christopher Faylor  <cgf@timesys.com>

	* fhandler_proc.cc (format_proc_cpuinfo): Avoid leading whitespace in
	model name.

2006-01-09  Christopher Faylor  <cgf@timesys.com>

	* spawn.cc (spawn_guts): Reorganize slightly so that 16 bit check is
	done prior to check for command.com/cmd.com.  Don't bother setting
	CREATE_SUSPENDED flag for a MS-DOS process since it doesn't work
	anyway.  Avoid calling remember() when the child process has already
	exited.
	(av::fixup): Explicitly set cygexec flag to false on a 16 bit process.

2006-01-09  Corinna Vinschen  <corinna@vinschen.de>

	* include/getopt.h (getopt_long_only): Declare.

2006-01-09  Eric Blake  <ebb9@byu.net>

	* cygwin.din: Export getsubopt.
	* include/cygwin/version.h: Bump API minor version.

2006-01-08  Christopher Faylor  <cgf@timesys.com>

	* fhandler_tty.cc (fhandler_tty_slave::dup): Don't assign a controlling
	terminal to a process when duped.  Linux doesn't do this, so we won't
	either.

2006-01-08  Christopher Faylor  <cgf@timesys.com>

	* environ.cc (spenvs[]): windir -> WINDIR.

2006-01-07  Christopher Faylor  <cgf@timesys.com>

	* fhandler_console.cc (fhandler_console::need_invisible): Remove
	duplicate test.

2006-01-07  Christopher Faylor  <cgf@timesys.com>

	* fhandler.h (set_console_state_for_spawn): Eliminate argument from
	declaration.
	* fhandler.cc (set_console_state_for_spawn): Eliminate argument from
	definition.  Always check for invisible console.
	(fhandler_console::need_invisible): Don't do anything if the windows
	station is already not visible.
	* spawn.cc (spawn_guts): Accommodate change of argument to
	set_console_state_for_spawn.

2006-01-05  Christopher Faylor  <cgf@timesys.com>

	* sigproc.cc (no_signals_available): Use existence of signal thread
	handle to figure out if we can actually send signals rather than
	relying on my_sendsig.
	(hwait_sig): Make static.
	(sigproc_init): Don't set my_sendsig to anything special.  Use new
	global static hwait_sig.
	(wait_sig): Set hwait_sig to NULL when we are exiting.

2006-01-05  Christopher Faylor  <cgf@timesys.com>

	* include/getopt.h: Accommodate recent unfortunate newlib changes.

2006-01-05  Christopher Faylor  <cgf@timesys.com>

	* cygtls.cc (_cygtls::remove): Don't output debugging info if this
	isn't a cygwin thread.
	* sigproc.cc (sigproc_init): Move clearing of sync_startup here to
	lessen the likelihood of trying to deal with non-cygwin threads in
	dll_entry.

	* fhandler_console: Fix set_console_state_for_spawn comment.

2006-01-05  Igor Peshansky  <pechtcha@cs.nyu.edu>

	* spawn.cc (spawn_guts): Invert the argument to
	set_console_state_for_spawn.

2006-01-04  Christopher Faylor  <cgf@timesys.com>

	* fhandler_console.cc (fhandler_console::need_invisible): Only try to
	open "CygwinInvisible" windows station if opening of default station
	fails.  Use CloseWindowStation to close window station handle.

2006-01-04  Christopher Faylor  <cgf@timesys.com>

	* fhandler_console.cc (fhandler_console::need_invisible): Open up the
	security of the newly created windows station.

2006-01-04  Eric Blake  <ebb9@byu.net>

	* path.cc (dot_special_chars): Add ", <, >, and |.

2006-01-03  Christopher Faylor  <cgf@timesys.com>

	* fhandler_console.cc (beep): Use MB_OK which is documented as using
	the default bell rather than -1 which seems to behave differently on
	different versions of Windows.

2006-01-03  Christopher Faylor  <cgf@timesys.com>

	* fhandler_process.cc (fhandler_process::readdir): Add missing argument
	to syscall_printf.

	* fhandler_console.cc (fhandler_console::need_invisible): Use made-up
	name for windows station rather than asking Windows to create one for
	us.

	* spawn.cc (spawn_guts): Don't mess with console if we're detaching.

2006-01-03  Christopher Faylor  <cgf@timesys.com>

	* dir.cc (readdir_worker): Minor code cleanup.

	* fhandler_console.cc (beep): Use a more Windows-generic wav file if
	the beep is missing.  Use a more foolproof way to find out whether we
	should be recreating the missing key.

	* registry.h (reg_key::_disposition): New field.
	(reg_key::created): New function.
	* registry.cc (reg_key::reg_key): Set _disposition to zero by default.
	(reg_key::build_key): Fill in _disposition field.

2006-01-03  Eric Blake  <ebb9@byu.net>

	* dir.cc (readdir_worker): Ensure that saw_dot* flags are updated when
	not handling inodes.

2006-01-02  Christopher Faylor  <cgf@timesys.com>

	* fhandler_console.cc (beep): New function.  Restores missing "Default
	Beep", if necessary.
	(fhandler_console::write_normal): Use beep().

2006-01-02  Christopher Faylor  <cgf@timesys.com>

	* dcrt0.cc (_dll_crt0): Remove more leftover debugging stuff.
	(cygwin_dll_init): Remove unneeded initializations.  Call _dll_crt0
	rather than dll_crt0_1.

2006-01-02  Corinna Vinschen  <corinna@vinschen.de>

	* syslog.cc: Include sys/un.h instead of sys/socket.h.
	(syslogd_inited): Convert to enum type noting the exact result of
	trying to connect to syslog daemon.  Use this way throughout.
	(connect_syslogd): New static function taking over the task to
	connect to syslog socket.  Use correct struct sockaddr_un instead of
	struct sockaddr.
	(try_connect_syslogd): Call connect_syslogd.  If write fails on
	connection oriented socket, try to reconnect to syslog socket and
	try to write again.

2006-01-01  Christopher Faylor  <cgf@timesys.com>

	* pinfo.cc (pinfo::exit): Swap signal and normal exit value when not
	started from a cygwin process - just like the good-old-days of B20.

2006-01-01  Christopher Faylor  <cgf@timesys.com>

	* strace.cc (strace::write_childpid):  Remove debugging output.

2006-01-01  Christopher Faylor  <cgf@timesys.com>

	* cygtls.cc (_cygtls::remove): Remove left over debugging cruft which
	caused this function to always return prematurely.

2006-01-01  Christopher Faylor  <cgf@timesys.com>

	* exceptions.cc (sigpacket::process): Pass actual reference to signal's
	sigaction structure to setup_handler.

2006-01-01  Christopher Faylor  <cgf@timesys.com>

	* exceptions.cc (_cygtls::interrupt_setup): Implement SA_RESETHAND.
	* include/cygwin/signal.h: Define SA_ONESHOT and SA_NOMASK.

	* dcrt0.cc (get_cygwin_startup_info): Remove commented out code.

2006-01-01  Corinna Vinschen  <corinna@vinschen.de>

	* syslog.cc (vklog): Never log kernel messages using the vsyslog
	interface.


--------------090301000004080602020704
Content-Type: text/plain;
 name="cygcheck.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygcheck.txt"
Content-length: 29236


Cygwin Configuration Diagnostics
Current System Time: Tue Jul 18 13:32:33 2006

Windows 2000 Professional Ver 5.0 Build 2195 Service Pack 4

Path:	E:\cygwin\usr\local\bin
	E:\cygwin\bin
	E:\cygwin\bin
	E:\cygwin\usr\X11R6\bin
	e:\ruby\bin
	e:\winnt
	e:\winnt\system32\wbem
	c:\ruby18\bin
	e:\winnt\system32
	e:\Program Files\Corel\Corel SVG Viewer\
	e:\MSSQL7\BINN
	e:\postgresql\bin
	e:\Program Files\PostgreSQL\bin
	e:\Program Files\Apache Software Foundation\php
	e:\WATCOM\BINNT
	e:\WATCOM\BINW
	e:\Program Files\Common Files\GTK\2.0\bin
	e:\Program Files\GNU\Subversion\bin
	i:\Data-AL\bin\lib
	e:\Program Files\IDM Computer Solutions\UEStudio
	c:\PROGRA~1\WIN98RK
	c:\LAB4

Output from E:\cygwin\bin\id.exe (nontsec)
UID: 1010(slaguzzi) GID: 513(None)
=0(root)            513(None)           544(Administrators) 545(Users)

Output from E:\cygwin\bin\id.exe (ntsec)
UID: 1010(slaguzzi) GID: 513(None)
=0(root)            513(None)           544(Administrators) 545(Users)

SysDir: E:\WINNT\system32
WinDir: E:\WINNT

USER = 'slaguzzi'
PWD = '/home/slaguzzi/src/cygwin'
HOME = '/home/slaguzzi'
MAKE_MODE = 'unix'

MSSDK = 'E:\Program Files\Microsoft SDK\.'
HOMEPATH = '\Documents and Settings\slaguzzi'
MANPATH = '/usr/local/man:/usr/share/man:/usr/man::/usr/ssl/man'
APPDATA = 'E:\Documents and Settings\slaguzzi\Application Data'
HOSTNAME = 'HM'
VS71COMNTOOLS = 'E:\Program Files\Microsoft Visual Studio .NET 2003\Common7\Tools\'
MSTOOLS = 'E:\Program Files\Microsoft SDK\.'
TERM = 'cygwin'
PROCESSOR_IDENTIFIER = 'x86 Family 6 Model 6 Stepping 2, AuthenticAMD'
WINDIR = 'E:\WINNT'
WATCOM = 'E:\WATCOM'
CVSROOT = ':pserver:anoncvs@cgwin.com:/cvs/src'
OLDPWD = '/home/slaguzzi/src'
USERDOMAIN = 'HM'
OS = 'Windows_NT'
ALLUSERSPROFILE = 'E:\Documents and Settings\All Users'
OS2LIBPATH = 'E:\WINNT\system32\os2\dll;'
APR_ICONV_PATH = 'E:\Program Files\GNU\Subversion\iconv'
!:: = '::\'
TEMP = '/cygdrive/e/DOCUME~1/slaguzzi/LOCALS~1/Temp'
COMMONPROGRAMFILES = 'E:\Program Files\Common Files'
LIB = 'E:\Program Files\Microsoft Visual Studio .NET 2003\SDK\v1.1\Lib\;E:\Program Files\Microsoft SDK\Lib\.'
USERNAME = 'slaguzzi'
DXSDKROOT = 'E:\Program Files\Microsoft SDK\.'
PROCESSOR_LEVEL = '6'
SYSTEMDRIVE = 'E:'
USERPROFILE = 'E:\Documents and Settings\slaguzzi'
LANG = 'de'
PS1 = '\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '
LOGONSERVER = '\\HM'
PROCESSOR_ARCHITECTURE = 'x86'
PGHOME = 'e:\postgresql'
SHLVL = '1'
PATHEXT = '.COM;.EXE;.BAT;.CMD'
HOMEDRIVE = 'E:'
PROMPT = '$P$G'
INETSDK = 'E:\Program Files\Microsoft SDK\.'
COMSPEC = 'E:\WINNT\system32\cmd.exe'
TMP = '/cygdrive/e/DOCUME~1/slaguzzi/LOCALS~1/Temp'
SYSTEMROOT = 'E:\WINNT'
PRINTER = 'FinePrint'
CVS_RSH = '/bin/ssh'
PROCESSOR_REVISION = '0602'
BASEMAKE = 'E:\Program Files\Microsoft SDK\Include\BKOffice.Mak'
!E: = 'E:\cygwin\bin'
INFOPATH = '/usr/local/info:/usr/share/info:/usr/info:'
PROGRAMFILES = 'E:\Program Files'
BKOFFICE = 'E:\Program Files\Microsoft SDK\.'
NUMBER_OF_PROCESSORS = '1'
DRS_WORK_PATH = 'E:\Program Files\Kodak\XVCS6C\DRS\'
INCLUDE = 'E:\WATCOM\H;E:\WATCOM\H\NT'
EDPATH = 'E:\WATCOM\EDDAT'
COMPUTERNAME = 'HM'
_ = '/usr/bin/cygcheck'
POSIXLY_CORRECT = '1'

HKEY_CURRENT_USER\Software\Cygnus Solutions
HKEY_CURRENT_USER\Software\Cygnus Solutions\Cygwin
HKEY_CURRENT_USER\Software\Cygnus Solutions\Cygwin\mounts v2
HKEY_CURRENT_USER\Software\Cygnus Solutions\Cygwin\Program Options
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2
  (default) = '/cygdrive'
  cygdrive flags = 0x00000022
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/
  (default) = 'E:\cygwin'
  flags = 0x0000000a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/usr/bin
  (default) = 'E:\cygwin/bin'
  flags = 0x0000000a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/usr/lib
  (default) = 'E:\cygwin/lib'
  flags = 0x0000000a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\Program Options

a:  fd             N/A    N/A                    
c:  hd  FAT32     7985Mb  80% CP    UN           LOCAL DISK
d:  cd             N/A    N/A                    
e:  hd  NTFS     20010Mb  97% CP CS UN PA FC     Local Disk
f:  hd  NTFS     11240Mb  62% CP CS UN PA FC     develop
g:  cd             N/A    N/A                    
h:  hd  NTFS     80003Mb  90% CP CS UN PA FC     New Volume
i:  hd  NTFS     51058Mb  98% CP CS UN PA FC     New Volume

E:\cygwin      /          system  binmode
E:\cygwin/bin  /usr/bin   system  binmode
E:\cygwin/lib  /usr/lib   system  binmode
.              /cygdrive  system  binmode,cygdrive

Found: E:\cygwin\bin\awk.exe
Found: E:\cygwin\bin\bash.exe
Found: E:\cygwin\bin\cat.exe
Found: c:\PROGRA~1\WIN98RK\cat.exe
Warning: E:\cygwin\bin\cat.exe hides c:\PROGRA~1\WIN98RK\cat.exe
Found: E:\cygwin\bin\cp.exe
Found: E:\cygwin\bin\cpp.exe
Found: E:\cygwin\bin\crontab.exe
Found: E:\cygwin\bin\find.exe
Found: E:\cygwin\bin\gcc.exe
Found: E:\cygwin\bin\gdb.exe
Found: E:\cygwin\bin\grep.exe
Found: E:\cygwin\bin\kill.exe
Found: c:\PROGRA~1\WIN98RK\kill.exe
Warning: E:\cygwin\bin\kill.exe hides c:\PROGRA~1\WIN98RK\kill.exe
Found: E:\cygwin\bin\ld.exe
Found: E:\cygwin\bin\ls.exe
Found: c:\PROGRA~1\WIN98RK\ls.exe
Warning: E:\cygwin\bin\ls.exe hides c:\PROGRA~1\WIN98RK\ls.exe
Found: E:\cygwin\bin\make.exe
Found: E:\cygwin\bin\mv.exe
Found: c:\PROGRA~1\WIN98RK\mv.exe
Warning: E:\cygwin\bin\mv.exe hides c:\PROGRA~1\WIN98RK\mv.exe
Found: E:\cygwin\bin\patch.exe
Found: E:\cygwin\bin\perl.exe
Found: E:\cygwin\bin\rm.exe
Found: c:\PROGRA~1\WIN98RK\rm.exe
Warning: E:\cygwin\bin\rm.exe hides c:\PROGRA~1\WIN98RK\rm.exe
Found: E:\cygwin\bin\sed.exe
Not Found: ssh
Found: E:\cygwin\bin\sh.exe
Found: E:\cygwin\bin\tar.exe
Found: E:\cygwin\bin\test.exe
Found: c:\PROGRA~1\WIN98RK\vi.exe
Found: E:\cygwin\bin\vim.exe

   91k 2005/11/11 E:\cygwin\bin\cygapr-0-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygapr-0-0.dll" v0.0 ts=2005/11/11 16:03
  103k 2006/06/05 E:\cygwin\bin\cygapr-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygapr-1-0.dll" v0.0 ts=2006/6/5 18:25
   67k 2005/11/11 E:\cygwin\bin\cygaprutil-0-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygaprutil-0-0.dll" v0.0 ts=2005/11/11 17:55
   70k 2006/06/05 E:\cygwin\bin\cygaprutil-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygaprutil-1-0.dll" v0.0 ts=2006/6/6 0:06
   56k 2005/07/09 E:\cygwin\bin\cygbz2-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygbz2-1.dll" v0.0 ts=2005/7/9 7:09
    7k 2005/11/20 E:\cygwin\bin\cygcharset-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygcharset-1.dll" v0.0 ts=2005/11/20 3:24
    7k 2003/10/19 E:\cygwin\bin\cygcrypt-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygcrypt-0.dll" v0.0 ts=2003/10/19 9:57
 1108k 2006/06/01 E:\cygwin\bin\cygcrypto-0.9.7.dll - os=4.0 img=1.0 sys=4.0
                  "cygcrypto-0.9.7.dll" v0.0 ts=2006/6/1 17:50
 1050k 2006/06/01 E:\cygwin\bin\cygcrypto-0.9.8.dll - os=4.0 img=1.0 sys=4.0
                  "cygcrypto-0.9.8.dll" v0.0 ts=2006/6/1 18:08
  831k 2003/09/20 E:\cygwin\bin\cygdb-4.1.dll - os=4.0 img=1.0 sys=4.0
                  "cygdb-4.1.dll" v0.0 ts=2003/9/20 23:51
  895k 2004/04/28 E:\cygwin\bin\cygdb-4.2.dll - os=4.0 img=1.0 sys=4.0
                  "cygdb-4.2.dll" v0.0 ts=2004/4/27 17:31
  965k 2005/05/14 E:\cygwin\bin\cygdb-4.3.dll - os=4.0 img=1.0 sys=4.0
                  "cygdb-4.3.dll" v0.0 ts=2005/5/14 14:37
 1080k 2003/09/20 E:\cygwin\bin\cygdb_cxx-4.1.dll - os=4.0 img=1.0 sys=4.0
                  "cygdb_cxx-4.1.dll" v0.0 ts=2003/9/20 23:53
 1156k 2004/04/28 E:\cygwin\bin\cygdb_cxx-4.2.dll - os=4.0 img=1.0 sys=4.0
                  "cygdb_cxx-4.2.dll" v0.0 ts=2004/4/27 17:35
 1240k 2005/05/14 E:\cygwin\bin\cygdb_cxx-4.3.dll - os=4.0 img=1.0 sys=4.0
                  "cygdb_cxx-4.3.dll" v0.0 ts=2005/5/14 14:41
  174k 2004/10/14 E:\cygwin\bin\cygexpat-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygexpat-0.dll" v0.0 ts=2004/10/14 10:34
  129k 2004/03/11 E:\cygwin\bin\cygfontconfig-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygfontconfig-1.dll" v0.0 ts=2004/3/11 1:12
   40k 2006/03/24 E:\cygwin\bin\cygform-8.dll - os=4.0 img=1.0 sys=4.0
                  "cygform-8.dll" v0.0 ts=2006/3/24 8:16
   45k 2001/04/25 E:\cygwin\bin\cygform5.dll - os=4.0 img=1.0 sys=4.0
                  "cygform5.dll" v0.0 ts=2001/4/25 7:28
   35k 2002/01/09 E:\cygwin\bin\cygform6.dll - os=4.0 img=1.0 sys=4.0
                  "cygform6.dll" v0.0 ts=2002/1/9 7:03
   48k 2003/08/09 E:\cygwin\bin\cygform7.dll - os=4.0 img=1.0 sys=4.0
                  "cygform7.dll" v0.0 ts=2003/8/9 11:25
  375k 2005/09/06 E:\cygwin\bin\cygfreetype-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygfreetype-6.dll" v0.0 ts=2005/9/7 0:51
  222k 2005/01/13 E:\cygwin\bin\cyggd-2.dll - os=4.0 img=1.0 sys=4.0
                  "cyggd-2.dll" v0.0 ts=2005/1/13 16:56
   28k 2003/07/20 E:\cygwin\bin\cyggdbm-3.dll - os=4.0 img=1.0 sys=4.0
                  "cyggdbm-3.dll" v0.0 ts=2003/7/20 9:58
   30k 2003/08/11 E:\cygwin\bin\cyggdbm-4.dll - os=4.0 img=1.0 sys=4.0
                  "cyggdbm-4.dll" v0.0 ts=2003/8/11 4:12
   19k 2003/03/22 E:\cygwin\bin\cyggdbm.dll - os=4.0 img=1.0 sys=4.0
                  "cyggdbm.dll" v0.0 ts=2002/2/20 4:05
   15k 2003/07/20 E:\cygwin\bin\cyggdbm_compat-3.dll - os=4.0 img=1.0 sys=4.0
                  "cyggdbm_compat-3.dll" v0.0 ts=2003/7/20 10:00
   15k 2003/08/11 E:\cygwin\bin\cyggdbm_compat-4.dll - os=4.0 img=1.0 sys=4.0
                  "cyggdbm_compat-4.dll" v0.0 ts=2003/8/11 4:13
   17k 2001/06/28 E:\cygwin\bin\cyghistory4.dll - os=4.0 img=1.0 sys=4.0
                  "cyghistory4.dll" v0.0 ts=2001/1/7 5:34
   29k 2003/08/10 E:\cygwin\bin\cyghistory5.dll - os=4.0 img=1.0 sys=4.0
                  "cyghistory5.dll" v0.0 ts=2003/8/11 1:16
   24k 2006/03/25 E:\cygwin\bin\cyghistory6.dll - os=4.0 img=1.0 sys=4.0
                  "cyghistory6.dll" v0.0 ts=2006/3/25 15:05
  947k 2005/11/20 E:\cygwin\bin\cygiconv-2.dll - os=4.0 img=1.0 sys=4.0
                  "cygiconv-2.dll" v0.0 ts=2005/11/20 3:24
   22k 2001/12/13 E:\cygwin\bin\cygintl-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygintl-1.dll" v0.0 ts=2001/12/13 10:28
   37k 2003/08/10 E:\cygwin\bin\cygintl-2.dll - os=4.0 img=1.0 sys=4.0
                  "cygintl-2.dll" v0.0 ts=2003/8/10 23:50
   31k 2005/11/20 E:\cygwin\bin\cygintl-3.dll - os=4.0 img=1.0 sys=4.0
                  "cygintl-3.dll" v0.0 ts=2005/11/20 3:04
   21k 2001/06/20 E:\cygwin\bin\cygintl.dll - os=4.0 img=1.0 sys=4.0
                  "cygintl.dll" v0.0 ts=2001/6/20 19:09
   12k 2003/02/17 E:\cygwin\bin\cygioperm-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygioperm-0.dll" v0.0 ts=2003/2/17 20:58
  132k 2003/08/11 E:\cygwin\bin\cygjpeg-62.dll - os=4.0 img=1.0 sys=4.0
                  "cygjpeg-62.dll" v0.0 ts=2003/8/11 2:37
  119k 2002/02/09 E:\cygwin\bin\cygjpeg6b.dll - os=4.0 img=1.0 sys=4.0
                  "cygjpeg6b.dll" v0.0 ts=2002/2/9 6:19
   23k 2006/04/19 E:\cygwin\bin\cygltdl-3.dll - os=4.0 img=1.0 sys=4.0
                  "cygltdl-3.dll" v0.0 ts=2006/4/19 8:19
   48k 2005/11/19 E:\cygwin\bin\cygmagic-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygmagic-1.dll" v0.0 ts=2005/11/19 12:22
   21k 2006/03/24 E:\cygwin\bin\cygmenu-8.dll - os=4.0 img=1.0 sys=4.0
                  "cygmenu-8.dll" v0.0 ts=2006/3/24 8:16
   26k 2001/04/25 E:\cygwin\bin\cygmenu5.dll - os=4.0 img=1.0 sys=4.0
                  "cygmenu5.dll" v0.0 ts=2001/4/25 7:27
   20k 2002/01/09 E:\cygwin\bin\cygmenu6.dll - os=4.0 img=1.0 sys=4.0
                  "cygmenu6.dll" v0.0 ts=2002/1/9 7:03
   29k 2003/08/09 E:\cygwin\bin\cygmenu7.dll - os=4.0 img=1.0 sys=4.0
                  "cygmenu7.dll" v0.0 ts=2003/8/9 11:25
   21k 2004/10/22 E:\cygwin\bin\cygminires.dll - os=4.0 img=1.0 sys=4.0
                  "cygminires.dll" v0.0 ts=2004/10/22 22:28
   67k 2006/03/24 E:\cygwin\bin\cygncurses++-8.dll - os=4.0 img=1.0 sys=4.0
                  "cygncurses++-8.dll" v0.0 ts=2006/3/24 8:17
  156k 2001/04/25 E:\cygwin\bin\cygncurses++5.dll - os=4.0 img=1.0 sys=4.0
                  "cygncurses++5.dll" v0.0 ts=2001/4/25 7:29
  175k 2002/01/09 E:\cygwin\bin\cygncurses++6.dll - os=4.0 img=1.0 sys=4.0
                  "cygncurses++6.dll" v0.0 ts=2002/1/9 7:03
  227k 2006/03/24 E:\cygwin\bin\cygncurses-8.dll - os=4.0 img=1.0 sys=4.0
                  "cygncurses-8.dll" v0.0 ts=2006/3/24 5:51
  226k 2001/04/25 E:\cygwin\bin\cygncurses5.dll - os=4.0 img=1.0 sys=4.0
                  "cygncurses5.dll" v0.0 ts=2001/4/25 7:17
  202k 2002/01/09 E:\cygwin\bin\cygncurses6.dll - os=4.0 img=1.0 sys=4.0
                  "cygncurses6.dll" v0.0 ts=2002/1/9 7:03
  224k 2003/08/09 E:\cygwin\bin\cygncurses7.dll - os=4.0 img=1.0 sys=4.0
                  "cygncurses7.dll" v0.0 ts=2003/8/9 11:24
   91k 2005/11/24 E:\cygwin\bin\cygneon-24.dll - os=4.0 img=1.0 sys=4.0
                  "cygneon-24.dll" v0.0 ts=2005/11/24 13:21
   90k 2006/01/25 E:\cygwin\bin\cygneon-25.dll - os=4.0 img=1.0 sys=4.0
                  "cygneon-25.dll" v0.0 ts=2006/1/25 12:02
   12k 2006/03/24 E:\cygwin\bin\cygpanel-8.dll - os=4.0 img=1.0 sys=4.0
                  "cygpanel-8.dll" v0.0 ts=2006/3/24 8:16
   15k 2001/04/25 E:\cygwin\bin\cygpanel5.dll - os=4.0 img=1.0 sys=4.0
                  "cygpanel5.dll" v0.0 ts=2001/4/25 7:27
   12k 2002/01/09 E:\cygwin\bin\cygpanel6.dll - os=4.0 img=1.0 sys=4.0
                  "cygpanel6.dll" v0.0 ts=2002/1/9 7:03
   19k 2003/08/09 E:\cygwin\bin\cygpanel7.dll - os=4.0 img=1.0 sys=4.0
                  "cygpanel7.dll" v0.0 ts=2003/8/9 11:24
  109k 2006/02/10 E:\cygwin\bin\cygpcre-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygpcre-0.dll" v0.0 ts=2006/2/10 3:37
  299k 2006/02/10 E:\cygwin\bin\cygpcrecpp-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygpcrecpp-0.dll" v0.0 ts=2006/2/10 3:38
    7k 2006/02/10 E:\cygwin\bin\cygpcreposix-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygpcreposix-0.dll" v0.0 ts=2006/2/10 3:37
 1249k 2005/12/30 E:\cygwin\bin\cygperl5_8.dll - os=4.0 img=1.0 sys=4.0
                  "cygperl5_8.dll" v0.0 ts=2005/12/30 2:48
  224k 2005/07/11 E:\cygwin\bin\cygpng10.dll - os=4.0 img=1.0 sys=4.0
                  "cygpng10.dll" v0.0 ts=2005/7/12 1:45
  230k 2005/07/11 E:\cygwin\bin\cygpng12.dll - os=4.0 img=1.0 sys=4.0
                  "cygpng12.dll" v0.0 ts=2005/7/12 1:50
   22k 2002/06/09 E:\cygwin\bin\cygpopt-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygpopt-0.dll" v0.0 ts=2002/6/9 7:45
  108k 2001/06/28 E:\cygwin\bin\cygreadline4.dll - os=4.0 img=1.0 sys=4.0
                  "cygreadline4.dll" v0.0 ts=2001/1/7 5:34
  148k 2003/08/10 E:\cygwin\bin\cygreadline5.dll - os=4.0 img=1.0 sys=4.0
                  "cygreadline5.dll" v0.0 ts=2003/8/11 1:16
  152k 2006/03/25 E:\cygwin\bin\cygreadline6.dll - os=4.0 img=1.0 sys=4.0
                  "cygreadline6.dll" v0.0 ts=2006/3/25 15:05
  704k 2006/01/20 E:\cygwin\bin\cygruby18.dll - os=4.0 img=1.0 sys=4.0
                  "cygruby18.dll" v0.0 ts=2006/1/20 11:43
  230k 2006/06/01 E:\cygwin\bin\cygssl-0.9.7.dll - os=4.0 img=1.0 sys=4.0
                  "cygssl-0.9.7.dll" v0.0 ts=2006/6/1 17:50
  214k 2006/06/01 E:\cygwin\bin\cygssl-0.9.8.dll - os=4.0 img=1.0 sys=4.0
                  "cygssl-0.9.8.dll" v0.0 ts=2006/6/1 18:08
  140k 2006/07/14 E:\cygwin\bin\cygsvn_client-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygsvn_client-1-0.dll" v0.0 ts=2006/7/14 23:26
   27k 2006/07/14 E:\cygwin\bin\cygsvn_delta-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygsvn_delta-1-0.dll" v0.0 ts=2006/7/14 23:17
   23k 2006/07/14 E:\cygwin\bin\cygsvn_diff-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygsvn_diff-1-0.dll" v0.0 ts=2006/7/14 23:25
   14k 2006/07/14 E:\cygwin\bin\cygsvn_fs-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygsvn_fs-1-0.dll" v0.0 ts=2006/7/14 23:20
  127k 2006/07/14 E:\cygwin\bin\cygsvn_fs_base-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygsvn_fs_base-1-0.dll" v0.0 ts=2006/7/14 23:19
   89k 2006/07/14 E:\cygwin\bin\cygsvn_fs_fs-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygsvn_fs_fs-1-0.dll" v0.0 ts=2006/7/14 23:17
    9k 2006/07/14 E:\cygwin\bin\cygsvn_ra-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygsvn_ra-1-0.dll" v0.0 ts=2006/7/14 23:26
   86k 2006/07/14 E:\cygwin\bin\cygsvn_ra_dav-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygsvn_ra_dav-1-0.dll" v0.0 ts=2006/7/14 23:26
   20k 2006/07/14 E:\cygwin\bin\cygsvn_ra_local-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygsvn_ra_local-1-0.dll" v0.0 ts=2006/7/14 23:21
   58k 2006/07/14 E:\cygwin\bin\cygsvn_ra_svn-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygsvn_ra_svn-1-0.dll" v0.0 ts=2006/7/14 23:21
  106k 2006/07/14 E:\cygwin\bin\cygsvn_repos-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygsvn_repos-1-0.dll" v0.0 ts=2006/7/14 23:21
  135k 2006/07/14 E:\cygwin\bin\cygsvn_subr-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygsvn_subr-1-0.dll" v0.0 ts=2006/7/14 23:17
   38k 2006/07/14 E:\cygwin\bin\cygsvn_swig_ruby-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygsvn_swig_ruby-1-0.dll" v0.0 ts=2006/7/14 23:36
  154k 2006/07/14 E:\cygwin\bin\cygsvn_wc-1-0.dll - os=4.0 img=1.0 sys=4.0
                  "cygsvn_wc-1-0.dll" v0.0 ts=2006/7/14 23:25
 1065k 2006/06/09 E:\cygwin\bin\cygxml2-2.dll - os=4.0 img=1.0 sys=4.0
                  "cygxml2-2.dll" v0.0 ts=2006/6/9 21:10
   65k 2005/08/23 E:\cygwin\bin\cygz.dll - os=4.0 img=1.0 sys=4.0
                  "cygz.dll" v0.0 ts=2005/8/23 4:03
 1831k 2006/07/01 E:\cygwin\bin\cygwin1.dll - os=4.0 img=1.0 sys=4.0
                  "cygwin1.dll" v0.0 ts=2006/7/1 8:22
    Cygwin DLL version info:
        DLL version: 1.5.20
        DLL epoch: 19
        DLL bad signal mask: 19005
        DLL old termios: 5
        DLL malloc env: 28
        API major: 0
        API minor: 156
        Shared data: 4
        DLL identifier: cygwin1
        Mount registry: 2
        Cygnus registry name: Cygnus Solutions
        Cygwin registry name: Cygwin
        Program options name: Program Options
        Cygwin mount registry name: mounts v2
        Cygdrive flags: cygdrive flags
        Cygdrive prefix: cygdrive prefix
        Cygdrive default prefix: 
        Build date: Sat Jul 1 02:22:36 EDT 2006
        Shared id: cygwin1S4

   26k 2005/09/21 E:\cygwin\usr\X11R6\bin\cygDtPrint-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygDtPrint-1.dll" v0.0 ts=2005/9/22 1:31
   20k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygfontenc-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygfontenc-1.dll" v0.0 ts=2005/10/26 21:14
   34k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygFS-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygFS-6.dll" v0.0 ts=2005/10/26 19:52
  357k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygGL-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygGL-1.dll" v0.0 ts=2005/10/26 20:30
  441k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygGLU-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygGLU-1.dll" v0.0 ts=2005/10/26 20:48
   74k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygICE-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygICE-6.dll" v0.0 ts=2005/10/26 19:11
   74k 2005/09/21 E:\cygwin\usr\X11R6\bin\cygMrm-2.dll - os=4.0 img=1.0 sys=4.0
                  "cygMrm-2.dll" v0.0 ts=2005/9/22 1:30
    8k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygoldX-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygoldX-6.dll" v0.0 ts=2005/10/26 19:09
 1662k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygOSMesa-4.dll - os=4.0 img=1.0 sys=4.0
                  "cygOSMesa-4.dll" v0.0 ts=2005/10/26 20:32
   28k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygSM-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygSM-6.dll" v0.0 ts=2005/10/26 19:12
   63k 2005/09/21 E:\cygwin\usr\X11R6\bin\cygUil-2.dll - os=4.0 img=1.0 sys=4.0
                  "cygUil-2.dll" v0.0 ts=2005/9/22 1:31
  884k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygX11-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygX11-6.dll" v0.0 ts=2005/10/26 19:07
    8k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXau-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygXau-6.dll" v0.0 ts=2005/10/26 18:31
  250k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXaw-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygXaw-6.dll" v0.0 ts=2005/10/26 19:33
  354k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXaw-7.dll - os=4.0 img=1.0 sys=4.0
                  "cygXaw-7.dll" v0.0 ts=2005/10/26 19:39
  360k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXaw-8.dll - os=4.0 img=1.0 sys=4.0
                  "cygXaw-8.dll" v0.0 ts=2005/10/26 19:45
  275k 2004/01/13 E:\cygwin\usr\X11R6\bin\cygXaw3d-7.dll - os=4.0 img=1.0 sys=4.0
                  "cygXaw3d-7.dll" v0.0 ts=2004/1/13 23:17
    7k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXcomposite-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygXcomposite-1.dll" v0.0 ts=2005/10/26 21:04
   30k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXcursor-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygXcursor-1.dll" v0.0 ts=2005/10/26 21:03
    8k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXdamage-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygXdamage-1.dll" v0.0 ts=2005/10/26 21:02
   16k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXdmcp-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygXdmcp-6.dll" v0.0 ts=2005/10/26 18:34
    7k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXevie-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygXevie-1.dll" v0.0 ts=2005/10/26 21:01
   50k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXext-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygXext-6.dll" v0.0 ts=2005/10/26 19:14
   15k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXfixes-3.dll - os=4.0 img=1.0 sys=4.0
                  "cygXfixes-3.dll" v0.0 ts=2005/10/26 21:02
   56k 2004/03/11 E:\cygwin\usr\X11R6\bin\cygXft-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygXft-1.dll" v0.0 ts=2003/11/18 2:42
   63k 2004/03/23 E:\cygwin\usr\X11R6\bin\cygXft-2.dll - os=4.0 img=1.0 sys=4.0
                  "cygXft-2.dll" v0.0 ts=2004/3/23 23:20
   26k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXi-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygXi-6.dll" v0.0 ts=2005/10/26 19:48
  121k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygxkbfile-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygxkbfile-1.dll" v0.0 ts=2005/10/26 19:54
   11k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygxkbui-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygxkbui-1.dll" v0.0 ts=2005/10/26 19:54
 1185k 2005/09/21 E:\cygwin\usr\X11R6\bin\cygXm-2.dll - os=4.0 img=1.0 sys=4.0
                  "cygXm-2.dll" v0.0 ts=2005/9/22 1:27
   74k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXmu-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygXmu-6.dll" v0.0 ts=2005/10/26 19:22
   10k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXmuu-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygXmuu-1.dll" v0.0 ts=2005/10/26 19:23
   26k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXp-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygXp-6.dll" v0.0 ts=2005/10/26 19:27
   54k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXpm-4.dll - os=4.0 img=1.0 sys=4.0
                  "cygXpm-4.dll" v0.0 ts=2005/10/26 19:26
   10k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXrandr-2.dll - os=4.0 img=1.0 sys=4.0
                  "cygXrandr-2.dll" v0.0 ts=2005/10/26 20:58
   30k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXrender-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygXrender-1.dll" v0.0 ts=2005/10/26 20:52
    7k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXRes-1.dll - os=4.0 img=1.0 sys=4.0
                  "cygXRes-1.dll" v0.0 ts=2005/10/26 21:00
   38k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygxrx-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygxrx-6.dll" v0.0 ts=2005/10/26 22:13
   24k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygxrxnest-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygxrxnest-6.dll" v0.0 ts=2005/10/26 22:14
  283k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXt-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygXt-6.dll" v0.0 ts=2005/10/26 19:19
   27k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXTrap-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygXTrap-6.dll" v0.0 ts=2005/10/26 21:00
   17k 2005/10/27 E:\cygwin\usr\X11R6\bin\cygXtst-6.dll - os=4.0 img=1.0 sys=4.0
                  "cygXtst-6.dll" v0.0 ts=2005/10/26 19:49

No Cygwin services found.


Cygwin Package Information
Last downloaded files to: \\Server2003\BAZAR\Laguzzi\GNU\cygwin
Last downloaded files from: ftp://ftp.sunsite.utk.edu/pub/cygwin

Package              Version
_update-info-dir     00411-1
alternatives         1.3.20a-2
ash                  20040127-3
autoconf             2.59-2
autoconf2.1          2.13-1
autoconf2.5          2.59-2
automake1.9          1.9.6-1
base-files           3.7-1
base-passwd          2.2-1
bash                 3.1-6
bc                   1.06-2
binutils             20060709-1
bzip2                1.0.3-1
chere                0.6-4
coreutils            5.97-1
cron                 3.0.1-19
crypt                1.1-1
cvs                  1.11.17-1
cvsutils             0.2.3-1
cygrunsrv            1.17-1
cygutils             1.3.0-1
cygwin               1.5.20-1
cygwin-doc           1.4-3
ddd                  3.3.9-1
diffutils            2.8.7-1
e2fsprogs            1.35-3
editrights           1.01-1
expat                1.95.8-1
file                 4.16-1
findutils            4.2.27-1
fontconfig           2.2.2-1
freetype2            2.1.9-1
gawk                 3.1.5-4
gcc                  3.4.4-1
gcc-core             3.4.4-1
gcc-g++              3.4.4-1
gcc-mingw-core       20050522-1
gcc-mingw-g++        20050522-1
gd                   2.0.33-1
gdb                  20060706-2
gdbm                 1.8.3-7
gettext              0.14.5-1
ghostscript          8.50-1
ghostscript-base     8.50-1
ghostscript-x11      8.50-1
grep                 2.5.1a-2
groff                1.18.1-2
gzip                 1.3.5-2
ioperm               0.4-1
jpeg                 6b-11
less                 381-1
lesstif              0.94.4-1
libapr0              0.9.7-1
libapr1              1.2.7-1
libaprutil0          0.9.7-1
libaprutil1          1.2.7-1
libbz2_1             1.0.3-1
libcharset1          1.9.2-2
libdb4.1             4.1.25-1
libdb4.2             4.2.52-1
libdb4.3             4.3.28-1
libfontconfig1       2.2.2-1
libfreetype2-devel   2.1.9-1
libfreetype26        2.1.9-1
libgd-devel          2.0.33-1
libgd2               2.0.33-1
libgdbm              1.8.0-5
libgdbm-devel        1.8.3-7
libgdbm3             1.8.3-3
libgdbm4             1.8.3-7
libiconv             1.9.2-2
libiconv2            1.9.2-2
libintl              0.10.38-3
libintl1             0.10.40-1
libintl2             0.12.1-3
libintl3             0.14.5-1
libjpeg62            6b-11
libjpeg6b            6b-8
libltdl3             1.5.22-1
libncurses-devel     5.5-2
libncurses5          5.2-1
libncurses6          5.2-8
libncurses7          5.3-4
libncurses8          5.5-2
libneon24            0.24.7-2
libneon25            0.25.5-1
libpcre0             6.6-1
libpng               1.2.8-2
libpng10             1.0.18-2
libpng10-devel       1.0.18-2
libpng12             1.2.8-2
libpng12-devel       1.2.8-2
libpopt0             1.6.4-4
libreadline4         4.1-2
libreadline5         4.3-5
libreadline6         5.1-5
libtool1.5           1.5.22-1
libXft               2.1.6-1
libXft1              1.0.0-1
libXft2              2.1.6-1
libxml2              2.6.26-1
login                1.9-7
m4                   1.4.5-1
make                 3.81-1
man                  1.5p-1
mingw-runtime        3.10-1
minires              1.00-1
mktemp               1.5-3
mt                   2.3.1-1
ncurses              5.5-2
netcat               1.10-2
openssl              0.9.8b-1
openssl097           0.9.7j-1
patch                2.5.8-8
patchutils           0.2.31-1
pcre                 6.6-1
pcre-devel           6.6-1
pcre-doc             6.6-1
perl                 5.8.7-5
perl_manpages        5.8.7-5
pinfo                0.6.8-1
pkg-config           0.20-1
readline             5.1-5
rsync                2.6.6-1
ruby                 1.8.4-1
run                  1.1.10-1
sed                  4.1.5-1
sharutils            4.5.3-1
shutdown             1.7-1
subversion           1.3.2-1
subversion-devel     1.3.2-1
subversion-ruby      1.3.2-1
swig                 1.3.29-2
syslog-ng            1.6.11-1
tar                  1.15.1-4
tcltk                20060202-1
termcap              20050421-1
terminfo             5.5_20060323-1
texinfo              4.8-3
time                 1.7-1
transfig             3.2.4-2
tzcode               2005r-2
util-linux           2.12r-2
vim                  7.0.035-1
w32api               3.7-1
wget                 1.10.2-1
which                1.7-1
X-startup-scripts    1.0.11-1
Xaw3d                1.5D-5
xfig                 3.2.4-6
xfig-lib             3.2.4-6
xorg-x11-base        6.8.99.901-1
xorg-x11-bin         6.8.99.901-1
xorg-x11-bin-dlls    6.8.99.901-1
xorg-x11-bin-lndir   6.8.99.901-1
xorg-x11-etc         6.8.99.901-1
xorg-x11-fenc        6.8.99.901-1
xorg-x11-fnts        6.8.99.901-1
xorg-x11-libs-data   6.8.99.901-1
xorg-x11-xwin        6.8.99.901-1
xterm                202-1
zlib                 1.2.3-1
Use -h to see help about each section


--------------090301000004080602020704--

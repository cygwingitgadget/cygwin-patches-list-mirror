Return-Path: <cygwin-patches-return-1859-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2107 invoked by alias); 10 Feb 2002 16:55:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2081 invoked from network); 10 Feb 2002 16:55:55 -0000
Message-ID: <3C66A5E5.6FE83240@yahoo.com>
Date: Sun, 10 Feb 2002 10:04:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
Subject: [Fwd: src/winsup/cygwin ChangeLog child_info.h cyghe ...]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q1/txt/msg00216.txt.bz2

I hate to complain but, the ChangeLog isn't in proper format.

Earnie.

-------- Original Message --------
Subject: src/winsup/cygwin ChangeLog child_info.h cyghe ...
Date: 10 Feb 2002 13:38:53 -0000
From: corinna@cygwin.com
To: cygwin-cvs@cygwin.com

CVSROOT:	/cvs/src
Module name:	src
Changes by:	corinna@sources.redhat.com	2002-02-10 05:38:51

Modified files:
	winsup/cygwin  : ChangeLog child_info.h cygheap.h dcrt0.cc 
	                 dir.cc fhandler.cc fhandler.h 
	                 fhandler_clipboard.cc fhandler_disk_file.cc 
	                 fhandler_dsp.cc fhandler_floppy.cc 
	                 fhandler_mem.cc fhandler_random.cc 
	                 fhandler_tape.cc fhandler_zero.cc grp.cc 
	                 mmap.cc passwd.cc pinfo.cc pinfo.h pipe.cc 
	                 sec_acl.cc sec_helper.cc security.cc security.h 
	                 spawn.cc syscalls.cc thread.h uinfo.cc winsup.h 
	winsup/cygwin/include/cygwin: acl.h grp.h 

Log message:
	* (child_info.h, cygheap.h, dcrt0.cc, dir.cc, fhandler.cc, fhandler.h,
	fhandler_clipboard.cc, fhandler_disk_file.cc, fhandler_dsp.cc,
	fhandler_floppy.cc, fhandler_mem.cc, fhandler_random.cc,
	fhandler_tape.cc, fhandler_zero.cc, grp.cc, mmap.cc, passwd.cc,
	pinfo.cc, pinfo.h, pipe.cc, sec_acl.cc, sec_helper.cc, security.cc,
	security.h, spawn.cc, syscalls.cc, thread.h, uinfo.cc, winsup.h):
	Change usage of uid_t to __uid16_t, gid_t to __gid16_t and
	off_t to __off32_t throughout.  Use INVALID_UID, INVALID_GID and
	INVALID_SEEK instead casting -1 to the appropriate type.
	* winsup.h: Define INVALID_UID, INVALID_GID and INVALID_SEEK.
	* include/cygwin/acl.h: Define internal __aclent16_t and __aclent32_t
	types.  Don't declare acl functions when compiling Cygwin.
	* include/cygwin/grp.h: Declare getgrgid() and getgrnam() with
	correct types for internal usage.

Patches:
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/ChangeLog.diff?cvsroot=src&r1=1.1123&r2=1.1124
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/child_info.h.diff?cvsroot=src&r1=1.27&r2=1.28
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/cygheap.h.diff?cvsroot=src&r1=1.33&r2=1.34
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/dcrt0.cc.diff?cvsroot=src&r1=1.124&r2=1.125
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/dir.cc.diff?cvsroot=src&r1=1.58&r2=1.59
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler.cc.diff?cvsroot=src&r1=1.110&r2=1.111
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler.h.diff?cvsroot=src&r1=1.107&r2=1.108
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_clipboard.cc.diff?cvsroot=src&r1=1.13&r2=1.14
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_disk_file.cc.diff?cvsroot=src&r1=1.5&r2=1.6
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_dsp.cc.diff?cvsroot=src&r1=1.14&r2=1.15
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_floppy.cc.diff?cvsroot=src&r1=1.17&r2=1.18
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_mem.cc.diff?cvsroot=src&r1=1.24&r2=1.25
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_random.cc.diff?cvsroot=src&r1=1.16&r2=1.17
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_tape.cc.diff?cvsroot=src&r1=1.25&r2=1.26
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_zero.cc.diff?cvsroot=src&r1=1.12&r2=1.13
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/grp.cc.diff?cvsroot=src&r1=1.38&r2=1.39
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/mmap.cc.diff?cvsroot=src&r1=1.48&r2=1.49
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/passwd.cc.diff?cvsroot=src&r1=1.39&r2=1.40
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/pinfo.cc.diff?cvsroot=src&r1=1.53&r2=1.54
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/pinfo.h.diff?cvsroot=src&r1=1.31&r2=1.32
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/pipe.cc.diff?cvsroot=src&r1=1.32&r2=1.33
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/sec_acl.cc.diff?cvsroot=src&r1=1.9&r2=1.10
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/sec_helper.cc.diff?cvsroot=src&r1=1.13&r2=1.14
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/security.cc.diff?cvsroot=src&r1=1.82&r2=1.83
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/security.h.diff?cvsroot=src&r1=1.17&r2=1.18
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/spawn.cc.diff?cvsroot=src&r1=1.96&r2=1.97
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/syscalls.cc.diff?cvsroot=src&r1=1.181&r2=1.182
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/thread.h.diff?cvsroot=src&r1=1.31&r2=1.32
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/uinfo.cc.diff?cvsroot=src&r1=1.59&r2=1.60
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/winsup.h.diff?cvsroot=src&r1=1.84&r2=1.85
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/include/cygwin/acl.h.diff?cvsroot=src&r1=1.3&r2=1.4
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/include/cygwin/grp.h.diff?cvsroot=src&r1=1.1&r2=1.2

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com


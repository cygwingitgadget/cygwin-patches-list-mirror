Return-Path: <cygwin-patches-return-4397-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7063 invoked by alias); 15 Nov 2003 16:33:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7046 invoked from network); 15 Nov 2003 16:33:38 -0000
Date: Sat, 15 Nov 2003 16:33:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: src/winsup/cygwin ChangeLog bsdlib.cc cygheap. ...
Message-ID: <20031115163334.GA3039@redhat.com>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20031114234006.19467.qmail@sources.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031114234006.19467.qmail@sources.redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00116.txt.bz2

The patch below modifies user-visible files in the include tree.
I thought we were just making the CYG_MAX_PATH change and, even if
that was not the case, the ChangeLog does not correctly deal with
this scenario.

cgf

On Fri, Nov 14, 2003 at 11:40:06PM -0000, rbcollins@cygwin.com wrote:
>CVSROOT:	/cvs/src
>Module name:	src
>Changes by:	rbcollins@sourceware.org	2003-11-14 23:40:06
>
>Modified files:
>	winsup/cygwin  : ChangeLog bsdlib.cc cygheap.h dcrt0.cc 
>	                 delqueue.cc dlfcn.cc dll_init.cc dll_init.h 
>	                 dtable.cc environ.cc environ.h exceptions.cc 
>	                 external.cc fhandler_disk_file.cc 
>	                 fhandler_proc.cc fhandler_process.cc 
>	                 fhandler_raw.cc fhandler_registry.cc 
>	                 fhandler_socket.cc fhandler_virtual.cc 
>	                 miscfuncs.cc mmap.cc netdb.cc path.cc path.h 
>	                 pinfo.cc pinfo.h pthread.cc registry.cc 
>	                 shared.cc shared_info.h smallprint.c spawn.cc 
>	                 strace.cc syscalls.cc thread.h uinfo.cc 
>	                 winsup.h 
>	winsup/cygwin/include: limits.h 
>	winsup/cygwin/include/cygwin: config.h 
>	winsup/cygwin/include/sys: param.h 
>
>Log message:
>	2003-11-11  Robert Collins <rbtcollins@hotmail.com>
>	Ron Parker <rdparker@butlermfg.com>
>	
>	* bsdlib.cc: Update throughout to use CYG_MAX_PATH rather than MAX_PATH.
>	* cygheap.h: Ditto.
>	* dcrt0.cc: Ditto.
>	* delqueue.cc: Ditto.
>	* dlfcn.cc: Ditto.
>	* dll_init.cc: Ditto.
>	* dll_init.h: Ditto.
>	* dtable.cc: Ditto.
>	* environ.cc: Ditto.
>	* environ.h: Ditto.
>	* exceptions.cc: Ditto.
>	* external.cc: Ditto.
>	* fhandler_disk_file.cc: Ditto.
>	* fhandler_proc.cc: Ditto.
>	* fhandler_process.cc: Ditto.
>	* fhandler_raw.cc: Ditto.
>	* fhandler_registry.cc: Ditto.
>	* fhandler_socket.cc: Ditto.
>	* fhandler_virtual.cc: Ditto.
>	* miscfuncs.cc: Ditto.
>	* mmap.cc: Ditto.
>	* netdb.cc: Ditto.
>	* path.cc: Ditto.
>	* path.h: Ditto.
>	* pinfo.cc: Ditto.
>	* pinfo.h: Ditto.
>	* pthread.cc: Ditto.
>	* registry.cc: Ditto.
>	* shared.cc: Ditto.
>	* shared_info.h: Ditto.
>	* smallprint.c: Ditto.
>	* spawn.cc: Ditto.
>	* strace.cc: Ditto.
>	* syscalls.cc: Ditto.
>	* thread.h: Ditto.
>	* uinfo.cc: Ditto.
>	* winsup.h: Ditto.
>	* include/limits.h: Ditto.
>	* include/cygwin/config.h: Ditto.
>	* include/sys/param.h: Ditto.
>
>Patches:
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/ChangeLog.diff?cvsroot=src&r1=1.2165&r2=1.2166
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/bsdlib.cc.diff?cvsroot=src&r1=1.2&r2=1.3
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/cygheap.h.diff?cvsroot=src&r1=1.67&r2=1.68
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/dcrt0.cc.diff?cvsroot=src&r1=1.189&r2=1.190
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/delqueue.cc.diff?cvsroot=src&r1=1.10&r2=1.11
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/dlfcn.cc.diff?cvsroot=src&r1=1.19&r2=1.20
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/dll_init.cc.diff?cvsroot=src&r1=1.38&r2=1.39
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/dll_init.h.diff?cvsroot=src&r1=1.8&r2=1.9
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/dtable.cc.diff?cvsroot=src&r1=1.120&r2=1.121
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/environ.cc.diff?cvsroot=src&r1=1.96&r2=1.97
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/environ.h.diff?cvsroot=src&r1=1.7&r2=1.8
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/exceptions.cc.diff?cvsroot=src&r1=1.173&r2=1.174
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/external.cc.diff?cvsroot=src&r1=1.58&r2=1.59
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_disk_file.cc.diff?cvsroot=src&r1=1.68&r2=1.69
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_proc.cc.diff?cvsroot=src&r1=1.37&r2=1.38
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_process.cc.diff?cvsroot=src&r1=1.39&r2=1.40
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_raw.cc.diff?cvsroot=src&r1=1.36&r2=1.37
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_registry.cc.diff?cvsroot=src&r1=1.22&r2=1.23
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_socket.cc.diff?cvsroot=src&r1=1.111&r2=1.112
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fhandler_virtual.cc.diff?cvsroot=src&r1=1.21&r2=1.22
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/miscfuncs.cc.diff?cvsroot=src&r1=1.24&r2=1.25
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/mmap.cc.diff?cvsroot=src&r1=1.88&r2=1.89
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/netdb.cc.diff?cvsroot=src&r1=1.3&r2=1.4
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/path.cc.diff?cvsroot=src&r1=1.278&r2=1.279
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/path.h.diff?cvsroot=src&r1=1.56&r2=1.57
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/pinfo.cc.diff?cvsroot=src&r1=1.90&r2=1.91
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/pinfo.h.diff?cvsroot=src&r1=1.53&r2=1.54
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/pthread.cc.diff?cvsroot=src&r1=1.24&r2=1.25
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/registry.cc.diff?cvsroot=src&r1=1.17&r2=1.18
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/shared.cc.diff?cvsroot=src&r1=1.77&r2=1.78
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/shared_info.h.diff?cvsroot=src&r1=1.37&r2=1.38
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/smallprint.c.diff?cvsroot=src&r1=1.13&r2=1.14
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/spawn.cc.diff?cvsroot=src&r1=1.137&r2=1.138
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/strace.cc.diff?cvsroot=src&r1=1.43&r2=1.44
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/syscalls.cc.diff?cvsroot=src&r1=1.299&r2=1.300
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/thread.h.diff?cvsroot=src&r1=1.76&r2=1.77
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/uinfo.cc.diff?cvsroot=src&r1=1.121&r2=1.122
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/winsup.h.diff?cvsroot=src&r1=1.127&r2=1.128
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/include/limits.h.diff?cvsroot=src&r1=1.6&r2=1.7
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/include/cygwin/config.h.diff?cvsroot=src&r1=1.3&r2=1.4
>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/include/sys/param.h.diff?cvsroot=src&r1=1.3&r2=1.4

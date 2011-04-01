Return-Path: <cygwin-patches-return-7236-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25205 invoked by alias); 1 Apr 2011 09:31:08 -0000
Received: (qmail 25177 invoked by uid 22791); 1 Apr 2011 09:31:04 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_CB,TW_CP,TW_FP,TW_LR,TW_QN,TW_SG,TW_UF
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 01 Apr 2011 09:30:56 +0000
Received: by iyi20 with SMTP id 20so4330772iyi.2        for <cygwin-patches@cygwin.com>; Fri, 01 Apr 2011 02:30:56 -0700 (PDT)
Received: by 10.42.156.70 with SMTP id y6mr4563607icw.524.1301650255906;        Fri, 01 Apr 2011 02:30:55 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id gx2sm1349221ibb.26.2011.04.01.02.30.54        (version=SSLv3 cipher=OTHER);        Fri, 01 Apr 2011 02:30:54 -0700 (PDT)
Subject: [PATCH] implement /proc/sysvipc/*
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-ISUswHsQPayY40SAEbtL"
Date: Fri, 01 Apr 2011 09:31:00 -0000
Message-ID: <1301650256.3108.4.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00002.txt.bz2


--=-ISUswHsQPayY40SAEbtL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1318

These patches implement /proc/sysvipc/*, as found on Linux[1]:

$ ls -l /proc
[...]
dr-xr-xr-x 2 Yaakov         None           0 Apr  1 04:12 sysvipc/
[...]

$ ls -l /proc/sysvipc
total 0
-r--r--r-- 1 Yaakov None 0 Apr  1 04:12 msg
-r--r--r-- 1 Yaakov None 0 Apr  1 04:12 sem
-r--r--r-- 1 Yaakov None 0 Apr  1 04:12 shm

# yes, these lines are very long
$ cat /proc/sysvipc/shm 
       key      shmid perms       size  cpid  lpid nattch   uid   gid cuid   cgid      atime      dtime      ctime
         0     196608  6600     393216  4960  4996      2  1001   513  1001   513 1301639749          0 1301639749
         0      65537  6600     393216  4916  4996      2  1001   513  1001   513 1301639750          0 1301639750
[...]

If cygserver is not running, then the /proc/sysvipc directory still
exists but readdir()s as empty, and the files therein are nonexistent:

$ ls /proc/sysvipc/

$ ls /proc/sysvipc/shm
ls: cannot access /proc/sysvipc/sem: No such file or directory

$ cat /proc/sysvipc/shm
cat: /proc/sysvipc/shm: No such file or directory

The code uses some hints from the Cygwin modifications to ipcs(1).

Patch and new file for winsup/cygwin, and patch for winsup/doc attached.


Yaakov


[1] http://docs.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/4/html/Reference_Guide/s2-proc-dir-sysvipc.html


--=-ISUswHsQPayY40SAEbtL
Content-Disposition: attachment; filename="doc-proc-sysvipc.patch"
Content-Type: text/x-patch; name="doc-proc-sysvipc.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 734

2011-04-01  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* new-features.sgml (ov-new1.7.10): Document /proc/sysvipc/.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.70
diff -u -r1.70 new-features.sgml
--- new-features.sgml	1 Apr 2011 09:01:47 -0000	1.70
+++ new-features.sgml	1 Apr 2011 09:08:23 -0000
@@ -14,6 +14,12 @@
 total number of processes.
 </para></listitem>
 
+<listitem><para>
+Added /proc/sysvipc/msg, /proc/sysvipc/sem, and /proc/sysvipc/shm which
+provide information about System V IPC message queues, semaphores, and
+shared memory.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>

--=-ISUswHsQPayY40SAEbtL
Content-Disposition: attachment; filename="fhandler_procsysvipc.cc"
Content-Type: text/x-c++src; name="fhandler_procsysvipc.cc"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 9299

/* fhandler_procsysvipc.cc: fhandler for /proc/sysvipc virtual filesystem

   Copyright 2011 Red Hat, Inc.

This file is part of Cygwin.

This software is a copyrighted work licensed under the terms of the
Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
details. */

#include "winsup.h"
#include <stdlib.h>
#include <stdio.h>
#include <sys/cygwin.h>
#include "cygerrno.h"
#include "cygserver.h"
#include "security.h"
#include "path.h"
#include "fhandler.h"
#include "fhandler_virtual.h"
#include "pinfo.h"
#include "shared_info.h"
#include "dtable.h"
#include "cygheap.h"
#include "ntdll.h"
#include "cygtls.h"
#include "pwdgrp.h"
#include "tls_pbuf.h"
#include <sys/param.h>
#include <ctype.h>

#define _COMPILING_NEWLIB
#include <dirent.h>

#define _KERNEL
#include <sys/ipc.h>
#include <sys/msg.h>
#include <sys/sem.h>
#include <sys/shm.h>

static _off64_t format_procsysvipc_msg (void *, char *&);
static _off64_t format_procsysvipc_sem (void *, char *&);
static _off64_t format_procsysvipc_shm (void *, char *&);

static const virt_tab_t procsysvipc_tab[] =
{
  { _VN ("."),          FH_PROCSYSVIPC,   virt_directory, NULL },
  { _VN (".."),         FH_PROCSYSVIPC,   virt_directory, NULL },
  { _VN ("msg"),        FH_PROCSYSVIPC,   virt_file,   format_procsysvipc_msg },
  { _VN ("sem"),        FH_PROCSYSVIPC,   virt_file,   format_procsysvipc_sem },
  { _VN ("shm"),        FH_PROCSYSVIPC,   virt_file,   format_procsysvipc_shm },
  { NULL, 0,	        0,                virt_none,      NULL }
};

static const int PROCSYSVIPC_LINK_COUNT =
  (sizeof (procsysvipc_tab) / sizeof (virt_tab_t)) - 1;

/* Returns 0 if path doesn't exist, >0 if path is a directory,
 * -1 if path is a file.
 */
virtual_ftype_t
fhandler_procsysvipc::exists ()
{
  const char *path = get_name ();
  debug_printf ("exists (%s)", path);
  path += proc_len + 1;
  while (*path != 0 && !isdirsep (*path))
    path++;
  if (*path == 0)
    return virt_rootdir;

  virt_tab_t *entry = virt_tab_search (path + 1, true, procsysvipc_tab,
				       PROCSYSVIPC_LINK_COUNT);

  cygserver_init();

  if (entry)
    {
      if (entry->type == virt_file)
        {
          if (cygserver_running != CYGSERVER_OK)
            return virt_none;
        }
	  fileid = entry - procsysvipc_tab;
	  return entry->type;
	}
  return virt_none;
}

fhandler_procsysvipc::fhandler_procsysvipc ():
  fhandler_proc ()
{
}

int
fhandler_procsysvipc::fstat (struct __stat64 *buf)
{
  fhandler_base::fstat (buf);
  buf->st_mode &= ~_IFMT & NO_W;
  int file_type = exists ();
  switch (file_type)
    {
    case virt_none:
      set_errno (ENOENT);
      return -1;
    case virt_directory:
    case virt_rootdir:
      buf->st_mode |= S_IFDIR | S_IXUSR | S_IXGRP | S_IXOTH;
      buf->st_nlink = 2;
      return 0;
    case virt_file:
    default:
      buf->st_mode |= S_IFREG | S_IRUSR | S_IRGRP | S_IROTH;
      return 0;
    }
}

int
fhandler_procsysvipc::readdir (DIR *dir, dirent *de)
{
  int res = ENMFILE;
  if (dir->__d_position >= PROCSYSVIPC_LINK_COUNT)
    goto out;
  {
    cygserver_init();
    if (cygserver_running != CYGSERVER_OK)
      goto out;
  }
  strcpy (de->d_name, procsysvipc_tab[dir->__d_position++].name);
  dir->__flags |= dirent_saw_dot | dirent_saw_dot_dot;
  res = 0;
out:
  syscall_printf ("%d = readdir (%p, %p) (%s)", res, dir, de, de->d_name);
  return res;
}

int
fhandler_procsysvipc::open (int flags, mode_t mode)
{
  int res = fhandler_virtual::open (flags, mode);
  if (!res)
    goto out;

  nohandle (true);

  const char *path;
  path = get_name () + proc_len + 1;
  pid = atoi (path);
  while (*path != 0 && !isdirsep (*path))
    path++;

  if (*path == 0)
    {
      if ((flags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
	{
	  set_errno (EEXIST);
	  res = 0;
	  goto out;
	}
      else if (flags & O_WRONLY)
	{
	  set_errno (EISDIR);
	  res = 0;
	  goto out;
	}
      else
	{
	  flags |= O_DIROPEN;
	  goto success;
	}
    }

  virt_tab_t *entry;
  entry = virt_tab_search (path + 1, true, procsysvipc_tab, PROCSYSVIPC_LINK_COUNT);
  if (!entry)
    {
      set_errno ((flags & O_CREAT) ? EROFS : ENOENT);
      res = 0;
      goto out;
    }
  if (flags & O_WRONLY)
    {
      set_errno (EROFS);
      res = 0;
      goto out;
    }

  fileid = entry - procsysvipc_tab;
  if (!fill_filebuf ())
	{
	  res = 0;
	  goto out;
	}

  if (flags & O_APPEND)
    position = filesize;
  else
    position = 0;

success:
  res = 1;
  set_flags ((flags & ~O_TEXT) | O_BINARY);
  set_open_status ();
out:
  syscall_printf ("%d = fhandler_proc::open (%p, %d)", res, flags, mode);
  return res;
}

bool
fhandler_procsysvipc::fill_filebuf ()
{
  if (procsysvipc_tab[fileid].format_func)
    {
      filesize = procsysvipc_tab[fileid].format_func (NULL, filebuf);
      return true;
    }
  return false;
}

static _off64_t
format_procsysvipc_msg (void *, char *&destbuf)
{
  tmp_pathbuf tp;
  char *buf = tp.c_get ();
  char *bufptr = buf;
  struct msginfo msginfo;
  struct msqid_ds *xmsqids;
  size_t xmsqids_len;

  msgctl (0, IPC_INFO, (struct msqid_ds *) &msginfo);
  xmsqids_len = sizeof (struct msqid_ds) * msginfo.msgmni;
  xmsqids = (struct msqid_ds *) malloc (xmsqids_len);
  msgctl (msginfo.msgmni, IPC_INFO, (struct msqid_ds *) xmsqids);

  bufptr += __small_sprintf (bufptr,
            "       key      msqid perms      cbytes       qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctime\n");

  for (int i = 0; i < msginfo.msgmni; i++) {
    if (xmsqids[i].msg_qbytes != 0) {
       bufptr += sprintf (bufptr,
                 "%10llu %10u %5o %11lu %10lu %5d %5d %5lu %5lu %5lu %5lu %10ld %10ld %10ld\n",
                 xmsqids[i].msg_perm.key,
                 IXSEQ_TO_IPCID(i, xmsqids[i].msg_perm),
                 xmsqids[i].msg_perm.mode,
                 xmsqids[i].msg_cbytes,
                 xmsqids[i].msg_qnum,
                 xmsqids[i].msg_lspid,
                 xmsqids[i].msg_lrpid,
                 xmsqids[i].msg_perm.uid,
                 xmsqids[i].msg_perm.gid,
                 xmsqids[i].msg_perm.cuid,
                 xmsqids[i].msg_perm.cgid,
                 xmsqids[i].msg_stime,
                 xmsqids[i].msg_rtime,
                 xmsqids[i].msg_ctime);
    }
  }

  destbuf = (char *) crealloc_abort (destbuf, bufptr - buf);
  memcpy (destbuf, buf, bufptr - buf);
  return bufptr - buf;
}

static _off64_t
format_procsysvipc_sem (void *, char *&destbuf)
{
  tmp_pathbuf tp;
  char *buf = tp.c_get ();
  char *bufptr = buf;
  union semun semun;
  struct seminfo seminfo;
  struct semid_ds *xsemids;
  size_t xsemids_len;

  semun.buf = (struct semid_ds *) &seminfo;
  semctl (0, 0, IPC_INFO, semun);
  xsemids_len = sizeof (struct semid_ds) * seminfo.semmni;
  xsemids = (struct semid_ds *) malloc (xsemids_len);
  semun.buf = xsemids;
  semctl (seminfo.semmni, 0, IPC_INFO, semun);

  bufptr += __small_sprintf (bufptr,
            "       key      semid perms      nsems   uid   gid  cuid  cgid      otime      ctime\n");
  for (int i = 0; i < seminfo.semmni; i++) {
    if ((xsemids[i].sem_perm.mode & SEM_ALLOC) != 0) {
      bufptr += sprintf (bufptr,
                "%10llu %10u %5o %10d %5lu %5lu %5lu %5lu %10ld %10ld\n",
                xsemids[i].sem_perm.key,
                IXSEQ_TO_IPCID(i, xsemids[i].sem_perm),
                xsemids[i].sem_perm.mode,
                xsemids[i].sem_nsems,
                xsemids[i].sem_perm.uid,
                xsemids[i].sem_perm.gid,
                xsemids[i].sem_perm.cuid,
                xsemids[i].sem_perm.cgid,
                xsemids[i].sem_otime,
                xsemids[i].sem_ctime);
    }
  }

  destbuf = (char *) crealloc_abort (destbuf, bufptr - buf);
  memcpy (destbuf, buf, bufptr - buf);
  return bufptr - buf;
}

static _off64_t
format_procsysvipc_shm (void *, char *&destbuf)
{
  tmp_pathbuf tp;
  char *buf = tp.c_get ();
  char *bufptr = buf;
  struct shminfo shminfo;
  struct shmid_ds *xshmids;
  size_t xshmids_len;

  shmctl (0, IPC_INFO, (struct shmid_ds *) &shminfo);
  xshmids_len = sizeof (struct shmid_ds) * shminfo.shmmni;
  xshmids = (struct shmid_ds *) malloc (xshmids_len);
  shmctl (shminfo.shmmni, IPC_INFO, (struct shmid_ds *) xshmids);

  bufptr += __small_sprintf (bufptr,
            "       key      shmid perms       size  cpid  lpid nattch   uid   gid  cuid  cgid      atime      dtime      ctime\n");
  for (int i = 0; i < shminfo.shmmni; i++) {
    if (xshmids[i].shm_perm.mode & 0x0800) {
      bufptr += sprintf (bufptr,
                "%10llu %10u %5o %10u %5d %5d %6u %5lu %5lu %5lu %5lu %10ld %10ld %10ld\n",
                xshmids[i].shm_perm.key,
                IXSEQ_TO_IPCID(i, xshmids[i].shm_perm),
                xshmids[i].shm_perm.mode,
                xshmids[i].shm_segsz,
                xshmids[i].shm_cpid,
                xshmids[i].shm_lpid,
                xshmids[i].shm_nattch,
                xshmids[i].shm_perm.uid,
                xshmids[i].shm_perm.gid,
                xshmids[i].shm_perm.cuid,
                xshmids[i].shm_perm.cgid,
                xshmids[i].shm_atime,
                xshmids[i].shm_dtime,
                xshmids[i].shm_ctime);
		}
	}

  destbuf = (char *) crealloc_abort (destbuf, bufptr - buf);
  memcpy (destbuf, buf, bufptr - buf);
  return bufptr - buf;
}

--=-ISUswHsQPayY40SAEbtL
Content-Disposition: attachment; filename="proc-sysvipc.patch"
Content-Type: text/x-patch; name="proc-sysvipc.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 6579

2011-04-01  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	Implement /proc/sysvipc/*
	* devices.in (dev_procsysvipc_storage): Add.
	* devices.cc: Regenerate.
	* devices.h (fh_devices): Add FH_PROCSYSVIPC.
	* dtable.cc (build_fh_pc): Add case FH_PROCSYSVIPC.
	* fhandler.h (class fhandler_procsysvipc): Declare.
	(fhandler_union): Add __procsysvipc.
	* fhandler_proc.cc (proc_tab): Add sysvipc virt_directory.
	* fhandler_procsysvipc.cc: New file.
	* Makefile.in (DLL_OFILES): Add fhandler_procsysvipc.o.
	* path.h (isproc_dev): Add FH_PROCSYSVIPC to conditional.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.241
diff -u -r1.241 Makefile.in
--- Makefile.in	28 Sep 2010 14:49:31 -0000	1.241
+++ Makefile.in	20 Feb 2011 08:24:44 -0000
@@ -141,12 +141,12 @@
 	fhandler.o fhandler_clipboard.o fhandler_console.o fhandler_disk_file.o \
 	fhandler_dsp.o fhandler_fifo.o fhandler_floppy.o fhandler_mailslot.o \
 	fhandler_mem.o fhandler_netdrive.o fhandler_nodevice.o fhandler_proc.o \
-	fhandler_process.o fhandler_procnet.o fhandler_procsys.o fhandler_random.o \
-	fhandler_raw.o fhandler_registry.o fhandler_serial.o fhandler_socket.o \
-	fhandler_tape.o fhandler_termios.o fhandler_tty.o fhandler_virtual.o \
-	fhandler_windows.o fhandler_zero.o flock.o fnmatch.o fork.o fts.o ftw.o \
-	getopt.o glob.o glob_pattern_p.o globals.o grp.o heap.o hookapi.o \
-	inet_addr.o inet_network.o init.o ioctl.o ipc.o kernel32.o \
+	fhandler_process.o fhandler_procnet.o fhandler_procsys.o fhandler_procsysvipc.o \
+	fhandler_random.o fhandler_raw.o fhandler_registry.o fhandler_serial.o \
+	fhandler_socket.o fhandler_tape.o fhandler_termios.o fhandler_tty.o \
+	fhandler_virtual.o fhandler_windows.o fhandler_zero.o flock.o fnmatch.o \
+	fork.o fts.o ftw.o getopt.o glob.o glob_pattern_p.o globals.o grp.o heap.o \
+	hookapi.o inet_addr.o inet_network.o init.o ioctl.o ipc.o kernel32.o \
 	libstdcxx_wrapper.o localtime.o lsearch.o malloc_wrapper.o \
 	minires-os-if.o minires.o miscfuncs.o mktemp.o mmap.o msg.o \
 	mount.o net.o netdb.o nfs.o nftw.o nlsfuncs.o ntea.o passwd.o path.o \
Index: devices.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/devices.cc,v
retrieving revision 1.33
diff -u -r1.33 devices.cc
--- devices.cc	15 Feb 2011 15:25:59 -0000	1.33
+++ devices.cc	20 Feb 2011 08:24:51 -0000
@@ -27,6 +27,9 @@
 const device dev_procsys_storage =
   {"", {FH_PROCSYS}, ""};
 
+const device dev_procsysvipc_storage =
+  {"", {FH_PROCSYSVIPC}, ""};
+
 const device dev_netdrive_storage =
   {"", {FH_NETDRIVE}, ""};
 
Index: devices.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/devices.h,v
retrieving revision 1.26
diff -u -r1.26 devices.h
--- devices.h	6 Sep 2010 09:47:00 -0000	1.26
+++ devices.h	20 Feb 2011 08:24:51 -0000
@@ -54,6 +54,7 @@
   FH_PROCNET = FHDEV (0, 244),
   FH_PROCESSFD = FHDEV (0, 243),
   FH_PROCSYS = FHDEV (0, 242),
+  FH_PROCSYSVIPC = FHDEV (0,241),
 
   DEV_FLOPPY_MAJOR = 2,
   FH_FLOPPY  = FHDEV (DEV_FLOPPY_MAJOR, 0),
Index: devices.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/devices.in,v
retrieving revision 1.24
diff -u -r1.24 devices.in
--- devices.in	15 Feb 2011 15:25:59 -0000	1.24
+++ devices.in	20 Feb 2011 08:24:52 -0000
@@ -23,6 +23,9 @@
 const device dev_procsys_storage =
   {"", {FH_PROCSYS}, ""};
 
+const device dev_procsysvipc_storage =
+  {"", {FH_PROCSYSVIPC}, ""};
+
 const device dev_netdrive_storage =
   {"", {FH_NETDRIVE}, ""};
 
Index: dtable.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
retrieving revision 1.217
diff -u -r1.217 dtable.cc
--- dtable.cc	6 Sep 2010 09:47:01 -0000	1.217
+++ dtable.cc	20 Feb 2011 08:24:52 -0000
@@ -543,6 +543,9 @@
 	case FH_PROCSYS:
 	  fh = cnew (fhandler_procsys) ();
 	  break;
+	case FH_PROCSYSVIPC:
+	  fh = cnew (fhandler_procsysvipc) ();
+	  break;
 	case FH_NETDRIVE:
 	  fh = cnew (fhandler_netdrive) ();
 	  break;
Index: fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.410
diff -u -r1.410 fhandler.h
--- fhandler.h	12 Jan 2011 09:16:50 -0000	1.410
+++ fhandler.h	20 Feb 2011 08:24:52 -0000
@@ -1419,6 +1419,18 @@
   bool fill_filebuf ();
 };
 
+class fhandler_procsysvipc: public fhandler_proc
+{
+  pid_t pid;
+ public:
+  fhandler_procsysvipc ();
+  virtual_ftype_t exists();
+  int readdir (DIR *, dirent *) __attribute__ ((regparm (3)));
+  int open (int flags, mode_t mode = 0);
+  int __stdcall fstat (struct __stat64 *buf) __attribute__ ((regparm (2)));
+  bool fill_filebuf ();
+};
+
 class fhandler_netdrive: public fhandler_virtual
 {
  public:
@@ -1517,6 +1529,7 @@
   char __process[sizeof (fhandler_process)];
   char __procnet[sizeof (fhandler_procnet)];
   char __procsys[sizeof (fhandler_procsys)];
+  char __procsysvipc[sizeof (fhandler_procsysvipc)];
   char __pty_master[sizeof (fhandler_pty_master)];
   char __registry[sizeof (fhandler_registry)];
   char __serial[sizeof (fhandler_serial)];
Index: fhandler_proc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
retrieving revision 1.95
diff -u -r1.95 fhandler_proc.cc
--- fhandler_proc.cc	17 Jan 2011 14:31:30 -0000	1.95
+++ fhandler_proc.cc	20 Feb 2011 08:24:53 -0000
@@ -61,6 +61,7 @@
   { _VN ("self"),	 FH_PROC,	virt_symlink,	format_proc_self },
   { _VN ("stat"),	 FH_PROC,	virt_file,	format_proc_stat },
   { _VN ("sys"),	 FH_PROCSYS,	virt_directory,	NULL },
+  { _VN ("sysvipc"),	 FH_PROCSYSVIPC,	virt_directory,	NULL },
   { _VN ("uptime"),	 FH_PROC,	virt_file,	format_proc_uptime },
   { _VN ("version"),	 FH_PROC,	virt_file,	format_proc_version },
   { NULL, 0,	   	 0,		virt_none,	NULL }
Index: path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.154
diff -u -r1.154 path.h
--- path.h	17 Jan 2011 14:19:39 -0000	1.154
+++ path.h	20 Feb 2011 08:24:53 -0000
@@ -19,7 +19,7 @@
 
 #define isproc_dev(devn) \
   (devn == FH_PROC || devn == FH_REGISTRY || devn == FH_PROCESS || \
-   devn == FH_PROCNET || devn == FH_PROCSYS)
+   devn == FH_PROCNET || devn == FH_PROCSYS || devn == FH_PROCSYSVIPC)
 
 #define isprocsys_dev(devn) (devn == FH_PROCSYS)
 

--=-ISUswHsQPayY40SAEbtL--

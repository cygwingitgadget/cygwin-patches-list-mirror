Return-Path: <cygwin-patches-return-1925-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10822 invoked by alias); 27 Feb 2002 23:55:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10760 invoked from network); 27 Feb 2002 23:55:25 -0000
Message-ID: <00de01c1bfea$85045270$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
References: <008901c1b1be$80b36e70$0100a8c0@advent02> <20020210043745.GA5128@redhat.com> <006401c1b998$c106f230$0100a8c0@advent02> <20020219230649.GC4626@redhat.com> <024601c1b9a3$2f8fb700$0100a8c0@advent02> <20020220003104.GD22591@redhat.com> <20020225164230.GA17325@redhat.com> <001301c1be40$647220b0$0100a8c0@advent02> <20020225214630.GD22795@redhat.com> <00b501c1bec2$ae997530$0100a8c0@advent02> <20020227170138.GA2380@redhat.com>
Subject: Re: /proc and /proc/registry
Date: Thu, 28 Feb 2002 05:40:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00DB_01C1BFEA.845C2B90"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00282.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_00DB_01C1BFEA.845C2B90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 880

> On Tue, Feb 26, 2002 at 12:39:47PM -0000, Chris January wrote:
> >> 1) The copyrights still need to be changed.
> >Done.
> >> 2) The code formatting still is not correct.
> >Now piped through indent with a few touch-ups.
> >> 3) You have a lot of calls to normalize_posix_path.  Is that really
> >>    necessary?  It seems to be called a lot.  If it is really necessary,
> >>    I'd prefer that it just be called in dtable::build_fhandler and made
> >>    the standard "unix_path_name".
> >Done.
> >> 4) Could you generate the diff using 'cvs diff -up"
> >Done. The new files are diff'ed against /dev/null and are appended to the
> >output of cvs diff.

<--snip-->

> Phew.

Please find attached another patch with modifications as per your comments.
I don't have much time to work on this anymore so this will have to be the
last patch. ChangeLog is as before.

Regards
Chris


------=_NextPart_000_00DB_01C1BFEA.845C2B90
Content-Type: application/octet-stream;
	name="proc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc.patch"
Content-length: 52449

Index: Makefile.in=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v=0A=
retrieving revision 1.83=0A=
diff -u -3 -p -u -p -a -b -B -r1.83 Makefile.in=0A=
--- Makefile.in	2002/02/10 21:26:27	1.83=0A=
+++ Makefile.in	2002/02/27 23:49:52=0A=
@@ -122,16 +122,18 @@ DLL_OFILES:=3Dassert.o autoload.o cygheap.=0A=
 	dlfcn.o dll_init.o dtable.o environ.o  errno.o exceptions.o exec.o \=0A=
 	external.o fcntl.o fhandler.o fhandler_clipboard.o fhandler_console.o \=
=0A=
 	fhandler_disk_file.o fhandler_dsp.o fhandler_floppy.o fhandler_mem.o \=0A=
-	fhandler_random.o fhandler_raw.o fhandler_serial.o fhandler_socket.o \=0A=
-	fhandler_tape.o fhandler_termios.o fhandler_tty.o fhandler_windows.o \=0A=
-	fhandler_zero.o fnmatch.o fork.o glob.o grp.o heap.o init.o ioctl.o \=0A=
-	localtime.o malloc.o miscfuncs.o mmap.o net.o ntea.o passwd.o path.o \=0A=
-	pinfo.o pipe.o poll.o pthread.o regcomp.o regerror.o regexec.o \=0A=
-	regfree.o registry.o resource.o scandir.o sched.o sec_acl.o \=0A=
-	sec_helper.o security.o select.o shared.o shortcut.o signal.o \=0A=
-	sigproc.o smallprint.o spawn.o strace.o strsep.o sync.o syscalls.o \=0A=
-	sysconf.o syslog.o termios.o thread.o times.o tty.o uinfo.o uname.o \=0A=
-	v8_regexp.o v8_regerror.o v8_regsub.o wait.o wincap.o window.o \=0A=
+	fhandler_proc.o fhandler_process.o fhandler_random.o fhandler_raw.o \=0A=
+	fhandler_registry.o fhandler_serial.o fhandler_socket.o \=0A=
+	fhandler_tape.o fhandler_termios.o fhandler_tty.o fhandler_virtual.o \=0A=
+	fhandler_windows.o fhandler_zero.o fnmatch.o fork.o glob.o grp.o \=0A=
+	heap.o init.o ioctl.o localtime.o malloc.o miscfuncs.o mmap.o net.o \=0A=
+	ntea.o passwd.o path.o pinfo.o pipe.o poll.o pthread.o regcomp.o \=0A=
+	regerror.o regexec.o regfree.o registry.o resource.o scandir.o \=0A=
+	sched.o sec_acl.o sec_helper.o security.o select.o shared.o \=0A=
+	shortcut.o signal.o sigproc.o smallprint.o spawn.o strace.o strsep.o \=0A=
+	sync.o syscalls.o sysconf.o syslog.o termios.o thread.o times.o tty.o \=
=0A=
+	uinfo.o uname.o v8_regexp.o v8_regerror.o v8_regsub.o wait.o wincap.o \=
=0A=
+	window.o \=0A=
 	$(EXTRA_DLL_OFILES) $(EXTRA_OFILES) $(MALLOC_OFILES) $(MT_SAFE_OBJECTS)=
=0A=
=20=0A=
 GMON_OFILES:=3Dgmon.o mcount.o profil.o=0A=
Index: dtable.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v=0A=
retrieving revision 1.78=0A=
diff -u -3 -p -u -p -a -b -B -r1.78 dtable.cc=0A=
--- dtable.cc	2002/02/22 19:33:41	1.78=0A=
+++ dtable.cc	2002/02/27 23:49:53=0A=
@@ -363,6 +363,15 @@ dtable::build_fhandler (int fd, DWORD de=0A=
       case FH_OSS_DSP:=0A=
 	fh =3D cnew (fhandler_dev_dsp) ();=0A=
 	break;=0A=
+      case FH_PROC:=0A=
+        fh =3D cnew (fhandler_proc) ();=0A=
+        break;=0A=
+      case FH_REGISTRY:=0A=
+        fh =3D cnew (fhandler_registry) ();=0A=
+        break;=0A=
+      case FH_PROCESS:=0A=
+        fh =3D cnew (fhandler_process) ();=0A=
+        break;=0A=
       default:=0A=
 	system_printf ("internal error -- unknown device - %p", dev);=0A=
 	fh =3D NULL;=0A=
@@ -380,7 +389,9 @@ dtable::build_fhandler (int fd, DWORD de=0A=
 	  for (p =3D (char *) win32_name; (p =3D strchr (p, '/')); p++)=0A=
 	    *p =3D '\\';=0A=
 	}=0A=
-      fh->set_name (unix_name, win32_name, fh->get_unit ());=0A=
+      char normalized_path[MAX_PATH];=0A=
+      normalize_posix_path (unix_name, normalized_path);=0A=
+      fh->set_name (normalized_path, win32_name, fh->get_unit ());=0A=
     }=0A=
   debug_printf ("fd %d, fh %p", fd, fh);=0A=
   return fd >=3D 0 ? (fds[fd] =3D fh) : fh;=0A=
Index: fhandler.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v=0A=
retrieving revision 1.112=0A=
diff -u -3 -p -u -p -a -b -B -r1.112 fhandler.cc=0A=
--- fhandler.cc	2002/02/19 22:06:50	1.112=0A=
+++ fhandler.cc	2002/02/27 23:49:56=0A=
@@ -147,7 +147,8 @@ fhandler_base::get_readahead_into_buffer=0A=
 /* Record the file name.=0A=
    Filenames are used mostly for debugging messages, and it's hoped that=
=0A=
    in cases where the name is really required, the filename wouldn't ever=
=0A=
-   be too long (e.g. devices or some such).  */=0A=
+   be too long (e.g. devices or some such).=0A=
+   The unix_path_name is also used by virtual fhandlers.  */=0A=
 void=0A=
 fhandler_base::set_name (const char *unix_path, const char *win32_path, in=
t unit)=0A=
 {=0A=
Index: fhandler.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v=0A=
retrieving revision 1.108=0A=
diff -u -3 -p -u -p -a -b -B -r1.108 fhandler.h=0A=
--- fhandler.h	2002/02/10 13:38:48	1.108=0A=
+++ fhandler.h	2002/02/27 23:49:59=0A=
@@ -70,8 +70,11 @@ enum=0A=
   FH_CLIPBOARD =3D 0x00000017,	/* is a clipboard device */=0A=
   FH_OSS_DSP =3D 0x00000018,	/* is a dsp audio device */=0A=
   FH_CYGDRIVE=3D 0x00000019,	/* /cygdrive/x */=0A=
+  FH_PROC    =3D 0x0000001a,      /* /proc */=0A=
+  FH_REGISTRY =3D0x0000001b,      /* /proc/registry */=0A=
+  FH_PROCESS =3D 0x0000001c,      /* /proc/<n> */=0A=
=20=0A=
-  FH_NDEV    =3D 0x0000001a,	/* Maximum number of devices */=0A=
+  FH_NDEV    =3D 0x0000001d,      /* Maximum number of devices */=0A=
   FH_DEVMASK =3D 0x00000fff,	/* devices live here */=0A=
   FH_BAD     =3D 0xffffffff=0A=
 };=0A=
@@ -100,6 +103,8 @@ enum=0A=
 extern const char *windows_device_names[];=0A=
 extern struct __cygwin_perfile *perfile_table;=0A=
 #define __fmode (*(user_data->fmode_ptr))=0A=
+extern const char proc[];=0A=
+extern const int proc_len;=0A=
=20=0A=
 class select_record;=0A=
 class path_conv;=0A=
@@ -1028,6 +1033,74 @@ class fhandler_dev_dsp : public fhandler=0A=
   void fixup_after_exec (HANDLE);=0A=
 };=0A=
=20=0A=
+class fhandler_virtual : public fhandler_base=0A=
+{=0A=
+ protected:=0A=
+  char *filebuf;=0A=
+  int bufalloc, filesize;=0A=
+  __off32_t position;=0A=
+ public:=0A=
+=0A=
+  fhandler_virtual (DWORD devtype);=0A=
+  virtual ~fhandler_virtual();=0A=
+=0A=
+  virtual int exists(const char *path);=0A=
+  DIR *opendir (path_conv& pc);=0A=
+  virtual DIR *opendir(const char *path);=0A=
+  __off32_t telldir (DIR *);=0A=
+  void seekdir (DIR *, __off32_t);=0A=
+  void rewinddir (DIR *);=0A=
+  int closedir (DIR *);=0A=
+  int write (const void *ptr, size_t len);=0A=
+  int __stdcall read (void *ptr, size_t len) __attribute__ ((regparm (3)))=
;=0A=
+  __off32_t lseek (__off32_t, int);=0A=
+  int dup (fhandler_base * child);=0A=
+  int open (path_conv *, int flags, mode_t mode =3D 0);=0A=
+  virtual int open(const char *path, int flags, mode_t mode);=0A=
+  int close (void);=0A=
+  virtual int fstat (const char *path, struct stat *buf);=0A=
+  int __stdcall fstat (struct stat *buf, path_conv *pc) __attribute__ ((re=
gparm (3)));=0A=
+};=0A=
+=0A=
+class fhandler_proc: public fhandler_virtual=0A=
+{=0A=
+ public:=0A=
+  fhandler_proc ();=0A=
+  fhandler_proc (DWORD devtype);=0A=
+  int exists(const char *path);=0A=
+  struct dirent *readdir (DIR *);=0A=
+  int fstat (const char *path, struct stat *buf);=0A=
+  int open(const char *path, int flags, mode_t mode);=0A=
+=0A=
+  static DWORD get_proc_fhandler(const char *path);=0A=
+};=0A=
+=0A=
+class fhandler_registry: public fhandler_proc=0A=
+{=0A=
+ public:=0A=
+  fhandler_registry ();=0A=
+  int exists(const char *path);=0A=
+  struct dirent *readdir (DIR *);=0A=
+  __off32_t telldir (DIR *);=0A=
+  void seekdir (DIR *, __off32_t);=0A=
+  void rewinddir (DIR *);=0A=
+  int closedir (DIR *);=0A=
+  virtual int fstat (const char *path, struct stat *buf);=0A=
+  int open (const char *path, int flags, mode_t mode =3D 0);=0A=
+=0A=
+  static HKEY open_key(const char *name, REGSAM access =3D KEY_READ, bool =
isValue =3D false);=0A=
+};=0A=
+=0A=
+class fhandler_process: public fhandler_proc=0A=
+{=0A=
+ public:=0A=
+  fhandler_process ();=0A=
+  int exists(const char *path);=0A=
+  struct dirent *readdir (DIR *);=0A=
+  virtual int fstat (const char *path, struct stat *buf);=0A=
+  int open (const char *path, int flags, mode_t mode =3D 0);=0A=
+};=0A=
+=0A=
 typedef union=0A=
 {=0A=
   char base[sizeof(fhandler_base)];=0A=
@@ -1043,7 +1116,10 @@ typedef union=0A=
   char dev_zero[sizeof(fhandler_dev_zero)];=0A=
   char disk_file[sizeof(fhandler_disk_file)];=0A=
   char pipe[sizeof(fhandler_pipe)];=0A=
+  char proc[sizeof(fhandler_proc)];=0A=
+  char process[sizeof(fhandler_process)];=0A=
   char pty_master[sizeof(fhandler_pty_master)];=0A=
+  char registry[sizeof(fhandler_registry)];=0A=
   char serial[sizeof(fhandler_serial)];=0A=
   char socket[sizeof(fhandler_socket)];=0A=
   char termios[sizeof(fhandler_termios)];=0A=
Index: path.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v=0A=
retrieving revision 1.198=0A=
diff -u -3 -p -u -p -a -b -B -r1.198 path.cc=0A=
--- path.cc	2002/02/22 19:33:41	1.198=0A=
+++ path.cc	2002/02/27 23:50:09=0A=
@@ -118,6 +118,12 @@ int pcheck_case =3D PCHECK_RELAXED; /* Det=0A=
    (isdirsep(path[mount_table->cygdrive_len + 1]) || \=0A=
     !path[mount_table->cygdrive_len + 1]))=0A=
=20=0A=
+#define isproc(path) \=0A=
+  (path_prefix_p (proc, (path), proc_len))=0A=
+=0A=
+#define isvirtual_dev(devn) \=0A=
+  (devn =3D=3D FH_CYGDRIVE || devn =3D=3D FH_PROC || devn =3D=3D FH_REGIST=
RY || devn =3D=3D FH_PROCESS)=0A=
+=0A=
 /* Return non-zero if PATH1 is a prefix of PATH2.=0A=
    Both are assumed to be of the same path style and / vs \ usage.=0A=
    Neither may be "".=0A=
@@ -490,6 +496,24 @@ path_conv::check (const char *src, unsig=0A=
 		}=0A=
 	      goto out;=0A=
 	    }=0A=
+          else if (isvirtual_dev (devn))=0A=
+            {=0A=
+              fhandler_virtual *fh =3D=0A=
+                (fhandler_virtual *) cygheap->fdtab.build_fhandler (-1, de=
vn, path_copy, NULL, unit);=0A=
+              int file_type =3D fh->exists (path_copy);=0A=
+              switch (file_type)=0A=
+                {=0A=
+                  case 0:=0A=
+                    error =3D ENOENT;=0A=
+                  case 1:=0A=
+                  case 2:=0A=
+                    fileattr =3D FILE_ATTRIBUTE_DIRECTORY;=0A=
+                  case -1:=0A=
+                    fileattr =3D 0;=0A=
+                }=0A=
+              delete fh;=0A=
+              return;=0A=
+            }=0A=
 	  /* devn should not be a device.  If it is, then stop parsing now. */=0A=
 	  else if (devn !=3D FH_BAD)=0A=
 	    {=0A=
@@ -1405,6 +1429,14 @@ mount_info::conv_to_win32_path (const ch=0A=
       else if (mount_table->cygdrive_len > 1)=0A=
 	return ENOENT;=0A=
     }=0A=
+  if (isproc (pathbuf))=0A=
+    {=0A=
+      devn =3D fhandler_proc::get_proc_fhandler (pathbuf);=0A=
+      dst[0] =3D '\0';=0A=
+      if (devn =3D=3D FH_BAD)=0A=
+        return ENOENT;=0A=
+      goto out;=0A=
+    }=0A=
=20=0A=
   int chrooted_path_len;=0A=
   chrooted_path_len =3D 0;=0A=
@@ -1472,7 +1504,7 @@ mount_info::conv_to_win32_path (const ch=0A=
       *flags =3D mi->flags;=0A=
     }=0A=
=20=0A=
-  if (devn !=3D FH_CYGDRIVE)=0A=
+  if (!isvirtual_dev (devn))=0A=
     win32_device_name (src_path, dst, devn, unit);=0A=
=20=0A=
  out:=0A=
@@ -3233,7 +3265,8 @@ chdir (const char *in_dir)=0A=
       path.get_win32 ()[3] =3D '\0';=0A=
     }=0A=
   int res;=0A=
-  if (path.get_devn () !=3D FH_CYGDRIVE)=0A=
+  int devn =3D path.get_devn();=0A=
+  if (!isvirtual_dev (devn))=0A=
     res =3D SetCurrentDirectory (native_dir) ? 0 : -1;=0A=
   else=0A=
     {=0A=
@@ -3253,8 +3286,8 @@ chdir (const char *in_dir)=0A=
      we'll see if Cygwin mailing list users whine about the current behavi=
or. */=0A=
   if (res =3D=3D -1)=0A=
     __seterrno ();=0A=
-  else if (!path.has_symlinks () && strpbrk (dir, ":\\") =3D=3D NULL=0A=
-	   && pcheck_case =3D=3D PCHECK_RELAXED)=0A=
+  else if ((!path.has_symlinks () && strpbrk (dir, ":\\") =3D=3D NULL=0A=
+            && pcheck_case =3D=3D PCHECK_RELAXED) || isvirtual_dev (devn))=
=0A=
     cygheap->cwd.set (native_dir, dir);=0A=
   else=0A=
     cygheap->cwd.set (native_dir, NULL);=0A=
Index: path.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/path.h,v=0A=
retrieving revision 1.37=0A=
diff -u -3 -p -u -p -a -b -B -r1.37 path.h=0A=
--- path.h	2002/01/14 20:39:59	1.37=0A=
+++ path.h	2002/02/27 23:50:10=0A=
@@ -178,3 +178,6 @@ has_exec_chars (const char *buf, int len=0A=
=20=0A=
 int pathmatch (const char *path1, const char *path2) __attribute__ ((regpa=
rm (2)));=0A=
 int pathnmatch (const char *path1, const char *path2, int len) __attribute=
__ ((regparm (2)));=0A=
+=0A=
+int path_prefix_p (const char *path1, const char *path2, int len1) __attri=
bute__ ((regparm (3)));=0A=
+int normalize_posix_path (const char *src, char *dst);=0A=
--- /dev/null	Wed Feb 27 23:52:27 2002=0A=
+++ fhandler_proc.cc	Wed Feb 27 23:06:09 2002=0A=
@@ -0,0 +1,302 @@=0A=
+/* fhandler_proc.cc: fhandler for /proc virtual filesystem=0A=
+=0A=
+   Copyright 2002 Red Hat, Inc.=0A=
+=0A=
+This file is part of Cygwin.=0A=
+=0A=
+This software is a copyrighted work licensed under the terms of the=0A=
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
+details. */=0A=
+=0A=
+#include "winsup.h"=0A=
+#include <sys/fcntl.h>=0A=
+#include <errno.h>=0A=
+#include <unistd.h>=0A=
+#include <stdlib.h>=0A=
+#include <sys/cygwin.h>=0A=
+#include "cygerrno.h"=0A=
+#include "security.h"=0A=
+#include "fhandler.h"=0A=
+#include "path.h"=0A=
+#include "sigproc.h"=0A=
+#include "pinfo.h"=0A=
+#include <assert.h>=0A=
+#include <sys/utsname.h>=0A=
+=0A=
+#define _COMPILING_NEWLIB=0A=
+#include <dirent.h>=0A=
+=0A=
+/* offsets in proc_listing */=0A=
+static const int PROC_REGISTRY =3D 0;     // /proc/registry=0A=
+static const int PROC_VERSION =3D 1;      // /proc/version=0A=
+static const int PROC_UPTIME =3D 2;       // /proc/uptime=0A=
+=0A=
+/* names of objects in /proc */=0A=
+static const char *proc_listing[] =3D {=0A=
+  "registry",=0A=
+  "version",=0A=
+  "uptime",=0A=
+  NULL=0A=
+};=0A=
+=0A=
+static const int PROC_LINK_COUNT =3D (sizeof(proc_listing) / sizeof(const =
char *)) - 1;=0A=
+=0A=
+/* FH_PROC in the table below means the file/directory is handles by=0A=
+ * fhandler_proc.=0A=
+ */=0A=
+static const DWORD proc_fhandlers[] =3D {=0A=
+  FH_REGISTRY,=0A=
+  FH_PROC,=0A=
+  FH_PROC=0A=
+};=0A=
+=0A=
+/* name of the /proc filesystem */=0A=
+const char proc[] =3D "/proc";=0A=
+const int proc_len =3D sizeof (proc) - 1;=0A=
+=0A=
+/* auxillary function that returns the fhandler associated with the given =
path=0A=
+ * this is where it would be nice to have pattern matching in C - polymorp=
hism=0A=
+ * just doesn't cut it=0A=
+ */=0A=
+DWORD=0A=
+fhandler_proc::get_proc_fhandler (const char *path)=0A=
+{=0A=
+  debug_printf ("get_proc_fhandler(%s)", path);=0A=
+  path +=3D proc_len;=0A=
+  /* Since this method is called from path_conv::check we can't rely on=0A=
+   * it being normalised and therefore the path may have runs of slashes=
=0A=
+   * in it.=0A=
+   */=0A=
+  while (SLASH_P (*path))=0A=
+    path++;=0A=
+=0A=
+  /* Check if this is the root of the virtual filesystem (i.e. /proc).  */=
=0A=
+  if (*path =3D=3D 0)=0A=
+    return FH_PROC;=0A=
+=0A=
+  for (int i =3D 0; proc_listing[i]; i++)=0A=
+    {=0A=
+      if (path_prefix_p (proc_listing[i], path, strlen (proc_listing[i])))=
=0A=
+        return proc_fhandlers[i];=0A=
+    }=0A=
+=0A=
+  int pid =3D atoi (path);=0A=
+  winpids pids;=0A=
+  for (unsigned i =3D 0; i < pids.npids; i++)=0A=
+    {=0A=
+      _pinfo *p =3D pids[i];=0A=
+=0A=
+      if (!proc_exists (p))=0A=
+        continue;=0A=
+=0A=
+      if (p->pid =3D=3D pid)=0A=
+        return FH_PROCESS;=0A=
+    }=0A=
+  return FH_BAD;=0A=
+}=0A=
+=0A=
+/* Returns 0 if path doesn't exist, >0 if path is a directory,=0A=
+ * <0 if path is a file.=0A=
+ */=0A=
+int=0A=
+fhandler_proc::exists (const char *path)=0A=
+{=0A=
+  debug_printf ("exists (%s)", path);=0A=
+  path +=3D proc_len;=0A=
+  if (*path =3D=3D 0)=0A=
+    return 2;=0A=
+  for (int i =3D 0; proc_listing[i]; i++)=0A=
+    if (pathmatch (path + 1, proc_listing[i]))=0A=
+      return (proc_fhandlers[i] =3D=3D FH_PROC) ? -1 : 1;=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+fhandler_proc::fhandler_proc ():=0A=
+  fhandler_virtual (FH_PROC)=0A=
+{=0A=
+}=0A=
+=0A=
+fhandler_proc::fhandler_proc (DWORD devtype):=0A=
+  fhandler_virtual (devtype)=0A=
+{=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_proc::fstat (const char *path, struct stat *buf)=0A=
+{=0A=
+  debug_printf ("fstat (%s)", path);=0A=
+  path +=3D proc_len;=0A=
+  if (*path =3D=3D 0)=0A=
+    {=0A=
+      buf->st_mode =3D S_IFDIR | 0555;=0A=
+      buf->st_nlink =3D PROC_LINK_COUNT;=0A=
+      return 0;=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      for (int i =3D 0; proc_listing[i]; i++)=0A=
+        if (pathmatch (path + 1, proc_listing[i]))=0A=
+          {=0A=
+            buf->st_mode =3D=0A=
+              (proc_fhandlers[i] =3D=3D=0A=
+               FH_PROC) ? (S_IFREG | 0444) : (S_IFDIR | 0555);=0A=
+            buf->st_nlink =3D 1;=0A=
+            return 0;=0A=
+          }=0A=
+    }=0A=
+  set_errno (ENOENT);=0A=
+  return -1;=0A=
+}=0A=
+=0A=
+struct dirent *=0A=
+fhandler_proc::readdir (DIR * dir)=0A=
+{=0A=
+  if (dir->__d_position >=3D PROC_LINK_COUNT)=0A=
+    {=0A=
+      winpids pids;=0A=
+      int found =3D 0;=0A=
+      for (unsigned i =3D 0; i < pids.npids; i++)=0A=
+        {=0A=
+          _pinfo *p =3D pids[i];=0A=
+=0A=
+          if (!proc_exists (p))=0A=
+            continue;=0A=
+=0A=
+          if (found =3D=3D dir->__d_position - PROC_LINK_COUNT)=0A=
+            {=0A=
+              __small_sprintf (dir->__d_dirent->d_name, "%d", p->pid);=0A=
+              dir->__d_position++;=0A=
+              return dir->__d_dirent;=0A=
+            }=0A=
+          found++;=0A=
+        }=0A=
+      return NULL;=0A=
+    }=0A=
+=0A=
+  strcpy (dir->__d_dirent->d_name, proc_listing[dir->__d_position++]);=0A=
+  syscall_printf ("%p =3D readdir (%p) (%s)", &dir->__d_dirent, dir,=0A=
+                  dir->__d_dirent->d_name);=0A=
+  return dir->__d_dirent;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_proc::open (const char *path, int flags, mode_t mode)=0A=
+{=0A=
+  int proc_file_no =3D -1;=0A=
+=0A=
+  int res =3D fhandler_virtual::open (path, flags, mode);=0A=
+  if (!res)=0A=
+    goto out;=0A=
+=0A=
+  path +=3D proc_len;=0A=
+=0A=
+  if (*path =3D=3D 0)=0A=
+    {=0A=
+      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+        {=0A=
+          set_errno (EEXIST);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else if (mode & O_WRONLY)=0A=
+        {=0A=
+          set_errno (EISDIR);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          flags |=3D O_DIROPEN;=0A=
+          goto success;=0A=
+        }=0A=
+    }=0A=
+=0A=
+  proc_file_no =3D -1;=0A=
+  for (int i =3D 0; proc_listing[i]; i++)=0A=
+    if (path_prefix_p (proc_listing[i], path + 1, strlen (proc_listing[i])=
))=0A=
+      {=0A=
+        proc_file_no =3D i;=0A=
+        if (proc_fhandlers[i] !=3D FH_PROC)=0A=
+          {=0A=
+            if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+              {=0A=
+                set_errno (EEXIST);=0A=
+                res =3D 0;=0A=
+                goto out;=0A=
+              }=0A=
+            else if (mode & O_WRONLY)=0A=
+              {=0A=
+                set_errno (EISDIR);=0A=
+                res =3D 0;=0A=
+                goto out;=0A=
+              }=0A=
+            else=0A=
+              {=0A=
+                flags |=3D O_DIROPEN;=0A=
+                goto success;=0A=
+              }=0A=
+          }=0A=
+      }=0A=
+=0A=
+  if (proc_file_no =3D=3D -1)=0A=
+    {=0A=
+      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+        {=0A=
+          set_errno (EROFS);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          set_errno (ENOENT);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+    }=0A=
+  if (mode & O_WRONLY)=0A=
+    {=0A=
+      set_errno (EROFS);=0A=
+      res =3D 0;=0A=
+      goto out;=0A=
+    }=0A=
+  switch (proc_file_no)=0A=
+    {=0A=
+    case PROC_VERSION:=0A=
+      {=0A=
+        struct utsname uts_name;=0A=
+        uname (&uts_name);=0A=
+        filesize =3D bufalloc =3D strlen (uts_name.sysname) + 1 +=0A=
+          strlen (uts_name.release) + 1 + strlen (uts_name.version) + 2;=
=0A=
+        filebuf =3D new char[bufalloc];=0A=
+        __small_sprintf (filebuf, "%s %s %s\n", uts_name.sysname,=0A=
+                         uts_name.release, uts_name.version);=0A=
+        break;=0A=
+      }=0A=
+    case PROC_UPTIME:=0A=
+      {=0A=
+        /* GetTickCount() wraps after 49 days - on WinNT/2000/XP, should u=
se=0A=
+         * perfomance counters but I don't know Redhat's policy on=0A=
+         * NT only dependancies.=0A=
+         */=0A=
+        DWORD ticks =3D GetTickCount ();=0A=
+        filebuf =3D new char[bufalloc =3D 40];=0A=
+        __small_sprintf (filebuf, "%d.%02d\n", ticks / 1000,=0A=
+                         (ticks / 10) % 100);=0A=
+        filesize =3D strlen (filebuf);=0A=
+        break;=0A=
+      }=0A=
+    }=0A=
+=0A=
+  if (flags & O_APPEND)=0A=
+    position =3D filesize;=0A=
+  else=0A=
+    position =3D 0;=0A=
+=0A=
+success:=0A=
+  res =3D 1;=0A=
+  set_open_status ();=0A=
+  set_flags (flags);=0A=
+out:=0A=
+  syscall_printf ("%d =3D fhandler_proc::open (%p, %d)", res, flags, mode)=
;=0A=
+  return res;=0A=
+}=0A=
--- /dev/null	Wed Feb 27 23:52:27 2002=0A=
+++ fhandler_process.cc	Wed Feb 27 23:02:51 2002=0A=
@@ -0,0 +1,291 @@=0A=
+/* fhandler_process.cc: fhandler for /proc/<pid> virtual filesystem=0A=
+=0A=
+   Copyright 2002 Red Hat, Inc.=0A=
+=0A=
+This file is part of Cygwin.=0A=
+=0A=
+This software is a copyrighted work licensed under the terms of the=0A=
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
+details. */=0A=
+=0A=
+#include "winsup.h"=0A=
+#include <sys/fcntl.h>=0A=
+#include <errno.h>=0A=
+#include <unistd.h>=0A=
+#include <stdlib.h>=0A=
+#include <sys/cygwin.h>=0A=
+#include "cygerrno.h"=0A=
+#include "security.h"=0A=
+#include "fhandler.h"=0A=
+#include "sigproc.h"=0A=
+#include "pinfo.h"=0A=
+#include "path.h"=0A=
+#include "shared_info.h"=0A=
+#include <assert.h>=0A=
+=0A=
+#define _COMPILING_NEWLIB=0A=
+#include <dirent.h>=0A=
+=0A=
+static const int PROCESS_PPID =3D 0;=0A=
+static const int PROCESS_EXENAME =3D 1;=0A=
+static const int PROCESS_WINPID =3D 2;=0A=
+static const int PROCESS_WINEXENAME =3D 3;=0A=
+static const int PROCESS_STATUS =3D 4;=0A=
+static const int PROCESS_UID =3D 5;=0A=
+static const int PROCESS_GID =3D 6;=0A=
+static const int PROCESS_PGID =3D 7;=0A=
+static const int PROCESS_SID =3D 8;=0A=
+static const int PROCESS_CTTY =3D 9;=0A=
+=0A=
+static const char *process_listing[] =3D {=0A=
+  "ppid",=0A=
+  "exename",=0A=
+  "winpid",=0A=
+  "winexename",=0A=
+  "status",=0A=
+  "uid",=0A=
+  "gid",=0A=
+  "pgid",=0A=
+  "sid",=0A=
+  "ctty",=0A=
+  NULL=0A=
+};=0A=
+=0A=
+static const int PROCESS_LINK_COUNT =3D (sizeof(process_listing) / sizeof(=
const char *)) - 1;=0A=
+=0A=
+/* Returns 0 if path doesn't exist, >0 if path is a directory,=0A=
+ * <0 if path is a file.=0A=
+ */=0A=
+int=0A=
+fhandler_process::exists (const char *path)=0A=
+{=0A=
+  debug_printf ("exists (%s)", path);=0A=
+  path +=3D proc_len + 1;=0A=
+  while (*path !=3D 0 && !SLASH_P (*path))=0A=
+    path++;=0A=
+  if (*path =3D=3D 0)=0A=
+    return 2;=0A=
+=0A=
+  for (int i =3D 0; process_listing[i]; i++)=0A=
+    if (pathmatch (path + 1, process_listing[i]))=0A=
+      return -1;=0A=
+  return 1;=0A=
+}=0A=
+=0A=
+fhandler_process::fhandler_process ():=0A=
+  fhandler_proc (FH_PROCESS)=0A=
+{=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_process::fstat (const char *path, struct stat *buf)=0A=
+{=0A=
+  int file_type =3D exists (path);=0A=
+  switch (file_type)=0A=
+    {=0A=
+    case 0:=0A=
+      set_errno (ENOENT);=0A=
+      return -1;=0A=
+    case 1:=0A=
+      buf->st_mode =3D S_IFDIR | 0555;=0A=
+      buf->st_nlink =3D 1;=0A=
+      return 0;=0A=
+    case 2:=0A=
+      buf->st_mode =3D S_IFDIR | 0555;=0A=
+      buf->st_nlink =3D PROCESS_LINK_COUNT;=0A=
+      return 0;=0A=
+    case -1:=0A=
+      buf->st_mode =3D S_IFREG | 0444;=0A=
+      buf->st_nlink =3D 1;=0A=
+      return 0;=0A=
+    }=0A=
+}=0A=
+=0A=
+struct dirent *=0A=
+fhandler_process::readdir (DIR * dir)=0A=
+{=0A=
+  if (dir->__d_position >=3D PROCESS_LINK_COUNT)=0A=
+    return NULL;=0A=
+  strcpy (dir->__d_dirent->d_name, process_listing[dir->__d_position++]);=
=0A=
+  syscall_printf ("%p =3D readdir (%p) (%s)", &dir->__d_dirent, dir,=0A=
+                  dir->__d_dirent->d_name);=0A=
+  return dir->__d_dirent;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_process::open (const char *path, int flags, mode_t mode)=0A=
+{=0A=
+  int process_file_no =3D -1, pid;=0A=
+  winpids pids;=0A=
+  _pinfo *p;=0A=
+=0A=
+  int res =3D fhandler_virtual::open (path, flags, mode);=0A=
+  if (!res)=0A=
+    goto out;=0A=
+=0A=
+  path +=3D proc_len + 1;=0A=
+  pid =3D atoi (path);=0A=
+  while (*path !=3D 0 && !SLASH_P (*path))=0A=
+    path++;=0A=
+=0A=
+  if (*path =3D=3D 0)=0A=
+    {=0A=
+      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+        {=0A=
+          set_errno (EEXIST);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else if (mode & O_WRONLY)=0A=
+        {=0A=
+          set_errno (EISDIR);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          flags |=3D O_DIROPEN;=0A=
+          goto success;=0A=
+        }=0A=
+    }=0A=
+=0A=
+  process_file_no =3D -1;=0A=
+  for (int i =3D 0; process_listing[i]; i++)=0A=
+    {=0A=
+      if (path_prefix_p=0A=
+          (process_listing[i], path + 1, strlen (process_listing[i])))=0A=
+        process_file_no =3D i;=0A=
+    }=0A=
+  if (process_file_no =3D=3D -1)=0A=
+    {=0A=
+      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+        {=0A=
+          set_errno (EROFS);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          set_errno (ENOENT);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+    }=0A=
+  if (mode & O_WRONLY)=0A=
+    {=0A=
+      set_errno (EROFS);=0A=
+      res =3D 0;=0A=
+      goto out;=0A=
+    }=0A=
+  for (unsigned i =3D 0; i < pids.npids; i++)=0A=
+    {=0A=
+      p =3D pids[i];=0A=
+=0A=
+      if (!proc_exists (p))=0A=
+        continue;=0A=
+=0A=
+      if (p->pid =3D=3D pid)=0A=
+        goto found;=0A=
+    }=0A=
+  set_errno (ENOENT);=0A=
+  res =3D 0;=0A=
+  goto out;=0A=
+found:=0A=
+  switch (process_file_no)=0A=
+    {=0A=
+    case PROCESS_UID:=0A=
+    case PROCESS_GID:=0A=
+    case PROCESS_PGID:=0A=
+    case PROCESS_SID:=0A=
+    case PROCESS_CTTY:=0A=
+    case PROCESS_PPID:=0A=
+      {=0A=
+        filebuf =3D new char[bufalloc =3D 40];=0A=
+        int num;=0A=
+        switch (process_file_no)=0A=
+          {=0A=
+          case PROCESS_PPID:=0A=
+            num =3D p->ppid;=0A=
+            break;=0A=
+          case PROCESS_UID:=0A=
+            num =3D p->uid;=0A=
+            break;=0A=
+          case PROCESS_PGID:=0A=
+            num =3D p->pgid;=0A=
+            break;=0A=
+          case PROCESS_SID:=0A=
+            num =3D p->sid;=0A=
+            break;=0A=
+          case PROCESS_CTTY:=0A=
+            num =3D p->ctty;=0A=
+            break;=0A=
+          }=0A=
+        __small_sprintf (filebuf, "%d\n", num);=0A=
+        filesize =3D strlen (filebuf);=0A=
+        break;=0A=
+      }=0A=
+    case PROCESS_EXENAME:=0A=
+      {=0A=
+        filebuf =3D new char[bufalloc =3D MAX_PATH];=0A=
+        if (p->process_state & (PID_ZOMBIE | PID_EXITED))=0A=
+          strcpy (filebuf, "<defunct>");=0A=
+        else=0A=
+          {=0A=
+            mount_table->conv_to_posix_path (p->progname, filebuf, 1);=0A=
+            int len =3D strlen (filebuf);=0A=
+            if (len > 4)=0A=
+              {=0A=
+                char *s =3D filebuf + len - 4;=0A=
+                if (strcasecmp (s, ".exe") =3D=3D 0)=0A=
+                  *s =3D 0;=0A=
+              }=0A=
+          }=0A=
+        filesize =3D strlen (filebuf);=0A=
+        break;=0A=
+      }=0A=
+    case PROCESS_WINPID:=0A=
+      {=0A=
+        filebuf =3D new char[bufalloc =3D 40];=0A=
+        __small_sprintf (filebuf, "%d\n", p->dwProcessId);=0A=
+        filesize =3D strlen (filebuf);=0A=
+        break;=0A=
+      }=0A=
+    case PROCESS_WINEXENAME:=0A=
+      {=0A=
+        int len =3D strlen (p->progname);=0A=
+        filebuf =3D new char[len + 2];=0A=
+        strcpy (filebuf, p->progname);=0A=
+        filebuf[len] =3D '\n';=0A=
+        filesize =3D len + 1;=0A=
+        break;=0A=
+      }=0A=
+    case PROCESS_STATUS:=0A=
+      {=0A=
+        filebuf =3D new char[bufalloc =3D 3];=0A=
+        filebuf[0] =3D ' ';=0A=
+        filebuf[1] =3D '\n';=0A=
+        filebuf[2] =3D 0;=0A=
+        if (p->process_state & PID_STOPPED)=0A=
+          filebuf[0] =3D 'S';=0A=
+        else if (p->process_state & PID_TTYIN)=0A=
+          filebuf[0] =3D 'I';=0A=
+        else if (p->process_state & PID_TTYOU)=0A=
+          filebuf[0] =3D 'O';=0A=
+        filesize =3D 2;=0A=
+        break;=0A=
+      }=0A=
+    }=0A=
+=0A=
+  if (flags & O_APPEND)=0A=
+    position =3D filesize;=0A=
+  else=0A=
+    position =3D 0;=0A=
+=0A=
+success:=0A=
+  res =3D 1;=0A=
+  set_open_status ();=0A=
+  set_flags (flags);=0A=
+out:=0A=
+  syscall_printf ("%d =3D fhandler_proc::open (%p, %d)", res, flags, mode)=
;=0A=
+  return res;=0A=
+}=0A=
--- /dev/null	Wed Feb 27 23:52:27 2002=0A=
+++ fhandler_registry.cc	Wed Feb 27 23:39:31 2002=0A=
@@ -0,0 +1,508 @@=0A=
+/* fhandler_registry.cc: fhandler for /proc/registry virtual filesystem=0A=
+=0A=
+   Copyright 2002 Red Hat, Inc.=0A=
+=0A=
+This file is part of Cygwin.=0A=
+=0A=
+This software is a copyrighted work licensed under the terms of the=0A=
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
+details. */=0A=
+=0A=
+/* FIXME: Access permissions are ignored at the moment.  */=0A=
+=0A=
+#include "winsup.h"=0A=
+#include <sys/fcntl.h>=0A=
+#include <errno.h>=0A=
+#include <unistd.h>=0A=
+#include <stdlib.h>=0A=
+#include <sys/cygwin.h>=0A=
+#include "cygerrno.h"=0A=
+#include "security.h"=0A=
+#include "fhandler.h"=0A=
+#include "path.h"=0A=
+#include <assert.h>=0A=
+=0A=
+#define _COMPILING_NEWLIB=0A=
+#include <dirent.h>=0A=
+=0A=
+static const int registry_len =3D sizeof ("registry") - 1;=0A=
+/* If this bit is set in __d_position then we are enumerating values,=0A=
+ * else sub-keys. keeping track of where we are is horribly messy=0A=
+ * the bottom 16 bits are the absolute position and the top 15 bits=0A=
+ * make up the value index if we are enuerating values.=0A=
+ */=0A=
+static const __off32_t REG_ENUM_VALUES_MASK =3D 0x8000000;=0A=
+=0A=
+/* List of root keys in /proc/registry.=0A=
+ * Possibly we should filter out those not relevant to the flavour of Wind=
ows=0A=
+ * Cygwin is running on.=0A=
+ */=0A=
+static const char *registry_listing[] =3D {=0A=
+  "HKEY_CLASSES_ROOT",=0A=
+  "HKEY_CURRENT_CONFIG",=0A=
+  "HKEY_CURRENT_USER",=0A=
+  "HKEY_LOCAL_MACHINE",=0A=
+  "HKEY_USERS",=0A=
+  "HKEY_DYN_DATA",              // 95/98/Me=0A=
+  "HKEY_PERFOMANCE_DATA",       // NT/2000/XP=0A=
+  NULL=0A=
+};=0A=
+=0A=
+static const HKEY registry_keys[] =3D {=0A=
+  HKEY_CLASSES_ROOT,=0A=
+  HKEY_CURRENT_CONFIG,=0A=
+  HKEY_CURRENT_USER,=0A=
+  HKEY_LOCAL_MACHINE,=0A=
+  HKEY_USERS,=0A=
+  HKEY_DYN_DATA,=0A=
+  HKEY_PERFORMANCE_DATA=0A=
+};=0A=
+=0A=
+static const int ROOT_KEY_COUNT =3D sizeof(registry_keys) / sizeof(HKEY);=
=0A=
+=0A=
+/* Name given to default values */=0A=
+static const char *DEFAULT_VALUE_NAME =3D "@";=0A=
+=0A=
+/* Returns 0 if path doesn't exist, >0 if path is a directory,=0A=
+ * <0 if path is a file.=0A=
+ *=0A=
+ * We open the last key but one and then enum it's sub-keys and values to =
see if the=0A=
+ * final component is there. This gets round the problem of not having sec=
urity access=0A=
+ * to the final key in the path.=0A=
+ */=0A=
+int=0A=
+fhandler_registry::exists (const char *path)=0A=
+{=0A=
+  int file_type =3D 0, index =3D 0, pathlen;=0A=
+  DWORD buf_size =3D MAX_PATH;=0A=
+  LONG error;=0A=
+  char buf[buf_size];=0A=
+  const char *file;=0A=
+  HKEY hKey =3D (HKEY) INVALID_HANDLE_VALUE;=0A=
+=0A=
+  debug_printf ("exists (%s)", path);=0A=
+  path +=3D proc_len + 1 + registry_len;=0A=
+=0A=
+  while (SLASH_P (*path))=0A=
+    path++;=0A=
+  if (*path =3D=3D 0)=0A=
+    {=0A=
+      file_type =3D 2;=0A=
+      goto out;=0A=
+    }=0A=
+  pathlen =3D strlen (path);=0A=
+  file =3D path + pathlen - 1;=0A=
+  if (SLASH_P (*file) && pathlen > 1)=0A=
+    file--;=0A=
+  while (!SLASH_P (*file))=0A=
+    file--;=0A=
+  file++;=0A=
+=0A=
+  if (file =3D=3D path)=0A=
+    {=0A=
+      for (int i =3D 0; registry_listing[i]; i++)=0A=
+        if (path_prefix_p=0A=
+            (registry_listing[i], path, strlen (registry_listing[i])))=0A=
+          {=0A=
+            file_type =3D 1;=0A=
+            goto out;=0A=
+          }=0A=
+      goto out;=0A=
+    }=0A=
+=0A=
+  hKey =3D open_key (path, KEY_READ, true);=0A=
+  if (hKey =3D=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+    return 0;=0A=
+=0A=
+  while (ERROR_SUCCESS =3D=3D=0A=
+         (error =3D RegEnumKeyEx (hKey, index++, buf, &buf_size, NULL, NUL=
L,=0A=
+                                NULL, NULL)) || (error =3D=3D ERROR_MORE_D=
ATA))=0A=
+    {=0A=
+      if (pathmatch (buf, file))=0A=
+        {=0A=
+          file_type =3D 1;=0A=
+          goto out;=0A=
+        }=0A=
+      buf_size =3D MAX_PATH;=0A=
+    }=0A=
+  if (error !=3D ERROR_NO_MORE_ITEMS)=0A=
+    {=0A=
+      seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+      goto out;=0A=
+    }=0A=
+  index =3D 0;=0A=
+  buf_size =3D MAX_PATH;=0A=
+  while (ERROR_SUCCESS =3D=3D=0A=
+         (error =3D RegEnumValue (hKey, index++, buf, &buf_size, NULL, NUL=
L,=0A=
+                                NULL, NULL)) || (error =3D=3D ERROR_MORE_D=
ATA))=0A=
+    {=0A=
+      if (pathmatch (buf, file) || (buf[0] =3D=3D '\0' &&=0A=
+                                    pathmatch (file, DEFAULT_VALUE_NAME)))=
=0A=
+        {=0A=
+          file_type =3D -1;=0A=
+          goto out;=0A=
+        }=0A=
+      buf_size =3D MAX_PATH;=0A=
+    }=0A=
+  if (error !=3D ERROR_NO_MORE_ITEMS)=0A=
+    {=0A=
+      seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+      goto out;=0A=
+    }=0A=
+out:=0A=
+  if (hKey !=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+    RegCloseKey (hKey);=0A=
+  return file_type;=0A=
+}=0A=
+=0A=
+fhandler_registry::fhandler_registry ():=0A=
+  fhandler_proc (FH_REGISTRY)=0A=
+{=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_registry::fstat (const char *path, struct stat *buf)=0A=
+{=0A=
+  int file_type =3D exists (path);=0A=
+  switch (file_type)=0A=
+    {=0A=
+    case 0:=0A=
+      set_errno (ENOENT);=0A=
+      return -1;=0A=
+    case 1:=0A=
+      buf->st_mode =3D S_IFDIR | 0555;=0A=
+      buf->st_nlink =3D 1;=0A=
+      return 0;=0A=
+    case 2:=0A=
+      buf->st_mode =3D S_IFDIR | 0555;=0A=
+      buf->st_nlink =3D ROOT_KEY_COUNT;=0A=
+      return 0;=0A=
+    case -1:=0A=
+      buf->st_mode =3D S_IFREG | 0444;=0A=
+      buf->st_nlink =3D 1;=0A=
+      return 0;=0A=
+    }=0A=
+}=0A=
+=0A=
+struct dirent *=0A=
+fhandler_registry::readdir (DIR * dir)=0A=
+{=0A=
+  DWORD buf_size =3D MAX_PATH;=0A=
+  char buf[buf_size];=0A=
+  HANDLE handle;=0A=
+  struct dirent *res =3D NULL;=0A=
+  const char *path =3D dir->__d_dirname + proc_len + 1 + registry_len;=0A=
+  LONG error;=0A=
+=0A=
+  if (*path =3D=3D 0)=0A=
+    {=0A=
+      if (dir->__d_position >=3D ROOT_KEY_COUNT)=0A=
+        goto out;=0A=
+      strcpy (dir->__d_dirent->d_name, registry_listing[dir->__d_position+=
+]);=0A=
+      res =3D dir->__d_dirent;=0A=
+      goto out;=0A=
+    }=0A=
+  if (dir->__d_u.__d_data.__handle =3D=3D INVALID_HANDLE_VALUE=0A=
+      && dir->__d_position =3D=3D 0)=0A=
+    {=0A=
+      handle =3D open_key (path + 1);=0A=
+      dir->__d_u.__d_data.__handle =3D handle;;=0A=
+    }=0A=
+  if (dir->__d_u.__d_data.__handle =3D=3D INVALID_HANDLE_VALUE)=0A=
+    goto out;=0A=
+retry:=0A=
+  if (dir->__d_position & REG_ENUM_VALUES_MASK)=0A=
+    /* For the moment, the type of key is ignored here. when write access =
is added,=0A=
+     * maybe add an extension for the type of each value?=0A=
+     */=0A=
+    error =3D RegEnumValue ((HKEY) dir->__d_u.__d_data.__handle,=0A=
+                          (dir->__d_position & ~REG_ENUM_VALUES_MASK) >> 1=
6,=0A=
+                          buf, &buf_size, NULL, NULL, NULL, NULL);=0A=
+  else=0A=
+    error =3D=0A=
+      RegEnumKeyEx ((HKEY) dir->__d_u.__d_data.__handle, dir->__d_position=
,=0A=
+                    buf, &buf_size, NULL, NULL, NULL, NULL);=0A=
+  if (error =3D=3D ERROR_NO_MORE_ITEMS=0A=
+      && (dir->__d_position & REG_ENUM_VALUES_MASK) =3D=3D 0)=0A=
+    {=0A=
+      /* If we're finished with sub-keys, start on values under this key. =
 */=0A=
+      dir->__d_position |=3D REG_ENUM_VALUES_MASK;=0A=
+      buf_size =3D MAX_PATH;=0A=
+      goto retry;=0A=
+    }=0A=
+  if (error !=3D ERROR_SUCCESS && error !=3D ERROR_MORE_DATA)=0A=
+    {=0A=
+      RegCloseKey ((HKEY) dir->__d_u.__d_data.__handle);=0A=
+      dir->__d_u.__d_data.__handle =3D INVALID_HANDLE_VALUE;=0A=
+      if (error !=3D ERROR_NO_MORE_ITEMS)=0A=
+        seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+      goto out;=0A=
+    }=0A=
+=0A=
+  /* We get here if `buf' contains valid data.  */=0A=
+  if (*buf =3D=3D 0)=0A=
+    strcpy (dir->__d_dirent->d_name, DEFAULT_VALUE_NAME);=0A=
+  else=0A=
+    strcpy (dir->__d_dirent->d_name, buf);=0A=
+=0A=
+  dir->__d_position++;=0A=
+  if (dir->__d_position & REG_ENUM_VALUES_MASK)=0A=
+    dir->__d_position +=3D 0x10000;=0A=
+  res =3D dir->__d_dirent;=0A=
+out:=0A=
+  syscall_printf ("%p =3D readdir (%p) (%s)", &dir->__d_dirent, dir, buf);=
=0A=
+  return res;=0A=
+}=0A=
+=0A=
+__off32_t=0A=
+fhandler_registry::telldir (DIR * dir)=0A=
+{=0A=
+  return dir->__d_position & REG_ENUM_VALUES_MASK;=0A=
+}=0A=
+=0A=
+void=0A=
+fhandler_registry::seekdir (DIR * dir, __off32_t loc)=0A=
+{=0A=
+  /* Unfortunately cannot simply set __d_position due to transition from s=
ub-keys to=0A=
+   * values.=0A=
+   */=0A=
+  rewinddir (dir);=0A=
+  while (loc > dir->__d_position)=0A=
+    if (!readdir (dir))=0A=
+      break;=0A=
+}=0A=
+=0A=
+void=0A=
+fhandler_registry::rewinddir (DIR * dir)=0A=
+{=0A=
+  if (dir->__d_u.__d_data.__handle !=3D INVALID_HANDLE_VALUE)=0A=
+    {=0A=
+      (void) RegCloseKey ((HKEY) dir->__d_u.__d_data.__handle);=0A=
+      dir->__d_u.__d_data.__handle =3D INVALID_HANDLE_VALUE;=0A=
+    }=0A=
+  dir->__d_position =3D 0;=0A=
+  return;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_registry::closedir (DIR * dir)=0A=
+{=0A=
+  int res =3D 0;=0A=
+  if (dir->__d_u.__d_data.__handle !=3D INVALID_HANDLE_VALUE &&=0A=
+      RegCloseKey ((HKEY) dir->__d_u.__d_data.__handle) !=3D ERROR_SUCCESS=
)=0A=
+    {=0A=
+      __seterrno ();=0A=
+      res =3D -1;=0A=
+    }=0A=
+  syscall_printf ("%d =3D closedir (%p)", res, dir);=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_registry::open (const char *path, int flags, mode_t mode)=0A=
+{=0A=
+  DWORD type, size;=0A=
+  LONG error;=0A=
+  HKEY hKey =3D (HKEY) INVALID_HANDLE_VALUE;=0A=
+  int pathlen;=0A=
+  const char *file;=0A=
+=0A=
+  int res =3D fhandler_virtual::open (path, flags, mode);=0A=
+  if (!res)=0A=
+    goto out;=0A=
+=0A=
+  path +=3D proc_len + 1 + registry_len;=0A=
+  if (*path =3D=3D 0)=0A=
+    {=0A=
+      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+        {=0A=
+          set_errno (EEXIST);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else if (mode & O_WRONLY)=0A=
+        {=0A=
+          set_errno (EISDIR);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          flags |=3D O_DIROPEN;=0A=
+          goto success;=0A=
+        }=0A=
+    }=0A=
+  path++;=0A=
+  pathlen =3D strlen (path);=0A=
+  file =3D path + pathlen - 1;=0A=
+  if (SLASH_P (*file) && pathlen > 1)=0A=
+    file--;=0A=
+  while (!SLASH_P (*file))=0A=
+    file--;=0A=
+  file++;=0A=
+=0A=
+  if (file =3D=3D path)=0A=
+    {=0A=
+      for (int i =3D 0; registry_listing[i]; i++)=0A=
+        if (path_prefix_p=0A=
+            (registry_listing[i], path, strlen (registry_listing[i])))=0A=
+          {=0A=
+            if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+              {=0A=
+                set_errno (EEXIST);=0A=
+                res =3D 0;=0A=
+                goto out;=0A=
+              }=0A=
+            else if (mode & O_WRONLY)=0A=
+              {=0A=
+                set_errno (EISDIR);=0A=
+                res =3D 0;=0A=
+                goto out;=0A=
+              }=0A=
+            else=0A=
+              {=0A=
+                flags |=3D O_DIROPEN;=0A=
+                goto success;=0A=
+              }=0A=
+          }=0A=
+=0A=
+      if ((mode & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))=0A=
+        {=0A=
+          set_errno (EROFS);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          set_errno (ENOENT);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+    }=0A=
+=0A=
+  hKey =3D open_key (path, KEY_READ, true);=0A=
+  if (hKey =3D=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+    {=0A=
+      res =3D 0;=0A=
+      goto out;=0A=
+    }=0A=
+  if (mode & O_WRONLY)=0A=
+    {=0A=
+      set_errno (EROFS);=0A=
+      res =3D 0;=0A=
+      goto out;=0A=
+    }=0A=
+  if (pathmatch (file, DEFAULT_VALUE_NAME))=0A=
+    file =3D "";=0A=
+=0A=
+  if (hKey !=3D HKEY_PERFORMANCE_DATA)=0A=
+    {=0A=
+      error =3D RegQueryValueEx (hKey, file, NULL, &type, NULL, &size);=0A=
+      if (error !=3D ERROR_SUCCESS)=0A=
+        {=0A=
+          seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+          res =3D -1;=0A=
+          goto out;=0A=
+        }=0A=
+      bufalloc =3D size;=0A=
+      filebuf =3D new char[bufalloc];=0A=
+      error =3D=0A=
+        RegQueryValueEx (hKey, file, NULL, NULL, (BYTE *) filebuf, &size);=
=0A=
+      if (error !=3D ERROR_SUCCESS)=0A=
+        {=0A=
+          seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+          res =3D 0;=0A=
+          goto out;=0A=
+        }=0A=
+      filesize =3D size;=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      bufalloc =3D 0;=0A=
+      do=0A=
+        {=0A=
+          bufalloc +=3D 1000;=0A=
+          if (filebuf)=0A=
+            {=0A=
+              delete filebuf;=0A=
+              filebuf =3D new char[bufalloc];=0A=
+            }=0A=
+          error =3D=0A=
+            RegQueryValueEx (hKey, file, NULL, &type, (BYTE *) filebuf,=0A=
+                             &size);=0A=
+          if (error !=3D ERROR_SUCCESS && res !=3D ERROR_MORE_DATA)=0A=
+            {=0A=
+              seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+              res =3D 0;=0A=
+              goto out;=0A=
+            }=0A=
+        }=0A=
+      while (error =3D=3D ERROR_MORE_DATA);=0A=
+      filesize =3D size;=0A=
+    }=0A=
+=0A=
+  if (flags & O_APPEND)=0A=
+    position =3D filesize;=0A=
+  else=0A=
+    position =3D 0;=0A=
+=0A=
+success:=0A=
+  res =3D 1;=0A=
+  set_open_status ();=0A=
+  set_flags (flags);=0A=
+out:=0A=
+  if (hKey !=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+    RegCloseKey (hKey);=0A=
+  syscall_printf ("%d =3D fhandler_registry::open (%p, %d)", res, flags, m=
ode);=0A=
+  return res;=0A=
+}=0A=
+=0A=
+/* Auxillary member function to open registry keys.  */=0A=
+HKEY=0A=
+fhandler_registry::open_key (const char *name, REGSAM access =3D=0A=
+                             KEY_READ, bool isValue =3D false)=0A=
+{=0A=
+  HKEY hKey =3D (HKEY) INVALID_HANDLE_VALUE;=0A=
+  HKEY hParentKey =3D (HKEY) INVALID_HANDLE_VALUE;=0A=
+  bool parentOpened =3D false;=0A=
+  char component[MAX_PATH];=0A=
+=0A=
+  while (*name)=0A=
+    {=0A=
+      const char *anchor =3D name;=0A=
+      while (*name && !SLASH_P (*name))=0A=
+        name++;=0A=
+      strncpy (component, anchor, name - anchor);=0A=
+      component[name - anchor] =3D '\0';=0A=
+      if (*name)=0A=
+        name++;=0A=
+      if (*name =3D=3D 0 && isValue =3D=3D true)=0A=
+        goto out;=0A=
+=0A=
+      if (hParentKey !=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+        {=0A=
+          hKey =3D (HKEY) INVALID_HANDLE_VALUE;=0A=
+          LONG error =3D RegOpenKeyEx (hParentKey, component, 0, access, &=
hKey);=0A=
+          if (hKey =3D=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+            {=0A=
+              seterrno_from_win_error (__FILE__, __LINE__, error);=0A=
+              return hKey;=0A=
+            }=0A=
+          if (parentOpened)=0A=
+            RegCloseKey (hParentKey);=0A=
+          hParentKey =3D hKey;=0A=
+          parentOpened =3D true;=0A=
+        }=0A=
+      else=0A=
+        {=0A=
+          for (int i =3D 0; registry_listing[i]; i++)=0A=
+            if (pathmatch (component, registry_listing[i]))=0A=
+              hKey =3D registry_keys[i];=0A=
+          if (hKey =3D=3D (HKEY) INVALID_HANDLE_VALUE)=0A=
+            return hKey;=0A=
+          hParentKey =3D hKey;=0A=
+        }=0A=
+    }=0A=
+out:=0A=
+  return hKey;=0A=
+}=0A=
--- /dev/null	Wed Feb 27 23:52:27 2002=0A=
+++ fhandler_virtual.cc	Tue Feb 26 11:14:04 2002=0A=
@@ -0,0 +1,228 @@=0A=
+/* fhandler_virtual.cc: base fhandler class for virtual filesystems=0A=
+=0A=
+   Copyright 2002 Red Hat, Inc.=0A=
+=0A=
+This file is part of Cygwin.=0A=
+=0A=
+This software is a copyrighted work licensed under the terms of the=0A=
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
+details. */=0A=
+=0A=
+#include "winsup.h"=0A=
+#include <sys/fcntl.h>=0A=
+#include <errno.h>=0A=
+#include <unistd.h>=0A=
+#include <stdlib.h>=0A=
+#include <sys/cygwin.h>=0A=
+#include "cygerrno.h"=0A=
+#include "security.h"=0A=
+#include "fhandler.h"=0A=
+#include "path.h"=0A=
+#include "dtable.h"=0A=
+#include "cygheap.h"=0A=
+#include "shared_info.h"=0A=
+#include <assert.h>=0A=
+=0A=
+#define _COMPILING_NEWLIB=0A=
+#include <dirent.h>=0A=
+=0A=
+fhandler_virtual::fhandler_virtual (DWORD devtype):=0A=
+  fhandler_base (devtype), filebuf (NULL), bufalloc (-1)=0A=
+{=0A=
+}=0A=
+=0A=
+fhandler_virtual::~fhandler_virtual ()=0A=
+{=0A=
+  if (filebuf)=0A=
+    delete filebuf;=0A=
+  filebuf =3D NULL;=0A=
+}=0A=
+=0A=
+DIR *=0A=
+fhandler_virtual::opendir (const char *path)=0A=
+{=0A=
+  DIR *dir;=0A=
+  DIR *res =3D NULL;=0A=
+  size_t len;=0A=
+=0A=
+  if (exists (path) <=3D 0)=0A=
+    set_errno (ENOTDIR);=0A=
+  else if ((len =3D strlen (path)) > MAX_PATH - 3)=0A=
+    set_errno (ENAMETOOLONG);=0A=
+  else if ((dir =3D (DIR *) malloc (sizeof (DIR))) =3D=3D NULL)=0A=
+    set_errno (ENOMEM);=0A=
+  else if ((dir->__d_dirname =3D (char *) malloc (len + 3)) =3D=3D NULL)=
=0A=
+    {=0A=
+      free (dir);=0A=
+      set_errno (ENOMEM);=0A=
+    }=0A=
+  else if ((dir->__d_dirent =3D=0A=
+      (struct dirent *) malloc (sizeof (struct dirent))) =3D=3D NULL)=0A=
+    {=0A=
+      free (dir);=0A=
+      set_errno (ENOMEM);=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      strcpy (dir->__d_dirname, path);=0A=
+      dir->__d_dirent->d_version =3D __DIRENT_VERSION;=0A=
+      cygheap_fdnew fd;=0A=
+      fd =3D this;=0A=
+      fd->set_nohandle (true);=0A=
+      dir->__d_dirent->d_fd =3D fd;=0A=
+      dir->__d_u.__d_data.__fh =3D this;=0A=
+      dir->__d_cookie =3D __DIRENT_COOKIE;=0A=
+      dir->__d_u.__d_data.__handle =3D INVALID_HANDLE_VALUE;=0A=
+      dir->__d_position =3D 0;=0A=
+      dir->__d_dirhash =3D get_namehash ();=0A=
+=0A=
+      res =3D dir;=0A=
+    }=0A=
+=0A=
+  syscall_printf ("%p =3D opendir (%s)", res, get_name ());=0A=
+  return res;=0A=
+}=0A=
+=0A=
+=0A=
+DIR *=0A=
+fhandler_virtual::opendir (path_conv & real_name)=0A=
+{=0A=
+  return opendir (get_name());=0A=
+}=0A=
+=0A=
+__off32_t fhandler_virtual::telldir (DIR * dir)=0A=
+{=0A=
+  return dir->__d_position;=0A=
+}=0A=
+=0A=
+void=0A=
+fhandler_virtual::seekdir (DIR * dir, __off32_t loc)=0A=
+{=0A=
+  dir->__d_position =3D loc;=0A=
+  return;=0A=
+}=0A=
+=0A=
+void=0A=
+fhandler_virtual::rewinddir (DIR * dir)=0A=
+{=0A=
+  dir->__d_position =3D 0;=0A=
+  return;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::closedir (DIR * dir)=0A=
+{=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+__off32_t=0A=
+fhandler_virtual::lseek (__off32_t offset, int whence)=0A=
+{=0A=
+  switch (whence)=0A=
+    {=0A=
+    case SEEK_SET:=0A=
+      position =3D offset;=0A=
+      break;=0A=
+    case SEEK_CUR:=0A=
+      position +=3D offset;=0A=
+      break;=0A=
+    case SEEK_END:=0A=
+      position =3D filesize + offset;=0A=
+      break;=0A=
+    default:=0A=
+      set_errno (EINVAL);=0A=
+      return (__off32_t) -1;=0A=
+    }=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::dup (fhandler_base * child)=0A=
+{=0A=
+  fhandler_virtual *fhproc_child =3D (fhandler_virtual *) child;=0A=
+  fhproc_child->filebuf =3D new char[filesize];=0A=
+  fhproc_child->bufalloc =3D fhproc_child->filesize =3D filesize;=0A=
+  fhproc_child->position =3D position;=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::close ()=0A=
+{=0A=
+  if (filebuf)=0A=
+    delete[]filebuf;=0A=
+  filebuf =3D NULL;=0A=
+  bufalloc =3D -1;=0A=
+  cygwin_shared->delqueue.process_queue ();=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::read (void *ptr, size_t len)=0A=
+{=0A=
+  if (len =3D=3D 0)=0A=
+    return 0;=0A=
+  if (openflags & O_DIROPEN)=0A=
+    {=0A=
+      set_errno (EISDIR);=0A=
+      return -1;=0A=
+    }=0A=
+  if (!filebuf)=0A=
+    return 0;=0A=
+  int read =3D max (0, min (len, filesize - position));=0A=
+  if (read >=3D 0)=0A=
+    memcpy (ptr, filebuf + position, read);=0A=
+  position +=3D read;=0A=
+  return read;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::write (const void *ptr, size_t len)=0A=
+{=0A=
+  set_errno (EROFS);=0A=
+  return -1;=0A=
+}=0A=
+=0A=
+/* low-level open for all proc files */=0A=
+int=0A=
+fhandler_virtual::open (const char *normalized_path, int flags, mode_t mod=
e)=0A=
+{=0A=
+  set_r_binary (1);=0A=
+  set_w_binary (1);=0A=
+=0A=
+  set_has_acls (false);=0A=
+  set_isremote (false);=0A=
+=0A=
+  /* what to do about symlinks? */=0A=
+  set_symlink_p (false);=0A=
+  set_execable_p (not_executable);=0A=
+  set_socket_p (false);=0A=
+=0A=
+  set_flags (flags);=0A=
+=0A=
+  return 1;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::open (path_conv * real_path, int flags, mode_t mode)=0A=
+{=0A=
+  return open (get_name(), flags, mode);=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::fstat (struct stat *buf, path_conv * pc)=0A=
+{=0A=
+  return fstat (get_name(), buf);=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::fstat (const char *path, struct stat *buf)=0A=
+{=0A=
+  set_errno (ENOENT);=0A=
+  return -1;=0A=
+}=0A=
+=0A=
+int=0A=
+fhandler_virtual::exists (const char *path)=0A=
+{=0A=
+  return 0;=0A=
+}=0A=

------=_NextPart_000_00DB_01C1BFEA.845C2B90--

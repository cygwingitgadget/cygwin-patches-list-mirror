Return-Path: <cygwin-patches-return-7075-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12328 invoked by alias); 6 Sep 2010 09:53:13 -0000
Received: (qmail 12315 invoked by uid 22791); 6 Sep 2010 09:53:06 -0000
X-SWARE-Spam-Status: No, hits=2.8 required=5.0	tests=AWL,BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,KAM_STOCKGEN,RCVD_IN_DNSWL_NONE,TW_NV,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f43.google.com (HELO mail-fx0-f43.google.com) (209.85.161.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 06 Sep 2010 09:52:55 +0000
Received: by fxm9 with SMTP id 9so3495325fxm.2        for <cygwin-patches@cygwin.com>; Mon, 06 Sep 2010 02:52:52 -0700 (PDT)
Received: by 10.223.107.65 with SMTP id a1mr936049fap.2.1283766772169;        Mon, 06 Sep 2010 02:52:52 -0700 (PDT)
Received: from [10.71.1.25] (wall-ext.hola.org [212.235.66.73])        by mx.google.com with ESMTPS id r10sm2271591faq.29.2010.09.06.02.52.49        (version=SSLv3 cipher=RC4-MD5);        Mon, 06 Sep 2010 02:52:51 -0700 (PDT)
Message-ID: <4C84B9EF.9030109@gmail.com>
Date: Mon, 06 Sep 2010 09:53:00 -0000
From: Yoni Londner <yonihola2@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.12) Gecko/20100824 Thunderbird/3.0.7
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
Content-Type: multipart/mixed; boundary="------------040500050507090006070802"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00035.txt.bz2

This is a multi-part message in MIME format.
--------------040500050507090006070802
Content-Type: text/plain; charset=windows-1255; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 6016

Hi,

Abstract: I prepared a patch that improves Cygwin Filesystem performance 
by x4 on Cygwin 1.7.5 (1.7.5 vanilla 530ms --> 1.7.5 patched 120ms). I 
ported the patch to 1.7.7, did tests, and found out that 1.7.7 had a 
very serious 9x (!) performance degradation from 1.7.5 (1.7.5 vanilla 
530ms --> 1.7.7 vanilla 3900ms --> 1.7.7 patched 3500ms), which does 
makes this patch useless until the performance degradation is fixed.

=======================================================================
My patch:
------------

As a cygwin user, I wanted to make cygwin faster, since Cygwin is my 
host for Win32 Windows development platform (make, cvs, grep etc).

I saw that simple file access operations were x10 to x50 times slower 
than on Windows.
And x10 to x50 slower than VMWare linux accessing the drive using HostFS 
(which allows Linux VM to access the Windows C: drive).

So I did some performace test on Cygwin 1.7.5, and found out the biggest 
bottleneck were:

- CreateFile()/CloseHandle() on syscalls that only need file node info 
retrival, not file contents retrival (such as stat()). This can be 
solved by calling Win32 that do not open the File handle itself, rather 
query by name, or opening the directory handle (which is MUCH faster).

- repetitive Win32 Kernel calls on a single syscall (stat() would call 
up to 5 CreateFile/CloseHandle pairs plus another additional 5 to 10 
Win32 APIs).
on stat() system calls, managed to improve the performance of ls approx. 
by 4 times. This can be solved by caching: first time in a syscall the 
API is called the result is stored, so the second time the info is 
needed, it is re-used.

- ACLs: Windows is not a secure system. And its ACL model is strange to 
say the least... Most cygwin users do not use the unix permissions 
system on cygwin to achieve security. All they want is that the unix 
tools will run on Windows. The ACL calls are over 50% (!) of the time 
spent during cygwin filesystem syscalls, including stat. For application 
such as chmod/chown/chgrp etc I added automatic enabling of ACLs. For 
all other applications: the ACLs can be enabled via envirnoment. This 
gives the cygwin end user choice: run everything at x2 the speed with no 
ACLs, or slow - but with ACL support.

- stat inode number and inode link count: getting the inode in Windows 
requires a File handle or Directory handle (not possible to get inode by 
file name). Very few applications actually need a REAL inode number. So 
using the 'get file info by name' apis are used (and of course there is 
an envirnoment if you really want real inode numbers).

- GetVolumeInfo: The C:\ drive does not tend to be changed every 
millisecond! Therefore no reason for every filesystem syscall to call 
it. Caching this further increased the performance.

- File security check: GetSecurityInfo() is implemented in Windows in 
usermode dll (Advapi32.dll). It calls at the end 
NtQuerySecurityObject(). So I implemented a faster version: 
zGetSecurityInfo() which does the same... just faster.

- symbolic link files: Opening a file and reading its contents is an 
expensive operation. All file cygwin operations must check whether the 
file is a symbolic link or not, which is done by opening the file and 
reading its contents and checking whether it has the symlink magic at 
the beginning of this. Since symbolic link must be at least 8 bytes long 
(to include the symlink magic header), and cannot be longer than 
MAX_PATH+magic size  - there is no reason to read the file contents that 
is smaller or bigger than this. Since MOST of the files are outside of 
this range, we save a LOT of CreateFile/ReadFile/CloseHanlde calls on 
every single file operation!

I did all the above work on cygwin 1.7.5. I did a simple test: 'ls 
/bin', where bin holds 3500 files.
Cygwin 1.7.5 vanilla took 530 ms. After all my above improvements, the 
patched version did this in 120 ms. Thats more than 4x improvement! I 
then checked all other applications (grep, make, rsync, cvs, perl code 
etc...): they all had this same 4x improvement!

I think this is a very important patch that should find its way into the 
Cygwin source code, since it helps to dramatically reduce the x10-x50 
filesystem performance gap between Cygwin and native Win32 code.

And once part of standard cygwin, I have many more ideas how the 
filesystem performance can be further improved.

==============================================================================
The checks:

The check is did was 'ls > /dev/null' in /bin directory, which contain 
about 3500 files.
I did all that for version 1.7.5.
When i wanted to merge my changes to version 1.7.7 i noticed a major 
performance degradation.
with 1.7.5 'ls' in /bin took 530ms (with original version), and with 
1.7.7 it took almost 4 seconds!
You can see all the details below.
So, I think someone should have a look, and find out what is causing the 
performance degradation.
I also want to merge my patch to cygwin CVS, so everybody can enjoy it 
(me, and about 10 more people are using a patched cygwin1.dll for about 
4 month without any problems).

/bin$ ls /bin | wc -l
3580

The Win32 comparison (... yes: I know cmd.exe's version of ls collects 
less info)
/bin$ time cmd /c 'dir > nul:'
real    0m0.113s
user    0m0.015s
sys     0m0.015s

_Without my patch:_
/bin$ uname -a
CYGWIN_NT-5.1 yoni 1.7.5(0.225/5/3) 2010-04-12 19:07 i686 Cygwin
/bin$ time ls > /dev/null
real *0m0.530s*
user    0m0.140s
sys     0m0.421s

~$ uname -a
CYGWIN_NT-5.1 yoni 1.7.7(0.230/5/3) 2010-08-31 09:58 i686 Cygwin
/bin$ time ls > /dev/null
real *0m3.949s*
user    0m0.171s
sys     0m0.546s


_With my patch:_
$ uname -a
CYGWIN_NT-5.1 yoni 1.7.5(0.228/5/3) 2010-07-18 14:53 i686 Cygwin
~$ cd /bin/
/bin$ time ls > /dev/null
real *0m0.123s*
user    0m0.030s
sys     0m0.124s

/bin$ uname -a
CYGWIN_NT-5.1 yoni 1.7.7(0.230/5/3) 2010-09-01 17:14 i686 Cygwin
/bin$ time ls > /dev/null
real *0m3.575s*
user    0m0.108s
sys     0m0.374s

Best regards,
Yoni.


--------------040500050507090006070802
Content-Type: text/plain;
 name="cygwin_1_7_5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin_1_7_5.patch"
Content-length: 33105

Index: winsup/cygwin/cygtls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygtls.cc,v
retrieving revision 1.72
diff -c -r1.72 cygtls.cc
*** winsup/cygwin/cygtls.cc	28 Feb 2010 15:54:25 -0000	1.72
--- winsup/cygwin/cygtls.cc	12 May 2010 11:42:51 -0000
***************
*** 161,166 ****
--- 161,167 ----
        free_local (protoent_buf);
        free_local (servent_buf);
        free_local (hostent_buf);
+       free_local (security_buf);
      }
  
    /* Free temporary TLS path buffers. */
Index: winsup/cygwin/cygtls.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygtls.h,v
retrieving revision 1.66
diff -c -r1.66 cygtls.h
*** winsup/cygwin/cygtls.h	2 Mar 2010 00:49:15 -0000	1.66
--- winsup/cygwin/cygtls.h	12 May 2010 11:42:51 -0000
***************
*** 144,149 ****
--- 144,153 ----
  
    /* All functions requiring temporary path buffers. */
    tls_pathbuf pathbufs;
+ 
+   /* security.cc */
+   void *security_buf;
+   int security_buf_len;
  };
  
  typedef struct struct_waitq
Index: winsup/cygwin/fhandler_disk_file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.325
diff -c -r1.325 fhandler_disk_file.cc
*** winsup/cygwin/fhandler_disk_file.cc	19 Mar 2010 10:59:49 -0000	1.325
--- winsup/cygwin/fhandler_disk_file.cc	12 May 2010 11:42:53 -0000
***************
*** 137,145 ****
--- 137,148 ----
      void rewind () { memset (found, 0, sizeof found); }
  };
  
+ static int inode_from_hash = 1;
  inline bool
  path_conv::isgood_inode (__ino64_t ino) const
  {
+   if (inode_from_hash)
+     return 0;
    /* We can't trust remote inode numbers of only 32 bit.  That means,
       all remote inode numbers when running under NT4, as well as remote NT4
       NTFS, as well as shares of Samba version < 3.0.
***************
*** 393,403 ****
  		       get_dev (),
  		       fsi.EndOfFile.QuadPart,
  		       fsi.AllocationSize.QuadPart,
! 		       fii.FileId.QuadPart,
  		       fsi.NumberOfLinks,
  		       fi.fbi.FileAttributes);
  }
  
  int __stdcall
  fhandler_base::fstat_by_name (struct __stat64 *buf)
  {
--- 396,425 ----
  		       get_dev (),
  		       fsi.EndOfFile.QuadPart,
  		       fsi.AllocationSize.QuadPart,
! 		       inode_from_hash ? 0 : fii.FileId.QuadPart,
  		       fsi.NumberOfLinks,
  		       fi.fbi.FileAttributes);
  }
  
+ int path_conv_update_fi(path_conv *pc, PUNICODE_STRING path)
+ {
+     WCHAR _path[MAX_PATH];
+     if (path->Length>MAX_PATH)
+ 	return 0;
+     memcpy(_path, path->Buffer, path->Length);
+     _path[path->Length/sizeof(WCHAR)] = 0;
+     if (pc->fi_updated > 0 && !wcscmp(pc->fi_path, _path))
+ 	return pc->fi_updated;
+     wcscpy(pc->fi_path, _path);
+     OBJECT_ATTRIBUTES attr;
+     InitializeObjectAttributes(&attr, path,
+ 	pc->objcaseinsensitive() , NULL, NULL);
+     pc->fi_updated = NtQueryFullAttributesFile(&attr,
+ 	(PFILE_NETWORK_OPEN_INFORMATION)&pc->fi) ? -1 : 1;
+     return pc->fi_updated;
+ }
+ 
+ static int use_fast_api = 1;
  int __stdcall
  fhandler_base::fstat_by_name (struct __stat64 *buf)
  {
***************
*** 413,418 ****
--- 435,454 ----
    } fdi_buf;
    LARGE_INTEGER FileId;
  
+   if (use_fast_api)
+   {
+       debug_printf ("start fstat_by_name");
+       if (path_conv_update_fi(&pc, pc.get_nt_native_path())<0)
+ 	  goto too_bad;
+       if (pc.is_rep_symlink())
+ 	  pc.fi.FileAttributes &= ~FILE_ATTRIBUTE_DIRECTORY;
+       pc.file_attributes(pc.fi.FileAttributes);
+       return fstat_helper (buf,
+ 	  &pc.fi.ChangeTime, &pc.fi.LastAccessTime, &pc.fi.LastWriteTime,
+ 	  &pc.fi.CreationTime, pc.fs_serial_number (),
+ 	  pc.fi.EndOfFile.QuadPart, pc.fi.AllocationSize.QuadPart, 0, 1,
+ 	  pc.fi.FileAttributes);
+   }
    RtlSplitUnicodePath (pc.get_nt_native_path (), &dirname, &basename);
    InitializeObjectAttributes (&attr, &dirname, pc.objcaseinsensitive (),
  			      NULL, NULL);
***************
*** 485,491 ****
  fhandler_base::fstat_fs (struct __stat64 *buf)
  {
    int res = -1;
-   int oret;
    int open_flags = O_RDONLY | O_BINARY;
  
    if (get_handle ())
--- 521,526 ----
***************
*** 497,504 ****
        return res;
      }
    query_open (query_read_attributes);
!   oret = open_fs (open_flags, 0);
!   if (oret)
      {
        /* We now have a valid handle, regardless of the "nohandle" state.
  	 Since fhandler_base::open only calls CloseHandle if !nohandle,
--- 532,539 ----
        return res;
      }
    query_open (query_read_attributes);
!   res = fstat_by_name (buf);
!   if (res && open_fs (open_flags, 0))
      {
        /* We now have a valid handle, regardless of the "nohandle" state.
  	 Since fhandler_base::open only calls CloseHandle if !nohandle,
***************
*** 511,518 ****
        nohandle (no_handle);
        set_io_handle (NULL);
      }
-   if (res)
-     res = fstat_by_name (buf);
  
    return res;
  }
--- 546,551 ----
***************
*** 562,568 ****
  #endif
  
    /* Enforce namehash as inode number on untrusted file systems. */
!   if (pc.isgood_inode (nFileIndex))
      buf->st_ino = (__ino64_t) nFileIndex;
    else
      buf->st_ino = get_ino ();
--- 595,601 ----
  #endif
  
    /* Enforce namehash as inode number on untrusted file systems. */
!   if (!inode_from_hash && pc.isgood_inode (nFileIndex))
      buf->st_ino = (__ino64_t) nFileIndex;
    else
      buf->st_ino = get_ino ();
Index: winsup/cygwin/mount.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/mount.cc,v
retrieving revision 1.56
diff -c -r1.56 mount.cc
*** winsup/cygwin/mount.cc	30 Mar 2010 08:55:23 -0000	1.56
--- winsup/cygwin/mount.cc	12 May 2010 11:42:53 -0000
***************
*** 48,53 ****
--- 48,54 ----
  bool NO_COPY mount_info::got_usr_bin;
  bool NO_COPY mount_info::got_usr_lib;
  int NO_COPY mount_info::root_idx = -1;
+ static int no_global_noacl;
  
  /* is_unc_share: Return non-zero if PATH begins with //server/share
  		 or with one of the native prefixes //./ or //?/
***************
*** 105,110 ****
--- 106,214 ----
  };
  #pragma pack(pop)
  
+ typedef struct fs_info_list_t {
+     struct fs_info_list_t *next;
+     fs_info fsi;
+     wchar_t path[MAX_PATH];
+     int path_len;
+ } fs_info_list_t;
+ 
+ static fs_info_list_t *fs_info_list;
+ static int in_fs_info_update;
+ 
+ int fs_info_lookup(fs_info *fsi, PUNICODE_STRING upath)
+ {
+     int shortest = 0;
+     fs_info_list_t *f, *found = NULL;
+     if (in_fs_info_update)
+ 	return 0;
+     /* find first (longest match) */
+     for (f = fs_info_list; f != NULL; f=f->next)
+     {
+ 	if (!wcsncmp(f->path, upath->Buffer, f->path_len))
+ 	{
+ 	    if (!shortest || shortest > f->path_len)
+ 	    {
+ 		shortest = f->path_len;
+ 		found = f;
+ 	    }
+ 	}
+     }
+     if (!found)
+ 	return 0;
+     memcpy(fsi, &found->fsi, sizeof(fsi));
+     return 1;
+ }
+ 
+ static inline int fs_info_eq(fs_info *a, fs_info *b)
+ {
+     return a->serial_number()==b->serial_number() &&
+ 	!memcmp(&a->status, &b->status, sizeof(a->status));
+ }
+ 
+ static void fs_info_update(fs_info *fsi, PUNICODE_STRING upath)
+ {
+     wchar_t scan_path[MAX_PATH], save, *p;
+     fs_info *_fsi, *scan = NULL;
+     fs_info_list_t *f;
+     UNICODE_STRING  ustr;
+     if (in_fs_info_update)
+ 	return;
+     in_fs_info_update++;
+     _fsi = new fs_info();
+     _fsi->update(upath, NULL);
+     /* sanity check */
+     if (!fs_info_eq(_fsi, fsi))
+     {
+ 	debug_printf("fs_info_update: strange: got different volume");
+ 	delete _fsi;
+ 	goto Exit;
+     }
+     /* scan up the path to find the base directory of the mount */
+     wcscpy(scan_path, upath->Buffer);
+     while ((p=wcsrchr(scan_path, '\\')))
+     {
+ 	save = *p;
+ 	*p = 0;
+ 	if (p==scan_path)
+ 	{
+ 	    *p = save;
+ 	    break;
+ 	}
+ 	if (scan)
+ 	    delete scan;
+ 	scan = new fs_info();
+ 	ustr.Buffer = scan_path;
+ 	ustr.Length = wcslen(scan_path);
+ 	ustr.MaximumLength = sizeof(scan_path);
+ 	if (!scan->update(&ustr, NULL) || !fs_info_eq(scan, fsi))
+ 	{
+ 	    *p = save;
+ 	    break;
+ 	}
+     }
+     if (scan)
+ 	delete scan;
+     f = (fs_info_list_t*)calloc(sizeof(*f), 1);
+     memcpy(&f->fsi, _fsi, sizeof(_fsi));
+     f->path_len = wcslen(scan_path);
+     wcscpy(f->path, scan_path);
+     f->next = fs_info_list;
+     fs_info_list = f;
+ Exit:
+     in_fs_info_update--;
+ }
+ 
+ bool fs_info::has_acls(bool val)
+ {
+     return (bool) (status.has_acls = val);
+ }
+ 
+ bool fs_info::has_acls() const
+ {
+     return no_global_noacl ? status.has_acls : 0;
+ }
+ 
  bool
  fs_info::update (PUNICODE_STRING upath, HANDLE in_vol)
  {
***************
*** 124,130 ****
      WCHAR buf[NAME_MAX + 1];
    } ffvi_buf;
    UNICODE_STRING fsname;
! 
    clear ();
    if (in_vol)
      vol = in_vol;
--- 228,235 ----
      WCHAR buf[NAME_MAX + 1];
    } ffvi_buf;
    UNICODE_STRING fsname;
!   if (fs_info_lookup(this, upath))
!       return true;
    clear ();
    if (in_vol)
      vol = in_vol;
***************
*** 333,338 ****
--- 438,445 ----
  
    if (!in_vol)
      NtClose (vol);
+ 
+   fs_info_update(this, upath);
    return true;
  }
  
***************
*** 453,462 ****
--- 560,575 ----
  
     {,full_}win32_path must have sufficient space (i.e. NT_MAX_PATH bytes).  */
  
+ static int use_acl_inited;
  int
  mount_info::conv_to_win32_path (const char *src_path, char *dst, device& dev,
  				unsigned *flags)
  {
+   if (!use_acl_inited)
+   {
+       use_acl_inited = 1;
+       no_global_noacl = !!getenv("USEACL");
+   }
    bool chroot_ok = !cygheap->root.exists ();
    while (sys_mount_table_counter < cygwin_shared->sys_mount_table_counter)
      {
Index: winsup/cygwin/mount.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/mount.h,v
retrieving revision 1.11
diff -c -r1.11 mount.h
*** winsup/cygwin/mount.h	12 Jan 2010 14:47:46 -0000	1.11
--- winsup/cygwin/mount.h	12 May 2010 11:42:53 -0000
***************
*** 38,43 ****
--- 38,48 ----
  
  class fs_info
  {
+   ULONG sernum;			/* Volume Serial Number */
+   char fsn[80];			/* Windows filesystem name */
+   unsigned long got_fs () const { return status.fs_type != none; }
+ 
+  public:
    struct status_flags
    {
      ULONG flags;		/* Volume flags */
***************
*** 52,75 ****
      unsigned has_buggy_fileid_dirinfo	: 1;
      unsigned has_buggy_basic_info	: 1;
    } status;
-   ULONG sernum;			/* Volume Serial Number */
-   char fsn[80];			/* Windows filesystem name */
-   unsigned long got_fs () const { return status.fs_type != none; }
  
-  public:
    void clear ()
    {
      memset (&status, 0 , sizeof status);
!     sernum = 0UL; 
      fsn[0] = '\0';
    }
    fs_info () { clear (); }
  
    IMPLEMENT_STATUS_FLAG (ULONG, flags)
    IMPLEMENT_STATUS_FLAG (ULONG, samba_version)
    IMPLEMENT_STATUS_FLAG (ULONG, name_len)
    IMPLEMENT_STATUS_FLAG (bool, is_remote_drive)
-   IMPLEMENT_STATUS_FLAG (bool, has_acls)
    IMPLEMENT_STATUS_FLAG (bool, hasgood_inode)
    IMPLEMENT_STATUS_FLAG (bool, caseinsensitive)
    IMPLEMENT_STATUS_FLAG (bool, has_buggy_open)
--- 57,77 ----
      unsigned has_buggy_fileid_dirinfo	: 1;
      unsigned has_buggy_basic_info	: 1;
    } status;
  
    void clear ()
    {
      memset (&status, 0 , sizeof status);
!     sernum = 0UL;
      fsn[0] = '\0';
    }
    fs_info () { clear (); }
  
+   bool has_acls(bool val);
+   bool has_acls() const;
    IMPLEMENT_STATUS_FLAG (ULONG, flags)
    IMPLEMENT_STATUS_FLAG (ULONG, samba_version)
    IMPLEMENT_STATUS_FLAG (ULONG, name_len)
    IMPLEMENT_STATUS_FLAG (bool, is_remote_drive)
    IMPLEMENT_STATUS_FLAG (bool, hasgood_inode)
    IMPLEMENT_STATUS_FLAG (bool, caseinsensitive)
    IMPLEMENT_STATUS_FLAG (bool, has_buggy_open)
Index: winsup/cygwin/path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.583
diff -c -r1.583 path.cc
*** winsup/cygwin/path.cc	9 Apr 2010 16:51:08 -0000	1.583
--- winsup/cygwin/path.cc	26 May 2010 09:01:33 -0000
***************
*** 97,103 ****
    _minor_t minor;
    _mode_t mode;
    int check (char *path, const suffix_info *suffixes, unsigned opt,
! 	     fs_info &fs);
    int set (char *path);
    bool parse_device (const char *);
    int check_sysfile (HANDLE h);
--- 97,103 ----
    _minor_t minor;
    _mode_t mode;
    int check (char *path, const suffix_info *suffixes, unsigned opt,
! 	     fs_info &fs, path_conv *pc);
    int set (char *path);
    bool parse_device (const char *);
    int check_sysfile (HANDLE h);
***************
*** 469,475 ****
  void
  warn_msdos (const char *src)
  {
!   if (user_shared->warned_msdos || !dos_file_warning || !cygwin_finished_initializing)
      return;
    tmp_pathbuf tp;
    char *posix_path = tp.c_get ();
--- 469,475 ----
  void
  warn_msdos (const char *src)
  {
!   if (1 || user_shared->warned_msdos || !dos_file_warning || !cygwin_finished_initializing)
      return;
    tmp_pathbuf tp;
    char *posix_path = tp.c_get ();
***************
*** 798,804 ****
  	      full_path[3] = '\0';
  	    }
  
! 	  symlen = sym.check (full_path, suff, opt, fs);
  
  is_virtual_symlink:
  
--- 798,804 ----
  	      full_path[3] = '\0';
  	    }
  
! 	  symlen = sym.check (full_path, suff, opt, fs, this);
  
  is_virtual_symlink:
  
***************
*** 2168,2177 ****
  
  int
  symlink_info::check (char *path, const suffix_info *suffixes, unsigned opt,
! 		     fs_info &fs)
  {
    HANDLE h = NULL;
    int res = 0;
    suffix_scan suffix;
    contents[0] = '\0';
  
--- 2168,2178 ----
  
  int
  symlink_info::check (char *path, const suffix_info *suffixes, unsigned opt,
! 		     fs_info &fs, path_conv *pc)
  {
    HANDLE h = NULL;
    int res = 0;
+   LARGE_INTEGER filesize =  { QuadPart:0LL };
    suffix_scan suffix;
    contents[0] = '\0';
  
***************
*** 2193,2198 ****
--- 2194,2207 ----
    OBJECT_ATTRIBUTES attr;
    tp.u_get (&upath);
    InitializeObjectAttributes (&attr, &upath, ci_flag, NULL, NULL);
+ #define OPEN_IF_NEEDED() \
+       if (!h) { status = NtCreateFile (&h, \
+ 			     READ_CONTROL | FILE_READ_ATTRIBUTES, \
+ 			     &attr, &io, NULL, 0, FILE_SHARE_VALID_FLAGS, \
+ 			     FILE_OPEN, \
+ 			     FILE_OPEN_REPARSE_POINT \
+ 			     | FILE_OPEN_FOR_BACKUP_INTENT, \
+ 			     eabuf, easize); }
  
    PVOID eabuf = &nfs_aol_ffei;
    ULONG easize = sizeof nfs_aol_ffei;
***************
*** 2200,2207 ****
    bool had_ext = !!*ext_here;
    while (suffix.next ())
      {
!       FILE_BASIC_INFORMATION fbi;
!       NTSTATUS status;
        IO_STATUS_BLOCK io;
        bool no_ea = false;
        bool fs_update_called = false;
--- 2209,2215 ----
    bool had_ext = !!*ext_here;
    while (suffix.next ())
      {
!       NTSTATUS status = -1;
        IO_STATUS_BLOCK io;
        bool no_ea = false;
        bool fs_update_called = false;
***************
*** 2213,2230 ****
  	  NtClose (h);
  	  h = NULL;
  	}
        /* The EA given to NtCreateFile allows to get a handle to a symlink on
  	 an NFS share, rather than getting a handle to the target of the
  	 symlink (which would spoil the task of this method quite a bit).
  	 Fortunately it's ignored on most other file systems so we don't have
  	 to special case NFS too much. */
!       status = NtCreateFile (&h,
! 			     READ_CONTROL | FILE_READ_ATTRIBUTES,
! 			     &attr, &io, NULL, 0, FILE_SHARE_VALID_FLAGS,
! 			     FILE_OPEN,
! 			     FILE_OPEN_REPARSE_POINT
! 			     | FILE_OPEN_FOR_BACKUP_INTENT,
! 			     eabuf, easize);
        debug_printf ("%p = NtCreateFile (%S)", status, &upath);
        /* No right to access EAs or EAs not supported? */
        if (!NT_SUCCESS (status)
--- 2221,2242 ----
  	  NtClose (h);
  	  h = NULL;
  	}
+       filesize.QuadPart = 0LL;
+       if (path_conv_update_fi(pc, &upath)>0)
+       {
+ 	status = 0;
+ 	fileattr = pc->fi.FileAttributes;
+ 	filesize = pc->fi.AllocationSize;
+       }
+       else
+       {
        /* The EA given to NtCreateFile allows to get a handle to a symlink on
  	 an NFS share, rather than getting a handle to the target of the
  	 symlink (which would spoil the task of this method quite a bit).
  	 Fortunately it's ignored on most other file systems so we don't have
  	 to special case NFS too much. */
!          OPEN_IF_NEEDED();
!       }
        debug_printf ("%p = NtCreateFile (%S)", status, &upath);
        /* No right to access EAs or EAs not supported? */
        if (!NT_SUCCESS (status)
***************
*** 2281,2294 ****
  	  /* Check file system while we're having the file open anyway.
  	     This speeds up path_conv noticably (~10%). */
  	  && (fs_update_called || fs.update (&upath, h))
! 	  && NT_SUCCESS (status = fs.has_buggy_basic_info ()
! 			 ? NtQueryAttributesFile (&attr, &fbi)
! 			 : NtQueryInformationFile (h, &io, &fbi, sizeof fbi,
! 						   FileBasicInformation)))
! 	fileattr = fbi.FileAttributes;
        else
  	{
  	  debug_printf ("%p = NtQueryInformationFile (%S)", status, &upath);
  	  h = NULL;
  	  fileattr = INVALID_FILE_ATTRIBUTES;
  
--- 2293,2308 ----
  	  /* Check file system while we're having the file open anyway.
  	     This speeds up path_conv noticably (~10%). */
  	  && (fs_update_called || fs.update (&upath, h))
! 	  && path_conv_update_fi(pc, &upath)>0)
!       {
! 	  fileattr = pc->fi.FileAttributes;
! 	  filesize = pc->fi.AllocationSize;
!       }
        else
  	{
  	  debug_printf ("%p = NtQueryInformationFile (%S)", status, &upath);
+ 	  if (h)
+ 	      NtClose(h);
  	  h = NULL;
  	  fileattr = INVALID_FILE_ATTRIBUTES;
  
***************
*** 2398,2403 ****
--- 2412,2418 ----
        if ((fileattr & (FILE_ATTRIBUTE_READONLY | FILE_ATTRIBUTE_DIRECTORY))
  	  == FILE_ATTRIBUTE_READONLY && suffix.lnk_match ())
  	{
+ 	  OPEN_IF_NEEDED();
  	  res = check_shortcut (h);
  	  if (!res)
  	    {
***************
*** 2431,2436 ****
--- 2446,2452 ----
  	 with SYSTEM and HIDDEN flags set. */
        else if (fileattr & FILE_ATTRIBUTE_REPARSE_POINT)
  	{
+ 	  OPEN_IF_NEEDED();
  	  res = check_reparse_point (h);
  	  if (res == -1)
  	    {
***************
*** 2450,2457 ****
  	 have the `system' file attribute.  Only files can be symlinks
  	 (which can be symlinks to directories). */
        else if ((fileattr & (FILE_ATTRIBUTE_SYSTEM | FILE_ATTRIBUTE_DIRECTORY))
! 	       == FILE_ATTRIBUTE_SYSTEM)
  	{
  	  res = check_sysfile (h);
  	  if (res)
  	    break;
--- 2466,2475 ----
  	 have the `system' file attribute.  Only files can be symlinks
  	 (which can be symlinks to directories). */
        else if ((fileattr & (FILE_ATTRIBUTE_SYSTEM | FILE_ATTRIBUTE_DIRECTORY))
! 	       == FILE_ATTRIBUTE_SYSTEM &&
! 	       filesize.QuadPart>strlen("!<symlink>") && filesize.QuadPart<512)
  	{
+ 	  OPEN_IF_NEEDED();
  	  res = check_sysfile (h);
  	  if (res)
  	    break;
***************
*** 2462,2467 ****
--- 2480,2486 ----
  	 (which can be symlinks to directories). */
        else if (fs.is_nfs () && !no_ea && !(fileattr & FILE_ATTRIBUTE_DIRECTORY))
  	{
+ 	  OPEN_IF_NEEDED();
  	  res = check_nfs_symlink (h);
  	  if (res)
  	    break;
Index: winsup/cygwin/path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.140
diff -c -r1.140 path.h
*** winsup/cygwin/path.h	9 Apr 2010 16:51:08 -0000	1.140
--- winsup/cygwin/path.h	12 May 2010 11:42:56 -0000
***************
*** 85,91 ****
--- 85,101 ----
  };
  
  class symlink_info;
+ struct FILE_NETWORK_OPEN_INFORMATION2 {
+   LARGE_INTEGER CreationTime;
+   LARGE_INTEGER LastAccessTime;
+   LARGE_INTEGER LastWriteTime;
+   LARGE_INTEGER ChangeTime;
+   LARGE_INTEGER AllocationSize;
+   LARGE_INTEGER EndOfFile;
+   ULONG FileAttributes;
+ };
  
+ int path_conv_update_fi(path_conv *pc, PUNICODE_STRING path);
  class path_conv
  {
    DWORD fileattr;
***************
*** 102,112 ****
    const char *normalized_path;
    int error;
    device dev;
  
    bool isremote () const {return fs.is_remote_drive ();}
    ULONG objcaseinsensitive () const {return caseinsensitive;}
    bool has_acls () const {return !(path_flags & PATH_NOACL) && fs.has_acls (); }
!   bool hasgood_inode () const {return fs.hasgood_inode (); }
    bool isgood_inode (__ino64_t ino) const;
    int has_symlinks () const {return path_flags & PATH_HAS_SYMLINKS;}
    int has_buggy_open () const {return fs.has_buggy_open ();}
--- 112,125 ----
    const char *normalized_path;
    int error;
    device dev;
+   int fi_updated;
+   wchar_t fi_path[MAX_PATH];
+   FILE_NETWORK_OPEN_INFORMATION2 fi;
  
    bool isremote () const {return fs.is_remote_drive ();}
    ULONG objcaseinsensitive () const {return caseinsensitive;}
    bool has_acls () const {return !(path_flags & PATH_NOACL) && fs.has_acls (); }
!   bool hasgood_inode () const {return 0; }
    bool isgood_inode (__ino64_t ino) const;
    int has_symlinks () const {return path_flags & PATH_HAS_SYMLINKS;}
    int has_buggy_open () const {return fs.has_buggy_open ();}
***************
*** 168,202 ****
    path_conv (const device& in_dev)
    : fileattr (INVALID_FILE_ATTRIBUTES), wide_path (NULL), path (NULL),
      path_flags (0), known_suffix (NULL), normalized_path (NULL), error (0),
!     dev (in_dev)
    {
      set_path (in_dev.native);
    }
  
    path_conv (int, const char *src, unsigned opt = PC_SYM_FOLLOW,
  	     const suffix_info *suffixes = NULL)
!   : wide_path (NULL), path (NULL), normalized_path (NULL)
    {
      check (src, opt, suffixes);
    }
  
    path_conv (const UNICODE_STRING *src, unsigned opt = PC_SYM_FOLLOW,
  	     const suffix_info *suffixes = NULL)
!   : wide_path (NULL), path (NULL), normalized_path (NULL)
    {
      check (src, opt | PC_NULLEMPTY, suffixes);
    }
  
    path_conv (const char *src, unsigned opt = PC_SYM_FOLLOW,
  	     const suffix_info *suffixes = NULL)
!   : wide_path (NULL), path (NULL), normalized_path (NULL)
    {
      check (src, opt | PC_NULLEMPTY, suffixes);
    }
  
    path_conv ()
    : fileattr (INVALID_FILE_ATTRIBUTES), wide_path (NULL), path (NULL),
!     path_flags (0), known_suffix (NULL), normalized_path (NULL), error (0)
    {}
  
    ~path_conv ();
--- 181,216 ----
    path_conv (const device& in_dev)
    : fileattr (INVALID_FILE_ATTRIBUTES), wide_path (NULL), path (NULL),
      path_flags (0), known_suffix (NULL), normalized_path (NULL), error (0),
!     dev (in_dev), fi_updated (0)
    {
      set_path (in_dev.native);
    }
  
    path_conv (int, const char *src, unsigned opt = PC_SYM_FOLLOW,
  	     const suffix_info *suffixes = NULL)
!   : wide_path (NULL), path (NULL), normalized_path (NULL), fi_updated (0)
    {
      check (src, opt, suffixes);
    }
  
    path_conv (const UNICODE_STRING *src, unsigned opt = PC_SYM_FOLLOW,
  	     const suffix_info *suffixes = NULL)
!   : wide_path (NULL), path (NULL), normalized_path (NULL), fi_updated (0)
    {
      check (src, opt | PC_NULLEMPTY, suffixes);
    }
  
    path_conv (const char *src, unsigned opt = PC_SYM_FOLLOW,
  	     const suffix_info *suffixes = NULL)
!   : wide_path (NULL), path (NULL), normalized_path (NULL), fi_updated (0)
    {
      check (src, opt | PC_NULLEMPTY, suffixes);
    }
  
    path_conv ()
    : fileattr (INVALID_FILE_ATTRIBUTES), wide_path (NULL), path (NULL),
!     path_flags (0), known_suffix (NULL), normalized_path (NULL), error (0),
!     fi_updated (0)
    {}
  
    ~path_conv ();
Index: winsup/cygwin/pseudo-reloc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pseudo-reloc.cc,v
retrieving revision 1.4
diff -c -r1.4 pseudo-reloc.cc
*** winsup/cygwin/pseudo-reloc.cc	26 Oct 2009 14:50:09 -0000	1.4
--- winsup/cygwin/pseudo-reloc.cc	26 May 2010 09:01:33 -0000
***************
*** 109,115 ****
                       1);
  
    if (modulelen > 0)
!     posix_module = cygwin_create_path (CCP_WIN_W_TO_POSIX, module);
  
    va_start (args, msg);
    len = (DWORD) vsnprintf (buf, SHORT_MSG_BUF_SZ, msg, args);
--- 109,115 ----
                       1);
  
    if (modulelen > 0)
!     posix_module = (char*)cygwin_create_path (CCP_WIN_W_TO_POSIX, module);
  
    va_start (args, msg);
    len = (DWORD) vsnprintf (buf, SHORT_MSG_BUF_SZ, msg, args);
Index: winsup/cygwin/security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.240
diff -c -r1.240 security.cc
*** winsup/cygwin/security.cc	26 Feb 2010 14:51:59 -0000	1.240
--- winsup/cygwin/security.cc	26 May 2010 09:01:34 -0000
***************
*** 26,35 ****
--- 26,192 ----
  #include "pwdgrp.h"
  #include <aclapi.h>
  
+ extern "C" {
+ NTSTATUS WINAPI RtlGetOwnerSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, PSID *Owner,
+     PBOOLEAN OwnerDefaulted);
+ NTSTATUS WINAPI RtlGetGroupSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, PSID *Group,
+     PBOOLEAN GroupDefaulted);
+ NTSTATUS WINAPI RtlGetDaclSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor,
+     PBOOLEAN DaclPresent, PACL *Dacl, PBOOLEAN DaclDefaulted);
+ NTSTATUS WINAPI RtlGetSaclSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, PBOOLEAN SaclPresent, PACL *Sacl,
+     PBOOLEAN SaclDefaulted);
+ ULONG WINAPI RtlLengthSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor);
+ NTSTATUS WINAPI RtlCreateSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, ULONG Revision);
+ NTSTATUS WINAPI RtlCopySid(ULONG DestinationSidLength, PSID DestinationSid,
+   PSID SourceSid);
+ ULONG WINAPI RtlLengthSid (PSID Sid);
+ NTSTATUS WINAPI RtlSetOwnerSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, PSID Owner,
+     BOOLEAN OwnerDefaulted);
+ NTSTATUS WINAPI RtlSetGroupSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, PSID Group,
+     BOOLEAN GroupDefaulted);
+ NTSTATUS WINAPI RtlSetDaclSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, BOOLEAN DaclPresent, PACL Dacl,
+     BOOLEAN DaclDefaulted);
+ NTSTATUS WINAPI RtlSetSaclSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, BOOLEAN SaclPresent, PACL Sacl,
+     BOOLEAN SaclDefaulted);
+ }
+ 
+ #define IF_PTR_SET(ptr, val) \
+ do { \
+     if (ptr) \
+         *(ptr) = val; \
+ } while (0)
+ DWORD zGetSecurityDescriptorParts(PISECURITY_DESCRIPTOR sd,
+     SECURITY_INFORMATION si, PSID *sido, PSID *sidg,
+     PACL *dacl, PACL *sacl, PSECURITY_DESCRIPTOR *out_sd)
+ {
+     NTSTATUS stat = 0;
+     PISECURITY_DESCRIPTOR _out_sd = NULL;
+     PACL _dacl = NULL, _sacl = NULL;
+     BOOLEAN unused, have_param;
+     DWORD ret = NO_ERROR;
+     char *buf;
+     PSID owner = NULL, group = NULL;
+     IF_PTR_SET(sido, NULL);
+     IF_PTR_SET(sidg, NULL);
+     IF_PTR_SET(dacl, NULL);
+     IF_PTR_SET(sacl, NULL);
+     *out_sd = NULL;
+     if ((stat = RtlGetOwnerSecurityDescriptor(sd, &owner, &unused)))
+ 	goto Exit;
+     if ((stat = RtlGetGroupSecurityDescriptor(sd, &group, &unused)))
+ 	goto Exit;
+     if ((stat = RtlGetDaclSecurityDescriptor(sd, &have_param, &_dacl,
+ 	&unused)))
+     {
+ 	goto Exit;
+     }
+     if (!have_param)
+ 	_dacl = NULL;
+     if ((stat = RtlGetSaclSecurityDescriptor(sd, &have_param, &_sacl,
+ 	&unused)))
+     {
+ 	goto Exit;
+     }
+     if (!have_param)
+ 	_sacl = NULL;
+     _out_sd = (PISECURITY_DESCRIPTOR)LocalAlloc(LPTR,
+ 	RtlLengthSecurityDescriptor(sd));
+     RtlCreateSecurityDescriptor(_out_sd, SECURITY_DESCRIPTOR_REVISION);
+     buf = (char *)_out_sd + sizeof(SECURITY_DESCRIPTOR);
+     if (si & OWNER_SECURITY_INFORMATION)
+     {
+ 	if (!owner)
+ 	{
+ 	    ret = ERROR_NO_SECURITY_ON_OBJECT;
+ 	    goto Exit;
+ 	}
+ 	RtlCopySid(RtlLengthSid(owner), (PSID)buf, owner);
+ 	RtlSetOwnerSecurityDescriptor(_out_sd, (PSID)buf, 0);
+ 	buf += RtlLengthSid(owner);
+ 	IF_PTR_SET(sido, _out_sd->Owner);
+     }
+     if (si & GROUP_SECURITY_INFORMATION)
+     {
+ 	if (!group)
+ 	{
+ 	    ret = ERROR_NO_SECURITY_ON_OBJECT;
+ 	    goto Exit;
+ 	}
+ 	RtlCopySid(RtlLengthSid(group), (PSID)buf, group);
+ 	RtlSetGroupSecurityDescriptor(_out_sd, (PSID)buf, 0);
+ 	buf += RtlLengthSid(group);
+ 	IF_PTR_SET(sidg, _out_sd->Group);
+     }
+     if ((si & DACL_SECURITY_INFORMATION) && _dacl)
+     {
+ 	memcpy(buf, _dacl, _dacl->AclSize);
+ 	RtlSetDaclSecurityDescriptor(_out_sd, 1, (ACL *)buf, 0);
+ 	IF_PTR_SET(dacl, _out_sd->Dacl);
+     }
+     if ((si & SACL_SECURITY_INFORMATION) && _sacl)
+     {
+         memcpy(buf, _sacl, _sacl->AclSize);
+         RtlSetSaclSecurityDescriptor(_out_sd, 1, (ACL *)buf, 0);
+ 	IF_PTR_SET(sacl, _out_sd->Sacl);
+     }
+     *out_sd = _out_sd;
+     _out_sd = NULL;
+ Exit:
+     if (stat)
+ 	ret = RtlNtStatusToDosError(stat);
+     if (_out_sd)
+ 	LocalFree(_out_sd);
+     return ret;
+ }
+ 
+ #define PSD_BASE_LENGTH 1024
+ DWORD zGetSecurityInfo(HANDLE fh, SE_OBJECT_TYPE ObjectType,
+     SECURITY_INFORMATION SecurityInfo, PSID *ppsidOwner, PSID *ppsidGroup,
+     PACL *ppDacl, PACL *ppSacl, PSECURITY_DESCRIPTOR *ppSecurityDescriptor)
+ {
+     ULONG bytes_needed = 0;
+     int ret;
+     if ((ret = NtQuerySecurityObject(fh, SecurityInfo,
+ 	(PISECURITY_DESCRIPTOR)_my_tls.locals.security_buf,
+ 	_my_tls.locals.security_buf_len, &bytes_needed)))
+     {
+ 	if (ret!=STATUS_BUFFER_TOO_SMALL)
+ 	    return RtlNtStatusToDosError(ret);
+ 	_my_tls.locals.security_buf = realloc(_my_tls.locals.security_buf,
+ 	    bytes_needed);
+ 	_my_tls.locals.security_buf_len = bytes_needed;
+ 	if ((ret = NtQuerySecurityObject(fh, SecurityInfo,
+ 	    (PISECURITY_DESCRIPTOR)_my_tls.locals.security_buf,
+ 	    _my_tls.locals.security_buf_len, &bytes_needed)))
+ 	{
+ 	    return ret;
+ 	}
+     }
+     if (ret==NO_ERROR)
+     {
+ 	return zGetSecurityDescriptorParts(
+ 	    (PISECURITY_DESCRIPTOR)_my_tls.locals.security_buf,
+ 	    SecurityInfo, ppsidOwner, ppsidGroup, ppDacl, ppSacl,
+ 	    ppSecurityDescriptor);
+     }
+     return ret;
+ }
+ 
  #define ALL_SECURITY_INFORMATION (DACL_SECURITY_INFORMATION \
  				  | GROUP_SECURITY_INFORMATION \
  				  | OWNER_SECURITY_INFORMATION)
  
+ int use_zGetSecurityInfo = 1;
  LONG
  get_file_sd (HANDLE fh, path_conv &pc, security_descriptor &sd)
  {
***************
*** 38,83 ****
    int res = -1;
  
    for (; retry < 2; ++retry)
!     {
        if (fh)
! 	{
  	  /* Amazing but true.  If you want to know if an ACE is inherited
! 	     from the parent object, you can't use the NtQuerySecurityObject
! 	     function.  In the DACL returned by this functions, the
! 	     INHERITED_ACE flag is never set.  Only by calling GetSecurityInfo
! 	     you get this information.  Oh well. */
  	  PSECURITY_DESCRIPTOR psd;
! 	  error = GetSecurityInfo (fh, SE_FILE_OBJECT, ALL_SECURITY_INFORMATION,
! 				   NULL, NULL, NULL, NULL, &psd);
  	  if (error == ERROR_SUCCESS)
! 	    {
  	      sd = psd;
  	      res = 0;
  	      break;
! 	    }
! 	}
        if (!retry)
! 	{
  	  OBJECT_ATTRIBUTES attr;
  	  IO_STATUS_BLOCK io;
  	  NTSTATUS status;
  
  	  status = NtOpenFile (&fh, READ_CONTROL,
! 			       pc.get_object_attr (attr, sec_none_nih),
! 			       &io, FILE_SHARE_VALID_FLAGS,
! 			       FILE_OPEN_FOR_BACKUP_INTENT);
  	  if (!NT_SUCCESS (status))
! 	    {
  	      fh = NULL;
  	      error = RtlNtStatusToDosError (status);
  	      break;
! 	    }
! 	}
!     }
    if (retry && fh)
!     NtClose (fh);
    if (error != ERROR_SUCCESS)
!     __seterrno_from_win_error (error);
    return res;
  }
  
--- 195,248 ----
    int res = -1;
  
    for (; retry < 2; ++retry)
!   {
        if (fh)
!       {
  	  /* Amazing but true.  If you want to know if an ACE is inherited
! 	   * from the parent object, you can't use the NtQuerySecurityObject
! 	   * function.  In the DACL returned by this functions, the
! 	   * INHERITED_ACE flag is never set.  Only by calling GetSecurityInfo
! 	   * you get this information.  Oh well. */
  	  PSECURITY_DESCRIPTOR psd;
! 	  if (use_zGetSecurityInfo)
! 	  {
! 	      error = zGetSecurityInfo (fh, SE_FILE_OBJECT, 
! 		  ALL_SECURITY_INFORMATION, NULL, NULL, NULL, NULL, &psd);
! 	  }
! 	  else
! 	  {
! 	      error = GetSecurityInfo (fh, SE_FILE_OBJECT, 
! 		  ALL_SECURITY_INFORMATION, NULL, NULL, NULL, NULL, &psd);
! 	  }
  	  if (error == ERROR_SUCCESS)
! 	  {
  	      sd = psd;
  	      res = 0;
  	      break;
! 	  }
!       }
        if (!retry)
!       {
  	  OBJECT_ATTRIBUTES attr;
  	  IO_STATUS_BLOCK io;
  	  NTSTATUS status;
  
  	  status = NtOpenFile (&fh, READ_CONTROL,
! 	      pc.get_object_attr (attr, sec_none_nih),
! 	      &io, FILE_SHARE_VALID_FLAGS,
! 	      FILE_OPEN_FOR_BACKUP_INTENT);
  	  if (!NT_SUCCESS (status))
! 	  {
  	      fh = NULL;
  	      error = RtlNtStatusToDosError (status);
  	      break;
! 	  }
!       }
!   }
    if (retry && fh)
!       NtClose (fh);
    if (error != ERROR_SUCCESS)
!       __seterrno_from_win_error (error);
    return res;
  }


--------------040500050507090006070802
Content-Type: text/plain;
 name="cygwin_1_7_7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin_1_7_7.patch"
Content-length: 34666

Index: winsup/cygwin/cygtls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygtls.cc,v
retrieving revision 1.72
diff -c -r1.72 cygtls.cc
*** winsup/cygwin/cygtls.cc	28 Feb 2010 15:54:25 -0000	1.72
--- winsup/cygwin/cygtls.cc	1 Sep 2010 14:03:29 -0000
***************
*** 161,166 ****
--- 161,167 ----
        free_local (protoent_buf);
        free_local (servent_buf);
        free_local (hostent_buf);
+       free_local (security_buf);
      }
  
    /* Free temporary TLS path buffers. */
Index: winsup/cygwin/cygtls.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygtls.h,v
retrieving revision 1.66
diff -c -r1.66 cygtls.h
*** winsup/cygwin/cygtls.h	2 Mar 2010 00:49:15 -0000	1.66
--- winsup/cygwin/cygtls.h	1 Sep 2010 14:03:29 -0000
***************
*** 144,149 ****
--- 144,153 ----
  
    /* All functions requiring temporary path buffers. */
    tls_pathbuf pathbufs;
+ 
+   /* security.cc */
+   void *security_buf;
+   int security_buf_len;
  };
  
  typedef struct struct_waitq
Index: winsup/cygwin/environ.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.183
diff -c -r1.183 environ.cc
*** winsup/cygwin/environ.cc	18 May 2010 14:30:50 -0000	1.183
--- winsup/cygwin/environ.cc	1 Sep 2010 14:03:30 -0000
***************
*** 34,39 ****
--- 34,44 ----
  extern bool dos_file_warning;
  extern bool ignore_case_with_glob;
  extern bool allow_winsymlinks;
+ extern bool fast_symlink_check;
+ extern bool fast_security_info;
+ extern bool use_acl;
+ extern bool use_fs_info_cache;
+ extern bool inode_from_hash;
  bool reset_com = false;
  static bool envcache = true;
  static bool create_upcaseenv = false;
***************
*** 605,610 ****
--- 610,620 ----
    {"tty", {NULL}, set_process_state, NULL, {{0}, {PID_USETTY}}},
    {"upcaseenv", {&create_upcaseenv}, justset, NULL, {{false}, {true}}},
    {"winsymlinks", {&allow_winsymlinks}, justset, NULL, {{false}, {true}}},
+   {"fast_symlink_check", {&fast_symlink_check}, justset, NULL, {{false}, {true}}},
+   {"use_acl", {&use_acl}, justset, NULL, {{false}, {true}}},
+   {"use_fs_info_cache", {&use_fs_info_cache}, justset, NULL, {{false}, {true}}},
+   {"inode_from_hash", {&inode_from_hash}, justset, NULL, {{false}, {true}}},
+   {"fast_security_info", {&fast_security_info}, justset, NULL, {{false}, {true}}},
    {NULL, {0}, justset, 0, {{0}, {0}}}
  };
  
***************
*** 616,621 ****
--- 626,632 ----
    int istrue;
    char *p, *lasts;
    parse_thing *k;
+   TCHAR exe_name[MAX_PATH];
  
    if (buf == NULL)
      {
***************
*** 694,699 ****
--- 705,717 ----
  	    break;
  	  }
        }
+   if (GetModuleFileName(0, exe_name, MAX_PATH) && (strstr(exe_name, "chmod") ||
+       strstr(exe_name, "chown") || strstr(exe_name, "chgrp")))
+   {
+       use_acl = 1;
+   }
+   if (!inode_from_hash)
+       use_acl = 1;
    debug_printf ("returning");
  }
  
Index: winsup/cygwin/fhandler_disk_file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.334
diff -c -r1.334 fhandler_disk_file.cc
*** winsup/cygwin/fhandler_disk_file.cc	20 Aug 2010 11:18:58 -0000	1.334
--- winsup/cygwin/fhandler_disk_file.cc	1 Sep 2010 14:03:31 -0000
***************
*** 30,35 ****
--- 30,37 ----
  #define _COMPILING_NEWLIB
  #include <dirent.h>
  
+ bool inode_from_hash = true;
+ 
  class __DIR_mounts
  {
    int		 count;
***************
*** 140,145 ****
--- 142,149 ----
  inline bool
  path_conv::isgood_inode (__ino64_t ino) const
  {
+   if (inode_from_hash)
+     return 0;
    /* We can't trust remote inode numbers of only 32 bit.  That means,
       all remote inode numbers when running under NT4, as well as remote NT4
       NTFS, as well as shares of Samba version < 3.0.
***************
*** 417,427 ****
  		       get_dev (),
  		       fsi.EndOfFile.QuadPart,
  		       fsi.AllocationSize.QuadPart,
! 		       ino,
  		       fsi.NumberOfLinks,
  		       fi.fbi.FileAttributes);
  }
  
  int __stdcall
  fhandler_base::fstat_by_name (struct __stat64 *buf)
  {
--- 421,450 ----
  		       get_dev (),
  		       fsi.EndOfFile.QuadPart,
  		       fsi.AllocationSize.QuadPart,
! 		       inode_from_hash ? 0 : fii.FileId.QuadPart,
  		       fsi.NumberOfLinks,
  		       fi.fbi.FileAttributes);
  }
  
+ int path_conv_update_fi(path_conv *pc, PUNICODE_STRING path)
+ {
+     WCHAR _path[MAX_PATH];
+     if (path->Length>MAX_PATH)
+ 	return 0;
+     memcpy(_path, path->Buffer, path->Length);
+     _path[path->Length/sizeof(WCHAR)] = 0;
+     if (pc->fi_updated > 0 && !wcscmp(pc->fi_path, _path))
+ 	return pc->fi_updated;
+     wcscpy(pc->fi_path, _path);
+     OBJECT_ATTRIBUTES attr;
+     InitializeObjectAttributes(&attr, path,
+ 	pc->objcaseinsensitive() , NULL, NULL);
+     pc->fi_updated = NtQueryFullAttributesFile(&attr,
+ 	(PFILE_NETWORK_OPEN_INFORMATION)&pc->fi) ? -1 : 1;
+     return pc->fi_updated;
+ }
+ 
+ static int use_fast_api = 1;
  int __stdcall
  fhandler_base::fstat_by_name (struct __stat64 *buf)
  {
***************
*** 437,442 ****
--- 460,479 ----
    } fdi_buf;
    LARGE_INTEGER FileId;
  
+   if (use_fast_api)
+   {
+       debug_printf ("start fstat_by_name");
+       if (path_conv_update_fi(&pc, pc.get_nt_native_path())<0)
+ 	  goto too_bad;
+       if (pc.is_rep_symlink())
+ 	  pc.fi.FileAttributes &= ~FILE_ATTRIBUTE_DIRECTORY;
+       pc.file_attributes(pc.fi.FileAttributes);
+       return fstat_helper (buf,
+ 	  &pc.fi.ChangeTime, &pc.fi.LastAccessTime, &pc.fi.LastWriteTime,
+ 	  &pc.fi.CreationTime, pc.fs_serial_number (),
+ 	  pc.fi.EndOfFile.QuadPart, pc.fi.AllocationSize.QuadPart, 0, 1,
+ 	  pc.fi.FileAttributes);
+   }
    RtlSplitUnicodePath (pc.get_nt_native_path (), &dirname, &basename);
    InitializeObjectAttributes (&attr, &dirname, pc.objcaseinsensitive (),
  			      NULL, NULL);
***************
*** 509,515 ****
  fhandler_base::fstat_fs (struct __stat64 *buf)
  {
    int res = -1;
-   int oret;
    int open_flags = O_RDONLY | O_BINARY;
  
    if (get_stat_handle ())
--- 546,551 ----
***************
*** 520,536 ****
  	res = fstat_by_name (buf);
        return res;
      }
!   /* First try to open with generic read access.  This allows to read the file
!      in fstat_helper (when checking for executability) without having to
!      re-open it.  Opening a file can take a lot of time on network drives
!      so we try to avoid that. */
!   oret = open_fs (open_flags, 0);
!   if (!oret)
!     {
!       query_open (query_read_attributes);
!       oret = open_fs (open_flags, 0);
!     }
!   if (oret)
      {
        /* We now have a valid handle, regardless of the "nohandle" state.
  	 Since fhandler_base::open only calls CloseHandle if !nohandle,
--- 556,564 ----
  	res = fstat_by_name (buf);
        return res;
      }
!   query_open (query_read_attributes);
!   res = fstat_by_name (buf);
!   if (res && open_fs (open_flags, 0))
      {
        /* We now have a valid handle, regardless of the "nohandle" state.
  	 Since fhandler_base::open only calls CloseHandle if !nohandle,
***************
*** 543,550 ****
        nohandle (no_handle);
        set_io_handle (NULL);
      }
-   if (res)
-     res = fstat_by_name (buf);
  
    return res;
  }
--- 571,576 ----
***************
*** 592,598 ****
  #endif
  
    /* Enforce namehash as inode number on untrusted file systems. */
!   if (nFileIndex && pc.isgood_inode (nFileIndex))
      buf->st_ino = (__ino64_t) nFileIndex;
    else
      buf->st_ino = get_ino ();
--- 618,624 ----
  #endif
  
    /* Enforce namehash as inode number on untrusted file systems. */
!   if (!inode_from_hash && nFileIndex && pc.isgood_inode (nFileIndex))
      buf->st_ino = (__ino64_t) nFileIndex;
    else
      buf->st_ino = get_ino ();
Index: winsup/cygwin/mount.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/mount.cc,v
retrieving revision 1.64
diff -c -r1.64 mount.cc
*** winsup/cygwin/mount.cc	25 Aug 2010 09:20:11 -0000	1.64
--- winsup/cygwin/mount.cc	1 Sep 2010 14:03:32 -0000
***************
*** 18,23 ****
--- 18,24 ----
  #include <winuser.h>
  #include <winnetwk.h>
  #include <shlobj.h>
+ #include <stdio.h>
  #include <cygwin/version.h>
  #include "cygerrno.h"
  #include "security.h"
***************
*** 48,53 ****
--- 49,56 ----
  bool NO_COPY mount_info::got_usr_bin;
  bool NO_COPY mount_info::got_usr_lib;
  int NO_COPY mount_info::root_idx = -1;
+ bool use_acl = false;
+ bool use_fs_info_cache = true;
  
  /* is_unc_share: Return non-zero if PATH begins with //server/share
  		 or with one of the native prefixes //./ or //?/
***************
*** 105,110 ****
--- 108,216 ----
  };
  #pragma pack(pop)
  
+ typedef struct fs_info_list_t {
+     struct fs_info_list_t *next;
+     fs_info fsi;
+     wchar_t path[MAX_PATH];
+     int path_len;
+ } fs_info_list_t;
+ 
+ static fs_info_list_t *fs_info_list;
+ static int in_fs_info_update;
+ 
+ int fs_info_lookup(fs_info *fsi, PUNICODE_STRING upath)
+ {
+     int shortest = 0;
+     fs_info_list_t *f, *found = NULL;
+     if (in_fs_info_update)
+ 	return 0;
+     /* find first (longest match) */
+     for (f = fs_info_list; f != NULL; f=f->next)
+     {
+ 	if (!wcsncmp(f->path, upath->Buffer, f->path_len))
+ 	{
+ 	    if (!shortest || shortest > f->path_len)
+ 	    {
+ 		shortest = f->path_len;
+ 		found = f;
+ 	    }
+ 	}
+     }
+     if (!found)
+ 	return 0;
+     memcpy(fsi, &found->fsi, sizeof(fsi));
+     return 1;
+ }
+ 
+ static inline int fs_info_eq(fs_info *a, fs_info *b)
+ {
+     return a->serial_number()==b->serial_number() &&
+ 	!memcmp(&a->status, &b->status, sizeof(a->status));
+ }
+ 
+ static void fs_info_update(fs_info *fsi, PUNICODE_STRING upath)
+ {
+     wchar_t scan_path[MAX_PATH], save, *p;
+     fs_info *_fsi, *scan = NULL;
+     fs_info_list_t *f;
+     UNICODE_STRING  ustr;
+     if (in_fs_info_update)
+ 	return;
+     in_fs_info_update++;
+     _fsi = new fs_info();
+     _fsi->update(upath, NULL);
+     /* sanity check */
+     if (!fs_info_eq(_fsi, fsi))
+     {
+ 	debug_printf("fs_info_update: strange: got different volume");
+ 	delete _fsi;
+ 	goto Exit;
+     }
+     /* scan up the path to find the base directory of the mount */
+     wcscpy(scan_path, upath->Buffer);
+     while ((p=wcsrchr(scan_path, '\\')))
+     {
+ 	save = *p;
+ 	*p = 0;
+ 	if (p==scan_path)
+ 	{
+ 	    *p = save;
+ 	    break;
+ 	}
+ 	if (scan)
+ 	    delete scan;
+ 	scan = new fs_info();
+ 	ustr.Buffer = scan_path;
+ 	ustr.Length = wcslen(scan_path);
+ 	ustr.MaximumLength = sizeof(scan_path);
+ 	if (!scan->update(&ustr, NULL) || !fs_info_eq(scan, fsi))
+ 	{
+ 	    *p = save;
+ 	    break;
+ 	}
+     }
+     if (scan)
+ 	delete scan;
+     f = (fs_info_list_t*)calloc(sizeof(*f), 1);
+     memcpy(&f->fsi, _fsi, sizeof(_fsi));
+     f->path_len = wcslen(scan_path);
+     wcscpy(f->path, scan_path);
+     f->next = fs_info_list;
+     fs_info_list = f;
+ Exit:
+     in_fs_info_update--;
+ }
+ 
+ bool fs_info::has_acls(bool val)
+ {
+     return (bool) (status.has_acls = val);
+ }
+ 
+ bool fs_info::has_acls() const
+ {
+     return use_acl ? status.has_acls : 0;
+ }
+ 
  bool
  fs_info::update (PUNICODE_STRING upath, HANDLE in_vol)
  {
***************
*** 124,130 ****
      WCHAR buf[NAME_MAX + 1];
    } ffvi_buf;
    UNICODE_STRING fsname;
! 
    clear ();
    if (in_vol)
      vol = in_vol;
--- 230,237 ----
      WCHAR buf[NAME_MAX + 1];
    } ffvi_buf;
    UNICODE_STRING fsname;
!   if (use_fs_info_cache && !use_acl && fs_info_lookup(this, upath))
!       return true;
    clear ();
    if (in_vol)
      vol = in_vol;
***************
*** 355,360 ****
--- 462,470 ----
  
    if (!in_vol)
      NtClose (vol);
+ 
+   if (use_fs_info_cache && !use_acl)
+       fs_info_update(this, upath);
    return true;
  }
  
Index: winsup/cygwin/mount.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/mount.h,v
retrieving revision 1.14
diff -c -r1.14 mount.h
*** winsup/cygwin/mount.h	9 Aug 2010 08:18:30 -0000	1.14
--- winsup/cygwin/mount.h	1 Sep 2010 14:03:32 -0000
***************
*** 43,48 ****
--- 43,53 ----
  
  class fs_info
  {
+   ULONG sernum;			/* Volume Serial Number */
+   char fsn[80];			/* Windows filesystem name */
+   unsigned long got_fs () const { return status.fs_type != none; }
+ 
+  public:
    struct status_flags
    {
      ULONG flags;		/* Volume flags */
***************
*** 58,68 ****
      unsigned has_buggy_basic_info	: 1;
      unsigned has_dos_filenames_only	: 1;
    } status;
-   ULONG sernum;			/* Volume Serial Number */
-   char fsn[80];			/* Windows filesystem name */
-   unsigned long got_fs () const { return status.fs_type != none; }
  
-  public:
    void clear ()
    {
      memset (&status, 0 , sizeof status);
--- 63,69 ----
***************
*** 75,81 ****
    IMPLEMENT_STATUS_FLAG (ULONG, samba_version)
    IMPLEMENT_STATUS_FLAG (ULONG, name_len)
    IMPLEMENT_STATUS_FLAG (bool, is_remote_drive)
!   IMPLEMENT_STATUS_FLAG (bool, has_acls)
    IMPLEMENT_STATUS_FLAG (bool, hasgood_inode)
    IMPLEMENT_STATUS_FLAG (bool, caseinsensitive)
    IMPLEMENT_STATUS_FLAG (bool, has_buggy_open)
--- 76,83 ----
    IMPLEMENT_STATUS_FLAG (ULONG, samba_version)
    IMPLEMENT_STATUS_FLAG (ULONG, name_len)
    IMPLEMENT_STATUS_FLAG (bool, is_remote_drive)
!   bool has_acls(bool val);
!   bool has_acls() const;
    IMPLEMENT_STATUS_FLAG (bool, hasgood_inode)
    IMPLEMENT_STATUS_FLAG (bool, caseinsensitive)
    IMPLEMENT_STATUS_FLAG (bool, has_buggy_open)
Index: winsup/cygwin/path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.604
diff -c -r1.604 path.cc
*** winsup/cygwin/path.cc	27 Aug 2010 17:58:43 -0000	1.604
--- winsup/cygwin/path.cc	1 Sep 2010 14:03:34 -0000
***************
*** 73,79 ****
  #include <wchar.h>
  #include <wctype.h>
  
! bool dos_file_warning = true;
  
  suffix_info stat_suffixes[] =
  {
--- 73,80 ----
  #include <wchar.h>
  #include <wctype.h>
  
! bool dos_file_warning = false;
! bool fast_symlink_check = true;
  
  suffix_info stat_suffixes[] =
  {
***************
*** 97,103 ****
    _minor_t minor;
    _mode_t mode;
    int check (char *path, const suffix_info *suffixes, fs_info &fs,
! 	     path_conv_handle &conv_hdl);
    int set (char *path);
    bool parse_device (const char *);
    int check_sysfile (HANDLE h);
--- 98,104 ----
    _minor_t minor;
    _mode_t mode;
    int check (char *path, const suffix_info *suffixes, fs_info &fs,
!             path_conv_handle &conv_hdl, path_conv *pc);
    int set (char *path);
    bool parse_device (const char *);
    int check_sysfile (HANDLE h);
***************
*** 826,832 ****
  	  if (is_msdos)
  	    sym.pflags |= PATH_NOPOSIX | PATH_NOACL;
  
! 	  symlen = sym.check (full_path, suff, fs, conv_handle);
  
  is_virtual_symlink:
  
--- 827,833 ----
  	  if (is_msdos)
  	    sym.pflags |= PATH_NOPOSIX | PATH_NOACL;
  
! 	  symlen = sym.check (full_path, suff, fs, conv_handle, this);
  
  is_virtual_symlink:
  
***************
*** 2183,2193 ****
  
  int
  symlink_info::check (char *path, const suffix_info *suffixes, fs_info &fs,
! 		     path_conv_handle &conv_hdl)
  {
    int res;
    HANDLE h;
    NTSTATUS status;
    UNICODE_STRING upath;
    OBJECT_ATTRIBUTES attr;
    IO_STATUS_BLOCK io;
--- 2184,2195 ----
  
  int
  symlink_info::check (char *path, const suffix_info *suffixes, fs_info &fs,
! 		     path_conv_handle &conv_hdl, path_conv *pc)
  {
    int res;
    HANDLE h;
    NTSTATUS status;
+   LARGE_INTEGER filesize =  { QuadPart:0LL };
    UNICODE_STRING upath;
    OBJECT_ATTRIBUTES attr;
    IO_STATUS_BLOCK io;
***************
*** 2225,2230 ****
--- 2227,2254 ----
  
  # define MIN_STAT_ACCESS	(READ_CONTROL | FILE_READ_ATTRIBUTES)
  # define FULL_STAT_ACCESS	(SYNCHRONIZE | GENERIC_READ)
+ 
+ #define OPEN_IF_NEEDED() \
+       if (!h) \
+       { \
+ 	  status = NtCreateFile (&h, \
+ 	      access = FULL_STAT_ACCESS, &attr, &io, NULL, 0, \
+ 	      FILE_SHARE_VALID_FLAGS, FILE_OPEN, \
+ 	      FILE_OPEN_REPARSE_POINT | FILE_OPEN_FOR_BACKUP_INTENT, \
+ 	      eabuf, easize); \
+           if (status == STATUS_ACCESS_DENIED) \
+ 	  { \
+ 	      status = NtCreateFile (&h, access = MIN_STAT_ACCESS, &attr, &io, \
+ 				 NULL, 0, FILE_SHARE_VALID_FLAGS, FILE_OPEN, \
+ 				 FILE_OPEN_REPARSE_POINT \
+ 				 | FILE_OPEN_FOR_BACKUP_INTENT, \
+ 				 eabuf, easize); \
+ 	      debug_printf ("%p = NtCreateFile (2:%S)", status, &upath); \
+ 	} \
+         else \
+ 	  debug_printf ("%p = NtCreateFile (1:%S)", status, &upath); \
+       }
+ 
    ACCESS_MASK access = 0;
  
    bool had_ext = !!*ext_here;
***************
*** 2239,2244 ****
--- 2263,2282 ----
  	  NtClose (h);
  	  h = NULL;
  	}
+       if (fast_symlink_check)
+       {
+ 	  filesize.QuadPart = 0LL;
+ 	  if (path_conv_update_fi(pc, &upath)>0)
+ 	  {
+ 	      status = 0;
+ 	      fileattr = pc->fi.FileAttributes;
+ 	      filesize = pc->fi.AllocationSize;
+ 	  }
+ 	  else
+ 	      OPEN_IF_NEEDED();
+       }
+       else
+       {
        /* The EA given to NtCreateFile allows to get a handle to a symlink on
  	 an NFS share, rather than getting a handle to the target of the
  	 symlink (which would spoil the task of this method quite a bit).
***************
*** 2260,2265 ****
--- 2298,2304 ----
  	}
        else
  	debug_printf ("%p = NtCreateFile (1:%S)", status, &upath);
+       }
        /* No right to access EAs or EAs not supported? */
        if (!NT_SUCCESS (status)
  	  && (status == STATUS_ACCESS_DENIED
***************
*** 2362,2376 ****
  	    }
  	}
  
!       if (NT_SUCCESS (status)
  	  /* Check file system while we're having the file open anyway.
  	     This speeds up path_conv noticably (~10%). */
  	  && (fs.inited () || fs.update (&upath, h))
! 	  && NT_SUCCESS (status = fs.has_buggy_basic_info ()
  			 ? NtQueryAttributesFile (&attr, &fbi)
  			 : NtQueryInformationFile (h, &io, &fbi, sizeof fbi,
! 						   FileBasicInformation)))
! 	fileattr = fbi.FileAttributes;
        else
  	{
  	  debug_printf ("%p = NtQueryInformationFile (%S)", status, &upath);
--- 2401,2424 ----
  	    }
  	}
  
!      if (NT_SUCCESS (status)
  	  /* Check file system while we're having the file open anyway.
  	     This speeds up path_conv noticably (~10%). */
  	  && (fs.inited () || fs.update (&upath, h))
! 	  && (fast_symlink_check ? path_conv_update_fi(pc, &upath)>0 :
! 	     NT_SUCCESS (status = fs.has_buggy_basic_info ()
  			 ? NtQueryAttributesFile (&attr, &fbi)
  			 : NtQueryInformationFile (h, &io, &fbi, sizeof fbi,
! 						   FileBasicInformation))))
!       {
! 	  if (fast_symlink_check)
! 	  {
! 	      fileattr = pc->fi.FileAttributes;
! 	      filesize = pc->fi.AllocationSize;
! 	  }
! 	  else
! 	      fileattr = fbi.FileAttributes;
!       }
        else
  	{
  	  debug_printf ("%p = NtQueryInformationFile (%S)", status, &upath);
***************
*** 2484,2489 ****
--- 2532,2538 ----
        if ((fileattr & (FILE_ATTRIBUTE_READONLY | FILE_ATTRIBUTE_DIRECTORY))
  	  == FILE_ATTRIBUTE_READONLY && suffix.lnk_match ())
  	{
+ 	  OPEN_IF_NEEDED();
  	  if (!(access & GENERIC_READ))
  	    res = 0;
  	  else
***************
*** 2526,2531 ****
--- 2575,2581 ----
        else if ((fileattr & FILE_ATTRIBUTE_REPARSE_POINT)
  	       && !fs.is_remote_drive())
  	{
+ 	  OPEN_IF_NEEDED();
  	  res = check_reparse_point (h);
  	  if (res == -1)
  	    {
***************
*** 2550,2557 ****
  	 have the `system' file attribute.  Only files can be symlinks
  	 (which can be symlinks to directories). */
        else if ((fileattr & (FILE_ATTRIBUTE_SYSTEM | FILE_ATTRIBUTE_DIRECTORY))
! 	       == FILE_ATTRIBUTE_SYSTEM)
  	{
  	  if (!(access & GENERIC_READ))
  	    res = 0;
  	  else
--- 2600,2610 ----
  	 have the `system' file attribute.  Only files can be symlinks
  	 (which can be symlinks to directories). */
        else if ((fileattr & (FILE_ATTRIBUTE_SYSTEM | FILE_ATTRIBUTE_DIRECTORY))
! 	       == FILE_ATTRIBUTE_SYSTEM &&
! 	       (!fast_symlink_check ? 1 :
! 		   (filesize.QuadPart>strlen("!<symlink>") && filesize.QuadPart<512)))
  	{
+ 	  OPEN_IF_NEEDED();
  	  if (!(access & GENERIC_READ))
  	    res = 0;
  	  else
***************
*** 2565,2570 ****
--- 2618,2624 ----
  	 (which can be symlinks to directories). */
        else if (fs.is_nfs () && !no_ea && !(fileattr & FILE_ATTRIBUTE_DIRECTORY))
  	{
+ 	  OPEN_IF_NEEDED();
  	  if (!(access & GENERIC_READ))
  	    res = 0;
  	  else
***************
*** 2581,2586 ****
--- 2635,2642 ----
        break;
      }
  
+   if (pflags & PC_KEEP_HANDLE)
+       OPEN_IF_NEEDED();
    if (h)
      {
        if (pflags & PC_KEEP_HANDLE)
Index: winsup/cygwin/path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.145
diff -c -r1.145 path.h
*** winsup/cygwin/path.h	4 Jul 2010 17:12:26 -0000	1.145
--- winsup/cygwin/path.h	1 Sep 2010 14:03:38 -0000
***************
*** 115,121 ****
--- 115,132 ----
  };
  
  class symlink_info;
+ struct FILE_NETWORK_OPEN_INFORMATION2 {
+   LARGE_INTEGER CreationTime;
+   LARGE_INTEGER LastAccessTime;
+   LARGE_INTEGER LastWriteTime;
+   LARGE_INTEGER ChangeTime;
+   LARGE_INTEGER AllocationSize;
+   LARGE_INTEGER EndOfFile;
+   ULONG FileAttributes;
+ };
  
+ extern bool inode_from_hash;
+ int path_conv_update_fi(path_conv *pc, PUNICODE_STRING path);
  class path_conv
  {
    DWORD fileattr;
***************
*** 133,143 ****
    const char *normalized_path;
    int error;
    device dev;
  
    bool isremote () const {return fs.is_remote_drive ();}
    ULONG objcaseinsensitive () const {return caseinsensitive;}
    bool has_acls () const {return !(path_flags & PATH_NOACL) && fs.has_acls (); }
!   bool hasgood_inode () const {return !(path_flags & PATH_IHASH); }
    bool isgood_inode (__ino64_t ino) const;
    int has_symlinks () const {return path_flags & PATH_HAS_SYMLINKS;}
    int has_dos_filenames_only () const {return path_flags & PATH_DOS;}
--- 144,158 ----
    const char *normalized_path;
    int error;
    device dev;
+   int fi_updated;
+   wchar_t fi_path[MAX_PATH];
+   FILE_NETWORK_OPEN_INFORMATION2 fi;
  
    bool isremote () const {return fs.is_remote_drive ();}
    ULONG objcaseinsensitive () const {return caseinsensitive;}
    bool has_acls () const {return !(path_flags & PATH_NOACL) && fs.has_acls (); }
!   bool hasgood_inode () const {return inode_from_hash ? 0 :
!       !(path_flags & PATH_IHASH); }
    bool isgood_inode (__ino64_t ino) const;
    int has_symlinks () const {return path_flags & PATH_HAS_SYMLINKS;}
    int has_dos_filenames_only () const {return path_flags & PATH_DOS;}
***************
*** 200,206 ****
    path_conv (const device& in_dev)
    : fileattr (INVALID_FILE_ATTRIBUTES), wide_path (NULL), path (NULL),
      path_flags (0), known_suffix (NULL), normalized_path (NULL), error (0),
!     dev (in_dev)
    {
      set_path (in_dev.native);
    }
--- 215,221 ----
    path_conv (const device& in_dev)
    : fileattr (INVALID_FILE_ATTRIBUTES), wide_path (NULL), path (NULL),
      path_flags (0), known_suffix (NULL), normalized_path (NULL), error (0),
!     dev (in_dev), fi_updated (0)
    {
      set_path (in_dev.native);
    }
***************
*** 208,214 ****
    path_conv (int, const char *src, unsigned opt = PC_SYM_FOLLOW,
  	     const suffix_info *suffixes = NULL)
    : fileattr (INVALID_FILE_ATTRIBUTES), wide_path (NULL), path (NULL),
!     path_flags (0), known_suffix (NULL), normalized_path (NULL), error (0)
    {
      check (src, opt, suffixes);
    }
--- 223,230 ----
    path_conv (int, const char *src, unsigned opt = PC_SYM_FOLLOW,
  	     const suffix_info *suffixes = NULL)
    : fileattr (INVALID_FILE_ATTRIBUTES), wide_path (NULL), path (NULL),
!     path_flags (0), known_suffix (NULL), normalized_path (NULL), error (0),
!     fi_updated (0)
    {
      check (src, opt, suffixes);
    }
***************
*** 216,222 ****
    path_conv (const UNICODE_STRING *src, unsigned opt = PC_SYM_FOLLOW,
  	     const suffix_info *suffixes = NULL)
    : fileattr (INVALID_FILE_ATTRIBUTES), wide_path (NULL), path (NULL),
!     path_flags (0), known_suffix (NULL), normalized_path (NULL), error (0)
    {
      check (src, opt | PC_NULLEMPTY, suffixes);
    }
--- 232,239 ----
    path_conv (const UNICODE_STRING *src, unsigned opt = PC_SYM_FOLLOW,
  	     const suffix_info *suffixes = NULL)
    : fileattr (INVALID_FILE_ATTRIBUTES), wide_path (NULL), path (NULL),
!     path_flags (0), known_suffix (NULL), normalized_path (NULL), error (0),
!     fi_updated (0)
    {
      check (src, opt | PC_NULLEMPTY, suffixes);
    }
***************
*** 224,237 ****
    path_conv (const char *src, unsigned opt = PC_SYM_FOLLOW,
  	     const suffix_info *suffixes = NULL)
    : fileattr (INVALID_FILE_ATTRIBUTES), wide_path (NULL), path (NULL),
!     path_flags (0), known_suffix (NULL), normalized_path (NULL), error (0)
    {
      check (src, opt | PC_NULLEMPTY, suffixes);
    }
  
    path_conv ()
    : fileattr (INVALID_FILE_ATTRIBUTES), wide_path (NULL), path (NULL),
!     path_flags (0), known_suffix (NULL), normalized_path (NULL), error (0)
    {}
  
    ~path_conv ();
--- 241,256 ----
    path_conv (const char *src, unsigned opt = PC_SYM_FOLLOW,
  	     const suffix_info *suffixes = NULL)
    : fileattr (INVALID_FILE_ATTRIBUTES), wide_path (NULL), path (NULL),
!     path_flags (0), known_suffix (NULL), normalized_path (NULL), error (0),
!     fi_updated (0)
    {
      check (src, opt | PC_NULLEMPTY, suffixes);
    }
  
    path_conv ()
    : fileattr (INVALID_FILE_ATTRIBUTES), wide_path (NULL), path (NULL),
!     path_flags (0), known_suffix (NULL), normalized_path (NULL), error (0),
!     fi_updated (0)
    {}
  
    ~path_conv ();
Index: winsup/cygwin/security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.242
diff -c -r1.242 security.cc
*** winsup/cygwin/security.cc	22 Jun 2010 09:54:36 -0000	1.242
--- winsup/cygwin/security.cc	1 Sep 2010 14:03:39 -0000
***************
*** 26,31 ****
--- 26,189 ----
  #include "pwdgrp.h"
  #include <aclapi.h>
  
+ bool fast_security_info = true;
+ 
+ extern "C" {
+ NTSTATUS WINAPI RtlGetOwnerSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, PSID *Owner,
+     PBOOLEAN OwnerDefaulted);
+ NTSTATUS WINAPI RtlGetGroupSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, PSID *Group,
+     PBOOLEAN GroupDefaulted);
+ NTSTATUS WINAPI RtlGetDaclSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor,
+     PBOOLEAN DaclPresent, PACL *Dacl, PBOOLEAN DaclDefaulted);
+ NTSTATUS WINAPI RtlGetSaclSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, PBOOLEAN SaclPresent, PACL *Sacl,
+     PBOOLEAN SaclDefaulted);
+ ULONG WINAPI RtlLengthSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor);
+ NTSTATUS WINAPI RtlCreateSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, ULONG Revision);
+ NTSTATUS WINAPI RtlCopySid(ULONG DestinationSidLength, PSID DestinationSid,
+   PSID SourceSid);
+ ULONG WINAPI RtlLengthSid (PSID Sid);
+ NTSTATUS WINAPI RtlSetOwnerSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, PSID Owner,
+     BOOLEAN OwnerDefaulted);
+ NTSTATUS WINAPI RtlSetGroupSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, PSID Group,
+     BOOLEAN GroupDefaulted);
+ NTSTATUS WINAPI RtlSetDaclSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, BOOLEAN DaclPresent, PACL Dacl,
+     BOOLEAN DaclDefaulted);
+ NTSTATUS WINAPI RtlSetSaclSecurityDescriptor(
+     PSECURITY_DESCRIPTOR SecurityDescriptor, BOOLEAN SaclPresent, PACL Sacl,
+     BOOLEAN SaclDefaulted);
+ }
+ 
+ #define IF_PTR_SET(ptr, val) \
+ do { \
+     if (ptr) \
+         *(ptr) = val; \
+ } while (0)
+ DWORD zGetSecurityDescriptorParts(PISECURITY_DESCRIPTOR sd,
+     SECURITY_INFORMATION si, PSID *sido, PSID *sidg,
+     PACL *dacl, PACL *sacl, PSECURITY_DESCRIPTOR *out_sd)
+ {
+     NTSTATUS stat = 0;
+     PISECURITY_DESCRIPTOR _out_sd = NULL;
+     PACL _dacl = NULL, _sacl = NULL;
+     BOOLEAN unused, have_param;
+     DWORD ret = NO_ERROR;
+     char *buf;
+     PSID owner = NULL, group = NULL;
+     IF_PTR_SET(sido, NULL);
+     IF_PTR_SET(sidg, NULL);
+     IF_PTR_SET(dacl, NULL);
+     IF_PTR_SET(sacl, NULL);
+     *out_sd = NULL;
+     if ((stat = RtlGetOwnerSecurityDescriptor(sd, &owner, &unused)))
+ 	goto Exit;
+     if ((stat = RtlGetGroupSecurityDescriptor(sd, &group, &unused)))
+ 	goto Exit;
+     if ((stat = RtlGetDaclSecurityDescriptor(sd, &have_param, &_dacl,
+ 	&unused)))
+     {
+ 	goto Exit;
+     }
+     if (!have_param)
+ 	_dacl = NULL;
+     if ((stat = RtlGetSaclSecurityDescriptor(sd, &have_param, &_sacl,
+ 	&unused)))
+     {
+ 	goto Exit;
+     }
+     if (!have_param)
+ 	_sacl = NULL;
+     _out_sd = (PISECURITY_DESCRIPTOR)LocalAlloc(LPTR,
+ 	RtlLengthSecurityDescriptor(sd));
+     RtlCreateSecurityDescriptor(_out_sd, SECURITY_DESCRIPTOR_REVISION);
+     buf = (char *)_out_sd + sizeof(SECURITY_DESCRIPTOR);
+     if (si & OWNER_SECURITY_INFORMATION)
+     {
+ 	if (!owner)
+ 	{
+ 	    ret = ERROR_NO_SECURITY_ON_OBJECT;
+ 	    goto Exit;
+ 	}
+ 	RtlCopySid(RtlLengthSid(owner), (PSID)buf, owner);
+ 	RtlSetOwnerSecurityDescriptor(_out_sd, (PSID)buf, 0);
+ 	buf += RtlLengthSid(owner);
+ 	IF_PTR_SET(sido, _out_sd->Owner);
+     }
+     if (si & GROUP_SECURITY_INFORMATION)
+     {
+ 	if (!group)
+ 	{
+ 	    ret = ERROR_NO_SECURITY_ON_OBJECT;
+ 	    goto Exit;
+ 	}
+ 	RtlCopySid(RtlLengthSid(group), (PSID)buf, group);
+ 	RtlSetGroupSecurityDescriptor(_out_sd, (PSID)buf, 0);
+ 	buf += RtlLengthSid(group);
+ 	IF_PTR_SET(sidg, _out_sd->Group);
+     }
+     if ((si & DACL_SECURITY_INFORMATION) && _dacl)
+     {
+ 	memcpy(buf, _dacl, _dacl->AclSize);
+ 	RtlSetDaclSecurityDescriptor(_out_sd, 1, (ACL *)buf, 0);
+ 	IF_PTR_SET(dacl, _out_sd->Dacl);
+     }
+     if ((si & SACL_SECURITY_INFORMATION) && _sacl)
+     {
+         memcpy(buf, _sacl, _sacl->AclSize);
+         RtlSetSaclSecurityDescriptor(_out_sd, 1, (ACL *)buf, 0);
+ 	IF_PTR_SET(sacl, _out_sd->Sacl);
+     }
+     *out_sd = _out_sd;
+     _out_sd = NULL;
+ Exit:
+     if (stat)
+ 	ret = RtlNtStatusToDosError(stat);
+     if (_out_sd)
+ 	LocalFree(_out_sd);
+     return ret;
+ }
+ 
+ #define PSD_BASE_LENGTH 1024
+ DWORD zGetSecurityInfo(HANDLE fh, SE_OBJECT_TYPE ObjectType,
+     SECURITY_INFORMATION SecurityInfo, PSID *ppsidOwner, PSID *ppsidGroup,
+     PACL *ppDacl, PACL *ppSacl, PSECURITY_DESCRIPTOR *ppSecurityDescriptor)
+ {
+     ULONG bytes_needed = 0;
+     int ret;
+     if ((ret = NtQuerySecurityObject(fh, SecurityInfo,
+ 	(PISECURITY_DESCRIPTOR)_my_tls.locals.security_buf,
+ 	_my_tls.locals.security_buf_len, &bytes_needed)))
+     {
+ 	if (ret!=STATUS_BUFFER_TOO_SMALL)
+ 	    return RtlNtStatusToDosError(ret);
+ 	_my_tls.locals.security_buf = realloc(_my_tls.locals.security_buf,
+ 	    bytes_needed);
+ 	_my_tls.locals.security_buf_len = bytes_needed;
+ 	if ((ret = NtQuerySecurityObject(fh, SecurityInfo,
+ 	    (PISECURITY_DESCRIPTOR)_my_tls.locals.security_buf,
+ 	    _my_tls.locals.security_buf_len, &bytes_needed)))
+ 	{
+ 	    return ret;
+ 	}
+     }
+     if (ret==NO_ERROR)
+     {
+ 	return zGetSecurityDescriptorParts(
+ 	    (PISECURITY_DESCRIPTOR)_my_tls.locals.security_buf,
+ 	    SecurityInfo, ppsidOwner, ppsidGroup, ppDacl, ppSacl,
+ 	    ppSecurityDescriptor);
+     }
+     return ret;
+ }
+ 
  #define ALL_SECURITY_INFORMATION (DACL_SECURITY_INFORMATION \
  				  | GROUP_SECURITY_INFORMATION \
  				  | OWNER_SECURITY_INFORMATION)
***************
*** 38,83 ****
    int res = -1;
  
    for (; retry < 2; ++retry)
!     {
        if (fh)
! 	{
  	  /* Amazing but true.  If you want to know if an ACE is inherited
! 	     from the parent object, you can't use the NtQuerySecurityObject
! 	     function.  In the DACL returned by this functions, the
! 	     INHERITED_ACE flag is never set.  Only by calling GetSecurityInfo
! 	     you get this information.  Oh well. */
  	  PSECURITY_DESCRIPTOR psd;
! 	  error = GetSecurityInfo (fh, SE_FILE_OBJECT, ALL_SECURITY_INFORMATION,
! 				   NULL, NULL, NULL, NULL, &psd);
  	  if (error == ERROR_SUCCESS)
! 	    {
  	      sd = psd;
  	      res = 0;
  	      break;
! 	    }
! 	}
        if (!retry)
! 	{
  	  OBJECT_ATTRIBUTES attr;
  	  IO_STATUS_BLOCK io;
  	  NTSTATUS status;
  
  	  status = NtOpenFile (&fh, READ_CONTROL,
! 			       pc.get_object_attr (attr, sec_none_nih),
! 			       &io, FILE_SHARE_VALID_FLAGS,
! 			       FILE_OPEN_FOR_BACKUP_INTENT);
  	  if (!NT_SUCCESS (status))
! 	    {
  	      fh = NULL;
  	      error = RtlNtStatusToDosError (status);
  	      break;
! 	    }
! 	}
!     }
    if (retry && fh)
!     NtClose (fh);
    if (error != ERROR_SUCCESS)
!     __seterrno_from_win_error (error);
    return res;
  }
  
--- 196,249 ----
    int res = -1;
  
    for (; retry < 2; ++retry)
!   {
        if (fh)
!       {
  	  /* Amazing but true.  If you want to know if an ACE is inherited
! 	   * from the parent object, you can't use the NtQuerySecurityObject
! 	   * function.  In the DACL returned by this functions, the
! 	   * INHERITED_ACE flag is never set.  Only by calling GetSecurityInfo
! 	   * you get this information.  Oh well. */
  	  PSECURITY_DESCRIPTOR psd;
! 	  if (fast_security_info)
! 	  {
! 	      error = zGetSecurityInfo (fh, SE_FILE_OBJECT, 
! 		  ALL_SECURITY_INFORMATION, NULL, NULL, NULL, NULL, &psd);
! 	  }
! 	  else
! 	  {
! 	      error = GetSecurityInfo (fh, SE_FILE_OBJECT, 
! 		  ALL_SECURITY_INFORMATION, NULL, NULL, NULL, NULL, &psd);
! 	  }
  	  if (error == ERROR_SUCCESS)
! 	  {
  	      sd = psd;
  	      res = 0;
  	      break;
! 	  }
!       }
        if (!retry)
!       {
  	  OBJECT_ATTRIBUTES attr;
  	  IO_STATUS_BLOCK io;
  	  NTSTATUS status;
  
  	  status = NtOpenFile (&fh, READ_CONTROL,
! 	      pc.get_object_attr (attr, sec_none_nih),
! 	      &io, FILE_SHARE_VALID_FLAGS,
! 	      FILE_OPEN_FOR_BACKUP_INTENT);
  	  if (!NT_SUCCESS (status))
! 	  {
  	      fh = NULL;
  	      error = RtlNtStatusToDosError (status);
  	      break;
! 	  }
!       }
!   }
    if (retry && fh)
!       NtClose (fh);
    if (error != ERROR_SUCCESS)
!       __seterrno_from_win_error (error);
    return res;
  }


--------------040500050507090006070802--

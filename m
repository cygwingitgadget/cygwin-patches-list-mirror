Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id DC674383802D
 for <cygwin-patches@cygwin.com>; Mon, 26 Apr 2021 15:03:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DC674383802D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MNLVU-1lyc230nhi-00Osjo for <cygwin-patches@cygwin.com>; Mon, 26 Apr 2021
 17:03:57 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C8542A80CFE; Mon, 26 Apr 2021 17:03:55 +0200 (CEST)
Date: Mon, 26 Apr 2021 17:03:55 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Use automake (v5)
Message-ID: <YIbWW3mJsphIW9hd@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210420201326.4876-1-jon.turney@dronecode.org.uk>
 <5d7176f9-8d82-9b2c-4717-fdc5041d95ce@dronecode.org.uk>
 <YIBVYytjWjpdFDTo@calimero.vinschen.de>
 <YIFkrv4KPAQypN8o@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YIFkrv4KPAQypN8o@calimero.vinschen.de>
X-Provags-ID: V03:K1:1RLWrY/MECv5marmE3jt/tT5F+8tv8IfRtPe5dfUum8OHZ5kLTw
 x3xmWMSyi7FU+i8cQEZfqJxIhAksKryIDLU3A1CcRYhT+jDS2mqajs+Ek4zvZK0AnRKcBhJ
 BK743t/s1m2dReRrm2TO+Q3HzoK9NLK1pcvYsB4GbrKdDaMYlKFnf7EZMmGqaBxIgUeogLi
 dgo1uXwN9PanklFMyaXSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NK5k6du78ak=:4XsaW//ze150C6M7ofDUop
 sYm6DDZYMY/FE6ZMeTBVMhRuOyCU0/ZGnY9vzsHTN5pOJlBUDkjAUvq0D8AR4FjYXw3e79NAd
 P2SyGyvfk2Dn3ZPWueQPqLSEQrgMa5MORuFdaTCyWplhDrh4F4VmLTgXVZLCGFFct1jJ2AI1K
 gE3sAOC4jv10wryZPr3BWplNq8gDmL3E93sO4QyiNFplQbv3lqP0zlxGGm2yU1HxUy7d6QYoj
 CiudU6tfXEedvaW4UCTGC0Qo6Hh6LD5IFRMLkgKs5AZ2qk0LP1qXNgKEW+F2hBMGBxsrwiagN
 9SxQrwagX277JCkS8jsxleSPipTmqf4KMU9HpcB60FdavGv1NaxcdMqsbjWqtDiJvnJ8NU+io
 KbjZ1sRn/wKqwp4MI39kO3qZe1jsAlppzwq7rZfnm4pk6D2d8IMfccdQf0rZ0MXoc/KfntmhY
 y7KS2GgrDtY9EV6Ob6ioRsG9NW6s99cP5LNFKuB0qPPBWtx71q8WHZLVSiwUPTGvJF5CSX914
 sCKepQ72gexMbwgg3/FMCo=
X-Spam-Status: No, score=-106.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 26 Apr 2021 15:04:04 -0000

On Apr 22 13:57, Corinna Vinschen wrote:
> On Apr 21 18:40, Corinna Vinschen wrote:
> > On Apr 20 21:15, Jon Turney wrote:
> > > On 20/04/2021 21:13, Jon Turney wrote:
> > > > For ease of reviewing, this patch doesn't contain changes to generated
> > > > files which would be made by running ./autogen.sh.
> > > 
> > > Sorry about getting distracted from this.  To summarize what I believe were
> > > the outstanding issues with v3 [1]:
> > > 
> > > [1] https://cygwin.com/pipermail/cygwin-patches/2020q4/010827.html
> > > 
> > > * 'INCLUDES' is the old name for 'AM_CPPFLAGS' warning from autogen.sh
> > > 
> > > I plan to clean this up in a future patch
> > > 
> > > * 'ps$(EXEEXT)' previously defined' warning from autogen.sh
> > > 
> > > It seems to be a shortcoming of automake that there's no way to suppress
> > > just that warning.
> > > 
> > > One possible solution is build ps.exe with a different name and rename it
> > > while installing, but I think that is counter-productive (in the sense that
> > > it trades this warning for making the build more complex to understand)
> > > 
> > > * some object files are in a unexpected places in the build file hierarchy
> > > (compared to naive expectations and/or the non-automake build)
> > 
> > This is the only minor qualm I have with this patch.  It would be nice
> > to have the mingw sources and .o files in the mingw subdir.  It would
> > simply be a bit cleaner.  The files shared between cygwin and mingw
> > (that's only path.cc, I think) could be handled by an include, i. e.
> > 
> >   utils/
> > 
> >     path.cc (full implementation)
> > 
> >   utils/mingw/
> > 
> >     path.cc:
> > 
> >       #include "../path.cc"
> 
> I wonder if it wouldn't make sense to split out the mingw-only parts
> of path.cc entirely.  I had a quick view into the file and it turns
> out that of the almost 1000 lines in this file, only about 100 lines
> are used by mount.  All the rest is only used by mingw code, i. e.,
> cygcheck and strace.
> 
> That's obviously not part of this patch, but something we should keep
> in mind for a later cleanup.

I tried this as a POC and it's not much of a problem.  See the below
patch.  Cleaning up the includes is still to do.


Corinna


diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
index e4f55dd3c50e..a2d8c426fdac 100644
--- a/winsup/utils/Makefile.in
+++ b/winsup/utils/Makefile.in
@@ -58,10 +58,10 @@ endif
 # List all objects to be compiled in MinGW mode.  Any object not on this
 # list will will be compiled in Cygwin mode implicitly, so there is no
 # need for a CYGWIN_OBJS.
-MINGW_OBJS := bloda.o cygcheck.o cygwin-console-helper.o dump_setup.o ldh.o path.o strace.o
+MINGW_OBJS := bloda.o cygcheck.o cygwin-console-helper.o dump_setup.o ldh.o mingw-path.o strace.o
 MINGW_LDFLAGS:=-static
 
-CYGCHECK_OBJS:=cygcheck.o bloda.o path.o dump_setup.o
+CYGCHECK_OBJS:=cygcheck.o bloda.o mingw-path.o dump_setup.o
 ZLIB:=-lz
 
 .PHONY: all
@@ -69,12 +69,10 @@ all:
 
 # If a binary should link in any objects besides the .o with the same
 # name as the binary, then list those here.
-strace.exe: path.o
-cygcheck.exe: cygcheck.o bloda.o path.o dump_setup.o
+strace.exe: mingw-path.o
+cygcheck.exe: cygcheck.o bloda.o mingw-path.o dump_setup.o
 
-path-mount.o: path.cc
-	${COMPILE.cc} -c -DFSTAB_ONLY -o $@ $<
-mount.exe: path-mount.o
+mount.exe: path.o
 
 .PHONY: tzmap
 tzmap:
diff --git a/winsup/utils/mingw-path.cc b/winsup/utils/mingw-path.cc
new file mode 100644
index 000000000000..6c60a8eb9bae
--- /dev/null
+++ b/winsup/utils/mingw-path.cc
@@ -0,0 +1,795 @@
+/* path.cc
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+/* The purpose of this file is to hide all the details about accessing
+   Cygwin's mount table, shortcuts, etc.  If the format or location of
+   the mount table, or the shortcut format changes, this is the file to
+   change to match it. */
+
+#include "path.cc"
+
+/* Used when treating / and \ as equivalent. */
+#define isslash(ch) \
+  ({ \
+      char __c = (ch); \
+      ((__c) == '/' || (__c) == '\\'); \
+   })
+
+
+static const GUID GUID_shortcut =
+  {0x00021401L, 0, 0, {0xc0, 0, 0, 0, 0, 0, 0, 0x46}};
+
+enum {
+  WSH_FLAG_IDLIST = 0x01,	/* Contains an ITEMIDLIST. */
+  WSH_FLAG_FILE = 0x02,		/* Contains a file locator element. */
+  WSH_FLAG_DESC = 0x04,		/* Contains a description. */
+  WSH_FLAG_RELPATH = 0x08,	/* Contains a relative path. */
+  WSH_FLAG_WD = 0x10,		/* Contains a working dir. */
+  WSH_FLAG_CMDLINE = 0x20,	/* Contains command line args. */
+  WSH_FLAG_ICON = 0x40		/* Contains a custom icon. */
+};
+
+struct win_shortcut_hdr
+  {
+    DWORD size;		/* Header size in bytes.  Must contain 0x4c. */
+    GUID magic;		/* GUID of shortcut files. */
+    DWORD flags;	/* Content flags.  See above. */
+
+    /* The next fields from attr to icon_no are always set to 0 in Cygwin
+       and U/Win shortcuts. */
+    DWORD attr;	/* Target file attributes. */
+    FILETIME ctime;	/* These filetime items are never touched by the */
+    FILETIME mtime;	/* system, apparently. Values don't matter. */
+    FILETIME atime;
+    DWORD filesize;	/* Target filesize. */
+    DWORD icon_no;	/* Icon number. */
+
+    DWORD run;		/* Values defined in winuser.h. Use SW_NORMAL. */
+    DWORD hotkey;	/* Hotkey value. Set to 0.  */
+    DWORD dummy[2];	/* Future extension probably. Always 0. */
+  };
+
+static bool
+cmp_shortcut_header (win_shortcut_hdr *file_header)
+{
+  /* A Cygwin or U/Win shortcut only contains a description and a relpath.
+     Cygwin shortcuts also might contain an ITEMIDLIST. The run type is
+     always set to SW_NORMAL. */
+  return file_header->size == sizeof (win_shortcut_hdr)
+      && !memcmp (&file_header->magic, &GUID_shortcut, sizeof GUID_shortcut)
+      && (file_header->flags & ~WSH_FLAG_IDLIST)
+	 == (WSH_FLAG_DESC | WSH_FLAG_RELPATH)
+      && file_header->run == SW_NORMAL;
+}
+
+int
+get_word (HANDLE fh, int offset)
+{
+  unsigned short rv;
+  unsigned r;
+
+  SetLastError(NO_ERROR);
+  if (SetFilePointer (fh, offset, 0, FILE_BEGIN) == INVALID_SET_FILE_POINTER
+      && GetLastError () != NO_ERROR)
+    return -1;
+
+  if (!ReadFile (fh, &rv, 2, (DWORD *) &r, 0))
+    return -1;
+
+  return rv;
+}
+
+/*
+ * Check the value of GetLastError() to find out whether there was an error.
+ */
+int
+get_dword (HANDLE fh, int offset)
+{
+  int rv;
+  unsigned r;
+
+  SetLastError(NO_ERROR);
+  if (SetFilePointer (fh, offset, 0, FILE_BEGIN) == INVALID_SET_FILE_POINTER
+      && GetLastError () != NO_ERROR)
+    return -1;
+
+  if (!ReadFile (fh, &rv, 4, (DWORD *) &r, 0))
+    return -1;
+
+  return rv;
+}
+
+#define EXE_MAGIC ((int)*(unsigned short *)"MZ")
+#define SHORTCUT_MAGIC ((int)*(unsigned short *)"L\0")
+#define SYMLINK_COOKIE "!<symlink>"
+#define SYMLINK_MAGIC ((int)*(unsigned short *)SYMLINK_COOKIE)
+
+bool
+is_exe (HANDLE fh)
+{
+  int magic = get_word (fh, 0x0);
+  return magic == EXE_MAGIC;
+}
+
+bool
+is_symlink (HANDLE fh)
+{
+  bool ret = false;
+  int magic = get_word (fh, 0x0);
+  if (magic != SHORTCUT_MAGIC && magic != SYMLINK_MAGIC)
+    goto out;
+  DWORD got;
+  BY_HANDLE_FILE_INFORMATION local;
+  if (!GetFileInformationByHandle (fh, &local))
+    return false;
+  if (magic == SHORTCUT_MAGIC)
+    {
+      DWORD size;
+      if (!local.dwFileAttributes & FILE_ATTRIBUTE_READONLY)
+	goto out; /* Not a Cygwin symlink. */
+      if ((size = GetFileSize (fh, NULL)) > 8192)
+	goto out; /* Not a Cygwin symlink. */
+      char buf[size];
+      SetFilePointer (fh, 0, 0, FILE_BEGIN);
+      if (!ReadFile (fh, buf, size, &got, 0))
+	goto out;
+      if (got != size || !cmp_shortcut_header ((win_shortcut_hdr *) buf))
+	goto out; /* Not a Cygwin symlink. */
+      /* TODO: check for invalid path contents
+	 (see symlink_info::check() in ../cygwin/path.cc) */
+    }
+  else /* magic == SYMLINK_MAGIC */
+    {
+      if (!(local.dwFileAttributes & FILE_ATTRIBUTE_SYSTEM))
+	goto out; /* Not a Cygwin symlink. */
+      char buf[sizeof (SYMLINK_COOKIE) - 1];
+      SetFilePointer (fh, 0, 0, FILE_BEGIN);
+      if (!ReadFile (fh, buf, sizeof (buf), &got, 0))
+	goto out;
+      if (got != sizeof (buf) ||
+	  memcmp (buf, SYMLINK_COOKIE, sizeof (buf)) != 0)
+	goto out; /* Not a Cygwin symlink. */
+    }
+  ret = true;
+out:
+  SetFilePointer (fh, 0, 0, FILE_BEGIN);
+  return ret;
+}
+
+/* Assumes is_symlink(fh) is true */
+bool
+readlink (HANDLE fh, char *path, size_t maxlen)
+{
+  DWORD rv;
+  char *buf, *cp;
+  unsigned short len;
+  win_shortcut_hdr *file_header;
+  BY_HANDLE_FILE_INFORMATION fi;
+
+  if (!GetFileInformationByHandle (fh, &fi)
+      || fi.nFileSizeHigh != 0
+      || fi.nFileSizeLow > 4 * 65536)
+    return false;
+
+  buf = (char *) alloca (fi.nFileSizeLow + 1);
+  file_header = (win_shortcut_hdr *) buf;
+
+  if (!ReadFile (fh, buf, fi.nFileSizeLow, &rv, NULL)
+      || rv != fi.nFileSizeLow)
+    return false;
+
+  if (fi.nFileSizeLow > sizeof (file_header)
+      && cmp_shortcut_header (file_header))
+    {
+      cp = buf + sizeof (win_shortcut_hdr);
+      if (file_header->flags & WSH_FLAG_IDLIST) /* Skip ITEMIDLIST */
+	cp += *(unsigned short *) cp + 2;
+      if (!(len = *(unsigned short *) cp))
+	return false;
+      cp += 2;
+      /* Has appended full path?  If so, use it instead of description. */
+      unsigned short relpath_len = *(unsigned short *) (cp + len);
+      if (cp + len + 2 + relpath_len < buf + fi.nFileSizeLow)
+	{
+	  cp += len + 2 + relpath_len;
+	  len = *(unsigned short *) cp;
+	  cp += 2;
+	}
+      if (*(PWCHAR) cp == 0xfeff)	/* BOM */
+	{
+	  size_t wlen = wcstombs (NULL, (wchar_t *) (cp + 2), 0);
+	  if (wlen == (size_t) -1 || wlen + 1 > maxlen)
+	    return false;
+	  wcstombs (path, (wchar_t *) (cp + 2), wlen + 1);
+	}
+      else if ((size_t) (len + 1) > maxlen)
+	return false;
+      else
+	memcpy (path, cp, len);
+      path[len] = '\0';
+      return true;
+    }
+  else if (strncmp (buf, SYMLINK_COOKIE, strlen (SYMLINK_COOKIE)) == 0
+	   && buf[fi.nFileSizeLow - 1] == '\0')
+    {
+      cp = buf + strlen (SYMLINK_COOKIE);
+      if (*(PWCHAR) cp == 0xfeff)	/* BOM */
+	{
+	  size_t wlen = wcstombs (NULL, (wchar_t *) (cp + 2), 0);
+	  if (wlen == (size_t) -1 || wlen + 1 > maxlen)
+	    return false;
+	  wcstombs (path, (wchar_t *) (cp + 2), wlen + 1);
+	}
+      else if (fi.nFileSizeLow - strlen (SYMLINK_COOKIE) > maxlen)
+	return false;
+      else
+	strcpy (path, cp);
+      return true;
+    }
+  else
+    return false;
+}
+
+static struct opt
+{
+  const char *name;
+  unsigned val;
+  bool clear;
+} oopts[] =
+{
+  {"acl", MOUNT_NOACL, 1},
+  {"auto", 0, 0},
+  {"binary", MOUNT_TEXT, 1},
+  {"cygexec", MOUNT_CYGWIN_EXEC, 0},
+  {"dos", MOUNT_DOS, 0},
+  {"exec", MOUNT_EXEC, 0},
+  {"ihash", MOUNT_IHASH, 0},
+  {"noacl", MOUNT_NOACL, 0},
+  {"nosuid", 0, 0},
+  {"notexec", MOUNT_NOTEXEC, 0},
+  {"nouser", MOUNT_SYSTEM, 0},
+  {"override", MOUNT_OVERRIDE, 0},
+  {"posix=0", MOUNT_NOPOSIX, 0},
+  {"posix=1", MOUNT_NOPOSIX, 1},
+  {"text", MOUNT_TEXT, 0},
+  {"user", MOUNT_SYSTEM, 1}
+};
+
+#ifndef TESTSUITE
+static bool
+read_flags (char *options, unsigned &flags)
+{
+  while (*options)
+    {
+      char *p = strchr (options, ',');
+      if (p)
+	*p++ = '\0';
+      else
+	p = strchr (options, '\0');
+
+      for (opt *o = oopts;
+	   o < (oopts + (sizeof (oopts) / sizeof (oopts[0])));
+	   o++)
+	if (strcmp (options, o->name) == 0)
+	  {
+	    if (o->clear)
+	      flags &= ~o->val;
+	    else
+	      flags |= o->val;
+	    goto gotit;
+	  }
+      return false;
+
+    gotit:
+      options = p;
+    }
+  return true;
+}
+
+#define BUFSIZE 65536
+
+static char *
+get_user ()
+{
+  static char user[UNLEN + 1];
+  char *userenv;
+
+  user[0] = '\0';
+  if ((userenv = getenv ("USER")) || (userenv = getenv ("USERNAME")))
+    strncat (user, userenv, UNLEN);
+  return user;
+}
+
+void
+from_fstab (bool user, PWCHAR path, PWCHAR path_end)
+{
+  mnt_t *m = mount_table + max_mount_entry;
+  char buf[BUFSIZE];
+
+  if (!user)
+    {
+      /* Create a default root dir from path. */
+      wcstombs (buf, path, BUFSIZE);
+      unconvert_slashes (buf);
+      char *native_path = buf;
+      if (!strncmp (native_path, "\\\\?\\", 4))
+	native_path += 4;
+      if (!strncmp (native_path, "UNC\\", 4))
+	*(native_path += 2) = '\\';
+      m->posix = strdup ("/");
+      m->native = strdup (native_path);
+      m->flags = MOUNT_SYSTEM | MOUNT_IMMUTABLE | MOUNT_AUTOMATIC;
+      ++m;
+      /* Create default /usr/bin and /usr/lib entries. */
+      char *trail = strchr (native_path, '\0');
+      strcpy (trail, "\\bin");
+      m->posix = strdup ("/usr/bin");
+      m->native = strdup (native_path);
+      m->flags = MOUNT_SYSTEM | MOUNT_AUTOMATIC;
+      ++m;
+      strcpy (trail, "\\lib");
+      m->posix = strdup ("/usr/lib");
+      m->native = strdup (native_path);
+      m->flags = MOUNT_SYSTEM | MOUNT_AUTOMATIC;
+      ++m;
+      /* Create a default cygdrive entry.  Note that this is a user entry.
+	 This allows to override it with mount, unless the sysadmin created
+	 a cygdrive entry in /etc/fstab. */
+      m->posix = strdup (CYGWIN_INFO_CYGDRIVE_DEFAULT_PREFIX);
+      m->native = strdup ("cygdrive prefix");
+      m->flags = MOUNT_CYGDRIVE;
+      ++m;
+      max_mount_entry = m - mount_table;
+    }
+
+  PWCHAR u = wcscpy (path_end, L"\\etc\\fstab") + 10;
+  if (user)
+    mbstowcs (wcscpy (u, L".d\\") + 3, get_user (), BUFSIZE - (u - path));
+  HANDLE h = CreateFileW (path, GENERIC_READ, FILE_SHARE_READ, NULL,
+			  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
+  if (h == INVALID_HANDLE_VALUE)
+    return;
+  char *got = buf;
+  DWORD len = 0;
+  /* Using BUFSIZE-1 leaves space to append two \0. */
+  while (ReadFile (h, got, BUFSIZE - 1 - (got - buf),
+		   &len, NULL))
+    {
+      char *end;
+
+      /* Set end marker. */
+      got[len] = got[len + 1] = '\0';
+      /* Set len to the absolute len of bytes in buf. */
+      len += got - buf;
+      /* Reset got to start reading at the start of the buffer again. */
+      got = buf;
+      while (got < buf + len && (end = strchr (got, '\n')))
+	{
+	  end[end[-1] == '\r' ? -1 : 0] = '\0';
+	  if (from_fstab_line (m, got, user))
+	    ++m;
+	  got = end + 1;
+	}
+      if (len < BUFSIZE - 1)
+	break;
+      /* We have to read once more.  Move remaining bytes to the start of
+	 the buffer and reposition got so that it points to the end of
+	 the remaining bytes. */
+      len = buf + len - got;
+      memmove (buf, got, len);
+      got = buf + len;
+      buf[len] = buf[len + 1] = '\0';
+    }
+  if (got > buf && from_fstab_line (m, got, user))
+    ++m;
+  max_mount_entry = m - mount_table;
+  CloseHandle (h);
+}
+
+static int
+mnt_sort (const void *a, const void *b)
+{
+  const mnt_t *ma = (const mnt_t *) a;
+  const mnt_t *mb = (const mnt_t *) b;
+  int ret;
+
+  ret = (ma->flags & MOUNT_CYGDRIVE) - (mb->flags & MOUNT_CYGDRIVE);
+  if (ret)
+    return ret;
+  ret = (ma->flags & MOUNT_SYSTEM) - (mb->flags & MOUNT_SYSTEM);
+  if (ret)
+    return ret;
+  return strcmp (ma->posix, mb->posix);
+}
+
+extern "C" WCHAR cygwin_dll_path[];
+
+static void
+read_mounts ()
+{
+  HKEY setup_key;
+  LONG ret;
+  DWORD len;
+  WCHAR path[32768];
+  PWCHAR path_end;
+
+  for (mnt_t *m1 = mount_table; m1->posix; m1++)
+    {
+      free (m1->posix);
+      if (m1->native)
+	free ((char *) m1->native);
+      m1->posix = NULL;
+    }
+  max_mount_entry = 0;
+
+  /* First fetch the cygwin1.dll path from the LoadLibrary call in load_cygwin.
+     This utilizes the DLL search order to find a matching cygwin1.dll and to
+     compute the installation path from that DLL's path. */
+  if (cygwin_dll_path[0])
+    wcscpy (path, cygwin_dll_path);
+  /* If we can't load cygwin1.dll, check where cygcheck is living itself and
+     try to fetch installation path from here.  Does cygwin1.dll exist in the
+     same path?  This should only kick in if the cygwin1.dll in the same path
+     has been made non-executable for the current user accidentally. */
+  else if (!GetModuleFileNameW (NULL, path, 32768))
+    return;
+  path_end = wcsrchr (path, L'\\');
+  if (path_end)
+    {
+      if (!cygwin_dll_path[0])
+	{
+	  wcscpy (path_end, L"\\cygwin1.dll");
+	  DWORD attr = GetFileAttributesW (path);
+	  if (attr == (DWORD) -1
+	      || (attr & (FILE_ATTRIBUTE_DIRECTORY
+			  | FILE_ATTRIBUTE_REPARSE_POINT)))
+	    path_end = NULL;
+	}
+      if (path_end)
+	{
+	  *path_end = L'\0';
+	  path_end = wcsrchr (path, L'\\');
+	}
+    }
+  /* If we can't create a valid installation dir from that, try to fetch
+     the installation dir from the setup registry key. */
+  if (!path_end)
+    {
+      for (int i = 0; i < 2; ++i)
+	if ((ret = RegOpenKeyExW (i ? HKEY_LOCAL_MACHINE : HKEY_CURRENT_USER,
+				  L"Software\\Cygwin\\setup", 0,
+				  KEY_READ, &setup_key)) == ERROR_SUCCESS)
+	  {
+	    len = 32768 * sizeof (WCHAR);
+	    ret = RegQueryValueExW (setup_key, L"rootdir", NULL, NULL,
+				    (PBYTE) path, &len);
+	    RegCloseKey (setup_key);
+	    if (ret == ERROR_SUCCESS)
+	      break;
+	  }
+      if (ret == ERROR_SUCCESS)
+	path_end = wcschr (path, L'\0');
+    }
+  /* If we can't fetch an installation dir, bail out. */
+  if (!path_end)
+    return;
+  *path_end = L'\0';
+
+  from_fstab (false, path, path_end);
+  from_fstab (true, path, path_end);
+  qsort (mount_table, max_mount_entry, sizeof (mnt_t), mnt_sort);
+}
+#endif /* !defined(TESTSUITE) */
+
+/* Return non-zero if PATH1 is a prefix of PATH2.
+   Both are assumed to be of the same path style and / vs \ usage.
+   Neither may be "".
+   LEN1 = strlen (PATH1).  It's passed because often it's already known.
+
+   Examples:
+   /foo/ is a prefix of /foo  <-- may seem odd, but desired
+   /foo is a prefix of /foo/
+   / is a prefix of /foo/bar
+   / is not a prefix of foo/bar
+   foo/ is a prefix foo/bar
+   /foo is not a prefix of /foobar
+*/
+
+static int
+path_prefix_p (const char *path1, const char *path2, size_t len1)
+{
+  /* Handle case where PATH1 has trailing '/' and when it doesn't.  */
+  if (len1 > 0 && isslash (path1[len1 - 1]))
+    len1--;
+
+  if (len1 == 0)
+    return isslash (path2[0]) && !isslash (path2[1]);
+
+  if (strncasecmp (path1, path2, len1) != 0)
+    return 0;
+
+  return isslash (path2[len1]) || path2[len1] == 0 || path1[len1 - 1] == ':';
+}
+
+static char *
+vconcat (const char *s, va_list v)
+{
+  int len;
+  char *rv, *arg;
+  va_list save_v = v;
+  int unc;
+
+  if (!s)
+    return 0;
+
+  len = strlen (s);
+
+  unc = isslash (*s) && isslash (s[1]);
+
+  while (1)
+    {
+      arg = va_arg (v, char *);
+      if (arg == 0)
+	break;
+      len += strlen (arg);
+    }
+  va_end (v);
+
+  rv = (char *) malloc (len + 1);
+  strcpy (rv, s);
+  v = save_v;
+  while (1)
+  {
+    arg = va_arg (v, char *);
+    if (arg == 0)
+      break;
+    strcat (rv, arg);
+  }
+  va_end (v);
+
+  char *d, *p;
+
+  /* concat is only used for urls and files, so we can safely
+     canonicalize the results */
+  for (p = d = rv; *p; p++)
+    {
+      *d++ = *p;
+      /* special case for URLs */
+      if (*p == ':' && p[1] == '/' && p[2] == '/' && p > rv + 1)
+	{
+	  *d++ = *++p;
+	  *d++ = *++p;
+	}
+      else if (isslash (*p))
+	{
+	  if (p == rv && unc)
+	    *d++ = *p++;
+	  while (p[1] == '/')
+	    p++;
+	}
+    }
+  *d = 0;
+
+  return rv;
+}
+
+static char *
+concat (const char *s, ...)
+{
+  va_list v;
+
+  va_start (v, s);
+
+  return vconcat (s, v);
+}
+
+/* This is a helper function for when vcygpath is passed what appears
+   to be a relative POSIX path.  We take a Win32 CWD (either as specified
+   in 'cwd' or as retrieved with GetCurrentDirectory() if 'cwd' is NULL)
+   and find the mount table entry with the longest match.  We replace the
+   matching portion with the corresponding POSIX prefix, and to that append
+   's' and anything in 'v'.  The returned result is a mostly-POSIX
+   absolute path -- 'mostly' because the portions of CWD that didn't
+   match the mount prefix will still have '\\' separators.  */
+static char *
+rel_vconcat (const char *cwd, const char *s, va_list v)
+{
+  char pathbuf[MAX_PATH];
+  if (!cwd || *cwd == '\0')
+    {
+      if (!GetCurrentDirectory (MAX_PATH, pathbuf))
+	return NULL;
+      cwd = pathbuf;
+    }
+
+  size_t max_len = 0;
+  mnt_t *m, *match = NULL;
+
+  for (m = mount_table; m->posix; m++)
+    {
+      if (m->flags & MOUNT_CYGDRIVE)
+	continue;
+
+      size_t n = strlen (m->native);
+      if (n < max_len || !path_prefix_p (m->native, cwd, n))
+	continue;
+      max_len = n;
+      match = m;
+    }
+
+  char *temppath;
+  if (!match)
+    // No prefix matched - best effort to return meaningful value.
+    temppath = concat (cwd, "/", s, NULL);
+  else if (strcmp (match->posix, "/") != 0)
+    // Matched on non-root.  Copy matching prefix + remaining 'path'.
+    temppath = concat (match->posix, cwd + max_len, "/", s, NULL);
+  else if (cwd[max_len] == '\0')
+    // Matched on root and there's no remaining 'path'.
+    temppath = concat ("/", s, NULL);
+  else if (isslash (cwd[max_len]))
+    // Matched on root but remaining 'path' starts with a slash anyway.
+    temppath = concat (cwd + max_len, "/", s, NULL);
+  else
+    temppath = concat ("/", cwd + max_len, "/", s, NULL);
+
+  char *res = vconcat (temppath, v);
+  free (temppath);
+  return res;
+}
+
+/* Convert a POSIX path in 's' to an absolute Win32 path, and append
+   anything in 'v' to the end, returning the result.  If 's' is a
+   relative path then 'cwd' is used as the working directory to make
+   it absolute.  Pass NULL in 'cwd' to use GetCurrentDirectory.  */
+static char *
+vcygpath (const char *cwd, const char *s, va_list v)
+{
+  size_t max_len = 0;
+  mnt_t *m, *match = NULL;
+
+#ifndef TESTSUITE
+  if (!max_mount_entry)
+    read_mounts ();
+#endif
+  char *path;
+  if (s[0] == '.' && isslash (s[1]))
+    s += 2;
+
+  if (s[0] == '/' || s[1] == ':')	/* FIXME: too crude? */
+    path = vconcat (s, v);
+  else
+    path = rel_vconcat (cwd, s, v);
+
+  if (!path)
+    return NULL;
+
+  if (strncmp (path, "/./", 3) == 0)
+    memmove (path + 1, path + 3, strlen (path + 3) + 1);
+
+  for (m = mount_table; m->posix; m++)
+    {
+      size_t n = strlen (m->posix);
+      if (n < max_len || !path_prefix_p (m->posix, path, n))
+	continue;
+      if (m->flags & MOUNT_CYGDRIVE)
+	{
+	  if (strlen (path) < n + 2)
+	    continue;
+	  /* If cygdrive path is just '/', fix n for followup evaluation. */
+	  if (n == 1)
+	    n = 0;
+	  if (path[n] != '/')
+	    continue;
+	  if (!isalpha (path[n + 1]))
+	    continue;
+	  if (path[n + 2] != '/')
+	    continue;
+	}
+      max_len = n;
+      match = m;
+    }
+
+  char *native;
+  if (match == NULL)
+    native = strdup (path);
+  else if (max_len == strlen (path))
+    native = strdup (match->native);
+  else if (match->flags & MOUNT_CYGDRIVE)
+    {
+      char drive[3] = { path[max_len + 1], ':', '\0' };
+      native = concat (drive, path + max_len + 2, NULL);
+    }
+  else if (isslash (path[max_len]))
+    native = concat (match->native, path + max_len, NULL);
+  else
+    native = concat (match->native, "\\", path + max_len, NULL);
+  free (path);
+
+  unconvert_slashes (native);
+  for (char *s = strstr (native + 1, "\\.\\"); s && *s; s = strstr (s, "\\.\\"))
+    memmove (s + 1, s + 3, strlen (s + 3) + 1);
+  return native;
+}
+
+char *
+cygpath_rel (const char *cwd, const char *s, ...)
+{
+  va_list v;
+
+  va_start (v, s);
+
+  return vcygpath (cwd, s, v);
+}
+
+char *
+cygpath (const char *s, ...)
+{
+  va_list v;
+
+  va_start (v, s);
+
+  return vcygpath (NULL, s, v);
+}
+
+static mnt_t *m = NULL;
+
+extern "C" FILE *
+setmntent (const char *, const char *)
+{
+  m = mount_table;
+#ifndef TESTSUITE
+  if (!max_mount_entry)
+    read_mounts ();
+#endif
+  return NULL;
+}
+
+extern "C" struct mntent *
+getmntent (FILE *)
+{
+  static mntent mnt;
+  if (!m->posix)
+    return NULL;
+
+  mnt.mnt_fsname = (char *) m->native;
+  mnt.mnt_dir = (char *) m->posix;
+  if (!mnt.mnt_type)
+    mnt.mnt_type = (char *) malloc (16);
+  if (!mnt.mnt_opts)
+    mnt.mnt_opts = (char *) malloc (64);
+
+  strcpy (mnt.mnt_type,
+	  (char *) ((m->flags & MOUNT_SYSTEM) ? "system" : "user"));
+
+  if (m->flags & MOUNT_TEXT)
+    strcpy (mnt.mnt_opts, (char *) "text");
+  else
+    strcpy (mnt.mnt_opts, (char *) "binary");
+
+  if (m->flags & MOUNT_CYGWIN_EXEC)
+    strcat (mnt.mnt_opts, (char *) ",cygexec");
+  else if (m->flags & MOUNT_EXEC)
+    strcat (mnt.mnt_opts, (char *) ",exec");
+  else if (m->flags & MOUNT_NOTEXEC)
+    strcat (mnt.mnt_opts, (char *) ",notexec");
+
+  if (m->flags & MOUNT_NOACL)
+    strcat (mnt.mnt_opts, (char *) ",noacl");
+
+  if (m->flags & MOUNT_NOPOSIX)
+    strcat (mnt.mnt_opts, (char *) ",posix=0");
+
+  if (m->flags & (MOUNT_AUTOMATIC | MOUNT_CYGDRIVE))
+    strcat (mnt.mnt_opts, (char *) ",auto");
+
+  mnt.mnt_freq = 1;
+  mnt.mnt_passno = 1;
+  m++;
+  return &mnt;
+}
diff --git a/winsup/utils/path.cc b/winsup/utils/path.cc
index 29344be02033..7e3f3cab74be 100644
--- a/winsup/utils/path.cc
+++ b/winsup/utils/path.cc
@@ -26,235 +26,11 @@ details. */
 #define _NOMNTENT_MACROS
 #include "../cygwin/include/mntent.h"
 #include "testsuite.h"
-#ifdef FSTAB_ONLY
+#ifdef __CYGWIN__
 #include <sys/cygwin.h>
 #endif
 #include "loadlib.h"
 
-#ifndef FSTAB_ONLY
-/* Used when treating / and \ as equivalent. */
-#define isslash(ch) \
-  ({ \
-      char __c = (ch); \
-      ((__c) == '/' || (__c) == '\\'); \
-   })
-
-
-static const GUID GUID_shortcut =
-  {0x00021401L, 0, 0, {0xc0, 0, 0, 0, 0, 0, 0, 0x46}};
-
-enum {
-  WSH_FLAG_IDLIST = 0x01,	/* Contains an ITEMIDLIST. */
-  WSH_FLAG_FILE = 0x02,		/* Contains a file locator element. */
-  WSH_FLAG_DESC = 0x04,		/* Contains a description. */
-  WSH_FLAG_RELPATH = 0x08,	/* Contains a relative path. */
-  WSH_FLAG_WD = 0x10,		/* Contains a working dir. */
-  WSH_FLAG_CMDLINE = 0x20,	/* Contains command line args. */
-  WSH_FLAG_ICON = 0x40		/* Contains a custom icon. */
-};
-
-struct win_shortcut_hdr
-  {
-    DWORD size;		/* Header size in bytes.  Must contain 0x4c. */
-    GUID magic;		/* GUID of shortcut files. */
-    DWORD flags;	/* Content flags.  See above. */
-
-    /* The next fields from attr to icon_no are always set to 0 in Cygwin
-       and U/Win shortcuts. */
-    DWORD attr;	/* Target file attributes. */
-    FILETIME ctime;	/* These filetime items are never touched by the */
-    FILETIME mtime;	/* system, apparently. Values don't matter. */
-    FILETIME atime;
-    DWORD filesize;	/* Target filesize. */
-    DWORD icon_no;	/* Icon number. */
-
-    DWORD run;		/* Values defined in winuser.h. Use SW_NORMAL. */
-    DWORD hotkey;	/* Hotkey value. Set to 0.  */
-    DWORD dummy[2];	/* Future extension probably. Always 0. */
-  };
-
-static bool
-cmp_shortcut_header (win_shortcut_hdr *file_header)
-{
-  /* A Cygwin or U/Win shortcut only contains a description and a relpath.
-     Cygwin shortcuts also might contain an ITEMIDLIST. The run type is
-     always set to SW_NORMAL. */
-  return file_header->size == sizeof (win_shortcut_hdr)
-      && !memcmp (&file_header->magic, &GUID_shortcut, sizeof GUID_shortcut)
-      && (file_header->flags & ~WSH_FLAG_IDLIST)
-	 == (WSH_FLAG_DESC | WSH_FLAG_RELPATH)
-      && file_header->run == SW_NORMAL;
-}
-
-int
-get_word (HANDLE fh, int offset)
-{
-  unsigned short rv;
-  unsigned r;
-
-  SetLastError(NO_ERROR);
-  if (SetFilePointer (fh, offset, 0, FILE_BEGIN) == INVALID_SET_FILE_POINTER
-      && GetLastError () != NO_ERROR)
-    return -1;
-
-  if (!ReadFile (fh, &rv, 2, (DWORD *) &r, 0))
-    return -1;
-
-  return rv;
-}
-
-/*
- * Check the value of GetLastError() to find out whether there was an error.
- */
-int
-get_dword (HANDLE fh, int offset)
-{
-  int rv;
-  unsigned r;
-
-  SetLastError(NO_ERROR);
-  if (SetFilePointer (fh, offset, 0, FILE_BEGIN) == INVALID_SET_FILE_POINTER
-      && GetLastError () != NO_ERROR)
-    return -1;
-
-  if (!ReadFile (fh, &rv, 4, (DWORD *) &r, 0))
-    return -1;
-
-  return rv;
-}
-
-#define EXE_MAGIC ((int)*(unsigned short *)"MZ")
-#define SHORTCUT_MAGIC ((int)*(unsigned short *)"L\0")
-#define SYMLINK_COOKIE "!<symlink>"
-#define SYMLINK_MAGIC ((int)*(unsigned short *)SYMLINK_COOKIE)
-
-bool
-is_exe (HANDLE fh)
-{
-  int magic = get_word (fh, 0x0);
-  return magic == EXE_MAGIC;
-}
-
-bool
-is_symlink (HANDLE fh)
-{
-  bool ret = false;
-  int magic = get_word (fh, 0x0);
-  if (magic != SHORTCUT_MAGIC && magic != SYMLINK_MAGIC)
-    goto out;
-  DWORD got;
-  BY_HANDLE_FILE_INFORMATION local;
-  if (!GetFileInformationByHandle (fh, &local))
-    return false;
-  if (magic == SHORTCUT_MAGIC)
-    {
-      DWORD size;
-      if (!local.dwFileAttributes & FILE_ATTRIBUTE_READONLY)
-	goto out; /* Not a Cygwin symlink. */
-      if ((size = GetFileSize (fh, NULL)) > 8192)
-	goto out; /* Not a Cygwin symlink. */
-      char buf[size];
-      SetFilePointer (fh, 0, 0, FILE_BEGIN);
-      if (!ReadFile (fh, buf, size, &got, 0))
-	goto out;
-      if (got != size || !cmp_shortcut_header ((win_shortcut_hdr *) buf))
-	goto out; /* Not a Cygwin symlink. */
-      /* TODO: check for invalid path contents
-	 (see symlink_info::check() in ../cygwin/path.cc) */
-    }
-  else /* magic == SYMLINK_MAGIC */
-    {
-      if (!(local.dwFileAttributes & FILE_ATTRIBUTE_SYSTEM))
-	goto out; /* Not a Cygwin symlink. */
-      char buf[sizeof (SYMLINK_COOKIE) - 1];
-      SetFilePointer (fh, 0, 0, FILE_BEGIN);
-      if (!ReadFile (fh, buf, sizeof (buf), &got, 0))
-	goto out;
-      if (got != sizeof (buf) ||
-	  memcmp (buf, SYMLINK_COOKIE, sizeof (buf)) != 0)
-	goto out; /* Not a Cygwin symlink. */
-    }
-  ret = true;
-out:
-  SetFilePointer (fh, 0, 0, FILE_BEGIN);
-  return ret;
-}
-
-/* Assumes is_symlink(fh) is true */
-bool
-readlink (HANDLE fh, char *path, size_t maxlen)
-{
-  DWORD rv;
-  char *buf, *cp;
-  unsigned short len;
-  win_shortcut_hdr *file_header;
-  BY_HANDLE_FILE_INFORMATION fi;
-
-  if (!GetFileInformationByHandle (fh, &fi)
-      || fi.nFileSizeHigh != 0
-      || fi.nFileSizeLow > 4 * 65536)
-    return false;
-
-  buf = (char *) alloca (fi.nFileSizeLow + 1);
-  file_header = (win_shortcut_hdr *) buf;
-
-  if (!ReadFile (fh, buf, fi.nFileSizeLow, &rv, NULL)
-      || rv != fi.nFileSizeLow)
-    return false;
-
-  if (fi.nFileSizeLow > sizeof (file_header)
-      && cmp_shortcut_header (file_header))
-    {
-      cp = buf + sizeof (win_shortcut_hdr);
-      if (file_header->flags & WSH_FLAG_IDLIST) /* Skip ITEMIDLIST */
-	cp += *(unsigned short *) cp + 2;
-      if (!(len = *(unsigned short *) cp))
-	return false;
-      cp += 2;
-      /* Has appended full path?  If so, use it instead of description. */
-      unsigned short relpath_len = *(unsigned short *) (cp + len);
-      if (cp + len + 2 + relpath_len < buf + fi.nFileSizeLow)
-	{
-	  cp += len + 2 + relpath_len;
-	  len = *(unsigned short *) cp;
-	  cp += 2;
-	}
-      if (*(PWCHAR) cp == 0xfeff)	/* BOM */
-	{
-	  size_t wlen = wcstombs (NULL, (wchar_t *) (cp + 2), 0);
-	  if (wlen == (size_t) -1 || wlen + 1 > maxlen)
-	    return false;
-	  wcstombs (path, (wchar_t *) (cp + 2), wlen + 1);
-	}
-      else if ((size_t) (len + 1) > maxlen)
-	return false;
-      else
-	memcpy (path, cp, len);
-      path[len] = '\0';
-      return true;
-    }
-  else if (strncmp (buf, SYMLINK_COOKIE, strlen (SYMLINK_COOKIE)) == 0
-	   && buf[fi.nFileSizeLow - 1] == '\0')
-    {
-      cp = buf + strlen (SYMLINK_COOKIE);
-      if (*(PWCHAR) cp == 0xfeff)	/* BOM */
-	{
-	  size_t wlen = wcstombs (NULL, (wchar_t *) (cp + 2), 0);
-	  if (wlen == (size_t) -1 || wlen + 1 > maxlen)
-	    return false;
-	  wcstombs (path, (wchar_t *) (cp + 2), wlen + 1);
-	}
-      else if (fi.nFileSizeLow - strlen (SYMLINK_COOKIE) > maxlen)
-	return false;
-      else
-	strcpy (path, cp);
-      return true;
-    }
-  else
-    return false;
-}
-#endif /* !FSTAB_ONLY */
-
 #ifndef TESTSUITE
 mnt_t mount_table[255];
 int max_mount_entry;
@@ -302,61 +78,8 @@ conv_fstab_spaces (char *field)
   return field;
 }
 
-#ifndef FSTAB_ONLY
-static struct opt
-{
-  const char *name;
-  unsigned val;
-  bool clear;
-} oopts[] =
-{
-  {"acl", MOUNT_NOACL, 1},
-  {"auto", 0, 0},
-  {"binary", MOUNT_TEXT, 1},
-  {"cygexec", MOUNT_CYGWIN_EXEC, 0},
-  {"dos", MOUNT_DOS, 0},
-  {"exec", MOUNT_EXEC, 0},
-  {"ihash", MOUNT_IHASH, 0},
-  {"noacl", MOUNT_NOACL, 0},
-  {"nosuid", 0, 0},
-  {"notexec", MOUNT_NOTEXEC, 0},
-  {"nouser", MOUNT_SYSTEM, 0},
-  {"override", MOUNT_OVERRIDE, 0},
-  {"posix=0", MOUNT_NOPOSIX, 0},
-  {"posix=1", MOUNT_NOPOSIX, 1},
-  {"text", MOUNT_TEXT, 0},
-  {"user", MOUNT_SYSTEM, 1}
-};
-
-static bool
-read_flags (char *options, unsigned &flags)
-{
-  while (*options)
-    {
-      char *p = strchr (options, ',');
-      if (p)
-	*p++ = '\0';
-      else
-	p = strchr (options, '\0');
-
-      for (opt *o = oopts;
-	   o < (oopts + (sizeof (oopts) / sizeof (oopts[0])));
-	   o++)
-	if (strcmp (options, o->name) == 0)
-	  {
-	    if (o->clear)
-	      flags &= ~o->val;
-	    else
-	      flags |= o->val;
-	    goto gotit;
-	  }
-      return false;
-
-    gotit:
-      options = p;
-    }
-  return true;
-}
+#ifndef __CYGWIN__
+static bool read_flags (char *, unsigned &);
 #endif
 
 bool
@@ -392,7 +115,7 @@ from_fstab_line (mnt_t *m, char *line, bool user)
   cend = find_ws (c);
   *cend = '\0';
   unsigned mount_flags = MOUNT_SYSTEM;
-#ifndef FSTAB_ONLY
+#ifndef __CYGWIN__
   if (!read_flags (c, mount_flags))
 #else
   if (cygwin_internal (CW_CVT_MNT_OPTS, &c, &mount_flags))
@@ -453,514 +176,4 @@ from_fstab_line (mnt_t *m, char *line, bool user)
   return true;
 }
 
-#ifndef FSTAB_ONLY
-
-#define BUFSIZE 65536
-
-static char *
-get_user ()
-{
-  static char user[UNLEN + 1];
-  char *userenv;
-
-  user[0] = '\0';
-  if ((userenv = getenv ("USER")) || (userenv = getenv ("USERNAME")))
-    strncat (user, userenv, UNLEN);
-  return user;
-}
-
-void
-from_fstab (bool user, PWCHAR path, PWCHAR path_end)
-{
-  mnt_t *m = mount_table + max_mount_entry;
-  char buf[BUFSIZE];
-
-  if (!user)
-    {
-      /* Create a default root dir from path. */
-      wcstombs (buf, path, BUFSIZE);
-      unconvert_slashes (buf);
-      char *native_path = buf;
-      if (!strncmp (native_path, "\\\\?\\", 4))
-	native_path += 4;
-      if (!strncmp (native_path, "UNC\\", 4))
-	*(native_path += 2) = '\\';
-      m->posix = strdup ("/");
-      m->native = strdup (native_path);
-      m->flags = MOUNT_SYSTEM | MOUNT_IMMUTABLE | MOUNT_AUTOMATIC;
-      ++m;
-      /* Create default /usr/bin and /usr/lib entries. */
-      char *trail = strchr (native_path, '\0');
-      strcpy (trail, "\\bin");
-      m->posix = strdup ("/usr/bin");
-      m->native = strdup (native_path);
-      m->flags = MOUNT_SYSTEM | MOUNT_AUTOMATIC;
-      ++m;
-      strcpy (trail, "\\lib");
-      m->posix = strdup ("/usr/lib");
-      m->native = strdup (native_path);
-      m->flags = MOUNT_SYSTEM | MOUNT_AUTOMATIC;
-      ++m;
-      /* Create a default cygdrive entry.  Note that this is a user entry.
-	 This allows to override it with mount, unless the sysadmin created
-	 a cygdrive entry in /etc/fstab. */
-      m->posix = strdup (CYGWIN_INFO_CYGDRIVE_DEFAULT_PREFIX);
-      m->native = strdup ("cygdrive prefix");
-      m->flags = MOUNT_CYGDRIVE;
-      ++m;
-      max_mount_entry = m - mount_table;
-    }
-
-  PWCHAR u = wcscpy (path_end, L"\\etc\\fstab") + 10;
-  if (user)
-    mbstowcs (wcscpy (u, L".d\\") + 3, get_user (), BUFSIZE - (u - path));
-  HANDLE h = CreateFileW (path, GENERIC_READ, FILE_SHARE_READ, NULL,
-			  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
-  if (h == INVALID_HANDLE_VALUE)
-    return;
-  char *got = buf;
-  DWORD len = 0;
-  /* Using BUFSIZE-1 leaves space to append two \0. */
-  while (ReadFile (h, got, BUFSIZE - 1 - (got - buf),
-		   &len, NULL))
-    {
-      char *end;
-
-      /* Set end marker. */
-      got[len] = got[len + 1] = '\0';
-      /* Set len to the absolute len of bytes in buf. */
-      len += got - buf;
-      /* Reset got to start reading at the start of the buffer again. */
-      got = buf;
-      while (got < buf + len && (end = strchr (got, '\n')))
-	{
-	  end[end[-1] == '\r' ? -1 : 0] = '\0';
-	  if (from_fstab_line (m, got, user))
-	    ++m;
-	  got = end + 1;
-	}
-      if (len < BUFSIZE - 1)
-	break;
-      /* We have to read once more.  Move remaining bytes to the start of
-	 the buffer and reposition got so that it points to the end of
-	 the remaining bytes. */
-      len = buf + len - got;
-      memmove (buf, got, len);
-      got = buf + len;
-      buf[len] = buf[len + 1] = '\0';
-    }
-  if (got > buf && from_fstab_line (m, got, user))
-    ++m;
-  max_mount_entry = m - mount_table;
-  CloseHandle (h);
-}
-#endif /* !FSTAB_ONLY */
 #endif /* !TESTSUITE */
-
-#ifndef FSTAB_ONLY
-
-#ifndef TESTSUITE
-static int
-mnt_sort (const void *a, const void *b)
-{
-  const mnt_t *ma = (const mnt_t *) a;
-  const mnt_t *mb = (const mnt_t *) b;
-  int ret;
-
-  ret = (ma->flags & MOUNT_CYGDRIVE) - (mb->flags & MOUNT_CYGDRIVE);
-  if (ret)
-    return ret;
-  ret = (ma->flags & MOUNT_SYSTEM) - (mb->flags & MOUNT_SYSTEM);
-  if (ret)
-    return ret;
-  return strcmp (ma->posix, mb->posix);
-}
-
-extern "C" WCHAR cygwin_dll_path[];
-
-static void
-read_mounts ()
-{
-  HKEY setup_key;
-  LONG ret;
-  DWORD len;
-  WCHAR path[32768];
-  PWCHAR path_end;
-
-  for (mnt_t *m1 = mount_table; m1->posix; m1++)
-    {
-      free (m1->posix);
-      if (m1->native)
-	free ((char *) m1->native);
-      m1->posix = NULL;
-    }
-  max_mount_entry = 0;
-
-  /* First fetch the cygwin1.dll path from the LoadLibrary call in load_cygwin.
-     This utilizes the DLL search order to find a matching cygwin1.dll and to
-     compute the installation path from that DLL's path. */
-  if (cygwin_dll_path[0])
-    wcscpy (path, cygwin_dll_path);
-  /* If we can't load cygwin1.dll, check where cygcheck is living itself and
-     try to fetch installation path from here.  Does cygwin1.dll exist in the
-     same path?  This should only kick in if the cygwin1.dll in the same path
-     has been made non-executable for the current user accidentally. */
-  else if (!GetModuleFileNameW (NULL, path, 32768))
-    return;
-  path_end = wcsrchr (path, L'\\');
-  if (path_end)
-    {
-      if (!cygwin_dll_path[0])
-	{
-	  wcscpy (path_end, L"\\cygwin1.dll");
-	  DWORD attr = GetFileAttributesW (path);
-	  if (attr == (DWORD) -1
-	      || (attr & (FILE_ATTRIBUTE_DIRECTORY
-			  | FILE_ATTRIBUTE_REPARSE_POINT)))
-	    path_end = NULL;
-	}
-      if (path_end)
-	{
-	  *path_end = L'\0';
-	  path_end = wcsrchr (path, L'\\');
-	}
-    }
-  /* If we can't create a valid installation dir from that, try to fetch
-     the installation dir from the setup registry key. */
-  if (!path_end)
-    {
-      for (int i = 0; i < 2; ++i)
-	if ((ret = RegOpenKeyExW (i ? HKEY_LOCAL_MACHINE : HKEY_CURRENT_USER,
-				  L"Software\\Cygwin\\setup", 0,
-				  KEY_READ, &setup_key)) == ERROR_SUCCESS)
-	  {
-	    len = 32768 * sizeof (WCHAR);
-	    ret = RegQueryValueExW (setup_key, L"rootdir", NULL, NULL,
-				    (PBYTE) path, &len);
-	    RegCloseKey (setup_key);
-	    if (ret == ERROR_SUCCESS)
-	      break;
-	  }
-      if (ret == ERROR_SUCCESS)
-	path_end = wcschr (path, L'\0');
-    }
-  /* If we can't fetch an installation dir, bail out. */
-  if (!path_end)
-    return;
-  *path_end = L'\0';
-
-  from_fstab (false, path, path_end);
-  from_fstab (true, path, path_end);
-  qsort (mount_table, max_mount_entry, sizeof (mnt_t), mnt_sort);
-}
-#endif /* !defined(TESTSUITE) */
-
-/* Return non-zero if PATH1 is a prefix of PATH2.
-   Both are assumed to be of the same path style and / vs \ usage.
-   Neither may be "".
-   LEN1 = strlen (PATH1).  It's passed because often it's already known.
-
-   Examples:
-   /foo/ is a prefix of /foo  <-- may seem odd, but desired
-   /foo is a prefix of /foo/
-   / is a prefix of /foo/bar
-   / is not a prefix of foo/bar
-   foo/ is a prefix foo/bar
-   /foo is not a prefix of /foobar
-*/
-
-static int
-path_prefix_p (const char *path1, const char *path2, size_t len1)
-{
-  /* Handle case where PATH1 has trailing '/' and when it doesn't.  */
-  if (len1 > 0 && isslash (path1[len1 - 1]))
-    len1--;
-
-  if (len1 == 0)
-    return isslash (path2[0]) && !isslash (path2[1]);
-
-  if (strncasecmp (path1, path2, len1) != 0)
-    return 0;
-
-  return isslash (path2[len1]) || path2[len1] == 0 || path1[len1 - 1] == ':';
-}
-
-static char *
-vconcat (const char *s, va_list v)
-{
-  int len;
-  char *rv, *arg;
-  va_list save_v = v;
-  int unc;
-
-  if (!s)
-    return 0;
-
-  len = strlen (s);
-
-  unc = isslash (*s) && isslash (s[1]);
-
-  while (1)
-    {
-      arg = va_arg (v, char *);
-      if (arg == 0)
-	break;
-      len += strlen (arg);
-    }
-  va_end (v);
-
-  rv = (char *) malloc (len + 1);
-  strcpy (rv, s);
-  v = save_v;
-  while (1)
-  {
-    arg = va_arg (v, char *);
-    if (arg == 0)
-      break;
-    strcat (rv, arg);
-  }
-  va_end (v);
-
-  char *d, *p;
-
-  /* concat is only used for urls and files, so we can safely
-     canonicalize the results */
-  for (p = d = rv; *p; p++)
-    {
-      *d++ = *p;
-      /* special case for URLs */
-      if (*p == ':' && p[1] == '/' && p[2] == '/' && p > rv + 1)
-	{
-	  *d++ = *++p;
-	  *d++ = *++p;
-	}
-      else if (isslash (*p))
-	{
-	  if (p == rv && unc)
-	    *d++ = *p++;
-	  while (p[1] == '/')
-	    p++;
-	}
-    }
-  *d = 0;
-
-  return rv;
-}
-
-static char *
-concat (const char *s, ...)
-{
-  va_list v;
-
-  va_start (v, s);
-
-  return vconcat (s, v);
-}
-
-/* This is a helper function for when vcygpath is passed what appears
-   to be a relative POSIX path.  We take a Win32 CWD (either as specified
-   in 'cwd' or as retrieved with GetCurrentDirectory() if 'cwd' is NULL)
-   and find the mount table entry with the longest match.  We replace the
-   matching portion with the corresponding POSIX prefix, and to that append
-   's' and anything in 'v'.  The returned result is a mostly-POSIX
-   absolute path -- 'mostly' because the portions of CWD that didn't
-   match the mount prefix will still have '\\' separators.  */
-static char *
-rel_vconcat (const char *cwd, const char *s, va_list v)
-{
-  char pathbuf[MAX_PATH];
-  if (!cwd || *cwd == '\0')
-    {
-      if (!GetCurrentDirectory (MAX_PATH, pathbuf))
-	return NULL;
-      cwd = pathbuf;
-    }
-
-  size_t max_len = 0;
-  mnt_t *m, *match = NULL;
-
-  for (m = mount_table; m->posix; m++)
-    {
-      if (m->flags & MOUNT_CYGDRIVE)
-	continue;
-
-      size_t n = strlen (m->native);
-      if (n < max_len || !path_prefix_p (m->native, cwd, n))
-	continue;
-      max_len = n;
-      match = m;
-    }
-
-  char *temppath;
-  if (!match)
-    // No prefix matched - best effort to return meaningful value.
-    temppath = concat (cwd, "/", s, NULL);
-  else if (strcmp (match->posix, "/") != 0)
-    // Matched on non-root.  Copy matching prefix + remaining 'path'.
-    temppath = concat (match->posix, cwd + max_len, "/", s, NULL);
-  else if (cwd[max_len] == '\0')
-    // Matched on root and there's no remaining 'path'.
-    temppath = concat ("/", s, NULL);
-  else if (isslash (cwd[max_len]))
-    // Matched on root but remaining 'path' starts with a slash anyway.
-    temppath = concat (cwd + max_len, "/", s, NULL);
-  else
-    temppath = concat ("/", cwd + max_len, "/", s, NULL);
-
-  char *res = vconcat (temppath, v);
-  free (temppath);
-  return res;
-}
-
-/* Convert a POSIX path in 's' to an absolute Win32 path, and append
-   anything in 'v' to the end, returning the result.  If 's' is a
-   relative path then 'cwd' is used as the working directory to make
-   it absolute.  Pass NULL in 'cwd' to use GetCurrentDirectory.  */
-static char *
-vcygpath (const char *cwd, const char *s, va_list v)
-{
-  size_t max_len = 0;
-  mnt_t *m, *match = NULL;
-
-#ifndef TESTSUITE
-  if (!max_mount_entry)
-    read_mounts ();
-#endif
-  char *path;
-  if (s[0] == '.' && isslash (s[1]))
-    s += 2;
-
-  if (s[0] == '/' || s[1] == ':')	/* FIXME: too crude? */
-    path = vconcat (s, v);
-  else
-    path = rel_vconcat (cwd, s, v);
-
-  if (!path)
-    return NULL;
-
-  if (strncmp (path, "/./", 3) == 0)
-    memmove (path + 1, path + 3, strlen (path + 3) + 1);
-
-  for (m = mount_table; m->posix; m++)
-    {
-      size_t n = strlen (m->posix);
-      if (n < max_len || !path_prefix_p (m->posix, path, n))
-	continue;
-      if (m->flags & MOUNT_CYGDRIVE)
-	{
-	  if (strlen (path) < n + 2)
-	    continue;
-	  /* If cygdrive path is just '/', fix n for followup evaluation. */
-	  if (n == 1)
-	    n = 0;
-	  if (path[n] != '/')
-	    continue;
-	  if (!isalpha (path[n + 1]))
-	    continue;
-	  if (path[n + 2] != '/')
-	    continue;
-	}
-      max_len = n;
-      match = m;
-    }
-
-  char *native;
-  if (match == NULL)
-    native = strdup (path);
-  else if (max_len == strlen (path))
-    native = strdup (match->native);
-  else if (match->flags & MOUNT_CYGDRIVE)
-    {
-      char drive[3] = { path[max_len + 1], ':', '\0' };
-      native = concat (drive, path + max_len + 2, NULL);
-    }
-  else if (isslash (path[max_len]))
-    native = concat (match->native, path + max_len, NULL);
-  else
-    native = concat (match->native, "\\", path + max_len, NULL);
-  free (path);
-
-  unconvert_slashes (native);
-  for (char *s = strstr (native + 1, "\\.\\"); s && *s; s = strstr (s, "\\.\\"))
-    memmove (s + 1, s + 3, strlen (s + 3) + 1);
-  return native;
-}
-
-char *
-cygpath_rel (const char *cwd, const char *s, ...)
-{
-  va_list v;
-
-  va_start (v, s);
-
-  return vcygpath (cwd, s, v);
-}
-
-char *
-cygpath (const char *s, ...)
-{
-  va_list v;
-
-  va_start (v, s);
-
-  return vcygpath (NULL, s, v);
-}
-
-static mnt_t *m = NULL;
-
-extern "C" FILE *
-setmntent (const char *, const char *)
-{
-  m = mount_table;
-#ifndef TESTSUITE
-  if (!max_mount_entry)
-    read_mounts ();
-#endif
-  return NULL;
-}
-
-extern "C" struct mntent *
-getmntent (FILE *)
-{
-  static mntent mnt;
-  if (!m->posix)
-    return NULL;
-
-  mnt.mnt_fsname = (char *) m->native;
-  mnt.mnt_dir = (char *) m->posix;
-  if (!mnt.mnt_type)
-    mnt.mnt_type = (char *) malloc (16);
-  if (!mnt.mnt_opts)
-    mnt.mnt_opts = (char *) malloc (64);
-
-  strcpy (mnt.mnt_type,
-	  (char *) ((m->flags & MOUNT_SYSTEM) ? "system" : "user"));
-
-  if (m->flags & MOUNT_TEXT)
-    strcpy (mnt.mnt_opts, (char *) "text");
-  else
-    strcpy (mnt.mnt_opts, (char *) "binary");
-
-  if (m->flags & MOUNT_CYGWIN_EXEC)
-    strcat (mnt.mnt_opts, (char *) ",cygexec");
-  else if (m->flags & MOUNT_EXEC)
-    strcat (mnt.mnt_opts, (char *) ",exec");
-  else if (m->flags & MOUNT_NOTEXEC)
-    strcat (mnt.mnt_opts, (char *) ",notexec");
-
-  if (m->flags & MOUNT_NOACL)
-    strcat (mnt.mnt_opts, (char *) ",noacl");
-
-  if (m->flags & MOUNT_NOPOSIX)
-    strcat (mnt.mnt_opts, (char *) ",posix=0");
-
-  if (m->flags & (MOUNT_AUTOMATIC | MOUNT_CYGDRIVE))
-    strcat (mnt.mnt_opts, (char *) ",auto");
-
-  mnt.mnt_freq = 1;
-  mnt.mnt_passno = 1;
-  m++;
-  return &mnt;
-}
-
-#endif /* !FSTAB_ONLY */

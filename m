Return-Path: <cygwin-patches-return-8620-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75867 invoked by alias); 31 Aug 2016 18:07:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75850 invoked by uid 89); 31 Aug 2016 18:07:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=__cplusplus, kludge, Avoid, consult
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 31 Aug 2016 18:07:41 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bf9vE-0004eL-D8; Wed, 31 Aug 2016 20:07:39 +0200
Received: from [172.28.41.34] (helo=s01en24)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bf9vD-0006vw-2v; Wed, 31 Aug 2016 20:07:36 +0200
Received: by s01en24 (sSMTP sendmail emulation); Wed, 31 Aug 2016 20:07:35 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH 1/4] dlopen: switch to new pathfinder class
Date: Wed, 31 Aug 2016 18:07:00 -0000
Message-Id: <1472666829-32223-2-git-send-email-michael.haubenwallner@ssi-schaefer.com>
In-Reply-To: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
X-SW-Source: 2016-q3/txt/msg00028.txt.bz2

Instead of find_exec, without changing behaviour use new pathfinder
class with new allocator_interface around tmp_pathbuf and new vstrlist
class.
* pathfinder.h (pathfinder): New file.
* vstrlist.h (allocator_interface, allocated_type, vstrlist): New file.
* dlfcn.cc (dlopen): Avoid redundant GetModuleHandleExW with RTLD_NOLOAD
and RTLD_NODELETE.  Switch to new pathfinder class, using
(tmp_pathbuf_allocator): New class.
(get_full_path_of_dll): Drop.
---
 winsup/cygwin/dlfcn.cc     | 310 ++++++++++++++++++++++++-------------
 winsup/cygwin/pathfinder.h | 208 +++++++++++++++++++++++++
 winsup/cygwin/vstrlist.h   | 373 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 782 insertions(+), 109 deletions(-)
 create mode 100644 winsup/cygwin/pathfinder.h
 create mode 100644 winsup/cygwin/vstrlist.h

diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
index 255a6d5..e592512 100644
--- a/winsup/cygwin/dlfcn.cc
+++ b/winsup/cygwin/dlfcn.cc
@@ -20,6 +20,74 @@ details. */
 #include "cygtls.h"
 #include "tls_pbuf.h"
 #include "ntdll.h"
+#include "pathfinder.h"
+
+/* Dumb allocator using memory from tmp_pathbuf.w_get ().
+
+   Does not reuse free'd memory areas.  Instead, memory
+   is released when the tmp_pathbuf goes out of scope.
+
+   ATTENTION: Requesting memory from an instance of tmp_pathbuf breaks
+   when another instance on a newer stack frame has provided memory. */
+class tmp_pathbuf_allocator
+  : public allocator_interface
+{
+  tmp_pathbuf & tp_;
+  union
+    {
+      PWCHAR wideptr;
+      void * voidptr;
+      char * byteptr;
+    }    freemem_;
+  size_t freesize_;
+
+  /* allocator_interface */
+  virtual void * alloc (size_t need)
+  {
+    if (need == 0)
+      need = 1; /* GNU-ish */
+    size_t chunksize = NT_MAX_PATH * sizeof (WCHAR);
+    if (need > chunksize)
+      api_fatal ("temporary buffer too small for %d bytes", need);
+    if (need > freesize_)
+      {
+	/* skip remaining, use next chunk */
+	freemem_.wideptr = tp_.w_get ();
+	freesize_ = chunksize;
+      }
+
+    void * ret = freemem_.voidptr;
+
+    /* adjust remaining, aligned at 8 byte boundary */
+    need = need + 7 - (need - 1) % 8;
+    freemem_.byteptr += need;
+    if (need > freesize_)
+      freesize_ = 0;
+    else
+      freesize_ -= need;
+
+    return ret;
+  }
+
+  /* allocator_interface */
+  virtual void free (void *)
+  {
+    /* no-op: released by tmp_pathbuf at end of scope */
+  }
+
+  tmp_pathbuf_allocator ();
+  tmp_pathbuf_allocator (tmp_pathbuf_allocator const &);
+  tmp_pathbuf_allocator & operator = (tmp_pathbuf_allocator const &);
+
+public:
+  /* use tmp_pathbuf of current stack frame */
+  tmp_pathbuf_allocator (tmp_pathbuf & tp)
+    : allocator_interface ()
+    , tp_ (tp)
+    , freemem_ ()
+    , freesize_ (0)
+  {}
+};
 
 static void
 set_dl_error (const char *str)
@@ -28,84 +96,61 @@ set_dl_error (const char *str)
   _my_tls.locals.dl_error = 1;
 }
 
-/* Look for an executable file given the name and the environment
-   variable to use for searching (eg., PATH); returns the full
-   pathname (static buffer) if found or NULL if not. */
-inline const char *
-check_path_access (const char *mywinenv, const char *name, path_conv& buf)
-{
-  return find_exec (name, buf, mywinenv, FE_NNF | FE_DLL);
-}
-
-/* Search LD_LIBRARY_PATH for dll, if it exists.  Search /usr/bin and /usr/lib
-   by default.  Return valid full path in path_conv real_filename. */
-static inline bool
-gfpod_helper (const char *name, path_conv &real_filename)
+/* Identify basename and baselen within name,
+   return true if there is a dir in name. */
+static bool
+spot_basename (const char * &basename, int &baselen, const char * name)
 {
-  if (strchr (name, '/'))
-    real_filename.check (name, PC_SYM_FOLLOW | PC_NULLEMPTY);
-  else if (!check_path_access ("LD_LIBRARY_PATH", name, real_filename))
-    check_path_access ("/usr/bin:/usr/lib", name, real_filename);
-  if (!real_filename.exists ())
-    real_filename.error = ENOENT;
-  return !real_filename.error;
+  basename = strrchr (name, '/');
+  basename = basename ? basename + 1 : name;
+  baselen = name + strlen (name) - basename;
+  return basename > name;
 }
 
-static bool
-get_full_path_of_dll (const char* str, path_conv &real_filename)
+/* Setup basenames using basename and baselen,
+   return true if basenames do have some suffix. */
+static void
+collect_basenames (pathfinder::basenamelist & basenames,
+		   const char * basename, int baselen)
 {
-  int len = strlen (str);
+  /* like strrchr (basename, '.'), but limited to baselen */
+  const char *suffix = basename + baselen;
+  while (--suffix >= basename)
+    if (*suffix == '.')
+      break;
 
-  /* empty string? */
-  if (len == 0)
+  int suffixlen;
+  if (suffix >= basename)
+    suffixlen = basename + baselen - suffix;
+  else
     {
-      set_errno (EINVAL);
-      return false;		/* Yes.  Let caller deal with it. */
+      suffixlen = 0;
+      suffix = NULL;
     }
 
-  tmp_pathbuf tp;
-  char *name = tp.c_get ();
-
-  strcpy (name, str);	/* Put it somewhere where we can manipulate it. */
+  char const * ext = "";
+  /* Without some suffix, reserve space for a trailing dot to override
+     GetModuleHandleExA's automatic adding of the ".dll" suffix. */
+  int extlen = suffix ? 0 : 1;
 
-  char *basename = strrchr (name, '/');
-  basename = basename ? basename + 1 : name;
-  char *suffix = strrchr (name, '.');
-  if (suffix && suffix < basename)
-    suffix = NULL;
-
-  /* Is suffix ".so"? */
-  if (suffix && !strcmp (suffix, ".so"))
+  /* If we have the ".so" suffix, ... */
+  if (suffixlen == 3 && !strncmp (suffix, ".so", 3))
     {
-      /* Does the file exist? */
-      if (gfpod_helper (name, real_filename))
-	return true;
-      /* No, replace ".so" with ".dll". */
-      strcpy (suffix, ".dll");
+      /* ... keep the basename with original suffix, before ... */
+      basenames.appendv (basename, baselen, NULL);
+      /* ... replacing the ".so" with the ".dll" suffix. */
+      baselen -= 3;
+      ext = ".dll";
+      extlen = 4;
     }
-  /* Does the filename start with "lib"? */
+  /* If the basename starts with "lib", ... */
   if (!strncmp (basename, "lib", 3))
     {
-      /* Yes, replace "lib" with "cyg". */
-      strncpy (basename, "cyg", 3);
-      /* Does the file exist? */
-      if (gfpod_helper (name, real_filename))
-	return true;
-      /* No, revert back to "lib". */
-      strncpy (basename, "lib", 3);
+      /* ... replace "lib" with "cyg", before ... */
+      basenames.appendv ("cyg", 3, basename+3, baselen-3, ext, extlen, NULL);
     }
-  if (gfpod_helper (name, real_filename))
-    return true;
-
-  /* If nothing worked, create a relative path from the original incoming
-     filename and let LoadLibrary search for it using the system default
-     DLL search path. */
-  real_filename.check (str, PC_SYM_FOLLOW | PC_NOFULL | PC_NULLEMPTY);
-  if (!real_filename.error)
-    return true;
-
-  set_errno (real_filename.error);
-  return false;
+  /* ... using original basename with new suffix. */
+  basenames.appendv (basename, baselen, ext, extlen, NULL);
 }
 
 extern "C" void *
@@ -113,64 +158,111 @@ dlopen (const char *name, int flags)
 {
   void *ret = NULL;
 
-  if (name == NULL)
-    {
-      ret = (void *) GetModuleHandle (NULL); /* handle for the current module */
-      if (!ret)
-	__seterrno ();
-    }
-  else
+  do
     {
+      if (name == NULL || *name == '\0')
+	{
+	  ret = (void *) GetModuleHandle (NULL); /* handle for the current module */
+	  if (!ret)
+	    __seterrno ();
+	  break;
+	}
+
+      DWORD gmheflags = (flags & RTLD_NODELETE)
+		      ?  GET_MODULE_HANDLE_EX_FLAG_PIN
+		      : 0;
+
+      tmp_pathbuf tp; /* single one per stack frame */
+      tmp_pathbuf_allocator allocator (tp);
+      pathfinder::basenamelist basenames (allocator);
+
+      const char *basename;
+      int baselen;
+      bool have_dir = spot_basename (basename, baselen, name);
+      collect_basenames (basenames, basename, baselen);
+
       /* handle for the named library */
-      path_conv pc;
-      if (get_full_path_of_dll (name, pc))
+      path_conv real_filename;
+      wchar_t *wpath = tp.w_get ();
+
+      pathfinder finder (allocator, basenames); /* eats basenames */
+
+      if (have_dir)
+	{
+	  /* search the specified dir */
+	  finder.add_searchdir (name, basename - 1 - name);
+	}
+      else
+	{
+	  /* NOTE: The Windows loader (for linked dlls) does
+	     not use the LD_LIBRARY_PATH environment variable. */
+	  finder.add_envsearchpath ("LD_LIBRARY_PATH");
+
+	  /* Finally we better have some fallback. */
+	  finder.add_searchdir ("/usr/bin", 8);
+	  finder.add_searchdir ("/usr/lib", 8);
+	}
+
+      /* now search the file system */
+      if (!finder.find (pathfinder::
+			exists_and_not_dir (real_filename,
+					    PC_SYM_FOLLOW | PC_POSIX)))
 	{
-	  tmp_pathbuf tp;
-	  wchar_t *path = tp.w_get ();
+	  /* If nothing worked, create a relative path from the original
+	     incoming filename and let LoadLibrary search for it using the
+	     system default DLL search path. */
+	  real_filename.check (name, PC_SYM_FOLLOW | PC_NOFULL | PC_NULLEMPTY);
+	  if (real_filename.error)
+	    break;
+	}
 
-	  pc.get_wide_win32_path (path);
-	  /* Check if the last path component contains a dot.  If so,
-	     leave the filename alone.  Otherwise add a trailing dot
-	     to override LoadLibrary's automatic adding of a ".dll" suffix. */
-	  wchar_t *last_bs = wcsrchr (path, L'\\') ?: path;
-	  if (last_bs && !wcschr (last_bs, L'.'))
-	    wcscat (last_bs, L".");
+      real_filename.get_wide_win32_path (wpath);
+      /* Check if the last path component contains a dot.  If so,
+	 leave the filename alone.  Otherwise add a trailing dot
+	 to override LoadLibrary's automatic adding of a ".dll" suffix. */
+      wchar_t *last_bs = wcsrchr (wpath, L'\\') ?: wpath;
+      if (last_bs && !wcschr (last_bs, L'.'))
+	wcscat (last_bs, L".");
+
+      if (flags & RTLD_NOLOAD)
+	{
+	  GetModuleHandleExW (gmheflags, wpath, (HMODULE *) &ret);
+	  if (ret)
+	    break;
+	}
 
 #ifndef __x86_64__
-	  /* Workaround for broken DLLs built against Cygwin versions 1.7.0-49
-	     up to 1.7.0-57.  They override the cxx_malloc pointer in their
-	     DLL initialization code even if loaded dynamically.  This is a
-	     no-no since a later dlclose lets cxx_malloc point into nirvana.
-	     The below kludge "fixes" that by reverting the original cxx_malloc
-	     pointer after LoadLibrary.  This implies that their overrides
-	     won't be applied; that's OK.  All overrides should be present at
-	     final link time, as Windows doesn't allow undefined references;
-	     it would actually be wrong for a dlopen'd DLL to opportunistically
-	     override functions in a way that wasn't known then.  We're not
-	     going to try and reproduce the full ELF dynamic loader here!  */
-
-	  /* Store original cxx_malloc pointer. */
-	  struct per_process_cxx_malloc *tmp_malloc;
-	  tmp_malloc = __cygwin_user_data.cxx_malloc;
+      /* Workaround for broken DLLs built against Cygwin versions 1.7.0-49
+	 up to 1.7.0-57.  They override the cxx_malloc pointer in their
+	 DLL initialization code even if loaded dynamically.  This is a
+	 no-no since a later dlclose lets cxx_malloc point into nirvana.
+	 The below kludge "fixes" that by reverting the original cxx_malloc
+	 pointer after LoadLibrary.  This implies that their overrides
+	 won't be applied; that's OK.  All overrides should be present at
+	 final link time, as Windows doesn't allow undefined references;
+	 it would actually be wrong for a dlopen'd DLL to opportunistically
+	 override functions in a way that wasn't known then.  We're not
+	 going to try and reproduce the full ELF dynamic loader here!  */
+
+      /* Store original cxx_malloc pointer. */
+      struct per_process_cxx_malloc *tmp_malloc;
+      tmp_malloc = __cygwin_user_data.cxx_malloc;
 #endif
 
-	  if (flags & RTLD_NOLOAD)
-	    GetModuleHandleExW (0, path, (HMODULE *) &ret);
-	  else
-	    ret = (void *) LoadLibraryW (path);
-	  if (ret && (flags & RTLD_NODELETE))
-	    GetModuleHandleExW (GET_MODULE_HANDLE_EX_FLAG_PIN, path,
-				(HMODULE *) &ret);
+      ret = (void *) LoadLibraryW (wpath);
 
 #ifndef __x86_64__
-	  /* Restore original cxx_malloc pointer. */
-	  __cygwin_user_data.cxx_malloc = tmp_malloc;
+      /* Restore original cxx_malloc pointer. */
+      __cygwin_user_data.cxx_malloc = tmp_malloc;
 #endif
 
-	  if (!ret)
-	    __seterrno ();
-	}
+      if (ret && gmheflags)
+	GetModuleHandleExW (gmheflags, wpath, (HMODULE *) &ret);
+
+      if (!ret)
+	__seterrno ();
     }
+  while (0);
 
   if (!ret)
     set_dl_error ("dlopen");
diff --git a/winsup/cygwin/pathfinder.h b/winsup/cygwin/pathfinder.h
new file mode 100644
index 0000000..bbba168
--- /dev/null
+++ b/winsup/cygwin/pathfinder.h
@@ -0,0 +1,208 @@
+/* pathfinder.h: find one of multiple file names in path list
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#include "vstrlist.h"
+
+#ifdef __cplusplus
+
+/* Search a list of directory names for first occurrence of a file,
+   which's file name matches one out of a list of file names.  */
+class pathfinder
+{
+public:
+  typedef vstrlist searchdirlist;
+  typedef vstrlist basenamelist;
+
+private:
+  pathfinder ();
+  pathfinder (pathfinder const &);
+  pathfinder & operator = (pathfinder const &);
+
+  basenamelist basenames_;
+  size_t       basenames_maxlen_;
+
+  /* Add to searchdirs_ with extra buffer for any basename we may search for.
+     This is an optimization for the loops in check_path_access method. */
+  searchdirlist searchdirs_;
+
+public:
+  ~pathfinder () {}
+
+  /* We need the basenames to search for first, to allow for optimized
+     memory allocation of each searchpath + longest basename combination.
+     The incoming list of basenames is emptied (ownership take over). */
+  pathfinder (allocator_interface & a, basenamelist & basenames)
+    : basenames_ (a)
+    , basenames_maxlen_ ()
+    , searchdirs_(a)
+  {
+    basenames_.swap(basenames);
+
+    for (basenamelist::buffer_iterator basename (basenames_.begin ());
+	 basename != basenames_.end ();
+	 ++ basename)
+      {
+	if (basenames_maxlen_ < basename->bufferlength ())
+	  basenames_maxlen_ = basename->bufferlength ();
+      }
+  }
+
+  void add_searchdir (const char *dir, int dirlen)
+  {
+      if (dirlen < 0)
+	dirlen = strlen (dir);
+
+      if (!dirlen)
+	return;
+
+      searchdirs_.appendv (dir, dirlen, "/", 1 + basenames_maxlen_, NULL);
+  }
+
+  void add_searchpath (const char *path)
+  {
+    while (path && *path)
+      {
+	const char *next = strchr (path, ':');
+	add_searchdir (path, next ? next - path : -1);
+	path = next ? next + 1 : next;
+      }
+  }
+
+  void add_envsearchpath (const char *envpath)
+    {
+      add_searchpath (getenv (envpath));
+    }
+
+
+  /* pathfinder::criterion_interface
+     Overload this test method when you need separate dir and basename.  */
+  struct criterion_interface
+  {
+    virtual char const * name () const { return NULL; }
+
+    virtual bool test (searchdirlist::iterator dir,
+		       basenamelist::iterator name) const = 0;
+  };
+
+
+  /* pathfinder::simple_criterion_interface
+     Overload this test method when you need a single filename.  */
+  class simple_criterion_interface
+    : public criterion_interface
+  {
+    virtual bool test (searchdirlist::iterator dir,
+		       basenamelist::iterator name) const
+    {
+      /* Complete the filename path to search for within dir,
+	 We have allocated enough memory above.  */
+      searchdirlist::buffer_iterator dirbuf (dir);
+      memcpy (dirbuf->buffer () + dirbuf->stringlength (),
+	      name->string (), name->stringlength () + 1);
+      bool ret = test (dirbuf->string ());
+      /* reset original dir */
+      dirbuf->buffer ()[dirbuf->stringlength ()] = '\0';
+      return ret;
+    }
+
+  public:
+    virtual bool test (const char * filename) const = 0;
+  };
+
+
+  /* pathfinder::path_conv_criterion_interface
+     Overload this test method when you need a path_conv. */
+  class path_conv_criterion_interface
+    : public simple_criterion_interface
+  {
+    path_conv mypc_;
+    path_conv & pc_;
+    unsigned opt_;
+
+    /* simple_criterion_interface */
+    virtual bool test (const char * filename) const
+    {
+      pc_.check (filename, opt_);
+      return test (pc_);
+    }
+
+  public:
+    path_conv_criterion_interface (unsigned opt = PC_SYM_FOLLOW)
+      : mypc_ ()
+      , pc_ (mypc_)
+      , opt_ (opt)
+    {}
+
+    path_conv_criterion_interface (path_conv & ret, unsigned opt = PC_SYM_FOLLOW)
+      : mypc_ ()
+      , pc_ (ret)
+      , opt_ (opt)
+    {}
+
+    virtual bool test (path_conv & pc) const = 0;
+  };
+
+
+  /* pathfinder::exists_and_not_dir
+     Test if path_conv argument does exist and is not a directory. */
+  struct exists_and_not_dir
+    : public path_conv_criterion_interface
+  {
+    virtual char const * name () const { return "exists and not dir"; }
+
+    exists_and_not_dir (path_conv & pc, unsigned opt = PC_SYM_FOLLOW)
+      : path_conv_criterion_interface (pc, opt)
+    {}
+
+    /* path_conv_criterion_interface */
+    virtual bool test (path_conv & pc) const
+    {
+      if (pc.exists () && !pc.isdir ())
+	return true;
+
+      pc.error = ENOENT;
+      return false;
+    }
+  };
+
+
+  /* Find the single dir + basename that matches criterion.
+
+     Calls criterion.test method for each registered dir + basename
+     until returning true:
+       Returns true with found_dir + found_basename set.
+     If criterion.test method never returns true:
+       Returns false, not modifying found_dir nor found_basename.  */
+  bool find (criterion_interface const & criterion,
+	     searchdirlist::member const ** found_dir = NULL,
+	     basenamelist::member const ** found_basename = NULL)
+  {
+    char const * critname = criterion.name ();
+    for (basenamelist::iterator name = basenames_.begin ();
+	 name != basenames_.end ();
+	 ++name)
+      for (searchdirlist::iterator dir(searchdirs_.begin ());
+	   dir != searchdirs_.end ();
+	   ++dir)
+	if (criterion.test (dir, name))
+	  {
+	    debug_printf ("(%s), take %s%s", critname,
+			  dir->string(), name->string ());
+	    if (found_dir)
+	      *found_dir = dir.operator -> ();
+	    if (found_basename)
+	      *found_basename = name.operator -> ();
+	    return true;
+	  }
+	else
+	  debug_printf ("not (%s), skip %s%s", critname,
+			dir->string(), name->string ());
+    return false;
+  }
+};
+
+#endif /* __cplusplus */
diff --git a/winsup/cygwin/vstrlist.h b/winsup/cygwin/vstrlist.h
new file mode 100644
index 0000000..d5ad717
--- /dev/null
+++ b/winsup/cygwin/vstrlist.h
@@ -0,0 +1,373 @@
+/* vstrlist.h: class vstrlist
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifdef __cplusplus
+
+struct allocator_interface
+{
+  virtual void * alloc (size_t) = 0;
+  virtual void free (void *) = 0;
+};
+
+
+/* The allocated_type makes sure to use the free () method of the
+   same allocator_interface than the alloc () method was used of.
+
+   Stores the allocator_interface address before the real object,
+   to hide it from (construction & destruction of) real object.  */
+class allocated_type
+{
+  union allocator_store
+  {
+    allocator_interface * allocator_;
+    char alignment_[8];
+
+    union pointer
+    {
+      void            * vptr;
+      allocator_store * real;
+    };
+  };
+
+public:
+  void * operator new (size_t class_size, allocator_interface & allocator)
+  {
+    allocator_store::pointer astore;
+    astore.vptr = allocator.alloc (sizeof (allocator_store) + class_size);
+    astore.real->allocator_ = &allocator;
+    ++ astore.real;
+    return astore.vptr;
+  }
+
+  void operator delete (void * p)
+  {
+    allocator_store::pointer astore;
+    astore.vptr = p;
+    -- astore.real;
+    astore.real->allocator_->free (astore.vptr);
+  }
+};
+
+
+/* Double linked list of char arrays, each being a string buffer,
+   which's final buffer size and initial string content is defined
+   by a NULL terminated variable argument list of STRING+LEN pairs,
+   where each STRING (up to LEN) is concatenated for the initial
+   string buffer content, and each LEN is added to the final size
+   of the allocated string buffer.
+   If LEN is -1, strlen(STRING) is used for LEN.
+
+   Needs:
+     An implementation of the allocator_interface.
+
+   Provides:
+     iterator:
+       short name for the string_iterator
+     string_iterator:
+       provides readonly access via member methods:
+	 string (): readonly string buffer
+	 stringlength (): length (readonly) of initial string
+     buffer_iterator:
+       extends string_iterator
+       provides writeable access via member methods:
+	 buffer (): writeable string buffer
+	 bufferlength (): length (readonly) of allocated buffer
+
+   Usage sample:
+     char * text = "snipe";
+     vstrlist l;
+     l.appendv (text, 4, text+3, 2, "", 2, NULL);
+     buffer_iterator it (l.begin ());
+     strcpy (it->buffer () + it->stringlength (), "ts");
+     printf ("Sample result is: '%s'", it->string ());
+   Sample result is: 'snippets' */
+class vstrlist
+{
+public:
+  class member
+    : public allocated_type
+  {
+    friend class vstrlist;
+    friend class string_iterator;
+
+    member * prev_;
+    member * next_;
+    size_t   bufferlength_;
+    size_t   stringlength_;
+    char     buffer_[1]; /* we always have space for the trailing zero */
+
+    /* no copy, just swap */
+    member (member const &);
+    member & operator = (member const &);
+
+    /* anchor */
+    void * operator new (size_t class_size, allocator_interface & allocator)
+    {
+      return allocated_type::operator new (class_size, allocator);
+    }
+
+    /* anchor */
+    member ()
+      : allocated_type ()
+      , prev_ (this)
+      , next_ (this)
+      , bufferlength_ (0)
+      , stringlength_ (0)
+      , buffer_ ()
+    {}
+
+    /* entry: determine memory size from args */
+    void * operator new (size_t class_size, allocator_interface & allocator,
+			 char const * part0, va_list parts)
+    {
+      char const * part = part0;
+      va_list partsdup;
+      va_copy (partsdup, parts);
+      while (part)
+	{
+	  int partlen = va_arg (partsdup, int);
+	  if (partlen < 0)
+	    partlen = strlen (part);
+	  class_size += partlen;
+	  part = va_arg (partsdup, char const *);
+	}
+      va_end (partsdup);
+
+      return allocated_type::operator new (class_size, allocator);
+    }
+
+    /* entry: instantly insert into list */
+    member (member * before, char const * part0, va_list parts)
+      : allocated_type ()
+      , prev_ (NULL)
+      , next_ (NULL)
+      , bufferlength_ (0)
+      , stringlength_ ()
+      , buffer_ ()
+    {
+      prev_ = before->prev_;
+      next_ = before;
+
+      prev_->next_ = this;
+      next_->prev_ = this;
+
+      char * dest = buffer_;
+      char const * part = part0;
+      va_list partsdup;
+      va_copy (partsdup, parts);
+      while (part)
+	{
+	  int partlen = va_arg (partsdup, int);
+	  if (partlen < 0)
+	    {
+	      char * old = dest;
+	      dest = stpcpy (old, part);
+	      partlen = dest - old;
+	    }
+	  else
+	    dest = stpncpy (dest, part, partlen);
+	  bufferlength_ += partlen;
+	  part = va_arg (partsdup, const char *);
+	}
+      va_end (partsdup);
+      *dest = (char)0;
+      stringlength_ = dest - buffer_;
+      if (bufferlength_ > stringlength_)
+	memset (++dest, 0, bufferlength_ - stringlength_);
+    }
+
+    /* remove entry from list */
+    ~member ()
+    {
+      member * next = next_;
+      member * prev = prev_;
+      if (next)
+	next->prev_ = prev;
+      if (prev)
+	prev->next_ = next;
+      prev_ = NULL;
+      next_ = NULL;
+    }
+
+  public:
+    member const * next () const { return next_; }
+    member       * next ()       { return next_; }
+    member const * prev () const { return next_; }
+    member       * prev ()       { return next_; }
+
+    /* readonly access */
+    char const * string () const { return buffer_; }
+    size_t stringlength () const { return stringlength_; }
+
+    /* writeable access */
+    char       * buffer ()       { return buffer_; }
+    size_t bufferlength ()       { return bufferlength_; }
+  };
+
+  /* readonly access */
+  class string_iterator
+  {
+    friend class vstrlist;
+    friend class buffer_iterator;
+
+    member * current_;
+
+    string_iterator ();
+
+    string_iterator (member * current)
+      : current_ (current)
+    {}
+
+  public:
+    string_iterator (string_iterator const & rhs)
+      : current_ (rhs.current_)
+    {}
+
+    string_iterator & operator = (string_iterator const & rhs)
+    {
+      current_ = rhs.current_;
+      return *this;
+    }
+
+    string_iterator & operator ++ ()
+    {
+      current_ = current_->next ();
+      return *this;
+    }
+
+    string_iterator operator ++ (int)
+    {
+      string_iterator ret (*this);
+      current_ = current_->next ();
+      return ret;
+    }
+
+    string_iterator & operator -- ()
+    {
+      current_ = current_->prev ();
+      return *this;
+    }
+
+    string_iterator operator -- (int)
+    {
+      string_iterator ret (*this);
+      current_ = current_->prev ();
+      return ret;
+    }
+
+    bool operator == (string_iterator const & rhs) const
+    {
+      return current_ == rhs.current_;
+    }
+
+    bool operator != (string_iterator const & rhs) const
+    {
+      return current_ != rhs.current_;
+    }
+
+    /* readonly member access */
+    member const & operator *  () const { return *current_; }
+    member const * operator -> () const { return  current_; }
+
+    void remove ()
+    {
+      member * old = current_;
+      ++ *this;
+      delete old;
+    }
+  };
+
+  /* writeable access */
+  class buffer_iterator
+    : public string_iterator
+  {
+  public:
+    explicit /* can be used with vstrlist.begin () */
+    buffer_iterator (string_iterator const & begin)
+      : string_iterator (begin)
+    {}
+
+    buffer_iterator (buffer_iterator const & rhs)
+      : string_iterator (rhs)
+    {}
+
+    buffer_iterator & operator = (buffer_iterator const & rhs)
+    {
+      string_iterator::operator = (rhs);
+      return *this;
+    }
+
+    /* writeable member access */
+    member & operator *  () const { return *current_; }
+    member * operator -> () const { return  current_; }
+  };
+
+private:
+  allocator_interface & allocator_;
+  member              * anchor_;
+
+  /* not without an allocator */
+  vstrlist ();
+
+  /* no copy, just swap () */
+  vstrlist (vstrlist const &);
+  vstrlist & operator = (vstrlist const &);
+
+public:
+  /* iterator is the string_iterator */
+  typedef class string_iterator iterator;
+
+  iterator  begin () { return iterator (anchor_->next ()); }
+  iterator  end   () { return iterator (anchor_         ); }
+  iterator rbegin () { return iterator (anchor_->prev ()); }
+  iterator rend   () { return iterator (anchor_         ); }
+
+  vstrlist (allocator_interface & a)
+    : allocator_ (a)
+    , anchor_ (NULL) /* exception safety */
+  {
+    anchor_ = new (allocator_) member ();
+  }
+
+  ~vstrlist ()
+  {
+    if (anchor_ != NULL)
+      {
+	for (iterator it = begin (); it != end (); it.remove ());
+	delete anchor_;
+      }
+  }
+
+  void swap (vstrlist & that)
+  {
+    allocator_interface & a = allocator_;
+    member              * m = anchor_;
+    allocator_ = that.allocator_;
+    anchor_    = that.anchor_;
+    that.allocator_ = a;
+    that.anchor_    = m;
+  }
+
+  string_iterator appendv (char const * part0, va_list parts)
+  {
+    member * ret = new (allocator_, part0, parts)
+		       member (anchor_, part0, parts);
+    return string_iterator (ret);
+  }
+
+  string_iterator appendv (char const * part0, ...)
+  {
+    va_list parts;
+    va_start (parts, part0);
+    string_iterator ret = appendv (part0, parts);
+    va_end (parts);
+    return ret;
+  }
+};
+
+#endif /* __cplusplus */
-- 
2.7.3

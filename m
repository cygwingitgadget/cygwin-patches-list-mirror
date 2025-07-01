Return-Path: <SRS0=8TyM=ZO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 0552A3854A95
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 23:41:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0552A3854A95
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0552A3854A95
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751413276; cv=none;
	b=BZUEAbaigIBhFx59jQyel5bFWn6EQXfyY6tzXRjWTvV6oVF5XVrtA83G4O8c5rjnN9MIIh3N9l4gIz6lrOsZLufBzQmgURQv1mlU9tI+aC3PYLZw7uTlLzQ/Wg8hb/yROl1Brsm9QhA11ZfsTN7C+JoC+KY9yJOFnzTkslfcDgQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751413276; c=relaxed/simple;
	bh=tAZmGtb8gMNV/0ZHlTorKLn2dwXfPJ3XtE5BMS+G09k=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=d7gE8jOJZQ3gC3/1wvhqbi0y+RZ4wipGyvhRpAI7XOx+k5OvATOObJpxxzLMZLeqZVqrRttqIt4QjpcFBarPkV8Op+rlHvdQv39XN0VlZCJdcK+8+bnAv4OOl0G853npEaBIql/OnneSTDaB83blYJnDVjmcBAfke9nSkbLpNcE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0552A3854A95
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=EQTTIQet
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id CBE8445CA9
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 19:41:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=Eo77D
	fw4xLqGUcaFtNy07ZbjGm4=; b=EQTTIQetEXSHg3KVrlfgV0+lG4qKdfdc5tlbm
	Y0Ve2Etiq8Y3Ys7efnIe+w+icd4IjBS1FK720f23LFKdtyGXq7lBlkvLAfwTyYns
	UEj+4xbIOUy4C8b5hZucRgXd+kDrbFfsqmABHkZGPTKj3lOn9B4YpL66MTolCo94
	35z9Cs=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id BF96645CA7
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 19:41:15 -0400 (EDT)
Date: Tue, 1 Jul 2025 16:41:15 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/6] posix_spawn fast path
Message-ID: <7e6f479a-277c-3212-7080-b678b76186f4@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch series implements a "fast path" for posix_spawn and
posix_spawnp which spawns the child directly, rather than forking and then
execing after processing actions dictated by posix_spawnattr_t and
posix_file_actions_t.  The actions supported in the fast path are
least-common-denominator file actions which are able to be supported for
both Cygwin and non-Cygwin executables (namely, open and dup2 with target
fds stdin/stdout/stderr, close and (f)chdir).  Additional commits add
support to the fast path for attributes setsigdef, setsigign, and
setpgroup, which are used by the likes of ninja and make.  It should be
possible to implement the scheduler-related attributes, but I haven't
looked at them yet.

Potential future improvements would be to pass the posix_spawn attributes
and file actions through the child_info and perform them in the spawned
child if it is a cygwin process, rather than doing them all in the parent.
It might also be possible to implement the msvcrt lpReserved2 startup info
data for establishing mappings of handles to file descriptors for
non-stdin/out/err file descriptors (which would add functionality to
exec as well as spawn).

Jeremy Drake (6):
  Cygwin: allow redirecting stderr in ch_spawn
  Cygwin: add ability to pass cwd to child process
  Cygwin: hook posix_spawn/posix_spawnp
  Cygwin: add fast-path for posix_spawn(p)
  Cygwin: posix_spawn: add fastpath support for SETSIGMASK and
    SETSIGDEF.
  Cygwin: add pgroup support to posix_spawn fast path

 winsup/cygwin/cygwin.din                  |   4 +-
 winsup/cygwin/dcrt0.cc                    |  21 +-
 winsup/cygwin/local_includes/child_info.h |  21 +-
 winsup/cygwin/local_includes/path.h       |   6 +-
 winsup/cygwin/local_includes/winf.h       |   2 +-
 winsup/cygwin/sigproc.cc                  |   2 +-
 winsup/cygwin/spawn.cc                    | 423 ++++++++++++++++++++--
 winsup/cygwin/syscalls.cc                 |  18 +-
 8 files changed, 449 insertions(+), 48 deletions(-)

Range-diff against v1:
1:  1e5dfdc04b ! 1:  9fa661e5d4 Cygwin: allow redirecting stderr in ch_spawn
    @@ Commit message
         stdin and stdout were alreadly allowed for popen, but implementing
         posix_spawn in terms of spawn would require stderr as well.

    +    Replace the conveniently-located 4 filler bytes with int __stderr so
    +    that child_info_spawn doesn't have to grow.
    +
    +    Introduce a struct for passing additional args to ch_worker.spawn, since
    +    there are getting to be quite a lot of additional args.
    +
         Signed-off-by: Jeremy Drake <cygwin@jdrake.com>

      ## winsup/cygwin/dcrt0.cc ##
    @@ winsup/cygwin/local_includes/child_info.h: enum child_status

      /* Change this value if you get a message indicating that it is out-of-sync. */
     -#define CURR_CHILD_INFO_MAGIC 0xacbf4682U
    -+#define CURR_CHILD_INFO_MAGIC 0x6ccb18aeU
    ++#define CURR_CHILD_INFO_MAGIC 0x8af37cfU

      #include "pinfo.h"
      struct cchildren
    +@@ winsup/cygwin/local_includes/child_info.h: public:
    +   void reattach_children (HANDLE);
    + };
    +
    ++struct spawn_worker_args
    ++{
    ++  int mode;
    ++  int stdfds[3];
    ++
    ++  spawn_worker_args (int mode)
    ++    : mode (mode), stdfds {-1, -1, -1}
    ++  { }
    ++};
    ++
    + class child_info_spawn: public child_info
    + {
    +   HANDLE hExeced;
     @@ winsup/cygwin/local_includes/child_info.h: public:
        cygheap_exec_info *moreinfo;
        int __stdin;
    @@ winsup/cygwin/local_includes/child_info.h: public:
        operator HANDLE& () {return hExeced;}
        int worker (const char *, const char *const *, const char *const [],
     -		     int, int = -1, int = -1);
    -+		     int, int = -1, int = -1, int = -1);
    ++	      const spawn_worker_args &);
      };

      extern child_info_spawn ch_spawn;

      ## winsup/cygwin/spawn.cc ##
     @@ winsup/cygwin/spawn.cc: extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
    +
      int
      child_info_spawn::worker (const char *prog_arg, const char *const *argv,
    - 			  const char *const envp[], int mode,
    +-			  const char *const envp[], int mode,
     -			  int in__stdin, int in__stdout)
    -+			  int in__stdin, int in__stdout, int in__stderr)
    ++			  const char *const envp[],
    ++			  const spawn_worker_args &args)
      {
        bool rc;
        int res = -1;
    +
    +   /* Check if we have been called from exec{lv}p or spawn{lv}p and mask
    +      mode to keep only the spawn mode. */
    +-  bool p_type_exec = !!(mode & _P_PATH_TYPE_EXEC);
    +-  mode = _P_MODE (mode);
    ++  bool p_type_exec = !!(args.mode & _P_PATH_TYPE_EXEC);
    ++  int mode = _P_MODE (args.mode);
    +
    +   if (prog_arg == NULL)
    +     {
     @@ winsup/cygwin/spawn.cc: child_info_spawn::worker (const char *prog_arg, const char *const *argv,
    + 	  __leave;
    + 	}
            set (chtype, real_path.iscygexec ());
    -       __stdin = in__stdin;
    -       __stdout = in__stdout;
    -+      __stderr = in__stderr;
    +-      __stdin = in__stdin;
    +-      __stdout = in__stdout;
    ++      __stdin = args.stdfds[0];
    ++      __stdout = args.stdfds[1];
    ++      __stderr = args.stdfds[2];
            record_children ();

            si.lpReserved2 = (LPBYTE) this;
     @@ winsup/cygwin/spawn.cc: child_info_spawn::worker (const char *prog_arg, const char *const *argv,
    + 			 PROCESS_QUERY_LIMITED_INFORMATION))
    + 	sa = &sec_none_nih;

    -       int fileno_stdin = in__stdin < 0 ? 0 : in__stdin;
    -       int fileno_stdout = in__stdout < 0 ? 1 : in__stdout;
    +-      int fileno_stdin = in__stdin < 0 ? 0 : in__stdin;
    +-      int fileno_stdout = in__stdout < 0 ? 1 : in__stdout;
     -      int fileno_stderr = 2;
    -+      int fileno_stderr = in__stderr < 0 ? 2 : in__stderr;
    ++      int fileno_stdin = args.stdfds[0] < 0 ? 0 : args.stdfds[0];
    ++      int fileno_stdout = args.stdfds[1] < 0 ? 1 : args.stdfds[1];
    ++      int fileno_stderr = args.stdfds[2] < 0 ? 2 : args.stdfds[2];

            bool no_pcon = mode != _P_OVERLAY && mode != _P_WAIT;
            term_spawn_worker.setup (iscygwin (), handle (fileno_stdin, false),
    +@@ winsup/cygwin/spawn.cc: spawnve (int mode, const char *path, const char *const *argv,
    +   switch (_P_MODE (mode))
    +     {
    +     case _P_OVERLAY:
    +-      ch_spawn.worker (path, argv, envp, mode);
    ++      ch_spawn.worker (path, argv, envp, spawn_worker_args (mode));
    +       /* Errno should be set by worker.  */
    +       ret = -1;
    +       break;
    +@@ winsup/cygwin/spawn.cc: spawnve (int mode, const char *path, const char *const *argv,
    +     case _P_WAIT:
    +     case _P_DETACH:
    +     case _P_SYSTEM:
    +-      ret = ch_spawn.worker (path, argv, envp, mode);
    ++      ret = ch_spawn.worker (path, argv, envp, spawn_worker_args (mode));
    +       break;
    +     default:
    +       set_errno (EINVAL);
    +@@ winsup/cygwin/spawn.cc: __posix_spawn_execvpe (const char *path, char * const *argv, char *const *envp,
    +   ch_spawn.set_sem (sem);
    +   ch_spawn.worker (use_env_path ? (find_exec (path, buf, "PATH", FE_NNF) ?: "")
    + 				: path,
    +-		   argv, envp, _P_OVERLAY);
    ++		   argv, envp, spawn_worker_args (_P_OVERLAY));
    +   __posix_spawn_sem_release (sem, errno);
    +   return -1;
    + }
    +
    + ## winsup/cygwin/syscalls.cc ##
    +@@ winsup/cygwin/syscalls.cc: popen (const char *command, const char *in_type)
    +       int stdchild = myix ^ 1;	/* stdchild denotes the index into fd for the
    + 				   handle which will be redirected to
    + 				   stdin/stdout */
    +-      int __std[2];
    +-      __std[myix] = -1;		/* -1 means don't pass this fd to the child
    +-				   process */
    +-      __std[stdchild] = fds[stdchild]; /* Do pass this as the std handle */
    ++      spawn_worker_args spawnargs (_P_NOWAIT);
    ++      spawnargs.stdfds[myix] = -1; /* -1 means don't pass this fd to the child
    ++				      process */
    ++      spawnargs.stdfds[stdchild] = fds[stdchild]; /* Do pass this as the std
    ++						     handle */
    +
    +       const char *argv[4] =
    + 	{
    +@@ winsup/cygwin/syscalls.cc: popen (const char *command, const char *in_type)
    +          end of the pipe.  Otherwise don't pass our end of the pipe to the
    + 	 child process. */
    +       if (pipe_flags & O_CLOEXEC)
    +-	fcntl (__std[stdchild], F_SETFD, 0);
    ++	fcntl (spawnargs.stdfds[stdchild], F_SETFD, 0);
    +       else
    + 	fcntl (myfd, F_SETFD, FD_CLOEXEC);
    +
    +@@ winsup/cygwin/syscalls.cc: popen (const char *command, const char *in_type)
    +       fcntl (stdchild, F_SETFD, stdchild_state | FD_CLOEXEC);
    +
    +       /* Start a shell process to run the given command without forking. */
    +-      pid_t pid = ch_spawn.worker ("/bin/sh", argv, environ, _P_NOWAIT,
    +-				   __std[0], __std[1]);
    ++      pid_t pid = ch_spawn.worker ("/bin/sh", argv, environ, spawnargs);
    +
    +       /* Reinstate the close-on-exec state */
    +       fcntl (stdchild, F_SETFD, stdchild_state);
2:  19d5e88b60 ! 2:  c83c5d18e7 Cygwin: add ability to pass cwd to child process
    @@ Commit message

         This will be used by posix_spawn_fileaction_add_(f)chdir.

    -    This implementation is not quite complete enough for posix_spawn, as it
    -    also needs to treat relative paths to the program as relative to the
    -    specified CWD.
    +    The int cwdfd is placed such that it fits into space previously unused
    +    due to alignment in the cygheap_exec_info class.
    +
    +    This uses a file descriptor rather than a path both because it is easier
    +    to marshal to the child and because this should protect against races
    +    where the directory might be renamed or removed between addfchdir and
    +    the actual setting of the cwd in the child.

         Signed-off-by: Jeremy Drake <cygwin@jdrake.com>

    @@ winsup/cygwin/dcrt0.cc: dll_crt0_1 (void *)
           otherwise it is reinitalized in fixup_after_fork */

      ## winsup/cygwin/local_includes/child_info.h ##
    -@@ winsup/cygwin/local_includes/child_info.h: enum child_status
    - #define EXEC_MAGIC_SIZE sizeof(child_info)
    -
    - /* Change this value if you get a message indicating that it is out-of-sync. */
    --#define CURR_CHILD_INFO_MAGIC 0x6ccb18aeU
    -+#define CURR_CHILD_INFO_MAGIC 0xeb5dce32U
    -
    - #include "pinfo.h"
    - struct cchildren
     @@ winsup/cygwin/local_includes/child_info.h: public:
        int envc;
        char **envp;
    @@ winsup/cygwin/local_includes/child_info.h: public:
        int nchildren;
        cchildren children[0];
        static cygheap_exec_info *alloc ();
    -@@ winsup/cygwin/local_includes/child_info.h: public:
    -   bool has_execed_cygwin () const { return iscygwin () && has_execed (); }
    -   operator HANDLE& () {return hExeced;}
    -   int worker (const char *, const char *const *, const char *const [],
    --		     int, int = -1, int = -1, int = -1);
    -+		     int, int = -1, int = -1, int = -1, int = AT_FDCWD);
    +@@ winsup/cygwin/local_includes/child_info.h: struct spawn_worker_args
    + {
    +   int mode;
    +   int stdfds[3];
    ++  int cwdfd;
    +
    +   spawn_worker_args (int mode)
    +-    : mode (mode), stdfds {-1, -1, -1}
    ++    : mode (mode), stdfds {-1, -1, -1}, cwdfd (AT_FDCWD)
    +   { }
      };

    - extern child_info_spawn ch_spawn;
    +
    + ## winsup/cygwin/local_includes/path.h ##
    +@@ winsup/cygwin/local_includes/path.h: class path_conv
    + /* Interix symlink marker */
    + #define INTERIX_SYMLINK_COOKIE  "IntxLNK\1"
    +
    ++int gen_full_path_at (char *path_ret, int dirfd, const char *pathname,
    ++		      int flags = 0);
    ++
    + enum fe_types
    + {
    +   FE_NADA = 0,		/* Nothing special */
    +@@ winsup/cygwin/local_includes/path.h: enum fe_types
    + const char *find_exec (const char *name, path_conv& buf,
    + 				 const char *search = "PATH",
    + 				 unsigned opt = FE_NADA,
    +-				 const char **known_suffix = NULL);
    ++				 const char **known_suffix = NULL,
    ++				 int cwdfd = AT_FDCWD);
    +
    + /* Common macros for checking for invalid path names */
    + #define isdrive(s) (isalpha (*(s)) && (s)[1] == ':')
    +
    + ## winsup/cygwin/local_includes/winf.h ##
    +@@ winsup/cygwin/local_includes/winf.h: class av
    +     calloced = argc;
    +   }
    +   int setup (const char *, path_conv&, const char *, int, const char *const *,
    +-	     bool);
    ++	     bool, int = AT_FDCWD);
    + };
    +
    + class linebuf

      ## winsup/cygwin/spawn.cc ##
    -@@ winsup/cygwin/spawn.cc: extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
    - int
    - child_info_spawn::worker (const char *prog_arg, const char *const *argv,
    - 			  const char *const envp[], int mode,
    --			  int in__stdin, int in__stdout, int in__stderr)
    -+			  int in__stdin, int in__stdout, int in__stderr,
    -+			  int cwdfd)
    +@@ winsup/cygwin/spawn.cc: details. */
    +    Returns (possibly NULL) suffix */
    +
    + static const char *
    +-perhaps_suffix (const char *prog, path_conv& buf, int& err, unsigned opt)
    ++perhaps_suffix (const char *prog, path_conv& buf, int& err, unsigned opt,
    ++		int cwdfd)
    + {
    ++  tmp_pathbuf tp;
    +   const char *ext;
    +
    +   err = 0;
    +   debug_printf ("prog '%s'", prog);
    ++  if (cwdfd != AT_FDCWD && !isabspath_strict (prog))
    ++    {
    ++      char *tmp = tp.c_get ();
    ++      if (gen_full_path_at (tmp, cwdfd, prog))
    ++	{
    ++	  err = get_errno ();
    ++	  return NULL;
    ++	}
    ++      prog = tmp;
    ++    }
    ++
    +   buf.check (prog,
    + 	     PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP | PC_NULLEMPTY | PC_POSIX,
    + 	     stat_suffixes);
    +@@ winsup/cygwin/spawn.cc: perhaps_suffix (const char *prog, path_conv& buf, int& err, unsigned opt)
    +    and NULL is returned.  */
    + const char *
    + find_exec (const char *name, path_conv& buf, const char *search,
    +-	   unsigned opt, const char **known_suffix)
    ++	   unsigned opt, const char **known_suffix, int cwdfd)
      {
    -   bool rc;
    -   int res = -1;
    +   const char *suffix = "";
    +   const char *retval = NULL;
    +@@ winsup/cygwin/spawn.cc: find_exec (const char *name, path_conv& buf, const char *search,
    +
    +   /* Check to see if file can be opened as is first. */
    +   if ((has_slash || opt & FE_CWD)
    +-      && (suffix = perhaps_suffix (name, buf, err, opt)) != NULL)
    ++      && (suffix = perhaps_suffix (name, buf, err, opt, cwdfd)) != NULL)
    +     {
    +       /* Overwrite potential symlink target with original path.
    + 	 See comment preceeding this method. */
    +@@ winsup/cygwin/spawn.cc: find_exec (const char *name, path_conv& buf, const char *search,
    +
    +       int err1;
    +
    +-      if ((suffix = perhaps_suffix (tmp_path, buf, err1, opt)) != NULL)
    ++      if ((suffix = perhaps_suffix (tmp_path, buf, err1, opt, cwdfd)) != NULL)
    + 	{
    + 	  if (buf.has_acls () && check_file_access (buf, X_OK, true))
    + 	    continue;
     @@ winsup/cygwin/spawn.cc: child_info_spawn::worker (const char *prog_arg, const char *const *argv,
    +
    +       int err;
    +       const char *ext;
    +-      if ((ext = perhaps_suffix (prog_arg, real_path, err, FE_NADA)) == NULL)
    ++      if ((ext = perhaps_suffix (prog_arg, real_path, err, FE_NADA,
    ++				 args.cwdfd)) == NULL)
    + 	{
    + 	  set_errno (err);
    + 	  res = -1;
    + 	  __leave;
    + 	}
    +
    +-      res = newargv.setup (prog_arg, real_path, ext, ac, argv, p_type_exec);
    ++      res = newargv.setup (prog_arg, real_path, ext, ac, argv, p_type_exec,
    ++			   args.cwdfd);
    +
            if (res)
      	__leave;

    @@ winsup/cygwin/spawn.cc: child_info_spawn::worker (const char *prog_arg, const ch
     +	{
     +	  moreinfo->argc = newargv.argc;
     +	  moreinfo->argv = newargv;
    -+	  moreinfo->cwdfd = cwdfd;
    ++	  moreinfo->cwdfd = args.cwdfd;
     +	}
     +
    -+      if (cwdfd > 0)
    ++      if (args.cwdfd > 0)
     +        {
    -+	  cygheap_fdget cfd (cwdfd);
    ++	  cygheap_fdget cfd (args.cwdfd);
     +	  if (cfd < 0)
     +	    {
     +	      set_errno (EBADF);
    @@ winsup/cygwin/spawn.cc: child_info_spawn::worker (const char *prog_arg, const ch
      			       &si,
      			       &pi);
      	  if (hwst)
    +@@ winsup/cygwin/spawn.cc: spawnvpe (int mode, const char *file, const char * const *argv,
    +
    + int
    + av::setup (const char *prog_arg, path_conv& real_path, const char *ext,
    +-	   int ac_in, const char *const *av_in, bool p_type_exec)
    ++	   int ac_in, const char *const *av_in, bool p_type_exec, int cwdfd)
    + {
    +   const char *p;
    +   bool exeext = ascii_strcasematch (ext, ".exe");
    +@@ winsup/cygwin/spawn.cc: av::setup (const char *prog_arg, path_conv& real_path, const char *ext,
    + 	if (arg1)
    + 	  unshift (arg1);
    +
    +-	find_exec (pgm, real_path, "PATH", FE_NADA, &ext);
    ++	find_exec (pgm, real_path, "PATH", FE_NADA, &ext, cwdfd);
    + 	unshift (real_path.get_posix ());
    +       }
    +   if (real_path.iscygexec ())
    +
    + ## winsup/cygwin/syscalls.cc ##
    +@@ winsup/cygwin/syscalls.cc: pclose (FILE *fp)
    +
    + /* Preliminary(?) implementation of the openat family of functions. */
    +
    +-static int
    ++int
    + gen_full_path_at (char *path_ret, int dirfd, const char *pathname,
    +-		  int flags = 0)
    ++		  int flags)
    + {
    +   /* futimesat allows a NULL pathname. */
    +   if (!pathname && !(flags & _AT_NULL_PATHNAME_ALLOWED))
3:  c58ecec305 = 3:  23bf40a743 Cygwin: hook posix_spawn/posix_spawnp
4:  dabcbab090 ! 4:  049e555f6d Cygwin: add fast-path for posix_spawn(p)
    @@ Metadata
      ## Commit message ##
         Cygwin: add fast-path for posix_spawn(p)

    -    Currently just file actions open/close/dup2 are supported in the fast
    -    path.
    +    Currently just file actions are supported in the fast path, open/dup2
    +    with a target fd of stdin/out/err, close of any fd, and chdir and
    +    fchdir.  These were chosen as the least-common-denominator of
    +    functionality supported for any child process, as they are allowed to be
    +    specified via CreateProcess.  They also happen to be the most common
    +    file operations, performed by the likes of GNU make, ninja, LLVM, and rust.
    +
    +    For other attributes or actions, fall back to the newlib implementation
    +    of posix_spawn (which uses fork/exec to set everything up in the child
    +    process).

         Signed-off-by: Jeremy Drake <cygwin@jdrake.com>

    @@ winsup/cygwin/spawn.cc: do_posix_spawn (pid_t *pid, const char *path,
     +
     +  {
     +    path_conv buf;
    ++    spawn_worker_args args (_P_NOWAIT);
    ++    /* lock the process to temporarily manipulate file descriptors for the
    ++       spawn operation */
     +    lock_process now;
     +    posix_spawn_file_actions_entry_t *fae;
    ++    /* make sure there is enough room in oldflags for the standard descriptors
    ++       at least */
    ++    size_t oldflagslen = cygheap->fdtab.size > 3 ? cygheap->fdtab.size : 3;
     +    pid_t chpid;
    -+    int fds[3] = {-1, -1, -1};
    -+    int oldflags[cygheap->fdtab.size];
    ++    int oldflags[oldflagslen];
     +    int ret = -1;
    -+    memset (oldflags, -1, sizeof (oldflags));
    ++    memset (oldflags, -1, oldflagslen * sizeof (int));
     +
     +    if (fa)
     +      {
    @@ winsup/cygwin/spawn.cc: do_posix_spawn (pid_t *pid, const char *path,
     +	    switch (fae->fae_action)
     +	      {
     +	      case __posix_spawn_file_actions_entry::FAE_DUP2:
    ++		/* only support new file descriptors 0 through 2 for now as
    ++		   least-common-denominator for all proceses, and also the
    ++		   most common operation */
     +		if (fae->fae_newfildes < 0 || fae->fae_newfildes > 2)
     +		  goto closes;
     +
    -+		if (fds[fae->fae_newfildes] != -1)
    -+		  close (fds[fae->fae_newfildes]);
    ++		if (args.stdfds[fae->fae_newfildes] != -1)
    ++		  close (args.stdfds[fae->fae_newfildes]);
     +
     +		if (fae->fae_fildes >= 0 && fae->fae_fildes <= 2 &&
    -+		    fds[fae->fae_fildes] != -1)
    -+		  fds[fae->fae_newfildes] = dup (fds[fae->fae_fildes]);
    ++		    args.stdfds[fae->fae_fildes] != -1)
    ++		  args.stdfds[fae->fae_newfildes] =
    ++					    dup (args.stdfds[fae->fae_fildes]);
     +		else
    -+		  fds[fae->fae_newfildes] = dup (fae->fae_fildes);
    ++		  args.stdfds[fae->fae_newfildes] = dup (fae->fae_fildes);
     +
    -+		if (fds[fae->fae_newfildes] < 0)
    ++		if (args.stdfds[fae->fae_newfildes] < 0)
     +		  {
    -+		    fds[fae->fae_newfildes] = -1;
    ++		    args.stdfds[fae->fae_newfildes] = -1;
     +		    ret = get_errno ();
     +		    goto closes;
     +		  }
    @@ winsup/cygwin/spawn.cc: do_posix_spawn (pid_t *pid, const char *path,
     +		break;
     +
     +	      case __posix_spawn_file_actions_entry::FAE_OPEN:
    ++		/* only support new file descriptors 0 through 2 for now as
    ++		   least-common-denominator for all proceses, and also the
    ++		   most common operation */
     +		if (fae->fae_fildes < 0 || fae->fae_fildes > 2)
     +		  goto closes;
    -+		if (fds[fae->fae_fildes] != -1)
    -+		  close (fds[fae->fae_fildes]);
    ++		if (args.stdfds[fae->fae_fildes] != -1)
    ++		  close (args.stdfds[fae->fae_fildes]);
     +		/* can we just mask out O_CLOEXEC from fae_oflag, or must we
     +		   use F_SETFD later? */
    -+		fds[fae->fae_fildes] = open (fae->fae_path, fae->fae_oflag,
    -+					     fae->fae_mode);
    -+		if (fds[fae->fae_fildes] < 0)
    ++		args.stdfds[fae->fae_fildes] = openat (args.cwdfd,
    ++						       fae->fae_path,
    ++						       fae->fae_oflag,
    ++						       fae->fae_mode);
    ++		if (args.stdfds[fae->fae_fildes] < 0)
     +		  {
    -+		    fds[fae->fae_fildes] = -1;
    ++		    args.stdfds[fae->fae_fildes] = -1;
     +		    ret = get_errno ();
     +		    goto closes;
     +		  }
    -+		fcntl (fds[fae->fae_fildes], F_SETFD, 0);
    ++		fcntl (args.stdfds[fae->fae_fildes], F_SETFD, 0);
     +		if (oldflags[fae->fae_fildes] == -1)
     +		  oldflags[fae->fae_fildes] = fcntl (fae->fae_fildes, F_GETFD,
     +						     0);
     +		fcntl (fae->fae_fildes, F_SETFD, FD_CLOEXEC);
     +		break;
     +	      case __posix_spawn_file_actions_entry::FAE_CLOSE:
    ++		/* If we're asked to close one of the standard handles, and
    ++		   we've already opened or duped that handle, mark it as CLOEXEC
    ++		   rather than actually closing it to make sure the child gets a
    ++		   closed handle.  If that same handle then gets opened or duped
    ++		   again later, the existing handle will be closed then */
     +		if (fae->fae_fildes >= 0 && fae->fae_fildes <= 2 &&
    -+		    fds[fae->fae_fildes] != -1)
    ++		    args.stdfds[fae->fae_fildes] != -1)
     +		  {
    -+		    fcntl (fds[fae->fae_fildes], F_SETFD, FD_CLOEXEC);
    ++		    fcntl (args.stdfds[fae->fae_fildes], F_SETFD, FD_CLOEXEC);
     +		  }
    -+		else
    ++		else if (fae->fae_fildes >= 0 &&
    ++			 (unsigned) fae->fae_fildes < oldflagslen)
     +		  {
     +		    if (oldflags[fae->fae_fildes] == -1)
     +		      oldflags[fae->fae_fildes] = fcntl (fae->fae_fildes,
     +							 F_GETFD, 0);
     +		    fcntl (fae->fae_fildes, F_SETFD, FD_CLOEXEC);
     +		  }
    ++		else
    ++		  {
    ++		    ret = EBADF;
    ++		    goto closes;
    ++		  }
     +		break;
    -+	      /* TODO: FAE_(F)CHDIR */
    ++	      case __posix_spawn_file_actions_entry::FAE_FCHDIR:
    ++		if (args.cwdfd >= 0)
    ++		  close (args.cwdfd);
    ++		args.cwdfd = dup (fae->fae_dirfd);
    ++		if (args.cwdfd < 0)
    ++		  {
    ++		    ret = get_errno ();
    ++		    goto closes;
    ++		  }
    ++		/* the cloexec flag will be set or cleared in ch_spawn.worker
    ++		   as necessary */
    ++		fcntl (args.cwdfd, F_SETFD, FD_CLOEXEC);
    ++		break;
    ++	      case __posix_spawn_file_actions_entry::FAE_CHDIR:
    ++		{
    ++		  int newfd = openat (args.cwdfd, fae->fae_dir,
    ++				      O_SEARCH|O_DIRECTORY|O_CLOEXEC, 0755);
    ++		  if (newfd < 0)
    ++		  {
    ++		    ret = get_errno ();
    ++		    goto closes;
    ++		  }
    ++		  if (args.cwdfd >= 0)
    ++		    close (args.cwdfd);
    ++		  args.cwdfd = newfd;
    ++		  break;
    ++		}
     +	      default:
     +		goto closes;
     +	      }
     +	  }
    ++
    ++	/* From popen: If fds are in the range of stdin/stdout/stderr, move
    ++	   them out of the way.  Otherwise, spawn_guts will be confused.
    ++	   We do this here rather than adding logic to spawn_guts because
    ++	   spawn_guts is likely to be a more frequently used routine and
    ++	   having stdin/stdout/stderr closed and reassigned to pipe handles
    ++	   is an unlikely event. */
    ++	for (int i = 0; i < 3; i++)
    ++	  if (args.stdfds[i] >= 0 && args.stdfds[i] <= 2)
    ++	    {
    ++	      cygheap_fdnew newfd (3);
    ++	      cygheap->fdtab.move_fd (args.stdfds[i], newfd);
    ++	      args.stdfds[i] = newfd;
    ++	    }
    ++
    ++	if (args.cwdfd >= 0 && args.cwdfd <= 2)
    ++	  {
    ++	    cygheap_fdnew newfd (3);
    ++	    cygheap->fdtab.move_fd (args.cwdfd, newfd);
    ++	    args.cwdfd = newfd;
    ++	  }
     +      }
     +
     +    chpid = ch_spawn.worker (
    -+	use_env_path ? (find_exec (path, buf, "PATH", FE_NNF) ?: "")
    ++	use_env_path ?
    ++		(find_exec (path, buf, "PATH", FE_NNF, NULL, args.cwdfd) ?: "")
     +		     : path,
    -+	argv, envp ?: environ,
    -+	_P_NOWAIT | (use_env_path ? _P_PATH_TYPE_EXEC : 0),
    -+	fds[0], fds[1], fds[2]);
    ++	argv, envp ?: environ, args);
     +
     +    if (chpid < 0)
     +      {
    @@ winsup/cygwin/spawn.cc: do_posix_spawn (pid_t *pid, const char *path,
     +
     +closes:
     +    int save_errno = get_errno ();
    ++    if (args.cwdfd >= 0)
    ++      close (args.cwdfd);
     +    for (size_t i = 0; i < 3; i++)
    -+      if (fds[i] != -1)
    -+	close (fds[i]);
    -+    for (size_t i = 0; i < sizeof (oldflags) / sizeof (oldflags[0]); i++)
    ++      if (args.stdfds[i] != -1)
    ++	close (args.stdfds[i]);
    ++    for (size_t i = 0; i < oldflagslen; i++)
     +      if (oldflags[i] != -1)
     +	fcntl (i, F_SETFD, oldflags[i]);
     +    set_errno (save_errno);
5:  cffe576059 ! 5:  05505d6873 Cygwin: posix_spawn: add fastpath support for SETSIGMASK and SETSIGDEF.
    @@ Metadata
      ## Commit message ##
         Cygwin: posix_spawn: add fastpath support for SETSIGMASK and SETSIGDEF.

    +    the sigmask was already a member of the child_info, so this just needed
    +    an arg to allow overriding the value copied from cygheap.  The signal
    +    handlers are referenced by two pointers, global_sigs which is used by
    +    the signal routines, and cygheap->sigs which is only used during process
    +    launch and startup.  Temporarily replace cygheap->sigs with a copy that
    +    has the requested signals reset to default while spawning the child.
    +
         Signed-off-by: Jeremy Drake <cygwin@jdrake.com>

      ## winsup/cygwin/local_includes/child_info.h ##
    -@@ winsup/cygwin/local_includes/child_info.h: public:
    -   bool has_execed_cygwin () const { return iscygwin () && has_execed (); }
    -   operator HANDLE& () {return hExeced;}
    -   int worker (const char *, const char *const *, const char *const [],
    --		     int, int = -1, int = -1, int = -1, int = AT_FDCWD);
    -+		     int, int = -1, int = -1, int = -1, int = AT_FDCWD,
    -+		     sigset_t * = NULL);
    +@@ winsup/cygwin/local_includes/child_info.h: struct spawn_worker_args
    +   int mode;
    +   int stdfds[3];
    +   int cwdfd;
    ++  sigset_t *sigmask;
    +
    +   spawn_worker_args (int mode)
    +-    : mode (mode), stdfds {-1, -1, -1}, cwdfd (AT_FDCWD)
    ++    : mode (mode), stdfds {-1, -1, -1}, cwdfd (AT_FDCWD), sigmask (NULL)
    +   { }
      };

    - extern child_info_spawn ch_spawn;

      ## winsup/cygwin/spawn.cc ##
    -@@ winsup/cygwin/spawn.cc: int
    - child_info_spawn::worker (const char *prog_arg, const char *const *argv,
    - 			  const char *const envp[], int mode,
    - 			  int in__stdin, int in__stdout, int in__stderr,
    --			  int cwdfd)
    -+			  int cwdfd, sigset_t *sigmaskp)
    - {
    -   bool rc;
    -   int res = -1;
     @@ winsup/cygwin/spawn.cc: child_info_spawn::worker (const char *prog_arg, const char *const *argv,
    -       __stdin = in__stdin;
    -       __stdout = in__stdout;
    -       __stderr = in__stderr;
    -+      if (sigmaskp)
    -+	sigmask = *sigmaskp;
    +       __stdin = args.stdfds[0];
    +       __stdout = args.stdfds[1];
    +       __stderr = args.stdfds[2];
    ++      if (args.sigmask)
    ++	sigmask = *args.sigmask;
            record_children ();

            si.lpReserved2 = (LPBYTE) this;
    @@ winsup/cygwin/spawn.cc: do_posix_spawn (pid_t *pid, const char *path,
      		const posix_spawnattr_t *sa, char * const argv[],
      		char * const envp[], int use_env_path)
      {
    -+  sigset_t *sigmaskp = NULL;
    ++  spawn_worker_args args (_P_NOWAIT);
     +  struct sigaction *sigs = NULL;
        syscall_printf ("posix_spawn%s (%p, %s, %p, %p, %p, %p)",
            use_env_path ? "p" : "", pid, path, fa, sa, argv, envp);
    @@ winsup/cygwin/spawn.cc: do_posix_spawn (pid_t *pid, const char *path,
     +	goto fallback;
     +
     +      if ((*sa)->sa_flags & POSIX_SPAWN_SETSIGMASK)
    -+	sigmaskp = &(*sa)->sa_sigmask;
    ++	args.sigmask = &(*sa)->sa_sigmask;
     +
     +      if ((*sa)->sa_flags & POSIX_SPAWN_SETSIGDEF)
     +	{
    @@ winsup/cygwin/spawn.cc: do_posix_spawn (pid_t *pid, const char *path,

        {
          path_conv buf;
    +-    spawn_worker_args args (_P_NOWAIT);
    +     /* lock the process to temporarily manipulate file descriptors for the
    +        spawn operation */
    +     lock_process now;
     @@ winsup/cygwin/spawn.cc: do_posix_spawn (pid_t *pid, const char *path,
      	  }
            }
    @@ winsup/cygwin/spawn.cc: do_posix_spawn (pid_t *pid, const char *path,
     +	      }
     +	  }
     +
    ++	/* the active signal handler info is kept in global_sigs and
    ++	   cygheap->sigs is only used for inheritance to child processes, so we
    ++	   can swap out cygheap->sigs without worrying about messing up the
    ++	   current process's state.  Use an InterlockedExchange just to be
    ++	   safe. */
     +	sigs = (struct sigaction *) InterlockedExchangePointer (
     +						(PVOID *) &cygheap->sigs, sigs);
     +      }
     +
          chpid = ch_spawn.worker (
    - 	use_env_path ? (find_exec (path, buf, "PATH", FE_NNF) ?: "")
    + 	use_env_path ?
    + 		(find_exec (path, buf, "PATH", FE_NNF, NULL, args.cwdfd) ?: "")
      		     : path,
    - 	argv, envp ?: environ,
    - 	_P_NOWAIT | (use_env_path ? _P_PATH_TYPE_EXEC : 0),
    --	fds[0], fds[1], fds[2]);
    -+	fds[0], fds[1], fds[2], AT_FDCWD, sigmaskp);
    -+
    + 	argv, envp ?: environ, args);
    +
    ++    /* put cygheap->sigs back how we found it (should be the same as
    ++       global_sigs */
     +    if (sigs)
     +      sigs = (struct sigaction *) InterlockedExchangePointer (
     +						(PVOID *) &cygheap->sigs, sigs);
    -
    ++
          if (chpid < 0)
            {
    + 	ret = get_errno ();
     @@ winsup/cygwin/spawn.cc: do_posix_spawn (pid_t *pid, const char *path,

      closes:
          int save_errno = get_errno ();
     +    if (sigs)
     +      cfree (sigs);
    +     if (args.cwdfd >= 0)
    +       close (args.cwdfd);
          for (size_t i = 0; i < 3; i++)
    -       if (fds[i] != -1)
    - 	close (fds[i]);
-:  ---------- > 6:  fc12ce516a Cygwin: add pgroup support to posix_spawn fast path
-- 
2.49.0.windows.1


From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com, cygwin-xfree@cygwin.com
Subject: Re: [PATCH] Re: pthread -- Corinna?
Date: Mon, 16 Apr 2001 21:51:00 -0000
Message-id: <20010417005137.A26463@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF79C0@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q2/msg00085.html

On Tue, Apr 17, 2001 at 02:03:19PM +1000, Robert Collins wrote:
>I've remembered my key thought:
>
>fopen should only fail open when etc_passwd is being read. 
>
>We've got two thread issues here: 
>1) a area that requires serialisation (reading the file into memory) 
>2) a potential deadlock due to recursion
>(read_etc->fopen->get_id->read_etc)

You probably know this, but, recurison won't cause the mutex to block
since repeated calls to a mutex in the same thread don't block if the
thread owns the mutex.  It will recurse, though, of course, which is not
right.

>I think we should address the two issues separately. They aren't the
>same thing after all.

Ah right.  I forgot my own point.  This can be controlled by changing
the state of passwd_state to something like "initializing".

>> >A true semaphore could be used, but as the current one is mutex
>> >protected there's no point in extra overhead.
>> 
>> Still not convinced.
>> 
>> It still seems like there is potential for error if two threads call
>> get_id_from_sid.  One may correctly read a UID via getpwuid, one will
>> short-circuit.  
>
>Nope, getpwuid blocks if read_etc_passwd is in progress. (Or does the
>short-circuit mean "do not call getpwuid" ?).

Yes.  I don't see how it can possibly be the right behavior that one
thread will call get_id_from_sid and get the right behavior and another
one will not.

You just can't use a static variable to guard against recursion in a a
multi-threaded application.  You could use thread local storage for
this though, I guess.

>> Hmm.  This would be a problem even if we were 
>> attempting
>> to detect recursion via a static variable.
>
>Get_id_from_sid should know whether the call is part of parsing
>/etc/passwd. We don't want to serialise disk access or opens in general,
>so some thought is needed on this one.
> 
>> Maybe we need another passwd_state == 'initializing'.
>
>Ahh, that gets kind of messy because then all the getpwnam checks will
>need to be passwd_state == uninitialised || passwd_state ==
>initializing.

passwd_state <= initializing
 
>> Hmm, again.  We actually have *three* variables controlling how this
>> operates now, passwd_state, passwd_sem, and etc_passwd_mutex.  IMO,
>> that's too many.
>
>Why don't we abstract out the read_etc_passwd into the search function?
>That will cleanup some of the state test issues. 
>
>That gives
>passwd_state - whether the passwd file has been parsed
>etc_passwd_mutex - serialises the parsing.
>passwd_sem - allows get_id_from_sid to skip checking access on
>/etc/passwd when parsing /etc/passwd.
>
>I think the correct solution is to get rid of passwd_sem completely. Get
>rid og get_id_from_sid's shortcut capability, and give the search
>function the ability to do a manual  one off parse of the file, without
>storing the result, to satisfy any getpwnam requests while /etc/passwd
>is being parsed. 

I won't disagree with the thought of getting rid of passwd_sem since
that is what I've been saying from the start.  I don't like the
idea of allowing a one-off parse of /etc/passwd, though.

We actually can use the action of mutexes to detect when we are being
called recursively in read_etc_passwd.  We can change passwd_state to
"initializing" prior to calling fopen, then if we can get the mutex in
read_etc_passwd and passwd_state == initializing, we are being called
recursively.

We then "short circuit" most of read_etc_passwd, getpwent will return
NULL, id will == -1 in get_id_from_sid and, theoretically, the rest of
get_id_from_sid can be executed.  Alternatively, we could also detect
the "impossible" event of 'getpwent()' returning NULL in its first
invocation in the function and use that to return 0, as it does now.

In other words:

Index: security.cc
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/security.cc,v
retrieving revision 1.38
diff -p -w -r1.38 security.cc
*** security.cc	2001/03/14 15:32:49	1.38
--- security.cc	2001/04/17 04:45:11
*************** get_world_sid ()
*** 185,191 ****
    return world_sid;
  }
  
- int passwd_sem = 0;
  int group_sem = 0;
  
  static int
--- 185,190 ----
*************** get_id_from_sid (PSID psid, BOOL search_
*** 207,216 ****
  
        if (!search_grp)
  	{
- 	  if (passwd_sem > 0)
- 	    return 0;
- 	  ++passwd_sem;
- 
  	  struct passwd *pw;
  	  while ((pw = getpwent ()) != NULL)
  	    {
--- 206,211 ----
*************** get_id_from_sid (PSID psid, BOOL search_
*** 221,227 ****
  		}
  	    }
  	  endpwent ();
- 	  --passwd_sem;
  	  if (id >= 0)
  	    {
  	      if (type)
--- 216,221 ----
*************** is_grp_member (uid_t uid, gid_t gid)
*** 330,336 ****
    extern int getgroups (int, gid_t *, gid_t, const char *);
    BOOL grp_member = TRUE;
  
!   if (!group_sem && !passwd_sem)
      {
        struct passwd *pw = getpwuid (uid);
        gid_t grps[NGROUPS_MAX];
--- 324,330 ----
    extern int getgroups (int, gid_t *, gid_t, const char *);
    BOOL grp_member = TRUE;
  
!   if (!group_sem)
      {
        struct passwd *pw = getpwuid (uid);
        gid_t grps[NGROUPS_MAX];
*************** extern "C"
*** 1745,1757 ****
  int
  facl (int fd, int cmd, int nentries, aclent_t *aclbufp)
  {
!   if (fdtab.not_open (fd))
      {
        syscall_printf ("-1 = facl (%d)", fd);
        set_errno (EBADF);
        return -1;
      }
!   const char *path = fdtab[fd]->get_name ();
    if (path == NULL)
      {
        syscall_printf ("-1 = facl (%d) (no name)", fd);
--- 1739,1751 ----
  int
  facl (int fd, int cmd, int nentries, aclent_t *aclbufp)
  {
!   if (cygheap->fdtab.not_open (fd))
      {
        syscall_printf ("-1 = facl (%d)", fd);
        set_errno (EBADF);
        return -1;
      }
!   const char *path = cygheap->fdtab[fd]->get_name ();
    if (path == NULL)
      {
        syscall_printf ("-1 = facl (%d) (no name)", fd);
Index: passwd.cc
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/passwd.cc,v
retrieving revision 1.17
diff -p -w -r1.17 passwd.cc
*** passwd.cc	2001/01/28 05:51:14	1.17
--- passwd.cc	2001/04/17 04:45:11
*************** static int max_lines = 0;
*** 35,40 ****
--- 35,41 ----
     and read in the password file if it isn't set. */
  enum pwd_state {
    uninitialized = 0,
+   initializing,
    emulated,
    loaded
  };
*************** add_pwd_line (char *line)
*** 120,130 ****
  void
  read_etc_passwd ()
  {
-     extern int passwd_sem;
      char linebuf[1024];
!     ++passwd_sem;
      FILE *f = fopen ("/etc/passwd", "rt");
-     --passwd_sem;
  
      if (f)
        {
--- 121,146 ----
  void
  read_etc_passwd ()
  {
      char linebuf[1024];
!     /* A mutex is ok for speed here - pthreads will use critical sections not mutex's
!      * for non-shared mutexs in the future. Also, this function will at most be called
!      * once from each thread, after that the passwd_state test will succeed
!      */
!     static pthread_mutex_t etc_passwd_mutex = (pthread_mutex_t) PTHREAD_MUTEX_INITIALIZER;
!     pthread_mutex_lock (&etc_passwd_mutex);
! 
!     /* if we got blocked by the mutex, then etc_passwd may have been processed */
!     if (passwd_state != uninitialized)
!       {
!         pthread_mutex_unlock(&etc_passwd_mutex);
!         return;
!       }
! 
!     if (passwd_state != initializing)
!       {
! 	passwd_state = initializing;
! 
  	FILE *f = fopen ("/etc/passwd", "rt");
  
  	if (f)
  	  {
*************** read_etc_passwd ()
*** 145,153 ****
--- 161,174 ----
  	    add_pwd_line (linebuf);
  	    passwd_state = emulated;
  	  }
+ 
+       }
+ 
+   pthread_mutex_unlock (&etc_passwd_mutex);
  }
  
  /* Cygwin internal */
+ /* If this ever becomes non-reentrant, update all the getpw*_r functions */
  static struct passwd *
  search_for (uid_t uid, const char *name)
  {
*************** search_for (uid_t uid, const char *name)
*** 182,206 ****
  extern "C" struct passwd *
  getpwuid (uid_t uid)
  {
!   if (passwd_state == uninitialized)
      read_etc_passwd ();
  
    return search_for (uid, 0);
  }
  
  extern "C" struct passwd *
  getpwnam (const char *name)
  {
!   if (passwd_state == uninitialized)
      read_etc_passwd ();
  
    return search_for (0, name);
  }
  
  extern "C" struct passwd *
  getpwent (void)
  {
!   if (passwd_state == uninitialized)
      read_etc_passwd ();
  
    if (pw_pos < curr_lines)
--- 203,300 ----
  extern "C" struct passwd *
  getpwuid (uid_t uid)
  {
!   if (passwd_state  <= initializing)
      read_etc_passwd ();
  
    return search_for (uid, 0);
  }
  
+ extern "C" int 
+ getpwuid_r (uid_t uid, struct passwd *pwd, char *buffer, size_t bufsize, struct passwd **result)
+ {
+   *result = NULL;
+ 
+   if (!pwd || !buffer)
+     return ERANGE;
+ 
+   if (passwd_state  <= initializing)
+     read_etc_passwd ();
+ 
+   struct passwd *temppw = search_for (uid, 0);
+ 
+   if (!temppw)
+     return 0;
+ 
+   /* check needed buffer size. */
+   size_t needsize = strlen (temppw->pw_name) + strlen (temppw->pw_dir) + strlen (temppw->pw_shell);
+   if (needsize > bufsize)
+     return ERANGE;
+ 
+   /* make a copy of temppw */
+   *result = pwd;
+   pwd->pw_uid = temppw->pw_uid;
+   pwd->pw_gid = temppw->pw_gid;
+   pwd->pw_name = buffer;
+   pwd->pw_dir = buffer + strlen (temppw->pw_name);
+   pwd->pw_shell = buffer + strlen (temppw->pw_name) + strlen (temppw->pw_dir);
+   strcpy (pwd->pw_name, temppw->pw_name);
+   strcpy (pwd->pw_dir, temppw->pw_dir);
+   strcpy (pwd->pw_shell, temppw->pw_shell);
+   return 0;
+ }
+ 
  extern "C" struct passwd *
  getpwnam (const char *name)
  {
!   if (passwd_state  <= initializing)
      read_etc_passwd ();
  
    return search_for (0, name);
  }
  
+ 
+ /* the max size buffer we can expect to 
+  * use is returned via sysconf with _SC_GETPW_R_SIZE_MAX.
+  * This may need updating! - Rob Collins April 2001.
+  */
+ extern "C" int
+ getpwnam_r (const char *nam, struct passwd *pwd, char *buffer, size_t bufsize, struct passwd **result)
+ {
+   *result = NULL;
+ 
+   if (!pwd || !buffer || !nam)
+     return ERANGE;
+ 
+   if (passwd_state  <= initializing)
+     read_etc_passwd ();
+ 
+   struct passwd *temppw = search_for (0, nam);
+ 
+   if (!temppw)
+     return 0;
+ 
+   /* check needed buffer size. */
+   size_t needsize = strlen (temppw->pw_name) + strlen (temppw->pw_dir) + strlen (temppw->pw_shell);
+   if (needsize > bufsize)
+     return ERANGE;
+     
+   /* make a copy of temppw */
+   *result = pwd;
+   pwd->pw_uid = temppw->pw_uid;
+   pwd->pw_gid = temppw->pw_gid;
+   pwd->pw_name = buffer;
+   pwd->pw_dir = buffer + strlen (temppw->pw_name);
+   pwd->pw_shell = buffer + strlen (temppw->pw_name) + strlen (temppw->pw_dir);
+   strcpy (pwd->pw_name, temppw->pw_name);
+   strcpy (pwd->pw_dir, temppw->pw_dir);
+   strcpy (pwd->pw_shell, temppw->pw_shell);
+   return 0;
+ }
+ 
  extern "C" struct passwd *
  getpwent (void)
  {
!   if (passwd_state  <= initializing)
      read_etc_passwd ();
  
    if (pw_pos < curr_lines)
*************** getpwent (void)
*** 212,218 ****
  extern "C" struct passwd *
  getpwduid (uid_t)
  {
!   if (passwd_state == uninitialized)
      read_etc_passwd ();
  
    return NULL;
--- 306,312 ----
  extern "C" struct passwd *
  getpwduid (uid_t)
  {
!   if (passwd_state  <= initializing)
      read_etc_passwd ();
  
    return NULL;
*************** getpwduid (uid_t)
*** 221,227 ****
  extern "C" void
  setpwent (void)
  {
!   if (passwd_state == uninitialized)
      read_etc_passwd ();
  
    pw_pos = 0;
--- 315,321 ----
  extern "C" void
  setpwent (void)
  {
!   if (passwd_state  <= initializing)
      read_etc_passwd ();
  
    pw_pos = 0;
*************** setpwent (void)
*** 230,236 ****
  extern "C" void
  endpwent (void)
  {
!   if (passwd_state == uninitialized)
      read_etc_passwd ();
  
    pw_pos = 0;
--- 324,330 ----
  extern "C" void
  endpwent (void)
  {
!   if (passwd_state  <= initializing)
      read_etc_passwd ();
  
    pw_pos = 0;
*************** endpwent (void)
*** 239,245 ****
  extern "C" int
  setpassent ()
  {
!   if (passwd_state == uninitialized)
      read_etc_passwd ();
  
    return 0;
--- 333,339 ----
  extern "C" int
  setpassent ()
  {
!   if (passwd_state  <= initializing)
      read_etc_passwd ();
  
    return 0;
*************** getpass (const char * prompt)
*** 255,271 ****
  #endif
    struct termios ti, newti;
  
!   if (passwd_state == uninitialized)
      read_etc_passwd ();
  
!   if (fdtab.not_open (0))
      {
        set_errno (EBADF);
        pass[0] = '\0';
      }
    else
      {
!       fhandler_base *fhstdin = fdtab[0];
        fhstdin->tcgetattr (&ti);
        newti = ti;
        newti.c_lflag &= ~ECHO;
--- 349,365 ----
  #endif
    struct termios ti, newti;
  
!   if (passwd_state  <= initializing)
      read_etc_passwd ();
  
!   if (cygheap->fdtab.not_open (0))
      {
        set_errno (EBADF);
        pass[0] = '\0';
      }
    else
      {
!       fhandler_base *fhstdin = cygheap->fdtab[0];
        fhstdin->tcgetattr (&ti);
        newti = ti;
        newti.c_lflag &= ~ECHO;

cgf

From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@cygwin.com
Cc: Danny Smith <danny_r_smith_2001@yahoo.co.nz>
Subject: Re: [PATCH] Fwd: Re: #define Win32_Winsock fails in 1.1.8]
Date: Mon, 12 Mar 2001 04:02:00 -0000
Message-id: <3AACBAD1.3EB93656@yahoo.com>
References: <3AA7A230.5D98FBF9@yahoo.com> <20010310095215.27469.qmail@web6403.mail.yahoo.com> <20010310152720.A1607@redhat.com>
X-SW-Source: 2001-q1/msg00167.html

Christopher Faylor wrote:
> 
> Danny,
> Could you submit the newlib patch to the newlib mailing list, please?
> 
> I'll leave it to Earnie to approve the w32api stuff.
> 

Which I'll do when I see the newlib patch applied.  It should happen the
same day.

Earnie

P.S.: The newlib mail address is newlib@sources.redhat.com

> cgf
> 
> On Sat, Mar 10, 2001 at 10:52:15PM +1300, Danny Smith wrote:
> >--- Earnie Boyd <earnie_boyd@yahoo.com> wrote: > Danny,
> >>
> >> Can you take a look at Matt's problem please?
> >>
> >> Earnie.
> >>
> >> -------- Original Message --------
> >> From: Matt.Brozowski@tavve.com
> >> Subject: Re: #define Win32_Winsock fails in 1.1.8
> >> To: cygwin@cygwin.com
> >>
> >> In fact I've run the
> >> file
> >> through gcc -E and found that the appropriate headers ARE being
> >> included
> >> the problem is that sys/types.h is ALSO being included and should NOT
> >> be
> >> until AFTER winsock.h is included.  It is unfortunately included
> >> before.
> >> The header files are VERY complicated and I don't know the
> >> conventions
> >> that
> >> are used to ensure they work consistently.  I am more than happy to
> >> develop
> >> a patch.  Is there anywhere that defines the header file conding
> >> conventions that I can read so I can be sure not to screw something
> >> else
> >> up.
> >>
> >> Matt Brozowski
> >>
> >
> >
> >There are several collisions between newlib and winsock names
> >These are the ones I know about.
> >
> >1) The #ifndef _WINSOCK_H guard for BSD int typedefs in the newlib
> >sys/types needs to be made more specific to prevent header inclusion
> >order problems.
> >Consider what happens here:
> >#include winsock.h
> >#include windows.h
> >
> >winsock.h is included and defines _WINSOCK_H
> >winsock.h then includes >
> >       windows.h >
> >               windef.h >
> >                       winnt.h >
> >                                string.h >
> >                                       sys/reent.h >
> >                                               time.h >
> >                                                       sys/types.h
> >which sees the _WINSOCK_H define and skips the BSD int
> >typedefs (u_char, u_short,etc) But ... sys/types defines _SYS_TYPES_H
> >which makes winsock.h also skip the BSD typedefs later on. The types
> >are
> >not defined anywhere.
> >
> >2. fd_set. The same chain of included headers from windows.h can also
> >cause the wrong fd_set definitions for winsock interface, but only in
> >the case where windows.h is included *before* winsock.h.
> >sys/types is included before winsock.h (ie before _WINSOCK_H is
> >defined),
> >so the sys/types definitions take precedence. One way to prevent the
> >sys/types
> >definitions of fd_set is to use Win32_Winsock (or similar macro that
> >signifies intent to use winsock interface), rather than _WINSOCK_H as a
> >guard.
> >
> >3. gethostname. Both winsock[2].h and the newlib sys/unistd.h declare
> >gethostname. The w32api version is __stdcall, the unistd.h one is not
> >and also differs in the second parameter (unsigned int rather than
> >int).
> >IMO, if we want w32api for sockets, the  function in
> >winsock.h/libwsock32.a should be used.
> >
> >While I'm at I'd change the macro name Win32_Winsock to something a bit
> >more
> >consistent with standard: eg  __USE_W32_SOCKETS_ but that is just my
> >preference.
> >
> >Mutually dependent patches to newlib and w32api headers, against winsup
> >cvs, follow.
> >
> >ChangeLog for newlib
> >
> >2001-03-10  Danny Smith <dannysmith@users.sourceforge.net>
> >       * libc/include/sys/types.h (BSD int typedefs): Guard with
> >       _BSDTYPES_DEFINED rather than _WINSOCK_H
> >       (fd_set): Add !defined __USE_W32_SOCKETS to guard;
> >       define _SYS_TYPES_FD_SET.
> >       * libc/include/sys/unistd.h (gethostname): don't declare if
> >       defined (_WINSOCK_H) || defined (__USE_W32_SOCKETS)
> >
> >
> >ChangeLog for w32api
> >
> >2001-03-10  Danny Smith <dannysmith@users.sourceforge.net>
> >       * include/winsock.h (_SYS_TYPES_H macro guard for int types): Remove;
> >       use only _BSDTYPES_DEFINED macro now defined in newlib sys/types.h.
> >       (SYS_TYPES_H macro guard for fd_set): Replace with_SYS_TYPES_FD_SET
> >       macro now defined in newlib sys/types.h. Emit warning if defined.
> >       * include/winsock2.h:As per winsock.h.
> >       * include/windows.h (Win32_Winsock): Replace with new macros
> >       __USE_W32_SOCKETS and warn of deprecation.
> >
> >
> >--- ./src/newlib/libc/include/sys/unistd.h     Tue Mar 06 13:04:42 2001
> >+++ d:/cygwin/usr/include/sys/unistd.h Sat Mar 10 18:06:40 2001
> >@@ -115,7 +115,10 @@ int       _EXFUN(setdtablesize, (int));
> > unsigned _EXFUN(usleep, (unsigned int __useconds));
> > int     _EXFUN(ftruncate, (int __fd, off_t __length));
> > int     _EXFUN(truncate, (const char *, off_t __length));
> >-int   _EXFUN(gethostname, (char *__name, size_t __len));
> >+#if !(defined  (_WINSOCK_H) || defined (__USE_W32_SOCKETS))
> >+/* winsock[2].h defines as __stdcall, and with int as 2nd arg */
> >+ int  _EXFUN(gethostname, (char *__name, size_t __len));
> >+#endif
> > char *        _EXFUN(mktemp, (char *));
> > int     _EXFUN(sync, (void));
> > int     _EXFUN(readlink, (const char *__path, char *__buf, int
> >__buflen));
> >--- ./src/newlib/libc/include/sys/types.h      Tue Dec 12 13:24:08 2000
> >+++ d:/cygwin/usr/include/sys/types.h  Sat Mar 10 20:47:45 2001
> >@@ -49,11 +49,13 @@
> > #  define     physadr         physadr_t
> > #  define     quad            quad_t
> >
> >-#ifndef _WINSOCK_H
> >+#ifndef _BSDTYPES_DEFINED
> >+/* also defined in mingw/gmon.h and in w32api/winsock[2].h */
> > typedef       unsigned char   u_char;
> > typedef       unsigned short  u_short;
> > typedef       unsigned int    u_int;
> > typedef       unsigned long   u_long;
> >+#define _BSDTYPES_DEFINED
> > #endif
> >
> > typedef       unsigned short  ushort;         /* System V compatibility */
> >@@ -152,12 +154,14 @@ typedef unsigned int mode_t _ST_INT32;
> > typedef unsigned short nlink_t;
> >
> > /* We don't define fd_set and friends if we are compiling POSIX
> >-   source, or if we have included the Windows Sockets.h header (which
> >-   defines Windows versions of them).  Note that a program which
> >-   includes the Windows sockets.h header must know what it is doing;
> >-   it must not call the cygwin32 select function.  */
> >-# if ! defined (_POSIX_SOURCE) && ! defined (_WINSOCK_H)
> >-
> >+   source, or if we have included (or may include as indicated
> >+   by __USE_W32_SOCKETS) the W32api winsock[2].h header which
> >+   defines Windows versions of them.   Note that a program which
> >+   includes the W32api winsock[2].h header must know what it is doing;
> >+   it must not call the cygwin32 select function.
> >+*/
> >+# if !(defined (_POSIX_SOURCE) || defined (_WINSOCK_H) || defined
> >(__USE_W32_SOCKETS))
> >+#  define _SYS_TYPES_FD_SET
> > #  define     NBBY    8               /* number of bits in a byte */
> > /*
> >  * Select uses bit masks of file descriptors in longs.
> >@@ -193,7 +197,7 @@ typedef    struct _types_fd_set {
> >        *__tmp++ = 0; \
> > }))
> >
> >-# endif       /* ! defined (_POSIX_SOURCE) && ! defined (_WINSOCK_H) */
> >+# endif       /* !(defined (_POSIX_SOURCE) || defined (_WINSOCK_H) ||
> >defined (__USE_W32_SOCKETS))
> >
> > #undef __MS_types__
> > #undef _ST_INT32
> >--- ./src/winsup/w32api/include/winsock.h      Thu Feb 22 08:40:47 2001
> >+++ d:/cygwin/usr/include/w32api/winsock.h     Sat Mar 10 21:31:16 2001
> >@@ -17,14 +17,14 @@
> > extern "C" {
> > #endif
> >
> >-#if !defined ( _BSDTYPES_DEFINED ) && !defined ( _SYS_TYPES_H  )
> >+#if !defined ( _BSDTYPES_DEFINED )
> > /* also defined in gmon.h and in cygwin's sys/types */
> > typedef unsigned char u_char;
> > typedef unsigned short        u_short;
> > typedef unsigned int  u_int;
> > typedef unsigned long u_long;
> > #define _BSDTYPES_DEFINED
> >-#endif /* ndef _BSDTYPES_  _SYS_TYPES_H */
> >+#endif /* !defined  _BSDTYPES_DEFINED */
> > typedef u_int SOCKET;
> > #ifndef FD_SETSIZE
> > #define FD_SETSIZE    64
> >@@ -35,8 +35,10 @@ typedef u_int       SOCKET;
> > #define SD_SEND         0x01
> > #define SD_BOTH         0x02
> >
> >-#ifndef _SYS_TYPES_H
> >-/* fd_set may have been defined by the newlib <sys/types.h>.  */
> >+#ifndef _SYS_TYPES_FD_SET
> >+/* fd_set may have be defined by the newlib <sys/types.h>
> >+ * if  __USE_W32_SOCKETS not defined.
> >+ */
> > #ifdef fd_set
> > #undef fd_set
> > #endif
> >@@ -71,7 +73,11 @@ for (__i = 0; __i < ((fd_set *)(set))->f
> > #ifndef FD_ISSET
> > #define FD_ISSET(fd, set) __WSAFDIsSet((SOCKET)(fd), (fd_set *)(set))
> > #endif
> >-#endif /* ndef _SYS_TYPES_H */
> >+#else /* def _SYS_TYPES_FD_SET */
> >+#warning "fd_set and associated macros have been defined in sys/types.
> >\
> >+    This can cause runtime problems with W32 sockets"
> >+#endif /* ndef _SYS_TYPES_FD_SET */
> >+
> > #ifndef __INSIDE_CYGWIN__
> > struct timeval {
> >       long    tv_sec;
> >--- ./src/winsup/w32api/include/winsock2.h     Thu Feb 22 08:40:47 2001
> >+++ d:/cygwin/usr/include/w32api/winsock2.h    Sat Mar 10 21:31:36 2001
> >@@ -25,14 +25,14 @@
> > extern "C" {
> > #endif
> > /*   Names common to Winsock1.1 and Winsock2  */
> >-#if !defined ( _BSDTYPES_DEFINED ) && !defined ( _SYS_TYPES_H  )
> >+#if !defined ( _BSDTYPES_DEFINED )
> > /* also defined in gmon.h and in cygwin's sys/types */
> > typedef unsigned char u_char;
> > typedef unsigned short        u_short;
> > typedef unsigned int  u_int;
> > typedef unsigned long u_long;
> > #define _BSDTYPES_DEFINED
> >-#endif /* ndef _BSDTYPES_  _SYS_TYPES_H */
> >+#endif /* ! def _BSDTYPES_DEFINED  */
> > typedef u_int SOCKET;
> > #ifndef FD_SETSIZE
> > #define FD_SETSIZE    64
> >@@ -43,8 +43,10 @@ typedef u_int       SOCKET;
> > #define SD_SEND         0x01
> > #define SD_BOTH         0x02
> >
> >-#ifndef _SYS_TYPES_H
> >-/* fd_set may have been defined by the newlib <sys/types.h>.  */
> >+#ifndef _SYS_TYPES_FD_SET
> >+/* fd_set may be defined by the newlib <sys/types.h>
> >+ * if __USE_W32_SOCKETS not defined.
> >+ */
> > #ifdef fd_set
> > #undef fd_set
> > #endif
> >@@ -68,7 +70,7 @@ for (__i = 0; __i < ((fd_set *)(set))->f
> > } while (0)
> > #endif
> > #ifndef FD_SET
> >-/* this differs from the define in winsock.h */
> >+/* this differs from the define in winsock.h and in cygwin sys/types.h
> >*/
> > #define FD_SET(fd, set) do { u_int __i;\
> > for (__i = 0; __i < ((fd_set *)(set))->fd_count ; __i++) {\
> >       if (((fd_set *)(set))->fd_array[__i] == (fd)) {\
> >@@ -89,7 +91,10 @@ if (__i == ((fd_set *)(set))->fd_count)
> > #ifndef FD_ISSET
> > #define FD_ISSET(fd, set) __WSAFDIsSet((SOCKET)(fd), (fd_set *)(set))
> > #endif
> >-#endif /* ndef _SYS_TYPES_H */
> >+#else /* def _SYS_TYPES_FD_SET */
> >+#warning "fd_set and associated macros have been defined in sys/types.
> >\
> >+    This may cause runtime problems with W32 sockets"
> >+#endif /* ndef _SYS_TYPES_FD_SET */
> > #ifndef __INSIDE_CYGWIN__
> > struct timeval {
> >       long    tv_sec;
> >--- ./src/winsup/w32api/include/windows.h      Fri Jul 28 06:30:51 2000
> >+++ d:/cygwin/usr/include/w32api/windows.h     Sat Mar 10 20:57:19 2001
> >@@ -133,7 +133,14 @@
> > #include <shellapi.h>
> > #include <winperf.h>
> > #include <winspool.h>
> >-#if defined(Win32_Winsock) || !(defined(__INSIDE_CYGWIN__) ||
> >defined(__CYGWIN__) || defined(__CYGWIN32__) || defined(_UWIN))
> >+#if defined(Win32_Winsock)
> >+#warning "The  Win32_Winsock macro name is deprecated.\
> >+    Please use __USE_W32_SOCKETS instead"
> >+#ifndef __USE_W32_SOCKETS
> >+#define __USE_W32_SOCKETS
> >+#endif
> >+#endif
> >+#if defined(__USE_W32_SOCKETS) || !(defined(__INSIDE_CYGWIN__) ||
> >defined(__CYGWIN__) || defined(__CYGWIN32__) || defined(_UWIN))
> > #include <winsock.h>
> > #endif
> > #endif /* WIN32_LEAN_AND_MEAN */

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com


From: Egor Duda <deo@logos-m.ru>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: error_start patch
Date: Mon, 22 May 2000 10:27:00 -0000
Message-id: <2891.000522@logos-m.ru>
X-SW-Source: 2000-q2/msg00074.html

Hi!

  Below  is  a  patch  to prevent cygwin's JIT debugger (specified via
'error_start')   from   being   spawned   recursively,  in  case  when
debugger throws exception itself. It also allows to notify the debugee
that  we've    done    with   debugging   and  it  can  exit in peace.
debugger can post event named

"cygwin_error_start_event_<debugee_win32_pid>"

instead of

(gdb) set keep_looping=0
(gdb) c

----------------------------------------------------------------------------
2000-05-22  Egor Duda <deo@logos-m.ru>

        * exceptions.cc (try_to_debug): prevent recursive spawning of JIT
        debugger.
        * exceptions.cc (try_to_debug): treat  special event from debugger
        as command to continue.

Index: cygwin/exceptions.cc
===================================================================
RCS file: /home/duda_admin/cvs-mirror/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.17
diff -c -2 -r1.17 exceptions.cc
*** cygwin/exceptions.cc        2000/05/20 05:52:33     1.17
--- cygwin/exceptions.cc        2000/05/22 16:55:40
***************
*** 301,304 ****
--- 301,306 ----
  static int NO_COPY keep_looping = 0;
  
+ #define TIME_TO_WAIT_FOR_DEBUGGER 10000
+ 
  extern "C" int
  try_to_debug ()
***************
*** 330,333 ****
--- 332,350 ----
    ReleaseMutex (title_mutex);
  
+   /* prevent recursive exception handling */
+   char* rawenv = GetEnvironmentStrings () ;
+   for ( char* p = rawenv; *p != '\0'; p = strchr (p, '\0') + 1 )
+     { 
+       if (strncmp ( p, "CYGWIN=", sizeof("CYGWIN=") - 1) == 0)
+         {
+           system_printf ( "%s", p);
+           char* q = strstr ( p, "error_start" ) ;
+           /* replace 'error_start=...' with '_rror_start=...' */
+           if ( q ) *q = '_' ;
+           SetEnvironmentVariable ( "CYGWIN", p+sizeof("CYGWIN=") ) ;
+           break ;
+         }
+     }
+ 
    dbg = CreateProcess (NULL,
                       debugger_command,
***************
*** 349,355 ****
    else
      {
        keep_looping = 1;
!       while (keep_looping)
!       Sleep (10000);
      }
  
--- 366,385 ----
    else
      {
+       char event_name [ sizeof ( "cygwin_error_start_event" ) + 9 ];
+       DWORD win32_pid = GetCurrentProcessId ();
+       __small_sprintf ( event_name, "cygwin_error_start_event%x", win32_pid );
+       HANDLE sync_with_dbg = CreateEvent ( NULL, TRUE, FALSE, event_name );
        keep_looping = 1;
!       while (keep_looping) 
!         {
!           if (sync_with_dbg == NULL)
!             Sleep (TIME_TO_WAIT_FOR_DEBUGGER);
!           else
!             {
!               if (WaitForSingleObject (sync_with_dbg,
!                                        TIME_TO_WAIT_FOR_DEBUGGER) == WAIT_OBJECT_0)
!                 break;
!             }
!          }
      }

----------------------------------------------------------------------------

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19


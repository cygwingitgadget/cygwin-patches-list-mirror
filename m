From: Bill Hegardt <bill@troyxcd.com>
To: cygwin-patches@sources.redhat.com
Subject: multi-threaded serial I/O patch
Date: Mon, 29 Jan 2001 17:23:00 -0000
Message-id: <3A7618B4.ED2741F5@troyxcd.com>
X-SW-Source: 2001-q1/msg00043.html

Attached is a patch and ChangeLog entry for the multi-threaded serial
I/O problem I fixed.

Mon Jan 29 17:15:22 2001  Bill Hegardt <bill@troyxcd.com>

        * fhandler_serial.cc (raw_write): Use local copy of OVERLAPPED
structure instead of io_status which was shared
		with the raw_read routine resulting in a race condition.
--- fhandler_serial.original	Fri Jan 19 16:22:00 2001
+++ fhandler_serial.cc	Mon Jan 29 16:47:32 2001
@@ -161,15 +161,19 @@ int
 fhandler_serial::raw_write (const void *ptr, size_t len)
 {
   DWORD bytes_written;
+  OVERLAPPED osWrite;
+
+  memset (&osWrite, 0, sizeof (osWrite));
+  osWrite.hEvent = CreateEvent (&sec_none_nih, TRUE, FALSE, NULL);
+  ProtectHandle (osWrite.hEvent);
 
   if (overlapped_armed)
     PurgeComm (get_handle (), PURGE_TXABORT | PURGE_RXABORT);
-  ResetEvent (io_status.hEvent);
 
   for (;;)
     {
       overlapped_armed = TRUE;
-      if (WriteFile (get_handle(), ptr, len, &bytes_written, &io_status))
+      if (WriteFile (get_handle(), ptr, len, &bytes_written, &osWrite))
 	break;
 
       switch (GetLastError ())
@@ -182,16 +186,19 @@ fhandler_serial::raw_write (const void *
 	    goto err;
 	}
 
-      if (!GetOverlappedResult (get_handle (), &io_status, &bytes_written, TRUE))
+      if (!GetOverlappedResult (get_handle (), &osWrite, &bytes_written, TRUE))
 	goto err;
 
       break;
     }
 
+  CloseHandle(osWrite.hEvent);
+ 
   overlapped_armed = FALSE;
   return bytes_written;
 
 err:
+  CloseHandle(osWrite.hEvent);
   __seterrno ();
   return -1;
 }

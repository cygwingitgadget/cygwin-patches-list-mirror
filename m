From: "Neil Erskine" <neil.erskine@jjmackay.ca>
To: <cygwin-patches@cygwin.com>
Subject: Cygwin Changes to Rename (Novell and CVS)
Date: Thu, 06 Sep 2001 20:25:00 -0000
Message-id: <CAEIIBEHOJELFDAHENHIOEHFCIAA.neil.erskine@jjmackay.ca>
X-SW-Source: 2001-q3/msg00108.html

The combination of Novell 5.1 with its current clients does not allow
"rename" as included in the 1.3.2 cygwin distribution to work correctly.
Unfortunately, different client/OS combinations seem to return different
error codes, and invoke different paths through rename, so the work arounds
for this are less than elegant.  None-the-less, the attached patch to rename
is the best I have come up with.  It works on NT 4.0, Windows 2000, Windows
95 and Windows 98.  I have not tried Windows Me.

I came up with this while getting cvs to work with Novell.  The patch in
this message is necessary but insufficient for cvs, which also requires
changes to "unlink".  I will submit a separate patch for "unlink" once we
get some closure on the rename issue. I can get CVS to work on NT 4.0,
Windows 2000, Windows 95 and Windows 98, with and without Novell.  I have
not tried Windows Me.  We have been using these changes here for over a
month with no obvious side-effects, but then we don't make extensive use of
Cygwin.

Should anyone be trying to get CVS to work with Novell and be willing to
patch their own code, I'll supply it upon request.

I added quite a few syscall_printf lines to rename so that I could see what
was happening.   I have no particular attraction to any of them, but I have
not seen reason to remove them.

===================================================================
RCS file: syscalls.cc,v
retrieving revision 1.1
diff -u -r1.1 syscalls.cc
--- syscalls.cc	2001/05/23 20:09:21	1.1
+++ syscalls.cc	2001/07/20 18:53:31
@@ -124,7 +124,7 @@
 	{
 	  CloseHandle (h);
 	  syscall_printf ("CreateFile/CloseHandle succeeded");
-	  if (os_being_run == winNT || GetFileAttributes (win32_name) ==
(DWORD) -1)
+	  if (GetFileAttributes (win32_name) == (DWORD) -1)
 	    {
 	      res = 0;
 	      break;
@@ -1234,6 +1234,7 @@
   sigframe thisframe (mainthread);
   int res = 0;

+  syscall_printf ("rename (%s, %s)", oldpath, newpath);
   path_conv real_old (oldpath, PC_SYM_NOFOLLOW);

   if (real_old.error)
@@ -1289,43 +1290,112 @@
       SetFileAttributesA (real_new.get_win32 (), real_new.file_attributes
() & ~ FILE_ATTRIBUTE_READONLY);
     }

-  if (!MoveFile (real_old.get_win32 (), real_new.get_win32 ()))
-    res = -1;
-
-  if (res == 0 || (GetLastError () != ERROR_ALREADY_EXISTS
-		   && GetLastError () != ERROR_FILE_EXISTS))
-    goto done;
-
-  if (os_being_run == winNT)
+  if (MoveFile (real_old.get_win32 (), real_new.get_win32 ()))
     {
-      if (MoveFileEx (real_old.get_win32 (), real_new.get_win32 (),
-		      MOVEFILE_REPLACE_EXISTING))
-	res = 0;
+      syscall_printf ( "MoveFile worked" );
     }
   else
     {
-      syscall_printf ("try win95 hack");
-      for (;;)
+      int HackWorked = (1 == 0);
+      DWORD LastError = GetLastError();
+
+      syscall_printf ( "MoveFile failed %x", LastError );
+
+      /* Normal approach didn't work. Try some hacks that might. */
+      switch ( LastError )
 	{
-	  if (!DeleteFileA (real_new.get_win32 ()) &&
-	      GetLastError () != ERROR_FILE_NOT_FOUND)
+	case ERROR_ALREADY_EXISTS:
+	case ERROR_FILE_EXISTS:
+	  if (os_being_run == winNT)
 	    {
-	      syscall_printf ("deleting %s to be paranoid",
-			      real_new.get_win32 ());
-	      break;
+	      /* MoveFileEx sometimes works when MoveFile doesn't. Try
+	       * that for WinNT systems only, as the call doesn't exist on
+	       * non-WinNT systems. */
+	      if (MoveFileEx (real_old.get_win32 (), real_new.get_win32 (),
+			      MOVEFILE_REPLACE_EXISTING))
+		{
+		  syscall_printf ( "MoveFileEx worked" );
+		  HackWorked = (1 == 1);
+		}
+	      else
+		{
+		  syscall_printf ( "MoveFileEx failed %x", GetLastError() );
+		}
 	    }
-	  else
+	  if ( ! HackWorked )
 	    {
+	      /* Try an approach that sometimes works for Win95/98
+               * systems using Novell. This is very similar to the
+               * "Win95 hack" below, without the loop, and
+               * without the assumption that you can delete a
+               * read-only file with DeleteFile. */
+	      chmod ( real_new.get_win32 (), 0777 );
+	      chmod ( real_old.get_win32 (), 0777 );
 	      if (MoveFile (real_old.get_win32 (), real_new.get_win32 ()))
+	        {
+		  syscall_printf ( "Novell hack A worked" );
+		  HackWorked = (1 == 1);
+		}
+	      else
+		{
+		  syscall_printf ( "Novell hack A (%s,%s) didn't work",
+			   real_old.get_win32 (),
+			   real_new.get_win32 ()  );
+		}
+	    }
+	  break;
+
+	case ERROR_ACCESS_DENIED:
+	  chmod ( real_old.get_win32 (), 0777 );
+	  if (MoveFile (real_old.get_win32 (), real_new.get_win32 ()))
+	    {
+	      syscall_printf ("Novell hack B succeeded");
+	      HackWorked = (1 == 1);
+	    }
+	  else
+	    {
+	      syscall_printf ("Novell hack B failed");
+	    }
+	  break;
+
+	default:
+	  syscall_printf ( "No specific solution for problem" );
+	  break;
+	}
+
+      /* The following loop might help, but so far we have no
+       * documentation on why.  It would be nice to know why it
+       * doesn't loop forever in the Win95 case; it does loop forever
+       * in the Win98/Novell case of a read-only file being
+       * renamed. */
+      if (os_being_run != winNT && ! HackWorked )
+	{
+	  syscall_printf ("win95 hack");
+	  for (;;)
+	    {
+	      if (!DeleteFileA (real_new.get_win32 ()) &&
+		  GetLastError () != ERROR_FILE_NOT_FOUND)
 		{
-		  res = 0;
+		  syscall_printf ("deleting %s to be paranoid",
+				  real_new.get_win32 ());
 		  break;
 		}
+	      else
+		{
+		  if (MoveFile (real_old.get_win32 (), real_new.get_win32 ()))
+		    {
+		      HackWorked = (1 == 1);
+		      break;
+		    }
+		}
 	    }
 	}
+      if ( ! HackWorked )
+	{
+	  res = -1;
+	}
     }
-
-done:
+
   if (res)
     __seterrno ();

@@ -1333,6 +1403,14 @@
     {
       /* make the new file have the permissions of the old one */
       SetFileAttributesA (real_new.get_win32 (), real_old.file_attributes
());
+    }
+  else
+    {
+      /* some of the rename algorithms tried above try to change
+         permissions; reset those of the old and new files back to the
+         way they were. */
+      SetFileAttributesA (real_new.get_win32 (), real_new.file_attributes
());
+      SetFileAttributesA (real_old.get_win32 (), real_old.file_attributes
());
     }

   syscall_printf ("%d = rename (%s, %s)", res, real_old.get_win32 (),

Neil Erskine
Manager, Research and Product Development
JJ Mackay Canada Limited
1046 Barrington Street, 1st floor
Halifax, N.S. B3H 2R1

voice 902 423 7727 ext. 230
fax 902 422 8108

From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sourceware.cygnus.com
Subject: preliminary patch2 for i18n: change the code page to ANSI.
Date: Mon, 03 Jul 2000 15:04:00 -0000
Message-id: <s1saefyooqa.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00001.html

Hi, folks.

Before I implemented i18n features in Cygwin, I studied the
difference between OEM and ANSI code pages existing in many
locales.

As a result, I realized Cygwin should use the ANSI code page.
Because ANSI code pages are much similar to ISO 8859 character
sets usually used in UNIX, and people in these locales probably
encode their text files in the ANSI code page.

In the following patch, I eliminate SetFileApisToOem and
CharToOem so filenames and command line arguments are treated in
the ANSI code page. Then I let fhandler_console translate
characters between ANSI and OEM code pages.
(By the way, I modified the method of distinguishing extended
keys into more usual one in fhandler_console.)

I hope, as a result of my patch, people suffering from
difference between these code pages can properly handle text
files and filenames including characters other than ASCII on
both consoles (cmd.exe or command.exe) and remote terminals.

ChangeLog:
2000-07-04  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* dcrt0.cc (dll_crt0_1): Eliminate SetFileApisToOEM and CharToOem.
	* (dummy_autoload): Add functions used in fhandler_console.
	* fhandler_console.cc (fhandler_console::read): Use ENCHANCED_KEY
	flag to distinguish extended keys. Translate an input character from
	the OEM code page to the ANSI code page.
	* (fhandler_console::write_normal): Translate output characters from
	the ANSI code page to the OEM code page.
	* syscalls.cc (_link): Use MultiByteToWideChar instead of OemToCharW.

Index: dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.26
diff -u -p -r1.26 dcrt0.cc
--- dcrt0.cc	2000/07/03 01:55:17	1.26
+++ dcrt0.cc	2000/07/03 14:19:31
@@ -613,15 +613,6 @@ dll_crt0_1 ()
   /* Set the os_being_run global. */
   set_os_type ();
 
-  /* If we didn't call SetFileApisToOEM, console I/O calls would use a
-     different codepage than other Win32 API calls.  In some languages
-     (not English), this would result in "cat > filename" creating a file
-     by a different name than if CreateFile was used to create filename.
-     SetFileApisToOEM prevents this problem by making all calls use the
-     OEM codepage. */
-
-  SetFileApisToOEM ();
-
   /* Initialize the host dependent constants object. */
   host_dependent.init ();
 
@@ -698,7 +689,6 @@ dll_crt0_1 ()
 #endif
 
   char *line = GetCommandLineA ();
-  CharToOem (line, line);
 
   line = strcpy ((char *) alloca (strlen (line) + 1), line);
 
@@ -1156,7 +1146,7 @@ static void
 dummy_autoload (void)
 {
 LoadDLLinit (user32)
-LoadDLLfunc (CharToOemA, 8, user32)
+LoadDLLfunc (CharToOemBuffA, 12, user32)
 LoadDLLfunc (CreateWindowExA, 48, user32)
 LoadDLLfunc (DefWindowProcA, 16, user32)
 LoadDLLfunc (DispatchMessageA, 4, user32)
@@ -1168,8 +1158,7 @@ LoadDLLfunc (GetUserObjectInformationA, 
 LoadDLLfunc (KillTimer, 8, user32)
 LoadDLLfunc (MessageBoxA, 16, user32)
 LoadDLLfunc (MsgWaitForMultipleObjects, 20, user32)
-LoadDLLfunc (OemToCharA, 8, user32)
-LoadDLLfunc (OemToCharW, 8, user32)
+LoadDLLfunc (OemToCharBuffA, 12, user32)
 LoadDLLfunc (PeekMessageA, 20, user32)
 LoadDLLfunc (PostMessageA, 16, user32)
 LoadDLLfunc (PostQuitMessage, 4, user32)
Index: fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.8
diff -u -p -r1.8 fhandler_console.cc
--- fhandler_console.cc	2000/04/24 21:41:11	1.8
+++ fhandler_console.cc	2000/07/03 14:19:32
@@ -179,7 +179,9 @@ fhandler_console::read (void *pv, size_t
 	  !input_rec.Event.KeyEvent.bKeyDown)
 	continue;
 
-      if (ich == 0 || (ich & 0xff) == 0xe0)  /* arrow/function keys */
+      if (ich == 0 ||
+	  /* arrow/function keys */
+	  (input_rec.Event.KeyEvent.dwControlKeyState & ENHANCED_KEY))
 	{
 	  toadd = get_nonascii_key (input_rec);
 	  if (!toadd)
@@ -187,7 +189,10 @@ fhandler_console::read (void *pv, size_t
 	  nread = strlen (toadd);
 	}
       else if (!(input_rec.Event.KeyEvent.dwControlKeyState & LEFT_ALT_PRESSED))
-	toadd = &ich;
+	{
+	  OemToCharBuff (&ich, &ich, 1);
+	  toadd = &ich;
+	}
       else
 	{
 	  static char tmp[2];
@@ -1024,13 +1029,20 @@ fhandler_console::write_normal (const un
   /* Print all the base ones out */
   if (found != src)
     {
-      if (! WriteFile (get_output_handle (), src,  found - src, &done, 0))
+      char buf[256];
+      int len = found - src;
+      do {
+	int l2 = min (256, len);
+	CharToOemBuff ((LPCSTR)src, buf, l2);
+	if (! WriteFile (get_output_handle (), buf, l2, &done, 0))
 	{
 	  debug_printf ("write failed, handle %p", get_output_handle ());
 	  __seterrno ();
 	  return 0;
 	}
-      src += done;
+	len -= done;
+	src += done;
+      } while (len > 0);
     }
   if (src < end)
     {
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.31
diff -u -p -r1.31 syscalls.cc
--- syscalls.cc	2000/07/02 10:17:44	1.31
+++ syscalls.cc	2000/07/03 14:19:32
@@ -547,8 +547,7 @@ _link (const char *a, const char *b)
 
       lpContext = NULL;
       cygwin_conv_to_full_win32_path (real_b.get_win32 (), buf);
-      OemToCharW (buf, wbuf);
-      cbPathLen = (strlen (buf) + 1) * sizeof (WCHAR);
+      cbPathLen = MultiByteToWideChar (CP_ACP, 0, buf, -1, wbuf, MAX_PATH) * sizeof (WCHAR);
 
       StreamId.dwStreamId = BACKUP_LINK;
       StreamId.dwStreamAttributes = 0;

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology

Return-Path: <cygwin-patches-return-4929-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30253 invoked by alias); 3 Sep 2004 01:42:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30212 invoked from network); 3 Sep 2004 01:42:56 -0000
Date: Fri, 03 Sep 2004 01:42:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] implementation of select for write on pipes
Message-ID: <20040903014352.GA588@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040902222555.07657E627@wildcard.curl.com> <20040902225449.GD29071@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902225449.GD29071@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00081.txt.bz2

On Thu, Sep 02, 2004 at 06:54:49PM -0400, Christopher Faylor wrote:
>On Thu, Sep 02, 2004 at 06:25:55PM -0400, Bob Byrnes wrote:
>>The following patch implements select for write on pipes.
>
>On a quick look, this looks very nice.  I will give it a further review
>on Saturday but it looks like you got the formatting and ChangeLog
>right, which is almost unheard-of for a first time submission.  So,
>this may just slide right in.
>
>Thanks!

Actually, I had time tonight and, while it didn't just slide in, it
was very close.

Here are my changes to your original patch.

There were a few style issues which I've rectified:

In 'debug_printf"s the style is to use "foo %s" rather than "foo = %s"
so I've done that where I noticed it.

Also, the use of "%E" is supposed to be ", %E" rather than ": %E" although
I do see a number of uses of ": %E" in cygwin, now that I notice it.

There were also a few spacing issues and gratuitous use of braces
which I rectified.

Some non-style issues:

While I know that using snprintf is generally a good thing and it
probably should be adopted within cygwin, I don't see any reason to use
snprintf on a string which you are certain will contain more than
adequate amount of space so I changed the use of snprintf to
__small_sprintf in pipe.cc.

I eliminated the reading of the CYGWIN_PIPEBUFSIZE environment variable
within pipe().  We don't invent random CYGWIN_* environment variables
anymore.  This kind of stuff is controlled by the CYGWIN environment
variable and I don't really see any reason to be able to control this
value at all.

Other than these minor quibbles, this is an excellent patch and adds
very-much-needed functionality, so I'm checking it in.  A diff between
my changes and yours is below.

Thanks again.

cgf

diff -up ./ntdll.h hold1/ntdll.h
--- ./ntdll.h	2004-09-02 21:17:02.268975652 -0400
+++ hold1/ntdll.h	2004-09-02 20:52:28.026171717 -0400
@@ -358,7 +358,8 @@ typedef struct _FILE_NAME_INFORMATION
   WCHAR FileName[MAX_PATH + 100];
 } FILE_NAME_INFORMATION;
 
-typedef struct _FILE_PIPE_LOCAL_INFORMATION {
+typedef struct _FILE_PIPE_LOCAL_INFORMATION
+{
   ULONG NamedPipeType;
   ULONG NamedPipeConfiguration;
   ULONG MaximumInstances;
diff -up ./pipe.cc hold1/pipe.cc
--- ./pipe.cc	2004-09-02 21:17:02.269975646 -0400
+++ hold1/pipe.cc	2004-09-02 21:13:10.061203678 -0400
@@ -13,7 +13,6 @@ details. */
 #include "winsup.h"
 #include <unistd.h>
 #include <stdlib.h>
-#include <stdio.h>
 #include <sys/socket.h>
 #include <limits.h>
 #include "cygerrno.h"
@@ -246,10 +245,10 @@ create_selectable_pipe (PHANDLE read_pip
     {
       static volatile LONG pipe_unique_id;
 
-      snprintf (pipename, sizeof pipename, "\\\\.\\pipe\\cygwin-%d-%ld",
-                getpid (), InterlockedIncrement ((LONG *)&pipe_unique_id));
+      __small_sprintf (pipename, "\\\\.\\pipe\\cygwin-%d-%ld", myself->pid,
+		       InterlockedIncrement ((LONG *) &pipe_unique_id));
 
-      debug_printf ("CreateNamedPipe: name = %s, size = %lu", pipename, psize);
+      debug_printf ("CreateNamedPipe: name %s, size %lu", pipename, psize);
 
       /* Use CreateNamedPipe instead of CreatePipe, because the latter
          returns a write handle that does not permit FILE_READ_ATTRIBUTES
@@ -271,7 +270,7 @@ create_selectable_pipe (PHANDLE read_pip
 
       if (read_pipe != INVALID_HANDLE_VALUE)
         {
-          debug_printf ("pipe read handle = %p", read_pipe);
+          debug_printf ("pipe read handle %p", read_pipe);
           break;
         }
 
@@ -292,24 +291,24 @@ create_selectable_pipe (PHANDLE read_pip
           /* We are on an older Win9x platform without named pipes.
              Return an anonymous pipe as the best approximation.  */
           debug_printf ("CreateNamedPipe not implemented, resorting to "
-                        "CreatePipe: size = %lu", psize);
+                        "CreatePipe size %lu", psize);
           if (CreatePipe (read_pipe_ptr, write_pipe_ptr, sa_ptr, psize))
             {
-              debug_printf ("pipe read handle = %p", *read_pipe_ptr);
-              debug_printf ("pipe write handle = %p", *write_pipe_ptr);
+              debug_printf ("pipe read handle %p", *read_pipe_ptr);
+              debug_printf ("pipe write handle %p", *write_pipe_ptr);
               return NO_ERROR;
             }
           err = GetLastError ();
-          debug_printf ("CreatePipe failed: %E");
+          debug_printf ("CreatePipe failed, %E");
           return err;
         default:
-          debug_printf ("CreateNamedPipe failed: %E");
+          debug_printf ("CreateNamedPipe failed, %E");
           return err;
         }
       /* NOTREACHED */
     }
 
-  debug_printf ("CreateFile: name = %s", pipename);
+  debug_printf ("CreateFile: name %s", pipename);
 
   /* Open the named pipe for writing.
      Be sure to permit FILE_READ_ATTRIBUTES access.  */
@@ -325,12 +324,12 @@ create_selectable_pipe (PHANDLE read_pip
     {
       /* Failure. */
       DWORD err = GetLastError ();
-      debug_printf ("CreateFile failed: %E");
+      debug_printf ("CreateFile failed, %E");
       CloseHandle (read_pipe);
       return err;
     }
 
-  debug_printf ("pipe write handle = %p", write_pipe);
+  debug_printf ("pipe write handle %p", write_pipe);
 
   /* Success. */
   *read_pipe_ptr = read_pipe;
@@ -410,21 +409,14 @@ fhandler_pipe::ioctl (unsigned int cmd, 
   return 0;
 }
 
-#define DEFAULT_PIPEBUFSIZE (4*PIPE_BUF)
+#define DEFAULT_PIPEBUFSIZE (4 * PIPE_BUF)
 
 extern "C" int
 pipe (int filedes[2])
 {
   extern DWORD binmode;
   fhandler_pipe *fhs[2];
-  static unsigned int psize = 0;
-  if (psize == 0)
-    {
-      char buf[80];
-      psize = GetEnvironmentVariable ("CYGWIN_PIPEBUFSIZE", buf, sizeof (buf))
-                ? (unsigned int) atoi (buf) : DEFAULT_PIPEBUFSIZE;
-      debug_printf ("pipe buffer size == %u", psize);
-    }
+  unsigned psize = DEFAULT_PIPEBUFSIZE;
   int res = fhandler_pipe::create (fhs, psize, (!binmode || binmode == O_BINARY)
 					       ? O_BINARY : O_TEXT);
   if (res == 0)
diff -up ./select.cc hold1/select.cc
--- ./select.cc	2004-09-02 21:17:02.271975633 -0400
+++ hold1/select.cc	2004-09-02 21:12:26.128880255 -0400
@@ -28,7 +28,6 @@ details. */
 #include <winuser.h>
 #include <netdb.h>
 #include <unistd.h>
-#include <stdio.h>
 #include <limits.h>
 #define USE_SYS_TYPES_FD_SET
 #include <winsock.h>
@@ -453,10 +452,8 @@ peek_pipe (select_record *s, bool from_s
     }
 
   if (fh->get_device () == FH_PIPEW)
-    {
-      select_printf ("%s, select for read/except on write end of pipe",
-                     fh->get_name ());
-    }
+    select_printf ("%s, select for read/except on write end of pipe",
+		   fh->get_name ());
   else if (!PeekNamedPipe (h, NULL, 0, NULL, (DWORD *) &n, NULL))
     {
       select_printf ("%s, PeekNamedPipe failed, %E", fh->get_name ());
@@ -494,7 +491,7 @@ peek_pipe (select_record *s, bool from_s
     }
   if (n > 0 && s->read_selected)
     {
-      select_printf ("%s, ready for read: avail = %d", fh->get_name (), n);
+      select_printf ("%s, ready for read: avail %d", fh->get_name (), n);
       gotone += s->read_ready = true;
     }
   if (!gotone && s->fh->hit_eof ())
@@ -516,18 +513,16 @@ out:
         }
       /* Do we need to do anything about SIGTTOU here? */
       else if (fh->get_device () == FH_PIPER)
-        {
-          select_printf ("%s, select for write on read end of pipe",
-                         fh->get_name ());
-        }
+	select_printf ("%s, select for write on read end of pipe",
+		       fh->get_name ());
       else
         {
           /* We don't worry about the guard mutex, because that only applies
              when from_select is false, and peek_pipe is never called that
              way for writes.  */
 
-          IO_STATUS_BLOCK iosb = { 0 };
-          FILE_PIPE_LOCAL_INFORMATION fpli = { 0 };
+          IO_STATUS_BLOCK iosb = {0};
+          FILE_PIPE_LOCAL_INFORMATION fpli = {0};
 
           if (NtQueryInformationFile (h,
                                       &iosb,
@@ -550,7 +545,7 @@ out:
              this way (e.g., BSD, Linux, Solaris).  */
           else if (fpli.WriteQuotaAvailable >= PIPE_BUF)
             {
-              select_printf ("%s, ready for write: size = %lu, avail = %lu",
+              select_printf ("%s, ready for write: size %lu, avail %lu",
                              fh->get_name (),
                              fpli.OutboundQuota,
                              fpli.WriteQuotaAvailable);
@@ -562,7 +557,7 @@ out:
           else if (fpli.OutboundQuota < PIPE_BUF &&
                    fpli.WriteQuotaAvailable == fpli.OutboundQuota)
             {
-              select_printf ("%s, tiny pipe: size = %lu, avail = %lu",
+              select_printf ("%s, tiny pipe: size %lu, avail %lu",
                              fh->get_name (),
                              fpli.OutboundQuota,
                              fpli.WriteQuotaAvailable);

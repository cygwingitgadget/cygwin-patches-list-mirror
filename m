Return-Path: <cygwin-patches-return-2385-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13734 invoked by alias); 10 Jun 2002 23:01:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13706 invoked from network); 10 Jun 2002 23:01:44 -0000
Message-ID: <017001c210d3$0077f2c0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <008801c210b9$248538e0$6132bc3e@BABEL>
Subject: Re: cygserver debug output patch
Date: Mon, 10 Jun 2002 16:01:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_016D_01C210DB.61E9CDF0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00368.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_016D_01C210DB.61E9CDF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1959

"Conrad Scott" <Conrad.Scott@dsl.pipex.com> wrote:
> I've made some changes to the cygserver code to "harmonize" the debugging
> output.

I also realise, now that I come to run things *without* cygserver running,
that I've made things *far* too noisy. So, here's a replacement for the
previous patch that calms things down somewhat (i.e. the winsup.patch
attached to this email supercedes the previous email's one). This version
doesn't generate any output to stderr in normal running except for the
cygserver itself (I think, hope and pray etc.).

I've also attached an incremental patch (from the last version to this) for
those who've already applied that patch (sorry about that Nicholas).

Anyhow, enjoy etc.

// Conrad

2002-06-10  Conrad Scott  <conrad.scott@dsl.pipex.com>

 * cygserver.cc: Move to "woutsup.h". Use new XXX_printf functions
 throughout.
 * cygserver_client.cc: Ditto.
 * cygserver_process.cc: Ditto.
 (process_init): Initialise with PTHREAD_ONCE_INIT.
 * cygserver_shm.cc: Move to "woutsup.h". Use new XXX_printf
 functions throughout.
 * cygserver_transport.cc: Ditto.
 (transport_layer_base::transport_layer_base): Removed (redundant).
 (transport_layer_base::listen): Now pure virtual.
 (transport_layer_base::accept): Ditto.
 (transport_layer_base::close): Ditto.
 (transport_layer_base::read): Ditto.
 (transport_layer_base::write): Ditto.
 (transport_layer_base::connect): Ditto.
 * cygserver_transport_pipes.cc: Move to "woutsup.h". Use new
 XXX_printf functions throughout.
 * cygserver_transport_sockets.cc: Ditto.
 * threaded_queue.cc: Ditto.
 * woutsup.h: New file.
 * include/cygwin/cygserver_transport.h
 (transport_layer_base::transport_layer_base): Removed (redundant).
 (transport_layer_base::listen): Now pure virtual.
 (transport_layer_base::accept): Ditto.
 (transport_layer_base::close): Ditto.
 (transport_layer_base::read): Ditto.
 (transport_layer_base::write): Ditto.
 (transport_layer_base::connect): Ditto.


------=_NextPart_000_016D_01C210DB.61E9CDF0
Content-Type: application/octet-stream;
	name="winsup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="winsup.patch"
Content-length: 45803

? woutsup.h=0A=
Index: cygserver.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/cygserver.cc,v=0A=
retrieving revision 1.4=0A=
diff -u -w -u -r1.4 cygserver.cc=0A=
--- cygserver.cc	15 Mar 2002 21:52:05 -0000	1.4=0A=
+++ cygserver.cc	10 Jun 2002 19:42:07 -0000=0A=
@@ -10,6 +10,8 @@=0A=
    Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
    details. */=0A=
=20=0A=
+#include "woutsup.h"=0A=
+=0A=
 #include <errno.h>=0A=
 #include <stdio.h>=0A=
 #include <unistd.h>=0A=
@@ -19,7 +21,6 @@=0A=
 #include <netdb.h>=0A=
 #include <signal.h>=0A=
 #include <stdlib.h>=0A=
-#include "wincap.h"=0A=
 #include "cygwin_version.h"=0A=
=20=0A=
 #include "getopt.h"=0A=
@@ -32,10 +33,6 @@=0A=
 #include "cygwin/cygserver.h"=0A=
 #include "cygserver_shm.h"=0A=
=20=0A=
-/* for quieter operation, set to 0 */=0A=
-#define DEBUG 0=0A=
-#define debug_printf if (DEBUG) printf=0A=
-=0A=
 GENERIC_MAPPING access_mapping;=0A=
 static class transport_layer_base *transport;=0A=
=20=0A=
@@ -51,14 +48,14 @@=0A=
   rc =3D OpenProcessToken (GetCurrentProcess() , TOKEN_ALL_ACCESS , &hToke=
n) ;=0A=
   if (!rc)=0A=
     {=0A=
-      printf ("error opening process token (%lu)\n", GetLastError ());=0A=
+      system_printf ("error opening process token (%lu)", GetLastError ())=
;=0A=
       ret_val =3D FALSE;=0A=
       goto out;=0A=
     }=0A=
   rc =3D LookupPrivilegeValue (NULL, SE_DEBUG_NAME, &sPrivileges.Privilege=
s[0].Luid);=0A=
   if (!rc)=0A=
     {=0A=
-      printf ("error getting prigilege luid (%lu)\n", GetLastError ());=0A=
+      system_printf ("error getting privilege luid (%lu)", GetLastError ()=
);=0A=
       ret_val =3D FALSE;=0A=
       goto out;=0A=
     }=0A=
@@ -67,7 +64,7 @@=0A=
   rc =3D AdjustTokenPrivileges (hToken, FALSE, &sPrivileges, 0, NULL, NULL=
) ;=0A=
   if (!rc)=0A=
     {=0A=
-      printf ("error adjusting prigilege level. (%lu)\n", GetLastError ())=
;=0A=
+      system_printf ("error adjusting privilege level. (%lu)", GetLastErro=
r ());=0A=
       ret_val =3D FALSE;=0A=
       goto out;=0A=
     }=0A=
@@ -108,7 +105,7 @@=0A=
 			0, bInheritHandle,=0A=
 			DUPLICATE_SAME_ACCESS))=0A=
     {=0A=
-      printf ("error getting handle(%u) to server (%lu)\n", (unsigned int)=
from_handle, GetLastError ());=0A=
+	  system_printf ("error getting handle(%u) to server (%lu)", (unsigned in=
t)from_handle, GetLastError ());=0A=
       goto out;=0A=
     }=0A=
 } else=0A=
@@ -118,7 +115,7 @@=0A=
 				OWNER_SECURITY_INFORMATION | GROUP_SECURITY_INFORMATION	| DACL_SECURIT=
Y_INFORMATION,=0A=
 				sd, sizeof (sd_buf), &bytes_needed))=0A=
     {=0A=
-      printf ("error getting handle SD (%lu)\n", GetLastError ());=0A=
+      system_printf ("error getting handle SD (%lu)", GetLastError ());=0A=
       goto out;=0A=
     }=0A=
=20=0A=
@@ -127,13 +124,13 @@=0A=
   if (!AccessCheck (sd, from_process_token, access, &access_mapping,=0A=
 		    &ps, &ps_len, &access, &status))=0A=
     {=0A=
-      printf ("error checking access rights (%lu)\n", GetLastError ());=0A=
+      system_printf ("error checking access rights (%lu)", GetLastError ()=
);=0A=
       goto out;=0A=
     }=0A=
=20=0A=
   if (!status)=0A=
     {=0A=
-      printf ("access to object denied\n");=0A=
+      system_printf ("access to object denied");=0A=
       goto out;=0A=
     }=0A=
=20=0A=
@@ -141,10 +138,10 @@=0A=
 			to_process, to_handle_ptr,=0A=
 			access, bInheritHandle, 0))=0A=
     {=0A=
-      printf ("error getting handle to client (%lu)\n", GetLastError ());=
=0A=
+      system_printf ("error getting handle to client (%lu)", GetLastError =
());=0A=
       goto out;=0A=
     }=0A=
-  debug_printf ("Duplicated %p to %p\n", from_handle, *to_handle_ptr);=0A=
+  debug_printf ("Duplicated %p to %p", from_handle, *to_handle_ptr);=0A=
=20=0A=
   ret_val =3D 0;=0A=
=20=0A=
@@ -158,9 +155,9 @@=0A=
 void=0A=
 client_request::serve (transport_layer_base *conn, class process_cache *ca=
che)=0A=
 {=0A=
-  printf ("*****************************************\n"=0A=
-	  "A call to the base client_request class has occured\n"=0A=
-	  "This indicates a mismatch in a virtual function definition somewhere\n=
");=0A=
+  system_printf ("*****************************************");=0A=
+  system_printf ("A call to the base client_request class has occured");=
=0A=
+  system_printf ("This indicates a mismatch in a virtual function definiti=
on somewhere");=0A=
   exit (1);=0A=
 }=0A=
=20=0A=
@@ -178,36 +175,36 @@=0A=
       return;=0A=
     }=0A=
=20=0A=
-  debug_printf ("pid %ld:(%p,%p) -> pid %ld\n", req.master_pid,=0A=
+  debug_printf ("pid %ld:(%p,%p) -> pid %ld", req.master_pid,=0A=
 				req.from_master, req.to_master,=0A=
 				req.pid);=0A=
=20=0A=
-  debug_printf ("opening process %ld\n", req.master_pid);=0A=
+  debug_printf ("opening process %ld", req.master_pid);=0A=
   from_process_handle =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE, req.mast=
er_pid);=0A=
-  debug_printf ("opening process %ld\n", req.pid);=0A=
+  debug_printf ("opening process %ld", req.pid);=0A=
   to_process_handle =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE, req.pid);=
=0A=
   if (!from_process_handle || !to_process_handle)=0A=
     {=0A=
-      printf ("error opening process (%lu)\n", GetLastError ());=0A=
+      system_printf ("error opening process (%lu)", GetLastError ());=0A=
       header.error_code =3D EACCES;=0A=
       goto out;=0A=
     }=0A=
=20=0A=
-  debug_printf ("Impersonating client\n");=0A=
+  debug_printf ("Impersonating client");=0A=
   conn->impersonate_client ();=0A=
=20=0A=
-  debug_printf ("about to open thread token\n");=0A=
+  debug_printf ("about to open thread token");=0A=
   rc =3D OpenThreadToken (GetCurrentThread (),=0A=
 			TOKEN_QUERY,=0A=
 			TRUE,=0A=
 			&token_handle);=0A=
=20=0A=
-  debug_printf ("opened thread token, rc=3D%lu\n", rc);=0A=
+  debug_printf ("opened thread token, rc=3D%lu", rc);=0A=
   conn->revert_to_self ();=0A=
=20=0A=
   if (!rc)=0A=
     {=0A=
-      printf ("error opening thread token (%lu)\n", GetLastError ());=0A=
+      system_printf ("error opening thread token (%lu)", GetLastError ());=
=0A=
       header.error_code =3D EACCES;=0A=
       goto out;=0A=
     }=0A=
@@ -218,7 +215,7 @@=0A=
 			    req.from_master,=0A=
 			    &req.from_master, TRUE) !=3D 0)=0A=
     {=0A=
-      printf ("error duplicating from_master handle (%lu)\n", GetLastError=
 ());=0A=
+      system_printf ("error duplicating from_master handle (%lu)", GetLast=
Error ());=0A=
       header.error_code =3D EACCES;=0A=
       goto out;=0A=
     }=0A=
@@ -231,16 +228,14 @@=0A=
 				req.to_master,=0A=
 				&req.to_master, TRUE) !=3D 0)=0A=
 	{=0A=
-	  printf ("error duplicating to_master handle (%lu)\n", GetLastError ());=
=0A=
+	  system_printf ("error duplicating to_master handle (%lu)", GetLastError=
 ());=0A=
 	  header.error_code =3D EACCES;=0A=
 	  goto out;=0A=
 	}=0A=
     }=0A=
=20=0A=
-#if DEBUG=0A=
-  printf ("%ld -> %ld(%p,%p)\n", req.master_pid, req.pid,=0A=
+  debug_printf ("%ld -> %ld(%p,%p)", req.master_pid, req.pid,=0A=
 				req.from_master, req.to_master);=0A=
-#endif=0A=
=20=0A=
   header.error_code =3D 0;=0A=
=20=0A=
@@ -346,15 +341,15 @@=0A=
   ssize_t bytes_read, bytes_written;=0A=
   struct request_header* req_ptr =3D (struct request_header*) &request_buf=
fer;=0A=
   client_request *req =3D NULL;=0A=
-  debug_printf ("about to read\n");=0A=
+  debug_printf ("about to read");=0A=
=20=0A=
   bytes_read =3D conn->read (request_buffer, sizeof (struct request_header=
));=0A=
   if (bytes_read !=3D sizeof (struct request_header))=0A=
     {=0A=
-      printf ("error reading from connection (%lu)\n", GetLastError ());=
=0A=
+      system_printf ("error reading from connection (%lu)", GetLastError (=
));=0A=
       goto out;=0A=
     }=0A=
-  debug_printf ("got header (%ld)\n", bytes_read);=0A=
+  debug_printf ("got header (%ld)", bytes_read);=0A=
=20=0A=
   switch (req_ptr->req_id)=0A=
     {=0A=
@@ -369,12 +364,12 @@=0A=
     default:=0A=
       req =3D new client_request (CYGSERVER_REQUEST_INVALID, 0);=0A=
       req->header.error_code =3D ENOSYS;=0A=
-      debug_printf ("Bad client request - returning ENOSYS\n");=0A=
+      debug_printf ("Bad client request - returning ENOSYS");=0A=
     }=0A=
=20=0A=
   if (req->header.cb !=3D req_ptr->cb)=0A=
     {=0A=
-      debug_printf ("Mismatch in request buffer sizes\n");=0A=
+      debug_printf ("Mismatch in request buffer sizes");=0A=
       goto out;=0A=
     }=0A=
=20=0A=
@@ -384,10 +379,10 @@=0A=
       bytes_read =3D conn->read (req->buffer, req->header.cb);=0A=
       if (bytes_read !=3D req->header.cb)=0A=
 	{=0A=
-	  debug_printf ("error reading from connection (%lu)\n", GetLastError ())=
;=0A=
+	  debug_printf ("error reading from connection (%lu)", GetLastError ());=
=0A=
 	  goto out;=0A=
 	}=0A=
-      debug_printf ("got body (%ld)\n",bytes_read);=0A=
+      debug_printf ("got body (%ld)",bytes_read);=0A=
     }=0A=
=20=0A=
   /* this is not allowed to fail. We must return ENOSYS at a minimum to th=
e client */=0A=
@@ -398,11 +393,11 @@=0A=
     (bytes_written =3D conn->write (req->buffer, req->header.cb)) !=3D req=
->header.cb))=0A=
     {=0A=
       req->header.error_code =3D -1;=0A=
-      printf ("error writing to connection (%lu)\n", GetLastError ());=0A=
+      system_printf ("error writing to connection (%lu)", GetLastError ())=
;=0A=
       goto out;=0A=
     }=0A=
=20=0A=
-  debug_printf("Sent reply, size (%ld)\n",bytes_written);=0A=
+  debug_printf ("Sent reply, size (%ld)",bytes_written);=0A=
   printf (".");=0A=
=20=0A=
 out:=0A=
@@ -475,7 +470,7 @@=0A=
     {=0A=
       if (!transport->connect())=0A=
 	{=0A=
-	  printf ("couldn't establish connection with server\n");=0A=
+	  system_printf ("couldn't establish connection with server");=0A=
 	  exit (1);=0A=
 	}=0A=
       client_request_shutdown *request =3D=0A=
@@ -503,26 +498,26 @@=0A=
 		 cygwin_version.mount_registry,=0A=
 		 cygwin_version.dll_build_date);=0A=
   setbuf (stdout, NULL);=0A=
-  printf ("daemon version %s starting up", version);=0A=
+  system_printf ("daemon version %s starting up", version);=0A=
   if (signal (SIGQUIT, handle_signal) =3D=3D SIG_ERR)=0A=
     {=0A=
-      printf ("\ncould not install signal handler (%d)- aborting startup\n=
", errno);=0A=
+      system_printf ("could not install signal handler (%d)- aborting star=
tup", errno);=0A=
       exit (1);=0A=
     }=0A=
-  printf (".");=0A=
+  debug_printf ("installed signal handler");=0A=
   transport->listen ();=0A=
-  printf (".");=0A=
+  debug_printf ("listening for connections");=0A=
   class process_cache cache (2);=0A=
   request_queue.initial_workers =3D 10;=0A=
   request_queue.cache =3D &cache;=0A=
   request_queue.create_workers ();=0A=
-  printf (".");=0A=
+  debug_printf ("created process cache");=0A=
   request_queue.process_requests (transport);=0A=
-  printf (".");=0A=
+  debug_printf ("started request queue");=0A=
   cache.create_workers ();=0A=
-  printf (".");=0A=
+  debug_printf ("created workers");=0A=
   cache.process_requests ();=0A=
-  printf (".complete\n");=0A=
+  system_printf ("daemon initialization complete");=0A=
   /* TODO: wait on multiple objects - the thread handle for each request l=
oop +=0A=
    * all the process handles. This should be done by querying the request_=
queue and=0A=
    * the process cache for all their handles, and then waiting for (say) 3=
0 seconds.=0A=
@@ -538,12 +533,12 @@=0A=
     {=0A=
       sleep (1);=0A=
     }=0A=
-  printf ("\nShutdown request recieved - new requests will be denied\n");=
=0A=
+  debug_printf ("Shutdown request received - new requests will be denied")=
;=0A=
   request_queue.cleanup ();=0A=
-  printf ("All pending requests processed\n");=0A=
+  debug_printf ("All pending requests processed");=0A=
   transport->close ();=0A=
-  printf ("No longer accepting requests - cygwin will operate in daemonles=
s mode\n");=0A=
+  debug_printf ("No longer accepting requests - cygwin will operate in dae=
monless mode");=0A=
   cache.cleanup ();=0A=
-  printf ("All outstanding process-cache activities completed\n");=0A=
-  printf ("daemon shutdown\n");=0A=
+  debug_printf ("All outstanding process-cache activities completed");=0A=
+  debug_printf ("Daemon shutdown");=0A=
 }=0A=
Index: cygserver_client.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/cygserver_client.cc,v=0A=
retrieving revision 1.3=0A=
diff -u -w -u -r1.3 cygserver_client.cc=0A=
--- cygserver_client.cc	13 Mar 2002 02:34:03 -0000	1.3=0A=
+++ cygserver_client.cc	10 Jun 2002 19:42:07 -0000=0A=
@@ -11,17 +11,11 @@=0A=
    details. */=0A=
=20=0A=
 #ifdef __OUTSIDE_CYGWIN__=0A=
-#undef __INSIDE_CYGWIN__=0A=
+#include "woutsup.h"=0A=
 #else=0A=
 #include "winsup.h"=0A=
 #endif=0A=
=20=0A=
-#ifndef __INSIDE_CYGWIN__=0A=
-#define debug_printf printf=0A=
-#define api_fatal printf=0A=
-#include <stdio.h>=0A=
-#include <windows.h>=0A=
-#endif=0A=
 #include <sys/socket.h>=0A=
 #include <errno.h>=0A=
 #include <unistd.h>=0A=
@@ -39,6 +33,8 @@=0A=
 client_request_get_version::client_request_get_version () : client_request=
 (CYGSERVER_REQUEST_GET_VERSION, sizeof (version))=0A=
 {=0A=
   buffer =3D (char *)&version;=0A=
+=0A=
+  debug_printf ("created");=0A=
 }=0A=
=20=0A=
 client_request_attach_tty::client_request_attach_tty () : client_request (=
CYGSERVER_REQUEST_ATTACH_TTY, sizeof (req))=0A=
@@ -48,6 +44,8 @@=0A=
   req.master_pid =3D 0;=0A=
   req.from_master =3D NULL;=0A=
   req.to_master =3D NULL;=0A=
+=0A=
+  debug_printf ("created");=0A=
 }=0A=
=20=0A=
 client_request_attach_tty::client_request_attach_tty (DWORD npid, DWORD nm=
aster_pid, HANDLE nfrom_master, HANDLE nto_master) : client_request (CYGSER=
VER_REQUEST_ATTACH_TTY, sizeof (req))=0A=
@@ -57,11 +55,15 @@=0A=
   req.master_pid =3D nmaster_pid;=0A=
   req.from_master =3D nfrom_master;=0A=
   req.to_master =3D nto_master;=0A=
+=0A=
+  debug_printf ("created");=0A=
 }=0A=
=20=0A=
 client_request_shutdown::client_request_shutdown () : client_request (CYGS=
ERVER_REQUEST_SHUTDOWN, 0)=0A=
 {=0A=
   buffer =3D NULL;=0A=
+=0A=
+  debug_printf ("created");=0A=
 }=0A=
=20=0A=
 client_request::client_request (cygserver_request_code id, ssize_t buffer_=
size) : header (id, buffer_size)=0A=
@@ -82,29 +84,29 @@=0A=
 {=0A=
   if (!conn)=0A=
     return;=0A=
-  debug_printf("this=3D%p, conn=3D%p\n",this, conn);=0A=
+  debug_printf("this=3D%p, conn=3D%p",this, conn);=0A=
   ssize_t bytes_written, bytes_read;=0A=
-  debug_printf("header.cb =3D %ld\n",header.cb);=0A=
+  debug_printf("header.cb =3D %ld",header.cb);=0A=
   if ((bytes_written =3D conn->write ((char *)&header, sizeof (header)))=
=0A=
     !=3D sizeof(header) || (header.cb &&=0A=
     (bytes_written =3D conn->write (buffer, header.cb)) !=3D header.cb))=
=0A=
     {=0A=
       header.error_code =3D -1;=0A=
-      debug_printf ("bytes written !=3D request size\n");=0A=
+      debug_printf ("bytes written !=3D request size");=0A=
       return;=0A=
     }=0A=
=20=0A=
-  debug_printf("Sent request, size (%ld)\n",bytes_written);=0A=
+  debug_printf("Sent request, size (%ld)",bytes_written);=0A=
=20=0A=
   if ((bytes_read =3D conn->read ((char *)&header, sizeof (header)))=0A=
     !=3D sizeof (header) || (header.cb &&=0A=
     (bytes_read =3D conn->read (buffer, header.cb)) !=3D header.cb))=0A=
     {=0A=
       header.error_code =3D -1;=0A=
-      debug_printf("failed reading response \n");=0A=
+      debug_printf("failed reading response");=0A=
       return;=0A=
     }=0A=
-  debug_printf ("completed ok\n");=0A=
+  debug_printf ("completed ok");=0A=
 }=0A=
=20=0A=
 /* Oh, BTW: Fix the procedural basis and make this more intuitive. */=0A=
@@ -134,7 +136,7 @@=0A=
       return -1;=0A=
     }=0A=
=20=0A=
-  debug_printf ("connected to server %p\n", transport);=0A=
+  debug_printf ("connected to server %p", transport);=0A=
=20=0A=
   req->send(transport);=0A=
=20=0A=
Index: cygserver_process.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/cygserver_process.cc,v=0A=
retrieving revision 1.4=0A=
diff -u -w -u -r1.4 cygserver_process.cc=0A=
--- cygserver_process.cc	28 May 2002 01:55:39 -0000	1.4=0A=
+++ cygserver_process.cc	10 Jun 2002 19:42:08 -0000=0A=
@@ -10,6 +10,8 @@=0A=
    Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
    details. */=0A=
=20=0A=
+#include "woutsup.h"=0A=
+=0A=
 #include <errno.h>=0A=
 #include <stdio.h>=0A=
 #include <unistd.h>=0A=
@@ -18,14 +20,10 @@=0A=
 #include <sys/types.h>=0A=
 #include <sys/socket.h>=0A=
 #include <netdb.h>=0A=
-#include "wincap.h"=0A=
 #include <pthread.h>=0A=
 #include <threaded_queue.h>=0A=
 #include <cygwin/cygserver_process.h>=0A=
=20=0A=
-#define debug_printf if (DEBUG) printf=0A=
-#define DEBUG 1=0A=
-=0A=
 /* the cache structures and classes are designed for one cache per server =
process.=0A=
  * To make multiple process caches, a redesign will be needed=0A=
  */=0A=
@@ -38,7 +36,7 @@=0A=
   InitializeCriticalSection (&cache_write_access);=0A=
   if ((cache_add_trigger =3D CreateEvent (NULL, FALSE, FALSE, NULL)) =3D=
=3D NULL)=0A=
     {=0A=
-      printf ("Failed to create cache add trigger (%lu), terminating\n",=
=0A=
+      system_printf ("Failed to create cache add trigger (%lu), terminatin=
g",=0A=
 	      GetLastError ());=0A=
       exit (1);=0A=
     }=0A=
@@ -118,7 +116,7 @@=0A=
       entry =3D (class process *) InterlockedExchangePointer (&head, thepr=
ocess->next);=0A=
       if (entry !=3D theprocess)=0A=
 	{=0A=
-	  printf ("Bug encountered, process cache corrupted\n");=0A=
+	  system_printf ("Bug encountered, process cache corrupted");=0A=
 	  exit (1);=0A=
 	}=0A=
     }=0A=
@@ -129,7 +127,7 @@=0A=
       class process *temp =3D (class process *) InterlockedExchangePointer=
 (&entry->next, theprocess->next);=0A=
       if (temp !=3D theprocess)=0A=
 	{=0A=
-	  printf ("Bug encountered, process cache corrupted\n");=0A=
+	  system_printf ("Bug encountered, process cache corrupted");=0A=
 	  exit (1);=0A=
 	}=0A=
     }=0A=
@@ -181,7 +179,7 @@=0A=
 /* process's */=0A=
 /* global process crit section */=0A=
 static CRITICAL_SECTION process_access;=0A=
-static pthread_once_t process_init;=0A=
+static pthread_once_t process_init =3D PTHREAD_ONCE_INIT;=0A=
=20=0A=
 void=0A=
 do_process_init (void)=0A=
@@ -198,10 +196,10 @@=0A=
   thehandle =3D OpenProcess (PROCESS_ALL_ACCESS, FALSE, pid);=0A=
   if (!thehandle)=0A=
     {=0A=
-      printf ("unable to obtain handle for new cache process %ld\n", pid);=
=0A=
+      system_printf ("unable to obtain handle for new cache process %ld", =
pid);=0A=
       thehandle =3D INVALID_HANDLE_VALUE;=0A=
     }=0A=
-  debug_printf ("Got handle %p for new cache process %ld\n", thehandle, pi=
d);=0A=
+  debug_printf ("Got handle %p for new cache process %ld", thehandle, pid)=
;=0A=
   InitializeCriticalSection (&access);=0A=
   LeaveCriticalSection (&process_access);=0A=
 }=0A=
@@ -221,10 +219,10 @@=0A=
   /* FIXME: call the cleanup list ? */=0A=
=20=0A=
 //  CloseHandle (thehandle);=0A=
-//  debug_printf ("Process id %ld has terminated, attempting to open a new=
 handle\n",=0A=
+//  debug_printf ("Process id %ld has terminated, attempting to open a new=
 handle",=0A=
 //       winpid);=0A=
 //  thehandle =3D OpenProcess (PROCESS_ALL_ACCESS, FALSE, winpid);=0A=
-//  debug_printf ("Got handle %p when refreshing cache process %ld\n", the=
handle, winpid);=0A=
+//  debug_printf ("Got handle %p when refreshing cache process %ld", theha=
ndle, winpid);=0A=
 //  /* FIXME: what if OpenProcess fails ? */=0A=
 //  if (thehandle)=0A=
 //    {=0A=
@@ -244,7 +242,7 @@=0A=
     err =3D GetExitCodeProcess (thehandle, &_exit_status);=0A=
   if (!err)=0A=
     {=0A=
-      debug_printf ("Failed to retrieve exit code (%ld)\n", GetLastError (=
));=0A=
+      system_printf ("Failed to retrieve exit code (%ld)", GetLastError ()=
);=0A=
       thehandle =3D INVALID_HANDLE_VALUE;=0A=
       return _exit_status;=0A=
     }=0A=
@@ -333,8 +331,8 @@=0A=
 						 HandlesSize + 10);=0A=
 	      if (!temp)=0A=
 		{=0A=
-		  printf=0A=
-		    ("cannot allocate more storage for the handle array!\n");=0A=
+		  system_printf=0A=
+		    ("cannot allocate more storage for the handle array!");=0A=
 		  exit (1);=0A=
 		}=0A=
 	      Handles =3D temp;=0A=
@@ -343,8 +341,8 @@=0A=
 						      HandlesSize + 10);=0A=
 	      if (!ptemp)=0A=
 		{=0A=
-		  printf=0A=
-		    ("cannot allocate more storage for the handle array!\n");=0A=
+		  system_printf=0A=
+		    ("cannot allocate more storage for the handle array!");=0A=
 		  exit (1);=0A=
 		}=0A=
 	      Entries =3D ptemp;=0A=
@@ -356,18 +354,18 @@=0A=
 				    HandlesSize - 2 - offset, offset);=0A=
 	  count +=3D copied;=0A=
 	}=0A=
-      debug_printf ("waiting on %u objects\n", count);=0A=
+      debug_printf ("waiting on %u objects", count);=0A=
       DWORD rc =3D WaitForMultipleObjects (count, Handles, FALSE, INFINITE=
);=0A=
       if (rc =3D=3D WAIT_FAILED)=0A=
 	{=0A=
-	  printf ("Could not wait on the process handles (%ld)!\n",=0A=
+	  system_printf ("Could not wait on the process handles (%ld)!",=0A=
 		  GetLastError ());=0A=
 	  exit (1);=0A=
 	}=0A=
       int objindex =3D rc - WAIT_OBJECT_0;=0A=
       if (objindex > 1 && objindex < count)=0A=
 	{=0A=
-	  debug_printf ("Process %ld has left the building\n",=0A=
+	  debug_printf ("Process %ld has left the building",=0A=
 			Entries[objindex]->winpid);=0A=
 	  /* fire off the termination routines */=0A=
 	  cache->remove_process (Entries[objindex]);=0A=
@@ -379,8 +377,8 @@=0A=
 	}=0A=
       else=0A=
 	{=0A=
-	  printf=0A=
-	    ("unexpected return code from WaitForMultiple objects in process_proc=
ess_param::request_loop\n");=0A=
+	  system_printf=0A=
+	    ("unexpected return code from WaitForMultiple objects in process_proc=
ess_param::request_loop");=0A=
 	}=0A=
     }=0A=
   running =3D false;=0A=
Index: cygserver_shm.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/cygserver_shm.cc,v=0A=
retrieving revision 1.7=0A=
diff -u -w -u -r1.7 cygserver_shm.cc=0A=
--- cygserver_shm.cc	28 May 2002 01:55:39 -0000	1.7=0A=
+++ cygserver_shm.cc	10 Jun 2002 19:42:08 -0000=0A=
@@ -11,20 +11,11 @@=0A=
 details. */=0A=
=20=0A=
 #ifdef __OUTSIDE_CYGWIN__=0A=
-#undef __INSIDE_CYGWIN__=0A=
+#include "woutsup.h"=0A=
 #else=0A=
 #include "winsup.h"=0A=
 #endif=0A=
=20=0A=
-#ifndef __INSIDE_CYGWIN__=0A=
-#define DEBUG 0=0A=
-#define system_printf printf=0A=
-#define debug_printf if (DEBUG) printf=0A=
-#define api_fatal printf=0A=
-#include <stdio.h>=0A=
-#include <windows.h>=0A=
-#endif=0A=
-=0A=
 #include <sys/stat.h>=0A=
 #include <errno.h>=0A=
 #include "cygerrno.h"=0A=
@@ -220,7 +211,7 @@=0A=
    */=0A=
   if (!from_process_handle)=0A=
     {=0A=
-      debug_printf ("error opening process (%lu)\n", GetLastError ());=0A=
+      system_printf ("error opening process (%lu)", GetLastError ());=0A=
       header.error_code =3D EACCES;=0A=
       return;=0A=
     }=0A=
@@ -230,22 +221,22 @@=0A=
   rc =3D OpenThreadToken (GetCurrentThread (),=0A=
 			TOKEN_QUERY, TRUE, &token_handle);=0A=
=20=0A=
+  const DWORD lasterr =3D GetLastError ();=0A=
+=0A=
   conn->revert_to_self ();=0A=
=20=0A=
   if (!rc)=0A=
     {=0A=
-      debug_printf ("error opening thread token (%lu)\n", GetLastError ())=
;=0A=
+      system_printf ("error opening thread token (%lu)", lasterr);=0A=
       header.error_code =3D EACCES;=0A=
       CloseHandle (from_process_handle);=0A=
       return;=0A=
     }=0A=
=20=0A=
-=0A=
   /* we trust the clients request - we will be doing it as them, and=0A=
    * the worst they can do is open their own permissions=0A=
    */=0A=
=20=0A=
-=0A=
   SECURITY_ATTRIBUTES sa;=0A=
   sa.nLength =3D sizeof (sa);=0A=
   sa.lpSecurityDescriptor =3D psd;=0A=
@@ -270,7 +261,7 @@=0A=
 		   DUPLICATE_SAME_ACCESS, tempnode->filemap,=0A=
 		   &parameters.out.filemap, TRUE) !=3D 0)=0A=
 		{=0A=
-		  debug_printf ("error duplicating filemap handle (%lu)\n",=0A=
+		  system_printf ("error duplicating filemap handle (%lu)",=0A=
 				GetLastError ());=0A=
 		  header.error_code =3D EACCES;=0A=
 		}=0A=
@@ -279,7 +270,7 @@=0A=
 		   DUPLICATE_SAME_ACCESS, tempnode->attachmap,=0A=
 		   &parameters.out.attachmap, TRUE) !=3D 0)=0A=
 		{=0A=
-		  debug_printf ("error duplicating attachmap handle (%lu)\n",=0A=
+		  system_printf ("error duplicating attachmap handle (%lu)",=0A=
 				GetLastError ());=0A=
 		  header.error_code =3D EACCES;=0A=
 		}=0A=
@@ -400,9 +391,9 @@=0A=
 	  shmname =3D stringbuf;=0A=
 	  snprintf (stringbuf1, 29, "CYGWINSHMD0x%0qx", parameters.in.key);=0A=
 	  shmaname =3D stringbuf1;=0A=
-	  debug_printf ("system id strings are \n%s\n%s\n", shmname,=0A=
+	  debug_printf ("system id strings are `%s' and `%s'", shmname,=0A=
 			shmaname);=0A=
-	  debug_printf ("key input value is 0x%0qx\n", parameters.in.key);=0A=
+	  debug_printf ("key input value is 0x%0qx", parameters.in.key);=0A=
 	}=0A=
=20=0A=
       /* attempt to open the key */=0A=
@@ -439,8 +430,8 @@=0A=
 		  && (parameters.in.shmflg & IPC_EXCL))=0A=
 		{=0A=
 		  header.error_code =3D EEXIST;=0A=
-		  debug_printf=0A=
-		    ("attempt to exclusively create already created shm_area with key 0x=
%0qx\n",=0A=
+		  system_printf=0A=
+		    ("attempt to exclusively create already created shm_area with key 0x=
%0qx",=0A=
 		     parameters.in.key);=0A=
 		  // FIXME: free the mutex=0A=
 		  CloseHandle (token_handle);=0A=
@@ -461,7 +452,7 @@=0A=
 		   DUPLICATE_SAME_ACCESS, tempnode->filemap,=0A=
 		   &parameters.out.filemap, TRUE) !=3D 0)=0A=
 		{=0A=
-		  printf ("error duplicating filemap handle (%lu)\n",=0A=
+		  system_printf ("error duplicating filemap handle (%lu)",=0A=
 			  GetLastError ());=0A=
 		  header.error_code =3D EACCES;=0A=
 /*mutex*/=0A=
@@ -473,7 +464,7 @@=0A=
 		   DUPLICATE_SAME_ACCESS, tempnode->attachmap,=0A=
 		   &parameters.out.attachmap, TRUE) !=3D 0)=0A=
 		{=0A=
-		  printf ("error duplicating attachmap handle (%lu)\n",=0A=
+		  system_printf ("error duplicating attachmap handle (%lu)",=0A=
 			  GetLastError ());=0A=
 		  header.error_code =3D EACCES;=0A=
 /*mutex*/=0A=
@@ -505,7 +496,7 @@=0A=
       if (filemap =3D=3D NULL)=0A=
 	{=0A=
 	  /* We failed to open the filemapping ? */=0A=
-	  system_printf ("failed to open file mapping: %lu\n",=0A=
+	  system_printf ("failed to open file mapping: %lu",=0A=
 			 GetLastError ());=0A=
 	  // free the mutex=0A=
 	  // we can assume that it exists, and that it was an access problem.=0A=
@@ -573,7 +564,7 @@=0A=
=20=0A=
       if (attachmap =3D=3D NULL)=0A=
 	{=0A=
-	  system_printf ("failed to get shm attachmap\n");=0A=
+	  system_printf ("failed to get shm attachmap");=0A=
 	  header.error_code =3D ENOMEM;=0A=
 	  UnmapViewOfFile (mapptr);=0A=
 	  CloseHandle (filemap);=0A=
@@ -585,7 +576,7 @@=0A=
       shmid_ds *shmtemp =3D new shmid_ds;=0A=
       if (!shmtemp)=0A=
 	{=0A=
-	  system_printf ("failed to malloc shm node\n");=0A=
+	  system_printf ("failed to malloc shm node");=0A=
 	  header.error_code =3D ENOMEM;=0A=
 	  UnmapViewOfFile (mapptr);=0A=
 	  CloseHandle (filemap);=0A=
@@ -631,7 +622,7 @@=0A=
 				tempnode->filemap, &parameters.out.filemap,=0A=
 				TRUE) !=3D 0)=0A=
 	{=0A=
-	  printf ("error duplicating filemap handle (%lu)\n",=0A=
+	  system_printf ("error duplicating filemap handle (%lu)",=0A=
 		  GetLastError ());=0A=
 	  header.error_code =3D EACCES;=0A=
 	  CloseHandle (token_handle);=0A=
@@ -644,7 +635,7 @@=0A=
 				tempnode->attachmap,=0A=
 				&parameters.out.attachmap, TRUE) !=3D 0)=0A=
 	{=0A=
-	  printf ("error duplicating attachmap handle (%lu)\n",=0A=
+	  system_printf ("error duplicating attachmap handle (%lu)",=0A=
 		  GetLastError ());=0A=
 	  header.error_code =3D EACCES;=0A=
 	  CloseHandle (from_process_handle);=0A=
Index: cygserver_transport.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/cygserver_transport.cc,v=0A=
retrieving revision 1.4=0A=
diff -u -w -u -r1.4 cygserver_transport.cc=0A=
--- cygserver_transport.cc	9 Jun 2002 23:02:00 -0000	1.4=0A=
+++ cygserver_transport.cc	10 Jun 2002 19:42:08 -0000=0A=
@@ -10,25 +10,19 @@=0A=
    Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
    details. */=0A=
=20=0A=
-#include <errno.h>=0A=
-#include <stdio.h>=0A=
-#include <unistd.h>=0A=
-#include <windows.h>=0A=
-#include <sys/types.h>=0A=
+#ifdef __OUTSIDE_CYGWIN__=0A=
+#include "woutsup.h"=0A=
+#else=0A=
+#include "winsup.h"=0A=
+#endif=0A=
+=0A=
+#include <assert.h>=0A=
+=0A=
 #include <sys/socket.h>=0A=
-#include <netdb.h>=0A=
-#include "wincap.h"=0A=
 #include "cygwin/cygserver_transport.h"=0A=
 #include "cygwin/cygserver_transport_pipes.h"=0A=
 #include "cygwin/cygserver_transport_sockets.h"=0A=
=20=0A=
-/* to allow this to link into cygwin and the .dll, a little magic is neede=
d. */=0A=
-#ifndef __OUTSIDE_CYGWIN__=0A=
-#include "winsup.h"=0A=
-#else=0A=
-#define debug_printf printf=0A=
-#endif=0A=
-=0A=
 /* The factory */=0A=
 class transport_layer_base *create_server_transport()=0A=
 {=0A=
@@ -39,46 +33,6 @@=0A=
   else=0A=
     temp =3D new transport_layer_sockets ();=0A=
   return temp;=0A=
-}=0A=
-=0A=
-=0A=
-transport_layer_base::transport_layer_base ()=0A=
-{=0A=
-  /* should we throw an error of some sort ? */=0A=
-}=0A=
-=0A=
-void=0A=
-transport_layer_base::listen ()=0A=
-{=0A=
-}=0A=
-=0A=
-class transport_layer_base *=0A=
-transport_layer_base::accept ()=0A=
-{=0A=
-  return NULL;=0A=
-}=0A=
-=0A=
-void=0A=
-transport_layer_base::close()=0A=
-{=0A=
-}=0A=
-=0A=
-ssize_t=0A=
-transport_layer_base::read (char *buf, size_t len)=0A=
-{=0A=
-  return 0;=0A=
-}=0A=
-=0A=
-ssize_t=0A=
-transport_layer_base::write (char *buf, size_t len)=0A=
-{=0A=
-  return 0;=0A=
-}=0A=
-=0A=
-bool=0A=
-transport_layer_base::connect ()=0A=
-{=0A=
-  return false;=0A=
 }=0A=
=20=0A=
 void=0A=
Index: cygserver_transport_pipes.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/cygserver_transport_pipes.cc,v=0A=
retrieving revision 1.4=0A=
diff -u -w -u -r1.4 cygserver_transport_pipes.cc=0A=
--- cygserver_transport_pipes.cc	13 Mar 2002 02:34:04 -0000	1.4=0A=
+++ cygserver_transport_pipes.cc	10 Jun 2002 19:42:08 -0000=0A=
@@ -10,6 +10,14 @@=0A=
    Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
    details. */=0A=
=20=0A=
+/* to allow this to link into cygwin and the .dll, a little magic is neede=
d. */=0A=
+=0A=
+#ifdef __OUTSIDE_CYGWIN__=0A=
+#include "woutsup.h"=0A=
+#else=0A=
+#include "winsup.h"=0A=
+#endif=0A=
+=0A=
 #include <errno.h>=0A=
 #include <stdio.h>=0A=
 #include <unistd.h>=0A=
@@ -17,18 +25,9 @@=0A=
 #include <sys/types.h>=0A=
 #include <sys/socket.h>=0A=
 #include <netdb.h>=0A=
-#include "wincap.h"=0A=
 #include "cygwin/cygserver_transport.h"=0A=
 #include "cygwin/cygserver_transport_pipes.h"=0A=
=20=0A=
-/* to allow this to link into cygwin and the .dll, a little magic is neede=
d. */=0A=
-#ifndef __OUTSIDE_CYGWIN__=0A=
-#include "winsup.h"=0A=
-#else=0A=
-#define DEBUG 0=0A=
-#define debug_printf if (DEBUG) printf=0A=
-#endif=0A=
-=0A=
 //SECURITY_DESCRIPTOR transport_layer_pipes::sd;=0A=
 //SECURITY_ATTRIBUTES transport_layer_pipes::sec_none_nih, transport_layer=
_pipes::sec_all_nih;=0A=
 //bool transport_layer_pipes::inited =3D false;=0A=
@@ -75,7 +74,7 @@=0A=
 {=0A=
   if (pipe)=0A=
     {=0A=
-      debug_printf ("Already have a pipe in this %p\n",this);=0A=
+      system_printf ("Already have a pipe in this %p",this);=0A=
       return NULL;=0A=
     }=0A=
=20=0A=
@@ -87,14 +86,14 @@=0A=
 			  &sec_all_nih );=0A=
   if (pipe =3D=3D INVALID_HANDLE_VALUE)=0A=
     {=0A=
-      debug_printf ("error creating pipe (%lu)\n.", GetLastError ());=0A=
+      system_printf ("error creating pipe (%lu).", GetLastError ());=0A=
       return NULL;=0A=
     }=0A=
=20=0A=
   if ( !ConnectNamedPipe ( pipe, NULL ) &&=0A=
      GetLastError () !=3D ERROR_PIPE_CONNECTED)=0A=
     {=0A=
-      printf ("error connecting to pipe (%lu)\n.", GetLastError ());=0A=
+      system_printf ("error connecting to pipe (%lu).", GetLastError ());=
=0A=
       CloseHandle (pipe);=0A=
       pipe =3D NULL;=0A=
       return NULL;=0A=
@@ -109,7 +108,7 @@=0A=
 void=0A=
 transport_layer_pipes::close()=0A=
 {=0A=
-  debug_printf ("closing pipe %p\n", pipe);=0A=
+  debug_printf ("closing pipe %p", pipe);=0A=
   if (pipe && pipe !=3D INVALID_HANDLE_VALUE)=0A=
     {=0A=
       FlushFileBuffers (pipe);=0A=
@@ -121,7 +120,7 @@=0A=
 ssize_t=0A=
 transport_layer_pipes::read (char *buf, size_t len)=0A=
 {=0A=
-  debug_printf ("reading from pipe %p\n", pipe);=0A=
+  debug_printf ("reading from pipe %p", pipe);=0A=
   if (!pipe || pipe =3D=3D INVALID_HANDLE_VALUE)=0A=
     return -1;=0A=
=20=0A=
@@ -129,7 +128,7 @@=0A=
   DWORD rc =3D ReadFile (pipe, buf, len, &bytes_read, NULL);=0A=
   if (!rc)=0A=
     {=0A=
-      debug_printf ("error reading from pipe (%lu)\n", GetLastError ());=
=0A=
+      system_printf ("error reading from pipe (%lu)", GetLastError ());=0A=
       return -1;=0A=
     }=0A=
   return bytes_read;=0A=
@@ -138,7 +137,7 @@=0A=
 ssize_t=0A=
 transport_layer_pipes::write (char *buf, size_t len)=0A=
 {=0A=
-  debug_printf ("writing to pipe %p\n", pipe);=0A=
+  debug_printf ("writing to pipe %p", pipe);=0A=
   DWORD bytes_written, rc;=0A=
   if (!pipe || pipe =3D=3D INVALID_HANDLE_VALUE)=0A=
     return -1;=0A=
@@ -146,7 +145,7 @@=0A=
   rc =3D WriteFile (pipe, buf, len, &bytes_written, NULL);=0A=
   if (!rc)=0A=
     {=0A=
-      debug_printf ("error writing to pipe (%lu)\n", GetLastError ());=0A=
+      system_printf ("error writing to pipe (%lu)", GetLastError ());=0A=
       return -1;=0A=
     }=0A=
   return bytes_written;=0A=
@@ -157,7 +156,7 @@=0A=
 {=0A=
   if (pipe && pipe !=3D INVALID_HANDLE_VALUE)=0A=
     {=0A=
-      debug_printf ("Already have a pipe in this %p\n",this);=0A=
+      system_printf ("Already have a pipe in this %p",this);=0A=
       return false;=0A=
     }=0A=
=20=0A=
@@ -176,35 +175,39 @@=0A=
=20=0A=
       if (GetLastError () !=3D ERROR_PIPE_BUSY)=0A=
 	{=0A=
-	  debug_printf ("Error opening the pipe (%lu)\n", GetLastError ());=0A=
+	  debug_printf ("Error opening the pipe (%lu)", GetLastError ());=0A=
 	  pipe =3D NULL;=0A=
 	  return false;=0A=
 	}=0A=
       if (!WaitNamedPipe (pipe_name, 20000))=0A=
-	debug_printf ( "error connecting to server pipe after 20 seconds (%lu)\n"=
, GetLastError () );=0A=
+	system_printf ( "error connecting to server pipe after 20 seconds (%lu)",=
 GetLastError () );=0A=
       /* We loop here, because the pipe exists but is busy. If it doesn't =
exist=0A=
        * the !=3D ERROR_PIPE_BUSY will catch it.=0A=
        */=0A=
     }=0A=
 }=0A=
=20=0A=
+/* FIXME: Can pipe ever be invalid here? Why? */=0A=
 void=0A=
 transport_layer_pipes::impersonate_client ()=0A=
 {=0A=
-  debug_printf ("impersonating pipe %p\n", pipe);=0A=
+  debug_printf ("impersonating pipe %p", pipe);=0A=
   if (pipe && pipe !=3D INVALID_HANDLE_VALUE)=0A=
     {=0A=
       BOOL rv =3D ImpersonateNamedPipeClient (pipe);=0A=
       if (!rv)=0A=
-	debug_printf ("Failed to Impersonate the client, (%lu)\n", GetLastError (=
));=0A=
+	{=0A=
+	  system_printf ("Failed to Impersonate the client, (%lu)", GetLastError =
());=0A=
+	  return;=0A=
+	}=0A=
     }=0A=
-  debug_printf("I am who you are\n");=0A=
+  debug_printf ("I am who you are");=0A=
+  return;=0A=
 }=0A=
=20=0A=
 void=0A=
 transport_layer_pipes::revert_to_self ()=0A=
 {=0A=
   RevertToSelf ();=0A=
-  debug_printf("I am who I yam\n");=0A=
+  debug_printf ("I am who I yam");=0A=
 }=0A=
-=0A=
Index: cygserver_transport_sockets.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/cygserver_transport_sockets.cc,v=0A=
retrieving revision 1.3=0A=
diff -u -w -u -r1.3 cygserver_transport_sockets.cc=0A=
--- cygserver_transport_sockets.cc	13 Mar 2002 02:34:04 -0000	1.3=0A=
+++ cygserver_transport_sockets.cc	10 Jun 2002 19:42:08 -0000=0A=
@@ -10,20 +10,23 @@=0A=
    Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
    details. */=0A=
=20=0A=
+#ifdef __OUTSIDE_CYGWIN__=0A=
+#include "woutsup.h"=0A=
+#else=0A=
+#include "winsup.h"=0A=
+#endif=0A=
+=0A=
 #include <errno.h>=0A=
 #include <stdio.h>=0A=
 #include <unistd.h>=0A=
-#include <windows.h>=0A=
 #include <sys/types.h>=0A=
 #include <sys/socket.h>=0A=
 #include <netdb.h>=0A=
-#include "wincap.h"=0A=
 #include "cygwin/cygserver_transport.h"=0A=
 #include "cygwin/cygserver_transport_sockets.h"=0A=
=20=0A=
 /* to allow this to link into cygwin and the .dll, a little magic is neede=
d. */=0A=
 #ifndef __OUTSIDE_CYGWIN__=0A=
-#include "winsup.h"=0A=
 extern "C" int=0A=
 cygwin_socket (int af, int type, int protocol);=0A=
 extern "C" int=0A=
@@ -43,7 +46,6 @@=0A=
 #define cygwin_listen(A,B)    ::listen(A,B)=0A=
 #define cygwin_bind(A,B,C)    ::bind(A,B,C)=0A=
 #define cygwin_connect(A,B,C) ::connect(A,B,C)=0A=
-#define debug_printf printf=0A=
 #endif=0A=
=20=0A=
 transport_layer_sockets::transport_layer_sockets (int newfd): fd(newfd)=0A=
@@ -68,11 +70,11 @@=0A=
 {=0A=
   /* we want a thread pool based approach. */=0A=
   if ((fd =3D cygwin_socket (AF_UNIX, SOCK_STREAM,0)) < 0)=0A=
-    printf ("Socket not created error %d\n", errno);=0A=
+    system_printf ("Socket not created error %d", errno);=0A=
   if (cygwin_bind(fd, &sockdetails, sdlen))=0A=
-    printf ("Bind doesn't like you. Tsk Tsk. Bind said %d\n", errno);=0A=
+    system_printf ("Bind doesn't like you. Tsk Tsk. Bind said %d", errno);=
=0A=
   if (cygwin_listen(fd, 5) < 0)=0A=
-    printf ("And the OS just isn't listening, all it says is %d\n", errno)=
;=0A=
+    system_printf ("And the OS just isn't listening, all it says is %d", e=
rrno);=0A=
 }=0A=
=20=0A=
 class transport_layer_sockets *=0A=
@@ -83,7 +85,7 @@=0A=
=20=0A=
   if ((new_fd =3D cygwin_accept(fd, &sockdetails, &sdlen)) < 0)=0A=
     {=0A=
-      printf ("Nup, could' accept. %d\n",errno);=0A=
+      system_printf ("Nup, could' accept. %d",errno);=0A=
       return NULL;=0A=
     }=0A=
=20=0A=
@@ -123,7 +125,7 @@=0A=
   fd =3D cygwin_socket (AF_UNIX, SOCK_STREAM, 0);=0A=
   if (cygwin_connect (fd, &sockdetails, sdlen) < 0)=0A=
     {=0A=
-      debug_printf("client connect failure %d\n", errno);=0A=
+      debug_printf("client connect failure %d", errno);=0A=
       ::close (fd);=0A=
       return false;=0A=
     }=0A=
Index: threaded_queue.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/threaded_queue.cc,v=0A=
retrieving revision 1.4=0A=
diff -u -w -u -r1.4 threaded_queue.cc=0A=
--- threaded_queue.cc	5 Jun 2002 04:01:43 -0000	1.4=0A=
+++ threaded_queue.cc	10 Jun 2002 19:42:28 -0000=0A=
@@ -10,16 +10,15 @@=0A=
    Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
    details. */=0A=
=20=0A=
+#include "woutsup.h"=0A=
+=0A=
 #include <errno.h>=0A=
 #include <stdio.h>=0A=
 #include <unistd.h>=0A=
 #include <windows.h>=0A=
 #include <sys/types.h>=0A=
 #include <stdlib.h>=0A=
-#include "wincap.h"=0A=
 #include "threaded_queue.h"=0A=
-#define DEBUG 1=0A=
-#define debug_printf if (DEBUG) printf=0A=
=20=0A=
 /* threaded_queue */=0A=
=20=0A=
@@ -38,7 +37,7 @@=0A=
 	  DWORD rc =3D WaitForSingleObject (queue->event, INFINITE);=0A=
 	  if (rc =3D=3D WAIT_FAILED)=0A=
 	    {=0A=
-	      printf ("Wait for event failed\n");=0A=
+	      system_printf ("Wait for event failed");=0A=
 	      queue->running--;=0A=
 	      ExitThread (0);=0A=
 	    }=0A=
@@ -69,7 +68,7 @@=0A=
   InitializeCriticalSection (&queuelock);=0A=
   if ((event =3D CreateEvent (NULL, FALSE, FALSE, NULL)) =3D=3D NULL)=0A=
     {=0A=
-      printf ("Failed to create event queue (%lu), terminating\n",=0A=
+      system_printf ("Failed to create event queue (%lu), terminating",=0A=
 	      GetLastError ());=0A=
       exit (1);=0A=
     }=0A=
@@ -85,7 +84,7 @@=0A=
       hThread =3D CreateThread (NULL, 0, worker_function, this, 0, &tid);=
=0A=
       if (hThread =3D=3D NULL)=0A=
 	{=0A=
-	  printf ("Failed to create thread (%lu), terminating\n",=0A=
+	  system_printf ("Failed to create thread (%lu), terminating",=0A=
 		  GetLastError ());=0A=
 	  exit (1);=0A=
 	}=0A=
@@ -114,7 +113,7 @@=0A=
   LeaveCriticalSection (&queuelock);=0A=
   if (!running)=0A=
     return;=0A=
-  printf ("Waiting for current queue threads to terminate\n");=0A=
+  debug_printf ("Waiting for current queue threads to terminate");=0A=
   for (int n =3D running; n; n--)=0A=
     PulseEvent (event);=0A=
   while (running)=0A=
@@ -132,7 +131,7 @@=0A=
   EnterCriticalSection (&queuelock);=0A=
   if (!running)=0A=
     {=0A=
-      printf ("No worker threads to handle request!\n");=0A=
+      system_printf ("No worker threads to handle request!");=0A=
     }=0A=
   if (!request)=0A=
     request =3D therequest;=0A=
@@ -169,10 +168,10 @@=0A=
 {=0A=
   if (!interruptible)=0A=
     return;=0A=
-  debug_printf ("creating an interruptible processing thread\n");=0A=
+  debug_printf ("creating an interruptible processing thread");=0A=
   if ((interrupt =3D CreateEvent (NULL, FALSE, FALSE, NULL)) =3D=3D NULL)=
=0A=
     {=0A=
-      printf ("Failed to create interrupt event (%lu), terminating\n",=0A=
+      system_printf ("Failed to create interrupt event (%lu), terminating"=
,=0A=
 	      GetLastError ());=0A=
       exit (1);=0A=
     }=0A=
@@ -198,7 +197,7 @@=0A=
       running =3D true;=0A=
       return true;=0A=
     }=0A=
-  printf ("Failed to create thread (%lu), terminating\n", GetLastError ())=
;=0A=
+  system_printf ("Failed to create thread (%lu), terminating", GetLastErro=
r ());=0A=
   return false;=0A=
 }=0A=
=20=0A=
@@ -217,7 +216,7 @@=0A=
       while (n-- && WaitForSingleObject (hThread, 1000) =3D=3D WAIT_TIMEOU=
T);=0A=
       if (!n)=0A=
 	{=0A=
-	  printf ("Process thread didn't shutdown cleanly after 200ms!\n");=0A=
+	  system_printf ("Process thread didn't shutdown cleanly after 200ms!");=
=0A=
 	  exit (1);=0A=
 	}=0A=
       else=0A=
@@ -225,11 +224,11 @@=0A=
     }=0A=
   else=0A=
     {=0A=
-      printf ("killing request loop thread %ld\n", tid);=0A=
+      debug_printf ("killing request loop thread %ld", tid);=0A=
       int rc;=0A=
       if (!(rc =3D TerminateThread (hThread, 0)))=0A=
 	{=0A=
-	  printf ("error shutting down request loop worker thread\n");=0A=
+	  system_printf ("error shutting down request loop worker thread");=0A=
 	}=0A=
       running =3D false;=0A=
     }=0A=
@@ -244,7 +243,8 @@=0A=
 void=0A=
 queue_request::process (void)=0A=
 {=0A=
-  printf ("\n**********************************************\n"=0A=
-	  "Oh no! we've hit the base queue_request process() function, and this i=
ndicates a coding\n"=0A=
-	  "fault !!!\n" "***********************************************\n");=0A=
+  system_printf ("**********************************************");=0A=
+  system_printf ("Oh no! we've hit the base queue_request process() functi=
on");=0A=
+  system_printf ("and this indicates a coding fault !!!");=0A=
+  system_printf ("***********************************************");=0A=
 }=0A=
Index: include/cygwin/cygserver_transport.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/cygserver_transport.h,v=
=0A=
retrieving revision 1.3=0A=
diff -u -w -u -r1.3 cygserver_transport.h=0A=
--- include/cygwin/cygserver_transport.h	13 Mar 2002 02:34:05 -0000	1.3=0A=
+++ include/cygwin/cygserver_transport.h	10 Jun 2002 19:42:29 -0000=0A=
@@ -18,15 +18,14 @@=0A=
 class transport_layer_base=0A=
 {=0A=
   public:=0A=
-    virtual void listen ();=0A=
-    virtual class transport_layer_base * accept ();=0A=
-    virtual void close ();=0A=
-    virtual ssize_t read (char *buf, size_t len);=0A=
-    virtual ssize_t write (char *buf, size_t len);=0A=
-    virtual bool connect();=0A=
+    virtual void listen () =3D 0;=0A=
+    virtual class transport_layer_base * accept () =3D 0;=0A=
+    virtual void close () =3D 0;=0A=
+    virtual ssize_t read (char *buf, size_t len) =3D 0;=0A=
+    virtual ssize_t write (char *buf, size_t len) =3D 0;=0A=
+    virtual bool connect() =3D 0;=0A=
     virtual void impersonate_client ();=0A=
     virtual void revert_to_self ();=0A=
-    transport_layer_base ();=0A=
 };=0A=
=20=0A=
 #endif /* _CYGSERVER_TRANSPORT_ */=0A=

------=_NextPart_000_016D_01C210DB.61E9CDF0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 1232

2002-06-10  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* cygserver.cc: Move to "woutsup.h". Use new XXX_printf functions
	throughout.
	* cygserver_client.cc: Ditto.
	* cygserver_process.cc: Ditto.
	(process_init): Initialise with PTHREAD_ONCE_INIT.
	* cygserver_shm.cc: Move to "woutsup.h". Use new XXX_printf
	functions throughout.
	* cygserver_transport.cc: Ditto.
	(transport_layer_base::transport_layer_base): Removed (redundant).
	(transport_layer_base::listen): Now pure virtual.
	(transport_layer_base::accept): Ditto.
	(transport_layer_base::close): Ditto.
	(transport_layer_base::read): Ditto.
	(transport_layer_base::write): Ditto.
	(transport_layer_base::connect): Ditto.
	* cygserver_transport_pipes.cc: Move to "woutsup.h". Use new
	XXX_printf functions throughout.
	* cygserver_transport_sockets.cc: Ditto.
	* threaded_queue.cc: Ditto.
	* woutsup.h: New file.
	* include/cygwin/cygserver_transport.h
	(transport_layer_base::transport_layer_base): Removed (redundant).
	(transport_layer_base::listen): Now pure virtual.
	(transport_layer_base::accept): Ditto.
	(transport_layer_base::close): Ditto.
	(transport_layer_base::read): Ditto.
	(transport_layer_base::write): Ditto.
	(transport_layer_base::connect): Ditto.

------=_NextPart_000_016D_01C210DB.61E9CDF0
Content-Type: application/octet-stream;
	name="woutsup.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="woutsup.h"
Content-length: 3017

/* woutsup.h: for Cygwin code compiled outside the DLL (i.e. cygserver).=0A=
=0A=
   Copyright 2002 Red Hat, Inc.=0A=
=0A=
This file is part of Cygwin.=0A=
=0A=
This software is a copyrighted work licensed under the terms of the=0A=
Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
details. */=0A=
=0A=
#ifdef HAVE_CONFIG_H=0A=
# include "config.h"=0A=
#endif=0A=
=0A=
#ifdef __INSIDE_CYGWIN__=0A=
#error "woutsup.h is not for code being compiled inside the dll"=0A=
#endif=0A=
=0A=
#define WIN32_LEAN_AND_MEAN 1=0A=
#define _WINGDI_H=0A=
#define _WINUSER_H=0A=
#define _WINNLS_H=0A=
#define _WINVER_H=0A=
#define _WINNETWK_H=0A=
#define _WINSVC_H=0A=
#include <windows.h>=0A=
#include <wincrypt.h>=0A=
#include <lmcons.h>=0A=
#undef _WINGDI_H=0A=
#undef _WINUSER_H=0A=
#undef _WINNLS_H=0A=
#undef _WINVER_H=0A=
#undef _WINNETWK_H=0A=
#undef _WINSVC_H=0A=
=0A=
#include "wincap.h"=0A=
=0A=
/* The one function we use from winuser.h most of the time */=0A=
extern "C" DWORD WINAPI GetLastError (void);=0A=
=0A=
/* From "winsup.h". */=0A=
=0A=
#if !defined(__STDC_VERSION__) || __STDC_VERSION__ >=3D 199900L=0A=
#define NEW_MACRO_VARARGS=0A=
#endif=0A=
=0A=
/*=0A=
 * A reproduction of the api_fatal() and <sys/strace.h> macros.  This=0A=
 * allows code that runs both inside and outside the Cygwin DLL to use=0A=
 * the same macros for logging messages.=0A=
 */=0A=
=0A=
#include <stdio.h>=0A=
=0A=
#ifdef NEW_MACRO_VARARGS=0A=
=0A=
#define system_printf(...)				\=0A=
  do							\=0A=
    {							\=0A=
      fprintf (stderr, "%s: ", __PRETTY_FUNCTION__);	\=0A=
      fprintf (stderr, __VA_ARGS__);			\=0A=
      fputc ('\n', stderr);				\=0A=
    } while (false);=0A=
=0A=
#define __noop_printf(...) do {;} while (false)=0A=
=0A=
#else /* !NEW_MACRO_VARARGS */=0A=
=0A=
#define system_printf(args...)				\=0A=
  do							\=0A=
    {							\=0A=
      fprintf (stderr,  "%s: ", __PRETTY_FUNCTION__);	\=0A=
      fprintf (stderr, ## args);			\=0A=
      fputc ('\n', stderr);				\=0A=
    } while (false)=0A=
=0A=
#define __noop_printf(args...) do {;} while (false)=0A=
=0A=
#endif /* !NEW_MACRO_VARARGS */=0A=
=0A=
#define api_fatal system_printf=0A=
=0A=
#ifdef DEBUGGING=0A=
#define debug_printf system_printf=0A=
#define paranoid_printf system_printf=0A=
#define select_printf system_printf=0A=
#define sigproc_printf system_printf=0A=
#define syscall_printf system_printf=0A=
#define termios_printf system_printf=0A=
#define wm_printf system_printf=0A=
#define minimal_printf system_printf=0A=
#define malloc_printf system_printf=0A=
#define thread_printf system_printf=0A=
#else=0A=
#define debug_printf __noop_printf=0A=
#define paranoid_printf __noop_printf=0A=
#define select_printf __noop_printf=0A=
#define sigproc_printf __noop_printf=0A=
#define syscall_printf __noop_printf=0A=
#define termios_printf __noop_printf=0A=
#define wm_printf __noop_printf=0A=
#define minimal_printf __noop_printf=0A=
#define malloc_printf __noop_printf=0A=
#define thread_printf __noop_printf=0A=
#endif=0A=

------=_NextPart_000_016D_01C210DB.61E9CDF0
Content-Type: application/octet-stream;
	name="incremental.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="incremental.patch"
Content-length: 1002

--- cygserver_transport_sockets.cc	2002-06-10 23:55:44.000000000 +0100=0A=
+++ /pack/src/cygwin/HEAD.src/winsup/cygwin/cygserver_transport_sockets.cc	=
2002-06-10 23:51:32.000000000 +0100=0A=
@@ -125,7 +125,7 @@=0A=
   fd =3D cygwin_socket (AF_UNIX, SOCK_STREAM, 0);=0A=
   if (cygwin_connect (fd, &sockdetails, sdlen) < 0)=0A=
     {=0A=
-      system_printf("client connect failure %d", errno);=0A=
+      debug_printf("client connect failure %d", errno);=0A=
       ::close (fd);=0A=
       return false;=0A=
     }=0A=
--- cygserver_transport_pipes.cc	2002-06-10 23:55:31.000000000 +0100=0A=
+++ /pack/src/cygwin/HEAD.src/winsup/cygwin/cygserver_transport_pipes.cc	20=
02-06-10 23:51:32.000000000 +0100=0A=
@@ -175,7 +175,7 @@=0A=
=20=0A=
       if (GetLastError () !=3D ERROR_PIPE_BUSY)=0A=
 	{=0A=
-	  system_printf ("Error opening the pipe (%lu)", GetLastError ());=0A=
+	  debug_printf ("Error opening the pipe (%lu)", GetLastError ());=0A=
 	  pipe =3D NULL;=0A=
 	  return false;=0A=
 	}=0A=

------=_NextPart_000_016D_01C210DB.61E9CDF0--


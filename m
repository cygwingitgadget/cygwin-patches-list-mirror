Return-Path: <cygwin-patches-return-4916-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28199 invoked by alias); 28 Aug 2004 01:47:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28153 invoked from network); 28 Aug 2004 01:46:59 -0000
Message-Id: <3.0.5.32.20040827214238.00819640@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 28 Aug 2004 01:47:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Truncate
In-Reply-To: <20040823110043.GW27978@cygbert.vinschen.de>
References: <3.0.5.32.20040822170941.007c2c90@incoming.verizon.net>
 <3.0.5.32.20040821183627.008186a0@incoming.verizon.net>
 <3.0.5.32.20040821183627.008186a0@incoming.verizon.net>
 <3.0.5.32.20040822170941.007c2c90@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00068.txt.bz2

At 01:00 PM 8/23/2004 +0200, Corinna Vinschen wrote:
>Except for this comment, which isn't valid (see above), please check it in.

Done. But here is another simple patch taking care of your concern that
we can fail while zero filling, leaving the file system filled to capacity.

2004-08-28  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler.cc (fhandler_base::write): In the lseek_bug case, set EOF
	before zero filling. Combine similar error handling statements. 


Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.203
diff -u -p -r1.203 fhandler.cc
--- fhandler.cc 19 Aug 2004 15:47:51 -0000      1.203
+++ fhandler.cc 28 Aug 2004 01:37:53 -0000
@@ -815,11 +815,17 @@ fhandler_base::write (const void *ptr, s
                 back and fill in the gap with zeros. - DJ
                 Note: this bug doesn't happen on NT4, even though the
                 documentation for WriteFile() says that it *may* happen
-                on any OS. */
+                on any OS. */ 
+             /* Check there is enough space */
+             if (!SetEndOfFile (get_output_handle ()))
+               {
+                 __seterrno ();
+                 return -1;
+               }
              char zeros[512];
              int number_of_zeros_to_write = current_position - actual_length;
              memset (zeros, 0, 512);
-             SetFilePointer (get_output_handle (), 0, NULL, FILE_END);
+             SetFilePointer (get_output_handle (), actual_length, NULL,
FILE_BEGIN);
              while (number_of_zeros_to_write > 0)
                {
                  DWORD zeros_this_time = (number_of_zeros_to_write > 512
@@ -831,6 +837,7 @@ fhandler_base::write (const void *ptr, s
                      __seterrno ();
                      if (get_errno () == EPIPE)
                        raise (SIGPIPE);
+                   err:
                      /* This might fail, but it's the best we can hope for */
                      SetFilePointer (get_output_handle (),
current_position, NULL,
                                      FILE_BEGIN);
@@ -840,10 +847,7 @@ fhandler_base::write (const void *ptr, s
                  if (written < zeros_this_time) /* just in case */
                    {
                      set_errno (ENOSPC);
-                     /* This might fail, but it's the best we can hope for */
-                     SetFilePointer (get_output_handle (),
current_position, NULL,
-                                     FILE_BEGIN);
-                     return -1;
+                     goto err;
                    }
                  number_of_zeros_to_write -= written;
                }

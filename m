Return-Path: <cygwin-patches-return-4917-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20465 invoked by alias); 28 Aug 2004 09:37:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20448 invoked from network); 28 Aug 2004 09:37:19 -0000
Date: Sat, 28 Aug 2004 09:37:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Truncate
Message-ID: <20040828093751.GW27978@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040822170941.007c2c90@incoming.verizon.net> <3.0.5.32.20040821183627.008186a0@incoming.verizon.net> <3.0.5.32.20040821183627.008186a0@incoming.verizon.net> <3.0.5.32.20040822170941.007c2c90@incoming.verizon.net> <3.0.5.32.20040827214238.00819640@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040827214238.00819640@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00069.txt.bz2

Hi Pierre,

On Aug 27 21:42, Pierre A. Humblet wrote:
> At 01:00 PM 8/23/2004 +0200, Corinna Vinschen wrote:
> >Except for this comment, which isn't valid (see above), please check it in.
> 
> Done. But here is another simple patch taking care of your concern that
> we can fail while zero filling, leaving the file system filled to capacity.
> 
> 2004-08-28  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* fhandler.cc (fhandler_base::write): In the lseek_bug case, set EOF
> 	before zero filling. Combine similar error handling statements. 

the first part of the patch is ok, but somehow the new `goto' looks
somewhat weird to me.  What about this instead:

Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.203
diff -u -p -r1.203 fhandler.cc
--- fhandler.cc	19 Aug 2004 15:47:51 -0000	1.203
+++ fhandler.cc	28 Aug 2004 09:36:04 -0000
@@ -825,26 +825,24 @@ fhandler_base::write (const void *ptr, s
 		  DWORD zeros_this_time = (number_of_zeros_to_write > 512
 					 ? 512 : number_of_zeros_to_write);
 		  DWORD written;
-		  if (!WriteFile (get_output_handle (), zeros, zeros_this_time,
-				  &written, NULL))
+		  DWORD ret = WriteFile (get_output_handle (), zeros,
+					 zeros_this_time, &written, NULL);
+		  if (!ret || written < zeros_this_time)
 		    {
-		      __seterrno ();
-		      if (get_errno () == EPIPE)
-			raise (SIGPIPE);
+		      if (!ret)
+		        {
+			  __seterrno ();
+			  if (get_errno () == EPIPE)
+			    raise (SIGPIPE);
+			}
+		      else
+			set_errno (ENOSPC);
 		      /* This might fail, but it's the best we can hope for */
 		      SetFilePointer (get_output_handle (), current_position, NULL,
 				      FILE_BEGIN);
 		      return -1;
 
 		    }
-		  if (written < zeros_this_time) /* just in case */
-		    {
-		      set_errno (ENOSPC);
-		      /* This might fail, but it's the best we can hope for */
-		      SetFilePointer (get_output_handle (), current_position, NULL,
-				      FILE_BEGIN);
-		      return -1;
-		    }
 		  number_of_zeros_to_write -= written;
 		}
 	    }

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.

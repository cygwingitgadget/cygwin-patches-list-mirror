Return-Path: <cygwin-patches-return-5087-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13141 invoked by alias); 27 Oct 2004 14:56:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13112 invoked from network); 27 Oct 2004 14:56:16 -0000
Date: Wed, 27 Oct 2004 14:56:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: sync(3)
Message-ID: <20041027145621.GJ24504@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <417F09A1.4090003@x-ray.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417F09A1.4090003@x-ray.at>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00088.txt.bz2

On Wed, Oct 27, 2004 at 04:36:17AM +0200, Reini Urban wrote:
>Why is this a bad idea?

It's a very limited implementation of what sync is supposed to do but
maybe it's better than nothing.

A slightly more robust method would be to implement an internal cygwin
signal which could be sent to every cygwin process telling it to run
code like the below.

Of course, that isn't foolproof either since it doesn't affect
non-cygwin processes.

Do you have an assignment with Red Hat?  If so, I'll check this in.

cgf

>2004-10-27  Reini Urban  <rurban@x-ray.at>
>
>	* syscalls.cc (sync): Implement it via cygheap->fdtab and 
>	FlushFileBuffers. Better than a noop.
>
>Index: syscalls.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
>retrieving revision 1.345
>diff -u -b -r1.345 syscalls.cc
>--- syscalls.cc	3 Sep 2004 01:53:12 -0000	1.345
>+++ syscalls.cc	27 Oct 2004 02:30:01 -0000
>@@ -1082,6 +1082,24 @@
> extern "C" void
> sync ()
> {
>+  int err = 0;
>+  cygheap->fdtab.lock ();
>+
>+  fhandler_base *fh;
>+  for (int i = 0; i < (int) cygheap->fdtab.size; i++)
>+    if ((fh = cygheap->fdtab[i]) != NULL)
>+      {
>+#ifdef DEBUGGING
>+	debug_printf ("syncing fd %d", i);
>+#endif
>+	if (FlushFileBuffers (fh->get_handle ()) == 0)
>+	  {
>+	    __seterrno ();
>+	    err++;
>+	  }
>+      }
>+  cygheap->fdtab.unlock ();
>+  return err ? 1 : 0;
> }
> 
> /* Cygwin internal */

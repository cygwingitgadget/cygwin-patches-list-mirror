Return-Path: <cygwin-patches-return-5088-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26800 invoked by alias); 27 Oct 2004 15:32:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26770 invoked from network); 27 Oct 2004 15:32:57 -0000
Message-ID: <417FBFA3.5040605@x-ray.at>
Date: Wed, 27 Oct 2004 15:32:00 -0000
From: Reini Urban <rurban@x-ray.at>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8a3) Gecko/20040817
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: sync(3)
References: <417F09A1.4090003@x-ray.at> <20041027145621.GJ24504@trixie.casa.cgf.cx>
In-Reply-To: <20041027145621.GJ24504@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00089.txt.bz2

Christopher Faylor schrieb:
> On Wed, Oct 27, 2004 at 04:36:17AM +0200, Reini Urban wrote:
> 
>>Why is this a bad idea?
> 
> It's a very limited implementation of what sync is supposed to do but
> maybe it's better than nothing.
> 
> A slightly more robust method would be to implement an internal cygwin
> signal which could be sent to every cygwin process telling it to run
> code like the below.

A signal looks better.
Maybe just to its master process, and all its subprocesses and threads?
I didn't check what fd's are actually stored in this heap.

On linux it should just ensure to flush the master inode block.
(makes sense for ext2 probably).
For NTFS Volumes this code would be okay as I read at MSDN.
Wonder what FAT will do. postgresql luckily uses fsync().
Maybe I should check which of our apps actually use sync(3).
exim out of my head.

> Of course, that isn't foolproof either since it doesn't affect
> non-cygwin processes.

Warning: I didn't test it. Maybe it would be better if someone else 
would copy-paste it from close_all_files() as I did and test it.
I just had no guts yet to build my own dll.

> Do you have an assignment with Red Hat?  If so, I'll check this in.

Not yet, but I'll send a letter this week.

>>2004-10-27  Reini Urban  <rurban@x-ray.at>
>>
>>	* syscalls.cc (sync): Implement it via cygheap->fdtab and 
>>	FlushFileBuffers. Better than a noop.
>>
>>Index: syscalls.cc
>>===================================================================
>>RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
>>retrieving revision 1.345
>>diff -u -b -r1.345 syscalls.cc
>>--- syscalls.cc	3 Sep 2004 01:53:12 -0000	1.345
>>+++ syscalls.cc	27 Oct 2004 02:30:01 -0000
>>@@ -1082,6 +1082,24 @@
>>extern "C" void
>>sync ()
>>{
>>+  int err = 0;
>>+  cygheap->fdtab.lock ();
>>+
>>+  fhandler_base *fh;
>>+  for (int i = 0; i < (int) cygheap->fdtab.size; i++)
>>+    if ((fh = cygheap->fdtab[i]) != NULL)
>>+      {
>>+#ifdef DEBUGGING
>>+	debug_printf ("syncing fd %d", i);
>>+#endif
>>+	if (FlushFileBuffers (fh->get_handle ()) == 0)
>>+	  {
>>+	    __seterrno ();
>>+	    err++;
>>+	  }
>>+      }
>>+  cygheap->fdtab.unlock ();
>>+  return err ? 1 : 0;
>>}
>>
>>/* Cygwin internal */
-- 
Reini Urban
http://xarch.tu-graz.ac.at/home/rurban/

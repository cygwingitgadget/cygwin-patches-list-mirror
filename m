Return-Path: <cygwin-patches-return-5195-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32149 invoked by alias); 13 Dec 2004 18:19:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32023 invoked from network); 13 Dec 2004 18:19:19 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.119.182)
  by sourceware.org with SMTP; 13 Dec 2004 18:19:19 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id C6CE357E53; Mon, 13 Dec 2004 19:21:27 +0100 (CET)
Date: Mon, 13 Dec 2004 18:19:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [Fwd: [que_andrewBOOHyahoo.com: FOLLOWUP: 1.5.12: problems without registry keys]]
Message-ID: <20041213182127.GB22056@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00196.txt.bz2

Pierre,

I think I tracked the problem down, reported in

  http://cygwin.com/ml/cygwin/2004-12/msg00236.html
  
I'm asking you since you were the one introducing cwdstuff->get_drive().

I found that the problem was raised by just using threads, nothing to do
with Semaphores, and only if a thread accesses cwdstuff one way or the
other.  A simple example for the hang is a thread which immediately calls
getcwd().

AFAICS there's a muto release missing in cwdstuff->get_drive().  This patch
solves Andrew's problem:

Index: cygheap.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygheap.h,v
retrieving revision 1.93
diff -p -u -r1.93 cygheap.h
--- cygheap.h   26 Nov 2004 04:15:06 -0000      1.93
+++ cygheap.h   13 Dec 2004 18:02:45 -0000
@@ -235,6 +235,7 @@ struct cwdstuff
   {
     get_initial (); 
     memcpy (dst, win32, drive_length); 
+    cwd_lock->release ();
     return drive_length;
   }
   void init ();

Is that ok to apply or is there any good reason not to release the muto
when get_drive() has finished?  I can't see any, FWIW.


Corinna


> ----- Forwarded message from Andrew Que -----
> From: Andrew Que 
> To: cygwin
> Subject: FOLLOWUP: 1.5.12: problems without registry keys
> Date: Wed, 8 Dec 2004 11:10:03 -0800 (PST)
> 
>    I apologise ahead of time, I could not for the life
> of me figure out how to send a reply to a thread.  The
> original thread is 101373: "1.5.12: problems without
> registry keys"
>   In my original post, I noted not all apps crashed
> without the registry key.  So, I tried to narrow it
> down.  It looks like apps. that use semaphores lock up
> every time.
> 
> I attached an example of an app that will lock up
> without the registry keys present.
> 
> To compile:
>   gcc Semaphore.cpp -o Semaphore.exe
> 
> (PS. The example is just a semaphore coalition test--
> and it's terrible code)

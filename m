Return-Path: <cygwin-patches-return-2541-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8743 invoked by alias); 29 Jun 2002 16:25:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8726 invoked from network); 29 Jun 2002 16:25:14 -0000
Date: Sat, 29 Jun 2002 10:33:00 -0000
From: David Euresti <davie@MIT.EDU>
X-X-Sender:  <davie@this>
To: <cygwin-patches@cygwin.com>
Subject: Re: Patch to pass file descriptors 
Message-ID: <Pine.LNX.4.33.0206291214370.4768-100000@this>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q2/txt/msg00524.txt.bz2

So here are three reasons to use the cygserver to pass file descriptors.

#1 Security - as has been mentioned.  Althought currently the patch has no 
security it can easily be added.

#2 My application is not allowed to block on anything.  I 
can't send a file descriptor and then block this changes the whole 
semantics of sendmsg.  I call select and it tells me I can write but then 
my call to sendmsg blocks?  That is really bad.  

As an example of this problem look at the test application I sent.  The
two processes both send a descriptor first, then try to read it.  This
would cause the two processes to block while the other waits.

#3 The cygserver provides temporary storage for the handle.  The sender
can close the handle after it sends it, and the handle is still happy.  
In Unix the file descriptor is stored in the kernel when this happens so 
there's no problem in unix to close the handle.  I thought the cygserver 
was supposed to provide a pseudo kernel, and that's exactly what I'm using 
it for.

Basically I think this has to be done with the cygserver, or we'll lose 
the semantics.

David


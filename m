Return-Path: <cygwin-patches-return-6873-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23018 invoked by alias); 16 Dec 2009 16:09:07 -0000
Received: (qmail 23007 invoked by uid 22791); 16 Dec 2009 16:09:05 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-77.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.77)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 16 Dec 2009 16:09:00 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 153303B0002 	for <cygwin-patches@cygwin.com>; Wed, 16 Dec 2009 11:08:51 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 11C842B352; Wed, 16 Dec 2009 11:08:51 -0500 (EST)
Date: Wed, 16 Dec 2009 16:09:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch: sleep/nanosleep bug
Message-ID: <20091216160851.GB31219@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B045581.4040301@byu.net>  <20091118204709.GA3461@ednor.casa.cgf.cx>  <4B06A48C.5050904@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B06A48C.5050904@byu.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00204.txt.bz2

On Fri, Nov 20, 2009 at 07:15:40AM -0700, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>According to Christopher Faylor on 11/18/2009 1:47 PM:
>> On Wed, Nov 18, 2009 at 01:13:53PM -0700, Eric Blake wrote:
>>> 2009-11-18  Eric Blake  <ebb9@byu.net>
>>>
>>> 	* signal.cc (nanosleep): Support 'infinite' sleep times.
>>> 	(sleep): Avoid uninitialized memory.
>> 
>> Sorry but, while I agree with the basic idea, this seems like
>> unnecessary use of recursion.  It seems like you could accomplish the
>> same thing by just putting the cancelable_wait in a for loop.  I think
>> adding recursion here obfuscates the function unnecesarily.
>
>How about the following, then?  Same changelog.

It wonder if your while (!done) loop could be expressed as a for loop but
it isn't enough of an issue to block inclusion of this patch.

So, thanks for the patch and please check in.  This will then go into 1.7.2.

cgf

>+
>+  while (!done)
>     {
>-      _my_tls.call_signal_handler ();
>-      set_errno (EINTR);
>-      res = -1;
>+      /* Divide user's input into transactions no larger than 49.7
>+         days at a time.  */
>+      if (sec > HIRES_DELAY_MAX)
>+        {
>+          req = ((HIRES_DELAY_MAX * 1000 + resolution - 1)
>+                 / resolution * resolution);
>+          sec -= HIRES_DELAY_MAX;
>+        }
>+      else
>+        {
>+          req = ((sec * 1000 + (rqtp->tv_nsec + 999999) / 1000000
>+                  + resolution - 1) / resolution) * resolution;
>+          sec = 0;
>+          done = true;
>+        }
>+

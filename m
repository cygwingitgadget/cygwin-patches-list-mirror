Return-Path: <cygwin-patches-return-2715-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21880 invoked by alias); 25 Jul 2002 15:51:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21862 invoked from network); 25 Jul 2002 15:51:04 -0000
Date: Thu, 25 Jul 2002 08:51:00 -0000
From: David MacMahon <cygwin@smartsc.com>
To: cygwin-patches@cygwin.com
Subject: Re: time(time_t*) problem
Message-ID: <20020725090142.A1935@SmartSC.com>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020724053334.GA2665@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00163.txt.bz2

On Wed, Jul 24, 2002 at 01:33:34AM -0400, Christopher Faylor wrote:
> On Tue, Jul 23, 2002 at 10:34:02PM -0700, David MacMahon wrote:
> >(sorry, I didn't do a Changelog >entry).
> 
> Why?

I was a little bit rushed (OK, lazy) at the time.  Below is a better
submission.  Do you prefer these to be inline (as below) or as
attachments (or both)?

Dave


2002-07-24  David MacMahon  <davidm@smartsc.com>

	* times.cc (to_time_t): Always round time_t down to nearest second.


Index: src/winsup/cygwin/times.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v
retrieving revision 1.38
diff -u -r1.38 times.cc
--- src/winsup/cygwin/times.cc	8 Jun 2002 01:24:58 -0000	1.38
+++ src/winsup/cygwin/times.cc	25 Jul 2002 00:09:08 -0000
@@ -212,7 +212,6 @@
      stuffed into two long words.
      A time_t is the number of seconds since jan 1 1970.  */
 
-  long rem;
   long long x = ((long long) ptr->dwHighDateTime << 32) + ((unsigned)ptr->dwLowDateTime);
 
   /* pass "no time" as epoch */
@@ -220,10 +219,7 @@
     return 0;
 
   x -= FACTOR;			/* number of 100ns between 1601 and 1970 */
-  rem = x % ((long long)NSPERSEC);
-  rem += (NSPERSEC / 2);
   x /= (long long) NSPERSEC;		/* number of 100ns in a second */
-  x += (long long) (rem / NSPERSEC);
   return x;
 }
 
-- 
David MacMahon, President
Smart Software Consulting
http://www.smartsc.com

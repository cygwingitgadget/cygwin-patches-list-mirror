Return-Path: <cygwin-patches-return-2007-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7762 invoked by alias); 26 Mar 2002 16:01:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7726 invoked from network); 26 Mar 2002 16:01:57 -0000
Date: Tue, 26 Mar 2002 08:14:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: Defining _POSIX_SEMAPHORES for cygwin
In-reply-to: <20020325225502.GA25903@redhat.com>
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20020326160710.GC1064@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_1Jsm7OR7WMhMQ8qLDtUmKg)"
User-Agent: Mutt/1.3.24i
References:
 <FC169E059D1A0442A04C40F86D9BA76008AB97@itdomain003.itdomain.net.au>
 <GBEGLOMMCLDACBPKDIHFOEJGCHAA.gsw@agere.com>
 <20020325225502.GA25903@redhat.com>
X-SW-Source: 2002-q1/txt/msg00364.txt.bz2


--Boundary_(ID_1Jsm7OR7WMhMQ8qLDtUmKg)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 779

On Mon, Mar 25, 2002 at 05:55:02PM -0500, Christopher Faylor wrote:
> Please discuss this in cygwin-patches.
> 
> On Mon, Mar 25, 2002 at 05:38:57PM -0500, Gerald S. Williams wrote:
> >I have a patch from Jason, which I planned to post to
> >the patches list, although I haven't done one yet, so
> >I'll probably mess something up. :-)
> >
> >It's a one-liner. I attached the patch here in case
> >you're interested. Is this the right format? It's
> >pretty straightforward, although I haven't really
> >had a chance to test it yet. I am insanely busy
> >right now.

I have tried the attached patch and threaded Cygwin Python builds with
semaphore support instead of conditional variables.  Is the consensus
that this patch should be submitted to the newlib list?

Thanks,
Jason

--Boundary_(ID_1Jsm7OR7WMhMQ8qLDtUmKg)
Content-type: message/rfc822
Content-length: 3686

Received: from internal by lmg.ahnet.net with cust_req_fwding id
 <295342-31167>; Mon, 25 Mar 2002 14:39:47 -0800
Received: from alageremail1.agere.com ([192.19.192.106])
 by lmg.ahnet.net with ESMTP id <308716-31173>; Mon, 25 Mar 2002 14:39:28 -0800
Received: from alerelay.agere.com (alerelay.agere.com [135.14.2.184])
	by alageremail1.agere.com (8.10.2+Sun/8.10.2) with ESMTP id g2PMb7t15634; Mon,
 25 Mar 2002 17:37:07 -0500 (EST)
Received: from almail.agere.com by alerelay.agere.com (8.9.3+Sun/EMS-1.5 sol2)
	id RAA16740 for ; Mon, 25 Mar 2002 17:39:15 -0500 (EST)
Received: from PAI820G1006951 by almail.agere.com (8.9.3+Sun/EMS-1.5 sol2)
	id RAA26534; Mon, 25 Mar 2002 17:39:11 -0500 (EST)
Date: Mon, 25 Mar 2002 17:38:57 -0500
From: "Gerald S. Williams" <gsw@agere.com>
Subject: RE: Defining _POSIX_SEMAPHORES for cygwin
In-reply-to:
 <FC169E059D1A0442A04C40F86D9BA76008AB97@itdomain003.itdomain.net.au>
To: Robert Collins <robert.collins@itdomain.com.au>
Cc: cgf@redhat.com, Jason Tishler <jason@tishler.net>, nhv@cape.com
Message-id: <GBEGLOMMCLDACBPKDIHFOEJGCHAA.gsw@agere.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Content-type: multipart/mixed; boundary="Boundary_(ID_XhDDKZbamKErVcG0H4mNxQ)"
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal

This is a multi-part message in MIME format.

--Boundary_(ID_XhDDKZbamKErVcG0H4mNxQ)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-length: 1097

How do you think this all got started? :-)

I have a patch from Jason, which I planned to post to
the patches list, although I haven't done one yet, so
I'll probably mess something up. :-)

It's a one-liner. I attached the patch here in case
you're interested. Is this the right format? It's
pretty straightforward, although I haven't really
had a chance to test it yet. I am insanely busy
right now.

BTW, I've done some investigation into the threading
issue, and it definitely seems to be related to that
race condition in Condition Variables, but I think
you knew that already.

-Jerry

-O Gerald S. Williams, 22Y-103GA : mailto:gsw@agere.com O-
-O AGERE SYSTEMS, 555 UNION BLVD : office:610-712-8661  O-
-O ALLENTOWN, PA, USA 18109-3286 : mobile:908-672-7592  O-

Rob Collins wrote:
> So yes, patches gratefully received. Please have a chat to Jason Tishler
> as well though, as he has a recurring problem with threaded pythons,
> that have prevented us having such a package for ages, and I've not been
> able to fix the bug (well I haven't actually had time to look at it
> since January).

--Boundary_(ID_XhDDKZbamKErVcG0H4mNxQ)
Content-type: application/octet-stream; name=ChangeLog
Content-transfer-encoding: 7bit
Content-disposition: attachment; filename=ChangeLog
Content-length: 97

2002-03-25  Gerald Williams <gsw@agere.com>

	* features.h: Add definition of _POSIX_SEMAPHORES.

--Boundary_(ID_XhDDKZbamKErVcG0H4mNxQ)
Content-type: application/octet-stream; name=features.h-patch
Content-transfer-encoding: 7bit
Content-disposition: attachment; filename=features.h-patch
Content-length: 541

Index: features.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/sys/features.h,v
retrieving revision 1.3
diff -u -p -r1.3 features.h
--- features.h	2001/04/12 00:05:57	1.3
+++ features.h	2002/03/25 22:28:21
@@ -86,6 +86,7 @@ extern "C" {
 # define _POSIX_THREAD_SAFE_FUNCTIONS            1
 # define _POSIX_THREAD_PRIORITY_SCHEDULING       1
 # define _POSIX_THREAD_ATTR_STACKSIZE            1
+# define _POSIX_SEMAPHORES                       1
 #endif
 
 #ifdef __cplusplus

--Boundary_(ID_XhDDKZbamKErVcG0H4mNxQ)--

--Boundary_(ID_1Jsm7OR7WMhMQ8qLDtUmKg)--

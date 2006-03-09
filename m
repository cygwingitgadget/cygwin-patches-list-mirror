Return-Path: <cygwin-patches-return-5806-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8944 invoked by alias); 9 Mar 2006 15:30:11 -0000
Received: (qmail 8927 invoked by uid 22791); 9 Mar 2006 15:30:10 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 09 Mar 2006 15:30:04 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 9B08F13C438; Thu,  9 Mar 2006 10:30:01 -0500 (EST)
Date: Thu, 09 Mar 2006 15:30:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: Patch for silent crash with Cygwin1.dll v 1.5.19-4
Message-ID: <20060309153001.GI3979@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <440CAE88.13DA9205@dessent.net> <20060309150423.15026.qmail@web53006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309150423.15026.qmail@web53006.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00115.txt.bz2

On Thu, Mar 09, 2006 at 07:04:23AM -0800, Gary Zablackis wrote:
>--- Brian Dessent <brian@dessent.net> wrote:
>>If you are trying to track down why you get a SIGSEGV in
>>pthread_key_create while running your app in gdb you are wasting your
>>time.  This is not a fault, it is expected and normal.  Search the
>>archives.
>
>In this case, the fault is NOT normal: instead of returning to
>pthread_key_create(), verifyably_object_isvalid() crashes.

We've moved out of the realm of a "patch" here.  Please use the main
cygwin list to report and diagnose problems.

cgf

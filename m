Return-Path: <cygwin-patches-return-6650-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15732 invoked by alias); 26 Sep 2009 14:58:05 -0000
Received: (qmail 15716 invoked by uid 22791); 26 Sep 2009 14:58:03 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-151.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.151)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 26 Sep 2009 14:57:58 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id E24BB13C0C4 	for <cygwin-patches@cygwin.com>; Sat, 26 Sep 2009 10:57:48 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 8FBB12B352; Sat, 26 Sep 2009 10:57:48 -0400 (EDT)
Date: Sat, 26 Sep 2009 14:58:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] rename/renameat error
Message-ID: <20090926145748.GA8697@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20090909T183010-83@post.gmane.org>  <loom.20090922T225033-801@post.gmane.org>  <4ABA1B92.9080406@byu.net>  <20090923133015.GA16976@calimero.vinschen.de>  <20090923140905.GA2527@ednor.casa.cgf.cx>  <20090923160846.GA18954@calimero.vinschen.de>  <20090923164127.GB3172@ednor.casa.cgf.cx>  <4ABC39A1.1060702@byu.net>  <20090925151114.GA23857@ednor.casa.cgf.cx>  <4ABD5A4A.9060603@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ABD5A4A.9060603@byu.net>
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
X-SW-Source: 2009-q3/txt/msg00104.txt.bz2

On Fri, Sep 25, 2009 at 06:03:22PM -0600, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>According to Christopher Faylor on 9/25/2009 9:11 AM:
>>> >+  /* POSIX says mkdir("symlink-to-missing/") should create the
>>> >+     directory "missing", but Linux rejects it with EEXIST.  Copy
>>> >+     Linux behavior for now.  */
>>> >+
>>> >+  dlen = strlen (dir);
>>> >+  if (isdirsep (dir[dlen - 1]))
>> 
>> Couldn't this index negatively if dir is zero length?
>
>Yep, and so could rename, where this was copied from.  Fixed in the respin
>below.
>
>> 
>>> >+    {
>>> >+      stpcpy (newbuf = tp.c_get (), dir);
>> 
>>Since stpcpy returns a pointer to the end of the buffer couldn't we use
>>that and do pointer arithmetic rather than index arithmetic?
>
>Theoretically, a good compiler can do just as well with either.

But a good compiler is not going to infer that stpcpy is returning
something that you're essentially calculating in the next line.

>But how does it look now?

It looks good.  Thanks.  Please check in.

cgf

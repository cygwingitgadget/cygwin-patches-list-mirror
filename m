Return-Path: <cygwin-patches-return-6043-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26197 invoked by alias); 19 Mar 2007 10:59:24 -0000
Received: (qmail 26183 invoked by uid 22791); 19 Mar 2007 10:59:23 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-87.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.87)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 19 Mar 2007 10:59:19 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 324BD13C01F; Mon, 19 Mar 2007 06:59:17 -0400 (EDT)
Date: Mon, 19 Mar 2007 10:59:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] getmntent()->mnt_type values that match Linux...
Message-ID: <20070319105917.GA24984@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <45FE2DF8.40709@icculus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45FE2DF8.40709@icculus.org>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00024.txt.bz2

On Mon, Mar 19, 2007 at 02:30:16AM -0400, Ryan C. Gordon wrote:
>
>There was a discussion quite some time ago about getmntent()'s mnt_type 
>field:
>
>   http://www.cygwin.com/ml/cygwin-developers/2002-09/msg00078.html
>
>...but nothing seems to have come of it. I noticed that Cygwin builds of 
>PhysicsFS (http://icculus.org/physfs/) don't detect CD-ROM drives since 
>mnt_type is always "system" or "user" ... this patch changes this to 
>make an earnest effort to match what a GNU/Linux system would report, 
>and moves the system/user string to mnt_opts.
>
>Without some solution like this, code external to Cygwin would have to 
>take heroic measures (#ifdefs and calls into the Win32 API) to figure 
>out what type of filesystem /cygdrive/f really is.
>
>After patching, here's the output from "mount" for a hard drive with two 
>NTFS partitions (C: and D:), a CD-ROM drive (E:), a FAT memory stick 
>(F:), and a Samba share (Z:) ...
>
>$ mount
>C:\cygwin\bin on /usr/bin type ntfs (binmode,system)
>C:\cygwin\lib on /usr/lib type ntfs (binmode,system)
>C:\cygwin on / type ntfs (binmode,system)
>c: on /cygdrive/c type ntfs (binmode,noumount,system)
>d: on /cygdrive/d type ntfs (binmode,noumount,system)
>e: on /cygdrive/e type iso9660 (binmode,noumount,system)
>f: on /cygdrive/f type vfat (binmode,noumount,system)
>z: on /cygdrive/z type smbfs (binmode,noumount,system)
>
>
>I haven't noticed any side effects of this patch, but my testing of the 
>Cygwin system as a whole is fairly limited. Comments welcome.
>
>Patch is against latest CVS.

Unfortunately a patch of this size, which changes functionality will
require an assignment as discussed at http://cygwin.com/contrib.html .

Thanks for the patch and I hope you will be able/willing to send in
an assignment to Red Hat.

cgf

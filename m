Return-Path: <cygwin-patches-return-6363-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6499 invoked by alias); 28 Nov 2008 02:17:14 -0000
Received: (qmail 6480 invoked by uid 22791); 28 Nov 2008 02:17:13 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-71-97.bstnma.fios.verizon.net (HELO cgf.cx) (96.233.71.97)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 28 Nov 2008 02:16:04 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 92A2D13C026 	for <cygwin-patches@cygwin.com>; Thu, 27 Nov 2008 21:15:54 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 881305D7C09; Thu, 27 Nov 2008 21:15:54 -0500 (EST)
Date: Fri, 28 Nov 2008 02:17:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Add dirent.d_type support to  Cygwin 1.7 ?
Message-ID: <20081128021554.GF16768@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <492DBE7E.7020100@t-online.de> <20081126221012.GA15970@ednor.casa.cgf.cx> <492DD7D0.6050001@t-online.de> <20081127093023.GA9487@calimero.vinschen.de> <1L5eGn-03rme80@fwd09.aul.t-online.de> <20081127111502.GF30831@calimero.vinschen.de> <492F1424.5000004@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492F1424.5000004@t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00007.txt.bz2

On Thu, Nov 27, 2008 at 10:41:56PM +0100, Christian Franke wrote:
> Corinna Vinschen wrote:
>> The logic sounds ok to me.  I just don't think we need a warning and the 
>> condition could be simplified accordingly.
>>
>>   
>
> New patch below. Conditionals removed as suggested by cgf.
>
> Define of _DIRENT_HAVE_D_TYPE still there - google code search finds 
> several projects using this instead of a ./configure check.
>
>
> 2008-11-27  Christian Franke  <franke@computer.org>
>
> 	* dir.cc (readdir_worker): Initialize dirent.d_type and __d_unused1.
> 	* fhandler_disk_file.cc (fhandler_disk_file::readdir_helper):
> 	Set dirent.d_type based on FILE_ATTRIBUTE_*.
> 	* include/sys/dirent.h: Define _DIRENT_HAVE_D_TYPE.
> 	(struct dirent): Add d_type. Adjust __d_unused1 size to preserve layout.
> 	[_DIRENT_HAVE_D_TYPE]: Enable DT_* declarations.

If Corinna's ok with this then so am I.

cgf

Return-Path: <cygwin-patches-return-7115-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32386 invoked by alias); 22 Sep 2010 13:44:35 -0000
Received: (qmail 32366 invoked by uid 22791); 22 Sep 2010 13:44:24 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-186-10.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.186.10)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 22 Sep 2010 13:44:14 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 908C613C061	for <cygwin-patches@cygwin.com>; Wed, 22 Sep 2010 09:44:12 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 825192B352; Wed, 22 Sep 2010 09:44:12 -0400 (EDT)
Date: Wed, 22 Sep 2010 13:44:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
Message-ID: <20100922134412.GA4817@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <4C8E0EED.4000606@gmail.com> <20100914093859.GB15121@calimero.vinschen.de> <4C999916.7080609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C999916.7080609@gmail.com>
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
X-SW-Source: 2010-q3/txt/msg00075.txt.bz2

On Wed, Sep 22, 2010 at 07:50:14AM +0200, Yoni Londner wrote:
>Hi,
>
> > I'm not exactly concerned about Linux being way faster accessing an NTFS
> > drive.  After all it's the OS itself and comes with it's own NTFS driver
> > which obviously is streamlined for typical POSIX operations.
>
>I did not test & compare to using the Linux NTFS, rather I compared with 
>Linux on VMWARE using the same Windows NTFS.SYS (via the same 
>kernel32.dll APIs):
>
>Cygwin: "C:/cygwin/bin/ls.exe /bin" -> cygwin1.dll -> kernel32.dll -> 
>NTOS kernel -> NTFS.SYS driver -> HD
>
>linux: "/bin/ls /mnt/hgfs/C/cygwin/bin" -> glibc -> linux kernel -> 
>VMWARE hgfs driver -> vmware_player.exe (on Win32) ->  kernel32.dll -> 
>NTOS kernel -> NTFS.SYS driver -> HD
>
>As you can see the VMWARE path is much longer than Cygwin, and it passes 
>the same APIs and NTFS.SYS driver, and yet it executes much faster.
>
>This helps us understand that there is a lot that still can be done in 
>Cygwin's filesystem performance.

What is /mnt/hgfs/C in this case?  How is it mounted?

cgf

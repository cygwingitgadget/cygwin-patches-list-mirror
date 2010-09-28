Return-Path: <cygwin-patches-return-7119-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21785 invoked by alias); 28 Sep 2010 17:45:32 -0000
Received: (qmail 21765 invoked by uid 22791); 28 Sep 2010 17:45:30 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 28 Sep 2010 17:45:23 +0000
Received: (qmail 35227 invoked by uid 13447); 28 Sep 2010 17:45:21 -0000
Received: from unknown (HELO [172.20.0.42]) ([71.213.140.186])          (envelope-sender <warren@etr-usa.com>)          by 130.94.180.135 (qmail-ldap-1.03) with SMTP          for <cygwin-patches@cygwin.com>; 28 Sep 2010 17:45:21 -0000
Message-ID: <4CA2298F.6030707@etr-usa.com>
Date: Tue, 28 Sep 2010 17:45:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <4C8E0EED.4000606@gmail.com> <20100914093859.GB15121@calimero.vinschen.de> <4C999916.7080609@gmail.com> <20100922134412.GA4817@ednor.casa.cgf.cx> <4CA20212.7050207@etr-usa.com> <20100928151032.GA30911@trixie.casa.cgf.cx>
In-Reply-To: <20100928151032.GA30911@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00079.txt.bz2

On 9/28/2010 9:10 AM, Christopher Faylor wrote:
> It isn't extremely surprising that Linux access speed for a filesystem
> in a simulated environment, which presumably does not go through
> multiple layers of DLLs, would be faster than Cygwin.

I think it more likely that the HGFS driver doesn't try to preserve full 
POSIX semantics.  There's plenty of precedent: vfat, iso9660...  One 
could probably verify this faster by examining the driver's source code 
(http://open-vm-tools.sourceforge.net/) than by tracing syscalls.

If that's the explanation, it points at a possible path forward.

On Linux, these secondary filesystems aren't expected to provide full 
POSIX semantics, simply because they are secondary.  No one cries very 
hard that you can't make symlinks on a FAT-formatted USB stick.

Yet, there's probably no technical reason you couldn't get a POSIX-like 
system to run on a crippled filesystem.  It's probably even been done 
lots of times before in the embedded world.  Some of the PC Unix systems 
from the 80s and early 90s were pretty screwy in this way, too.  Screwy 
doesn't prevent you from doing useful work, though.

Would it not be useful to have a mode in Cygwin that purposely skips any 
POSIX semantics that it can't get for free by making the POSIX syscalls 
nothing more than thin wrappers around the nearest equivalent Win32 API? 
  If you put it in this mode and it breaks, you get to keep both pieces. 
  There are those who would happily accept the speed increase for loss 
of some functionality.  I wouldn't, but some would.  I'd bet a lot of 
the 3PPs are in that group, since they know their target environment 
very well.

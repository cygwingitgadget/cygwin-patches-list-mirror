Return-Path: <cygwin-patches-return-7118-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32258 invoked by alias); 28 Sep 2010 15:10:56 -0000
Received: (qmail 32208 invoked by uid 22791); 28 Sep 2010 15:10:41 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-186-10.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.186.10)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 28 Sep 2010 15:10:34 +0000
Received: by cgf.cx (Postfix, from userid 201)	id 6C1B913C06C; Tue, 28 Sep 2010 11:10:32 -0400 (EDT)
Date: Tue, 28 Sep 2010 15:10:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
Message-ID: <20100928151032.GA30911@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <4C8E0EED.4000606@gmail.com> <20100914093859.GB15121@calimero.vinschen.de> <4C999916.7080609@gmail.com> <20100922134412.GA4817@ednor.casa.cgf.cx> <4CA20212.7050207@etr-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CA20212.7050207@etr-usa.com>
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
X-SW-Source: 2010-q3/txt/msg00078.txt.bz2

On Tue, Sep 28, 2010 at 08:56:18AM -0600, Warren Young wrote:
>On 9/22/2010 7:44 AM, Christopher Faylor wrote:
>>
>> What is /mnt/hgfs/C in this case?  How is it mounted?
>
>HGFS is the Host-Guest File System, a VMware technology that lets it 
>export host volumes to the guest in a high-speed way.
>
>If you used old versions of VMware Workstation for Linux, you may 
>remember that they used to ship a version of Samba to export Linux-side 
>filesystems to the Windows guest.  Now they use their proprietary HGFS 
>technology instead.  In addition to being smaller and faster than Samba, 
>it works with all supported host and guest combinations, and it removes 
>a dependency.
>
>I believe Yoni's point is that the
>
>     Linux guest -> HGFS/VMware -> Windows native
>
>path apparently has less code in it than the
>
>     Cygwin -> Windows native
>
>code path.

It isn't extremely surprising that Linux access speed for a filesystem
in a simulated environment, which presumably does not go through
multiple layers of DLLs, would be faster than Cygwin.  I wouldn't even
be surprised to see that the old Samba implementation was faster.

cgf

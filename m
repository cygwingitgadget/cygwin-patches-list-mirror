Return-Path: <cygwin-patches-return-3920-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3066 invoked by alias); 30 May 2003 13:23:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3003 invoked from network); 30 May 2003 13:23:40 -0000
Date: Fri, 30 May 2003 13:23:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: stat matters
Message-ID: <20030530132340.GC24294@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030527194843.008044b0@mail.attbi.com> <3.0.5.32.20030527194843.008044b0@mail.attbi.com> <3.0.5.32.20030529223239.007fca00@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030529223239.007fca00@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00147.txt.bz2

On Thu, May 29, 2003 at 10:32:39PM -0400, Pierre A. Humblet wrote:
>At 11:33 PM 5/28/2003 -0400, Christopher Faylor wrote:
>>On Tue, May 27, 2003 at 07:48:43PM -0400, Pierre A. Humblet wrote:
>>
>>>   So I suggest a more radical approach: do not check for root dir at all
>but
>>>   whenever FindFirstFile fails with winerror 2 (although we know the 
>>>   file did exist a few ms ago and we have its attributes), call
>fstat_helper 
>>>   with zero dates and lengths.
>>
>>I guess this is the best approach.  Want to work up a patch?
>
>Done, but it's not that simple. The error is not 2 for remote drives. Also
>I don't know what it might be on all other systems. So I check for directory
>but not for specific errors. The worst that can occur is that a directory 
>that was being deleted while the stat was in progress will show up with a 
>wrong date. 
>
>2003-05-29  Pierre Humblet  <pierre.humblet@ieee.org>
>
>	* fhandler_disk_file.cc (fhandler_disk_file::fstat_by_name): Assume
>	an existing directory is a root if FindFirstFile fails.

Please apply.

cgf 

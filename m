Return-Path: <cygwin-patches-return-4092-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28854 invoked by alias); 16 Aug 2003 03:30:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28842 invoked from network); 16 Aug 2003 03:30:36 -0000
Message-ID: <3F3DA55A.1070703@acm.org>
Date: Sat, 16 Aug 2003 03:30:00 -0000
From: David Rothenberger <daveroth@acm.org>
Reply-To: cygwin-patches@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Package content search and listing functionality for
 cygcheck
References: <Pine.GSO.4.44.0308152213460.8431-200000@slinky.cs.nyu.edu>
In-Reply-To: <Pine.GSO.4.44.0308152213460.8431-200000@slinky.cs.nyu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00108.txt.bz2

Igor Pechtchanski wrote:
> Dave,
> 
> Thanks for catching this -- this was a genuine bug.  Thanks also for the
> patch, but I have another one in the pipeline that'll conflict with yours
> (<http://cygwin.com/ml/cygwin-patches/2003-q3/msg00105.html>).  How about
> I just resubmit that patch with your changes included?
> 
> Attached is a new patch, with an updated ChangeLog entry (well, two
> entries).

Thanks for fixing package_find(), too.  I should've checked that myself.

I notice that package_list() prints a message in this case with the -v 
switch, but package_find() does not.  My personal pref. is for the 
message, but I'll leave it to you to decide.

Dave


Return-Path: <cygwin-patches-return-3650-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21482 invoked by alias); 28 Feb 2003 06:10:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21473 invoked from network); 28 Feb 2003 06:10:34 -0000
Date: Fri, 28 Feb 2003 06:10:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: access () and path.cc
Message-ID: <20030228061034.GB2298@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030228004959.007ff8b0@incoming.verizon.net> <3.0.5.32.20030227235437.0080a480@incoming.verizon.net> <3.0.5.32.20030227230453.007d3a60@mail.attbi.com> <3.0.5.32.20030227230453.007d3a60@mail.attbi.com> <3.0.5.32.20030227235437.0080a480@incoming.verizon.net> <3.0.5.32.20030228004959.007ff8b0@incoming.verizon.net> <3.0.5.32.20030228010258.007f2870@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030228010258.007f2870@incoming.verizon.net>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00299.txt.bz2

On Fri, Feb 28, 2003 at 01:02:58AM -0500, Pierre A. Humblet wrote:
>At 12:56 AM 2/28/2003 -0500, you wrote:
>>On Fri, Feb 28, 2003 at 12:49:59AM -0500, Pierre A. Humblet wrote:
>>>OK, following Chris' remarks here is a much smaller set
>>>of changes.
>>
>>Do you think it would make sense to do something along the lines
>>of:
>>>+      path_conv pc (cfd->is_device ? cfd->get_name () :
>cfd->get_win32_name (), PC_SYM_NOFOLLOW);
>
>I guess one could but judging from the times I see in 
>strace it's not really justified.
>
>On the other hand that's something that we could look at after you
>integrate your code.  There could eventually be a single get_name
>returning what's appropriate.

This isn't an issue with my code, at least for fstat64.  That's one of
the reasons for my changes.  I was trying to minimize the number of
duplicate passes through path_conv::check.  I still have some tweaking
to do though since adding path_conv to fhandler balloons the sizes of
fhandler_base and ends up using a lot more space in cygheap, which means
more memory to copy on fork, which could mean slower forks, which means
that my performance improvement makes things work more slowly...

Anyway, please feel free to check in what you have.

cgf

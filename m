Return-Path: <cygwin-patches-return-1977-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16361 invoked by alias); 11 Mar 2002 20:30:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16333 invoked from network); 11 Mar 2002 20:30:20 -0000
Date: Mon, 11 Mar 2002 12:38:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: msync patch
Message-ID: <20020311213018.Z29574@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <006201c1c927$8d05f550$0100a8c0@advent02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006201c1c927$8d05f550$0100a8c0@advent02>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00334.txt.bz2

On Mon, Mar 11, 2002 at 06:07:03PM -0000, Chris January wrote:
> This patch modifies msync in mmap.cc so that you can call msync with an
> address which occurs in the middle of an mmap'ed region. It also fixes the
> bug where the address in the relevant mmap_record would not match the one
> passed to msync if the offset of the mmap'ed region within the file was not
> on a dwAllocationGranularity boundary.

First I was inclined to refuse the patch since SUSv2 requires
`addr' to be a multiple of getpagesize() but POSIX doesn't
so it's better trying to be POSIX compliant here.

However, the patch only checks the beginning and the end of the
given address range but the address range could span over a
non-mapped region which is a fault from msync's point of view.

I've checked in a slightly different version which uses a method
I implemented today.  msync() now tests if the whole address range
is contigeously mmap'd, returning ENOMEM otherwise.

I'd appreciate if you could give it a try.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

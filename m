Return-Path: <cygwin-patches-return-3860-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28213 invoked by alias); 19 May 2003 21:59:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28188 invoked from network); 19 May 2003 21:59:35 -0000
Message-ID: <3EC953C6.7040908@hekimian.com>
Date: Mon, 19 May 2003 21:59:00 -0000
X-Sybari-Trust: 2f9d6b0d 36b09be0 523a3db8 00000109
From: Joe Buehler <jbuehler@hekimian.com>
Reply-To:  jbuehler@hekimian.com
Organization: Spirent Communications, Inc.
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC:  cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix for process virtual size display
References: <ICEBIHGCEJIPLNMBNCMKOEFACGAA.chris@atomice.net>
In-Reply-To: <ICEBIHGCEJIPLNMBNCMKOEFACGAA.chris@atomice.net>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00087.txt.bz2

Chris January wrote:

> I'm actually inclined to keep vmc.VirtualSize instead of vmc.PagefileUsage.
> However I found this formula cited in one of the Linux man pages:
>           vsize=(brk-start_code+PAGE_SIZE-1)+(TASK_SIZE-esp)
> which would seem to indicate vmsize actually refers to committed memory.
> With this in mind, I'm happy for this patch to be committed. Further work
> may be
> needed to include DLLs in that figure, however that would be a separate
> patch.

Does anyone on the list know what "reserved" memory means in Windows?  What
does the kernel actually allocate?  Is there just a few bytes indicating the
the memory range is "reserved"?  Or are page tables allocated for the reserved
memory?  Or????
-- 
Joe Buehler

Return-Path: <cygwin-patches-return-5962-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4294 invoked by alias); 21 Aug 2006 18:31:18 -0000
Received: (qmail 4283 invoked by uid 22791); 21 Aug 2006 18:31:17 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-229.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.229)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 21 Aug 2006 18:31:14 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 2FB4C13C042; Mon, 21 Aug 2006 14:31:13 -0400 (EDT)
Date: Mon, 21 Aug 2006 18:31:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] do_mount bug fix
Message-ID: <20060821183113.GA28854@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a6355d0d0608211052l6f756d9fq16f6ed3f1f7bba3e@mail.gmail.com> <20060821175837.GF24551@trixie.casa.cgf.cx> <a6355d0d0608211111kcac6b0q51f8073a0d3c26d3@mail.gmail.com> <a6355d0d0608211117n7a6fb985y68579fc3205679ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6355d0d0608211117n7a6fb985y68579fc3205679ed@mail.gmail.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00057.txt.bz2

On Mon, Aug 21, 2006 at 02:17:19PM -0400, Wang Yiping wrote:
>>cgf wrote:
>>>Please provide a simple and complete test case which illustrates the
>>>problem.
>>>
>On Mon, Aug 21, 2006 at 02:11:44PM -0400, Wang Yiping wrote:
>>OK, here is the test-case :-)
>>
>>mkdir /tmp/test123 mount -u -o managed `cygpath -m /home/whateverdd`
>>/tmp/test123/ umount /tmp/test123
>
>I recheck, umount can delete the entry, with umount -u /tmp/test123.
>But it may be better to check it before it is mounted.

Sorry but it has always been possible to mount nonexistent directories
on Cygwin and, obviously, as you've noted, you do need to use the -u
option on umount when you've mounted using -u.

cgf

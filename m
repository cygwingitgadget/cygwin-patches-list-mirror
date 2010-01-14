Return-Path: <cygwin-patches-return-6903-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31737 invoked by alias); 14 Jan 2010 07:00:57 -0000
Received: (qmail 31673 invoked by uid 22791); 14 Jan 2010 07:00:56 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-52-118.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.52.118)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 14 Jan 2010 07:00:50 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id D381C13C0C8 	for <cygwin-patches@cygwin.com>; Thu, 14 Jan 2010 02:00:39 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id C78D32B35A; Thu, 14 Jan 2010 02:00:39 -0500 (EST)
Date: Thu, 14 Jan 2010 07:00:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Message-ID: <20100114070039.GA6788@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100113212537.GB14511@calimero.vinschen.de>  <4B4E96D3.90300@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B4E96D3.90300@byu.net>
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
X-SW-Source: 2010-q1/txt/msg00019.txt.bz2

On Wed, Jan 13, 2010 at 09:00:19PM -0700, Eric Blake wrote:
>>    MALLOC_CHECK;
>> -  debug_printf ("dup2 (%d, %d)", oldfd, newfd);
>> +  debug_printf ("dup3 (%d, %d, %d)", oldfd, newfd, flags);
>
>I'd prefer %#x for flags, rather than %d (two instances in this function).

In that case it should be %p to be consistent with other uses.

>> +      set_errno (EBADF);
>> +      return -1;
>> +    }
>> +  if (!cygheap->fdtab.not_open (oldfd) && oldfd == newfd)
>
>Is not_open() expensive?  If so, reverse the order of the conditionals for
>speed.

Yes, not_open() is expensive.

cgf

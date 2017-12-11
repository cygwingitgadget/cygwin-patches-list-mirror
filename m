Return-Path: <cygwin-patches-return-8966-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61580 invoked by alias); 11 Dec 2017 09:24:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61387 invoked by uid 89); 11 Dec 2017 09:24:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=withdrawn, Hx-languages-length:2090, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 11 Dec 2017 09:24:53 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id vBB9OpVm068214	for <cygwin-patches@cygwin.com>; Mon, 11 Dec 2017 01:24:51 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Mon, 11 Dec 2017 09:24:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
In-Reply-To: <Pine.BSF.4.63.1712011340460.18120@m0.truegem.net>
Message-ID: <Pine.BSF.4.63.1712110114220.66725@m0.truegem.net>
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com> <20171128105334.GQ547@calimero.vinschen.de> <20171130103440. <Pine.BSF.4.63.1712011340460.18120@m0.truegem.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00096.txt.bz2

Just closing out this email thread...

On Fri, 1 Dec 2017, Mark Geisert wrote:
> On Fri, 1 Dec 2017, Corinna Vinschen wrote:
>> On Dec  1 10:30, Corinna Vinschen wrote:
>>> On Dec  1 00:44, Mark Geisert wrote:
>>>> And then pwrite() creates its own handle (or reuses one (!)) to avoid
>>>> messing up the seek pointer of the fd passed in.
>>> 
>>> Wait.  Not "re-use", but "re-open".  If you're more familiar with POSIX
>>> terms, this is along the lines of the fdopen(3) call, just on the NT
>>> API level.  There's an equivalent Win32 function since Windows 2003
>>> called ReOpenFile.
>>> 
>>> In terms of pread/pwrite, the new handle shares the same settings with
>>> the original handle.  However, if you use cygwin_attach_handle_to_fd,
>>> there's a chance information got lost.  Nobody actually uses this call ;)
>>> 
>>> In terms of FILE_SYNCHRONOUS_IO_NONALERT, this is stored in
>>> fhandler_base::options, utilizing the get_options/set_options methods.
>>> I have a hunch that cygwin_attach_handle_to_fd fails to call set_options,
>>> thus options is 0 when you call pwrite, thus the new handle is opened
>>> without FILE_SYNCHRONOUS_IO_NONALERT and all the other option flags
>>> we use by default.
>> 
>> It's more than a hunch.  Of course the info gets lost since
>> none of the functions called by cygwin_attach_handle_to_fd calls
>> NtQueryInformationFile(FileModeInformation) to fetch the options.
>
> Bang.  There it is.  Let me fix the offending program to just use 
> Cygwin-supplied handles and make sure this bug of mine is squashed.  I'll 
> report back but it might be a few days.

Yes, this bug of mine that I was blaming pwrite() internals for, 
doesn't occur when using Cygwin-supplied file descriptors with Cygwin i/o 
calls.  Who new?

Sorry for the noise, but at least what I learned from this discussion is 
very helpful in figuring out what makes sense for a future async i/o 
facility in Cygwin.

I have some further comments but I'll take them to cygwin-developers.
This IO_STATUS_BLOCK patch is withdrawn ;-) .

..mark

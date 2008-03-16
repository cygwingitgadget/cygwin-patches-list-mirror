Return-Path: <cygwin-patches-return-6304-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22609 invoked by alias); 16 Mar 2008 15:36:26 -0000
Received: (qmail 22599 invoked by uid 22791); 16 Mar 2008 15:36:26 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-250.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.250)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 16 Mar 2008 15:36:08 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 4709D63100F; Sun, 16 Mar 2008 11:36:07 -0400 (EDT)
Date: Sun, 16 Mar 2008 15:36:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] QueryDosDevice in handle_to_fn
Message-ID: <20080316153607.GB27448@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47DCF310.2E2CA04A@dessent.net> <20080316152213.GD29148@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080316152213.GD29148@calimero.vinschen.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00078.txt.bz2

On Sun, Mar 16, 2008 at 04:22:13PM +0100, Corinna Vinschen wrote:
>On Mar 16 03:14, Brian Dessent wrote:
>>   I debugged this and found the
>> strangest thing, when you call QueryDosDevice (NULL, fnbuf, len) to get
>> the list of all DOS devices and len >= 65536, Win32 always returns 0
>> with GetLastError set to ERROR_MORE_DATA.  Since len was being set as
>> "sizeof (OBJECT_NAME_INFORMATION) + NT_MAX_PATH * sizeof (WCHAR)" this
>> always happened, causing handle_to_fn() to simply give up and copy the
>> Win32 name into the POSIX name and return.  The attached patch fixes the
>> problem by just clamping the size of the buffer to under 64k.
>
><insert lament here>
>
>> Another observation that I had while debugging this is that calling
>> strncasematch() in this function is probably wrong -- it expands to
>> cygwin_strncasecmp(), which is a wrapper that first converts both
>> arguments to temporary UNICODE strings and then calls
>> RtlCompareUnicodeString() -- we're doing this on strings that we had
>> just converted *out* of UNICODE.  I think ascii_strncasematch() is
>> probably what we want here instead, either that or try to stay in
>> unicode throughout.
>
>Using ascii_strncasematch here is right because the DEVICE_PREFIX is
>plain ascii anyway.  But, yes, the function should be converted to
>do everything in WCHAR/UNICODE_STRING and only convert to char *
>when creating the final posix_fn.
>
>> +  /* For some reason QueryDosDevice will fail with Win32 errno 234
>> +     (ERROR_MORE_DATA) if you try to pass a buffer larger than 64k  */
>> +  size_t qddlen = len < 65536 ? len : 65535;
>
>len is a const value.  Checking len for being < 65536 is a constant
>expression which always results in qddlen being 65535 so the ?: is
>a noop, more or less.
>
>Did you test if QueryDosDeviceW has the same problem as QueryDosDeviceA?
>If not, we should use that function.

This is basically my function.  I'll try to convert it to use Unicode
today.

cgf

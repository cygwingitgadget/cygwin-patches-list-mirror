Return-Path: <cygwin-patches-return-3128-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8866 invoked by alias); 6 Nov 2002 01:47:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8856 invoked from network); 6 Nov 2002 01:47:05 -0000
Date: Tue, 05 Nov 2002 17:47:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: More fhandler_serial fixes.
Message-ID: <20021106014902.GA4346@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <007901c28515$e66596a0$0201a8c0@sos> <20021105222840.GB11142@redhat.com> <20021105231705.GA12749@redhat.com> <008901c2852c$95703810$0201a8c0@sos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008901c2852c$95703810$0201a8c0@sos>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00079.txt.bz2

On Tue, Nov 05, 2002 at 07:36:42PM -0500, Sergey Okhapkin wrote:
>>
>> I could see changing this to size_t but not adding the extra vmin_.
>>
>> >@@ -423,20 +426,21 @@ fhandler_serial::ioctl (unsigned int cmd
>> >                                               0, &mcr, 4, &cb, 0);
>> >                if (!result)
>> >                  {
>> >-                   __seterrno ();
>> >-                   res = -1;
>> >-                   goto out;
>> >+                   modem_status |= rts | dtr;
>>
>> This is saying that if a function (DeviceIoControl) fails we fallback to
>> Win95 behavior.  Why wouldn't we want to reflect the failure of the
>> function?  Otherwise we could be masking an actual failure.
>>
>> Anyway, I've checked in a variation of this change minus the
>> DeviceIoControl part.
>
>The call to DeviceIoCtl is
>     BOOL result = DeviceIoControl (get_handle (), 0x001B0078, NULL,
>                           0, &mcr, 4, &cb, 0);
>
>I heve no ideas what does this call means, it's undocumented.

I never noticed the raw hex value there.  How ugly.

It took some digging but this seems to be where it is documented:

http://msdn.microsoft.com/library/default.asp?url=/library/en-us/serial/hh/serial/serref_5xv6.asp

However, if it is failing for you, we might as well do away with the
wincap test and just always try to use it and then fill in the default
values if it fails.

I'll check something in to do that.

cgf

The call
>always fails on my W2k when
>attempting to get the status of laptop's built-in modem. It seems to me it's
>better to ignore the error and to fall back to Win95 behavior rather than
>return the error.
>
>Sergey Okhapkin
>Somerset, NJ
>

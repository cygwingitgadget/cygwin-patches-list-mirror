Return-Path: <cygwin-patches-return-4313-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17907 invoked by alias); 24 Oct 2003 01:14:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17898 invoked from network); 24 Oct 2003 01:13:59 -0000
Date: Fri, 24 Oct 2003 01:14:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_tty_slave::ioctl (FIONBIO) return status
Message-ID: <20031024011357.GA19368@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0310231702270.823@eos> <20031023223037.GC14018@redhat.com> <Pine.GSO.4.56.0310231736280.823@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0310231736280.823@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00032.txt.bz2

On Thu, Oct 23, 2003 at 05:42:55PM -0500, Brian Ford wrote:
>On Thu, 23 Oct 2003, Christopher Faylor wrote:
>
>> I don't think it makes sense to use get_ttyp ()->ioctl_retval = 0;
>> here since we aren't actually communicating with the tty.
>>
>> Does something like this work?
>>
>Sure.  I don't actually have a test case.  This is just a hypothetical
>that I ran into.  Small suggestion below.
>
>> @@ -1086,9 +1088,9 @@ fhandler_tty_slave::ioctl (unsigned int
>>      }
>>
>>    release_output_mutex ();
>> +  retval = get_ttyp ()->ioctl_retval;
>>
>>  out:
>> -  int retval = get_ttyp ()->ioctl_retval;
>>    if (retval < 0)
>>      {
>>        set_errno (-retval);
>>
>You might want to move this if statement up too, as an optimization.

Yep.  Good point.

Thanks for the patch.  I've checked in my variation.

cgf

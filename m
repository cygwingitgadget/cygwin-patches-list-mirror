Return-Path: <cygwin-patches-return-6753-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15929 invoked by alias); 9 Oct 2009 10:11:08 -0000
Received: (qmail 15919 invoked by uid 22791); 9 Oct 2009 10:11:08 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0 	tests=BAYES_00
X-Spam-Check-By: sourceware.org
Received: from demumfd001.nsn-inter.net (HELO demumfd001.nsn-inter.net) (217.115.75.233)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 09 Oct 2009 10:11:01 +0000
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56]) 	by demumfd001.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id n99AAwi6002704 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL) 	for <cygwin-patches@cygwin.com>; Fri, 9 Oct 2009 12:10:58 +0200
Received: from [10.149.155.84] ([10.149.155.84]) 	by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id n99AAvU0019135 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) 	for <cygwin-patches@cygwin.com>; Fri, 9 Oct 2009 12:10:57 +0200
Message-ID: <4ACF0C30.50207@computer.org>
Date: Fri, 09 Oct 2009 10:11:00 -0000
From: Thomas Wolff <towo@computer.org>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: utimensat UTIME_NOW granularity bug
References: <loom.20091008T221131-292@post.gmane.org>  <20091008212425.GB2068@ednor.casa.cgf.cx>  <4ACEACBA.4030904@byu.net> <20091009045800.GA17335@ednor.casa.cgf.cx>
In-Reply-To: <20091009045800.GA17335@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00084.txt.bz2

Christopher Faylor wrote:
> On Thu, Oct 08, 2009 at 09:23:38PM -0600, Eric Blake wrote:
>   
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> According to Christopher Faylor on 10/8/2009 3:24 PM:
>>     
>>>> I think we need to implement a companion to systime(), which returns the system 
>>>> time without any truncation, so that the function clock_gettime(CLOCK_REALTIME) 
>>>> can report time with resolution to the 10th of a microsecond rather than to 
>>>> plain microseconds.  Then utimensat needs to use clock_gettime rather than 
>>>> gettimeofday, so that it is not needlessly truncating the 10th of microsecond 
>>>> resolution available from Windows.
>>>>         
>>> Why not send these type of musings to the cygwin-developers list?  It really
>>> is more appropriate for this type of discussion.
>>>       
>> Sorry about the wrong list.  At any rate, what about this patch?
>>
>> ...
> I don't like "MILLION" or "BILLION".  I think a real number is clearer
> for that.  ...
And, speaking about I18N, "Billion" has a different meaning in the US 
and in Germany (where it is 1000 times as much) which occasionally gives 
rise to confusion (don't know about other countries' usage).

Thomas

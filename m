Return-Path: <cygwin-patches-return-3193-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31174 invoked by alias); 15 Nov 2002 19:04:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31165 invoked from network); 15 Nov 2002 19:04:34 -0000
Date: Fri, 15 Nov 2002 11:04:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fw: siginterrupt() call implementation
Message-ID: <20021115190459.GG2419@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <03eb01c28cd2$c5cb96f0$0201a8c0@sos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03eb01c28cd2$c5cb96f0$0201a8c0@sos>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00144.txt.bz2

On Fri, Nov 15, 2002 at 01:13:57PM -0500, Sergey Okhapkin wrote:
>I apologise for sending a patch to a wrong list.

You mean I missed the opportunity to mention an off-topic post?  Huh!

Anyway, I've applied the patch.

Thanks.

cgf

>> The patch implements siginterrupt(3) library function.
>>
>> 2002-11-14  Sergey Okhapkin  <sos@prospect.com.ru>
>>
>>         * cygwin.din (siginterrupt): New export.
>>         * signal.cc (siginterrupt): New.

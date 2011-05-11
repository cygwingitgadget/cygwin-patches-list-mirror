Return-Path: <cygwin-patches-return-7342-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14765 invoked by alias); 11 May 2011 18:49:40 -0000
Received: (qmail 14753 invoked by uid 22791); 11 May 2011 18:49:39 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 11 May 2011 18:49:25 +0000
Received: (qmail 2134 invoked by uid 107); 11 May 2011 18:49:22 -0000
Received: from sb-gw15.cs.toronto.edu (HELO discarded) (128.100.3.15) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Wed, 11 May 2011 20:49:22 +0200
Message-ID: <4DCADA31.2090600@cs.utoronto.ca>
Date: Wed, 11 May 2011 18:49:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling
References: <4DCA2A48.6020208@cs.utoronto.ca> <20110511075953.GG28594@calimero.vinschen.de> <20110511141350.GA19557@ednor.casa.cgf.cx> <4DCA9B5A.4090606@cs.utoronto.ca> <20110511161622.GA23628@ednor.casa.cgf.cx>
In-Reply-To: <20110511161622.GA23628@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q2/txt/msg00108.txt.bz2

On 11/05/2011 12:16 PM, Christopher Faylor wrote:
> On Wed, May 11, 2011 at 10:21:14AM -0400, Ryan Johnson wrote:
>> On 11/05/2011 10:13 AM, Christopher Faylor wrote:
>>> On Wed, May 11, 2011 at 09:59:53AM +0200, Corinna Vinschen wrote:
>>>> On May 11 02:18, Ryan Johnson wrote:
>>>>> Please find attached five patches [...]
>>>> Oops, wrong mailing list...
>>>>
>>>> Btw., it would be nice if you could create patches with the diff -p flag
>>>> as well.  It's not exactly essential, but IMHO it's quite a help when
>>>> trying to review patches.
>>>>
>>>> Another problem is this:  While you provide separate patches, you don't
>>>> provide separate ChangeLogs.  That makes it kind of hard to apply them
>>>> separately.  Would you mind to create one ChangeLog per change?
>>> Ditto.  This really needs to be broken down into easier to review chunks.
>> All right. Let's try this again with the correct mailing list.
>>
>> The patches have been generated with diff -p, and each includes
>> appropriate changelog entries. Hopefully the changes are split up finely
>> enough because I don't know a good way to break them down any further.
>>
>> For posterity's sake I'm including the original message body below.
> Please: One patch per message.  One ChangeLog entry per message, not
> sent as a diff.
Done. Please disregard the older (bundled) versions because I found a 
couple of glitches in the patches which the the 1-per-email set fixes.

Ryan

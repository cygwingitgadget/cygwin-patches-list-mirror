Return-Path: <cygwin-patches-return-3055-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17609 invoked by alias); 15 Oct 2002 16:05:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17599 invoked from network); 15 Oct 2002 16:05:44 -0000
Message-ID: <3DAC0CE8.6010804@yahoo.com>
Date: Tue, 15 Oct 2002 09:05:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To:  cygwin-patches@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicholas Wourms <nwourms@netscape.net>
CC:  cygwin-patches@cygwin.com
Subject: Re: w32api autoconfiscation changes
References: <3DA78C2A.9010709@yahoo.com> <3DAB2264.2000508@yahoo.com> <3DABFAAF.4030305@netscape.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00006.txt.bz2

Nicholas Wourms wrote:
> Earnie Boyd wrote:
> 
>> I've just implemented this.
>>
>> Earnie Boyd wrote:
>>
>>> This is a warning of changes about to occur.  I've tested these 
>>> chages with both native mingw32 and native cygwin.  I've not tested 
>>> these changes with a cross build system.  The purpose of the change 
>>> is to add targets for the ddk recently added to the sources and 
>>> making a few modifications due to differences in the way newer 
>>> versions of autoconf generates the results of important variables 
>>> such as host_alias.  I'm attaching w32api.cvsdiff.txt without 
>>> ChangeLog entry for your enjoyment.  The generated configure script 
>>> will be with autoconf 2.53.
>>>
> 
> Earnie,
> 
> What versions of the Windows DDK are you initially emulating and what 
> versions are you planning to emulate?  Just out of curiosity...
> 

According to the ChangeLog that would be up to:
2002-10-06  Casper Hornstrup  <chorns@it.dk>

Earnie.

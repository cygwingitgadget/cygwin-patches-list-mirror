Return-Path: <cygwin-patches-return-3054-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23918 invoked by alias); 15 Oct 2002 11:24:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23904 invoked from network); 15 Oct 2002 11:24:48 -0000
Message-ID: <3DABFAAF.4030305@netscape.net>
Date: Tue, 15 Oct 2002 04:24:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.1) Gecko/20020823 MultiZilla/v1.1.22
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: w32api autoconfiscation changes
References: <3DA78C2A.9010709@yahoo.com> <3DAB2264.2000508@yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00005.txt.bz2

Earnie Boyd wrote:
> I've just implemented this.
> 
> Earnie Boyd wrote:
> 
>> This is a warning of changes about to occur.  I've tested these chages 
>> with both native mingw32 and native cygwin.  I've not tested these 
>> changes with a cross build system.  The purpose of the change is to 
>> add targets for the ddk recently added to the sources and making a few 
>> modifications due to differences in the way newer versions of autoconf 
>> generates the results of important variables such as host_alias.  I'm 
>> attaching w32api.cvsdiff.txt without ChangeLog entry for your 
>> enjoyment.  The generated configure script will be with autoconf 2.53.
>>

Earnie,

What versions of the Windows DDK are you initially emulating 
and what versions are you planning to emulate?  Just out of 
curiosity...

Cheers,
Nicholas




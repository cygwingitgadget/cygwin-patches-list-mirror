Return-Path: <cygwin-patches-return-3399-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8950 invoked by alias); 15 Jan 2003 18:27:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8940 invoked from network); 15 Jan 2003 18:27:51 -0000
Date: Wed, 15 Jan 2003 18:27:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: setuid on Win95 and etc_changed, passwd & group.
Message-ID: <20030115182850.GG15975@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030115001238.00806440@mail.attbi.com> <20030115060939.GB15975@redhat.com> <3E2570BD.2582F293@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2570BD.2582F293@ieee.org>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00048.txt.bz2

On Wed, Jan 15, 2003 at 09:31:25AM -0500, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>> I'm not sure what you're saying.  Are you saying it's inefficient
>> because it is duplicated?  I don't see anything wrong with the code.
>
>I believe there are 8 unused bytes in every block.
>On line 221 sz is what's asked + 8.  On line 234 size is sz + 8, or
>what's asked + 16.  The header has size 8, the last 8 bytes will never
>be filled.

Ok.  Got it.  I checked in a patch.

>> In a similar vein,
>> 
>> BOOL isuninitialized () const
>>   {
>>     if (state == uninitialized)
>>       (void) cygheap->etc_changed (me);
>>     return (state == uninitialized);
>>   }
>> 
>> Are both tests for uninitialized necessary?  If not shouldn't it be
>> something like:
>> 
>> BOOL isuninitialized () const
>>   {
>>     if (state != uninitialized)
>>       return false;
>>     (void) cygheap->etc_changed (me);
>>     return true;
>>   }
>
>I like functions with a single return, within reason.
>I thought the compiler would be smart enough not to
>test twice.

Not if there was a etc_changed function call in the middle.

>> Also, could you explain what this 'me' stuff is wrt etc_changed?
>
>That's to go around the problem outlined in the e-mail. Objects
>accessing etc_changed (for now passwd and group) have an ID (me). 
>When an object discovers that etc has changed, it sets a flag for 
>all *other* objects, telling them that etc has already changed
>(see new code in cygheap.cc).

Ok, thanks.

cgf

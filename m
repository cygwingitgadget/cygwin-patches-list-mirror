Return-Path: <cygwin-patches-return-3450-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28728 invoked by alias); 21 Jan 2003 23:55:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28715 invoked from network); 21 Jan 2003 23:55:56 -0000
Date: Tue, 21 Jan 2003 23:55:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Races in group/passwd code (was Re: etc_changed, passwd & group)
Message-ID: <20030121235717.GC20123@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030117233612.007ed390@mail.attbi.com> <3.0.5.32.20030120215131.007f9740@h00207811519c.ne.client2.attbi.com> <20030121051325.GA4667@redhat.com> <20030121153538.GA24356@redhat.com> <3E2D6CF9.FF47B7F4@ieee.org> <20030121161115.GA13536@redhat.com> <3E2D79A7.DCC9AF74@ieee.org> <20030121223702.GA20862@redhat.com> <3E2DDAE1.4C772D36@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2DDAE1.4C772D36@ieee.org>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00099.txt.bz2

On Tue, Jan 21, 2003 at 06:42:25PM -0500, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>> 
>> 
>> Btw, Pierre, can you explain the rationale behind the "check" parameter
>> that some of the internal_* functions take?  Why would you not want to
>> check for an up-to-date /etc/passwd or /etc/group?  
>
>Two reasons:
>1) "check" is only true when the internal functions are called from external
>functions. getpwuid and non-reentrant friends return pointers to the malloced
>copy. They have to remain valid at least until the next non-reentrant call,
>thus cannot be invalidated by refresh from internal lookup functions.
>This could be solved with per thread storage, but it's more expensive,
>maximum size becomes an issue, etc...
>2) internal lookups are used a lot to map uids from/to sids, so decreasing
>overhead for them looks like a good idea to make Cygwin faster.   

Ok, thanks.

>> If not for this, it
>> seems like we could get rid of the initialization check entirely and
>> just let fn_changed return true when fn[etc_ix] is uninitialized,
>> forcing an initial read/parse of the appropriate file.
>
>That's true for the "uninitialized" state (although it's a cheaper comparison)
>but not for the "initializing" state, at least with the current locking
>scheme. That condition is checked twice (before and after the mutex), whereas
>WaitForSingleEvent and fn_changed normally return false the second time 
>around even when true the first time.

Right, I was changing the locking to occur around the initialization check and
then wondered why we needed an initialization check at all.  I also used your
code/idea to get rid of the state entirely and just check for initialized.

cgf

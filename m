Return-Path: <cygwin-patches-return-3449-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1985 invoked by alias); 21 Jan 2003 23:40:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1710 invoked from network); 21 Jan 2003 23:40:43 -0000
Message-ID: <3E2DDAE1.4C772D36@ieee.org>
Date: Tue, 21 Jan 2003 23:40:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Races in group/passwd code (was Re: etc_changed, passwd & group)
References: <3.0.5.32.20030117233612.007ed390@mail.attbi.com> <3.0.5.32.20030120215131.007f9740@h00207811519c.ne.client2.attbi.com> <20030121051325.GA4667@redhat.com> <20030121153538.GA24356@redhat.com> <3E2D6CF9.FF47B7F4@ieee.org> <20030121161115.GA13536@redhat.com> <3E2D79A7.DCC9AF74@ieee.org> <20030121223702.GA20862@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00098.txt.bz2

Christopher Faylor wrote:
> 
> 
> Btw, Pierre, can you explain the rationale behind the "check" parameter
> that some of the internal_* functions take?  Why would you not want to
> check for an up-to-date /etc/passwd or /etc/group?  

Two reasons:
1) "check" is only true when the internal functions are called from external
functions. getpwuid and non-reentrant friends return pointers to the malloced
copy. They have to remain valid at least until the next non-reentrant call,
thus cannot be invalidated by refresh from internal lookup functions.
This could be solved with per thread storage, but it's more expensive,
maximum size becomes an issue, etc...
2) internal lookups are used a lot to map uids from/to sids, so decreasing
overhead for them looks like a good idea to make Cygwin faster.   

> If not for this, it
> seems like we could get rid of the initialization check entirely and
> just let fn_changed return true when fn[etc_ix] is uninitialized,
> forcing an initial read/parse of the appropriate file.

That's true for the "uninitialized" state (although it's a cheaper comparison)
but not for the "initializing" state, at least with the current locking
scheme. That condition is checked twice (before and after the mutex), whereas
WaitForSingleEvent and fn_changed normally return false the second time 
around even when true the first time. Thus it's necessary to remember that they 
were true the first time.
Given that we have to remember something, it's cheap to use the same variable
to find out that we are uninitialized.
Recall too that in my book fn[etc_itx] is duplicative thus unnecessary :) 

Pierre

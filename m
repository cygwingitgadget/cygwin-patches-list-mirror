Return-Path: <cygwin-patches-return-3395-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25751 invoked by alias); 15 Jan 2003 14:30:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25742 invoked from network); 15 Jan 2003 14:30:17 -0000
Message-ID: <3E2570BD.2582F293@ieee.org>
Date: Wed, 15 Jan 2003 14:30:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: setuid on Win95 and etc_changed, passwd & group.
References: <3.0.5.32.20030115001238.00806440@mail.attbi.com> <20030115060939.GB15975@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00044.txt.bz2

Christopher Faylor wrote:

> >During testing I noticed another issue. If etc_changed is initialized
> >in a parent and /etc/passwd is changed between the moments where a
> >child is forked and where etc_changed is first called in the child,
> >etc_changed unexpectedly returns false in the child (WinME).
> >Not sure how to fix that, short of always rereading the files in
> >the child (when/if actually accessed).  That would be an OK solution if
> >we hadn't just copied the data from the parent.  Would it be possible
> >to store passwd and group in some other heap (from Windows?) that
> >doesn't get copied?  If that was done, then the etc_changed handle
> >could be opened as needed instead of being inherited.
> 
> It may be worse than what you say.  It's possible that there is a huge
> race here where the parent and child compete for the privilege of each
> being able to figure out when /etc changed.  I think that if the
> parent figures out that etc changed, the child will not notice and
> vice versa.  This is regardless of whether the process is in the
> middle of forking or not.
> 
> So, yes, you can easily put this in some other structure.  Just
> move it out of cygheap entirely and use a global variable that
> is marked NO_COPY.  Don't do the DuplicateHandle step to mark the
> file as inheritable.  Then parent and child should both be able
> to figure out when etc changes.

Yes, this is what I will do.
The passwd state and the non-inheritable etc_handle will be NO_COPY.
The handle will be created as needed on first access in a process. 
In addition forked processes, which may already have a malloced copy
of passwd, will do a date comparison on first access.
 
> >Incidentally while looking at cygheap.cc I noticed that the
> >+ sizeof (_cmalloc_entry) on line 221 duplicates the one on line
> >234. I didn't change it in this patch as it is not related to the rest,
> >but I have run with an abbreviated line 221 for a day.
> 
> I'm not sure what you're saying.  Are you saying it's inefficient
> because it is duplicated?  I don't see anything wrong with the code.

I believe there are 8 unused bytes in every block.
On line 221 sz is what's asked + 8.
On line 234 size is sz + 8, or what's asked + 16.
The header has size 8, the last 8 bytes will never be filled.

> In a similar vein,
> 
> BOOL isuninitialized () const
>   {
>     if (state == uninitialized)
>       (void) cygheap->etc_changed (me);
>     return (state == uninitialized);
>   }
> 
> Are both tests for uninitialized necessary?  If not shouldn't it be
> something like:
> 
> BOOL isuninitialized () const
>   {
>     if (state != uninitialized)
>       return false;
>     (void) cygheap->etc_changed (me);
>     return true;
>   }

I like functions with a single return, within reason.
I thought the compiler would be smart enough not to
test twice.
 
> Also, could you explain what this 'me' stuff is wrt etc_changed?

That's to go around the problem outlined in the e-mail. Objects
accessing etc_changed (for now passwd and group) have an ID (me). 
When an object discovers that etc has changed, it sets a flag for 
all *other* objects, telling them that etc has already changed
(see new code in cygheap.cc).

Pierre

Return-Path: <cygwin-patches-return-3391-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29697 invoked by alias); 15 Jan 2003 06:08:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29687 invoked from network); 15 Jan 2003 06:08:52 -0000
Date: Wed, 15 Jan 2003 06:08:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: setuid on Win95 and etc_changed, passwd & group.
Message-ID: <20030115060939.GB15975@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030115001238.00806440@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030115001238.00806440@mail.attbi.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00040.txt.bz2

On Wed, Jan 15, 2003 at 12:12:38AM -0500, Pierre A. Humblet wrote:
>Hello Corinna,
>
>The following patches affect many files but they are simple.
>They can wait for 1.3.20.
>
>1) On Win95/98/ME, seteuid and setegid now change the uid/gid.
>   Related to that are simplifications in spawn.cc and dcrt0.cc 
>   and plugging a handle leak in uinfo.cc (5 first files).
>2) passwd and group: various cleanup, plus fixing the following
>   scenario that came to light while investigating etc_changed
>   (but it doesn't cause any BSOD):
>   t0: process starts, reads passwd and group
>   t1: user updates /etc/group
>   t2: program calls getpwuid. etc_changed returns TRUE. Timestamp
>       of passwd file is old, no update. OK.
>   t3: program calls getgrgid. etc_changed returns FALSE. 
>       /etc/group is not updated. Bug.
>
>During testing I noticed another issue. If etc_changed is initialized
>in a parent and /etc/passwd is changed between the moments where a 
>child is forked and where etc_changed is first called in the child, 
>etc_changed unexpectedly returns false in the child (WinME).
>Not sure how to fix that, short of always rereading the files in 
>the child (when/if actually accessed).  That would be an OK solution if
>we hadn't just copied the data from the parent.  Would it be possible
>to store passwd and group in some other heap (from Windows?) that
>doesn't get copied?  If that was done, then the etc_changed handle
>could be opened as needed instead of being inherited.

It may be worse than what you say.  It's possible that there is a huge
race here where the parent and child compete for the privilege of each
being able to figure out when /etc changed.  I think that if the
parent figures out that etc changed, the child will not notice and
vice versa.  This is regardless of whether the process is in the
middle of forking or not.

So, yes, you can easily put this in some other structure.  Just
move it out of cygheap entirely and use a global variable that
is marked NO_COPY.  Don't do the DuplicateHandle step to mark the
file as inheritable.  Then parent and child should both be able
to figure out when etc changes.

>Incidentally while looking at cygheap.cc I noticed that the 
>+ sizeof (_cmalloc_entry) on line 221 duplicates the one on line
>234. I didn't change it in this patch as it is not related to the rest, 
>but I have run with an abbreviated line 221 for a day.

I'm not sure what you're saying.  Are you saying it's inefficient
because it is duplicated?  I don't see anything wrong with the code.

In a similar vein, 

BOOL isuninitialized () const
  {
    if (state == uninitialized)
      (void) cygheap->etc_changed (me);
    return (state == uninitialized);
  }

Are both tests for uninitialized necessary?  If not shouldn't it be
something like:

BOOL isuninitialized () const
  {
    if (state != uninitialized)
      return false;
    (void) cygheap->etc_changed (me);
    return true;
  }

Also, could you explain what this 'me' stuff is wrt etc_changed?

cgf

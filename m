Return-Path: <cygwin-patches-return-3075-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27765 invoked by alias); 21 Oct 2002 16:40:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27748 invoked from network); 21 Oct 2002 16:40:09 -0000
Message-ID: <3DB42E51.5C08727D@ieee.org>
Date: Mon, 21 Oct 2002 09:40:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Avoiding /etc/passwd and /etc/group scans
References: <3DB416E7.99E22851@ieee.org> <20021021162246.GC15828@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00026.txt.bz2

Christopher Faylor wrote:
> 
> On Mon, Oct 21, 2002 at 11:01:59AM -0400, Pierre A. Humblet wrote:
> >Cygwin scans the passwd and group files to map sids
> >to/from uid & gid. It does so even for the current user,
> >although the relevant mappings are stored internally.
> >This is inefficient and causes problems (e.g. gcc produces
> >non executable files) as soon as /etc/passwd is incomplete.
> 
> It's only supposed to be doing this for the first cygwin process that
> start up on a given console.  Is that, again, no longer the case?  

What is "doing this"? Cygwin initially reads the files into memory.
No change there.
Currently, each time it gets/sets a file mode, it scans the internal
copies of passwd and group to map gid to/from sid and to map uid 
to/from sid. It is already optimized to avoid the uid scan when the 
file uid is that of the current user.

The patch extends the optimization to the 3 other mappings (gid->sid,
sid->uid, sid->gid) for the current user (the most common case). 
As a positive side effect, Cygwin then behaves well even when the user 
sid is not present in passwd (a common occurrence, judging from the
"gcc produces non executable .exe" traffic on the cygwin list).

> It seems like we keep drifting here.  We shouldn't be incurring the
> /etc/group and /etc/passwd startup costs even when ntsec isn't
> available.
No change at all in startup.
The files are read once, with or without ntsec, to find the user uid/gid
from the sid (if the sid is present) or from the user name.

Pierre

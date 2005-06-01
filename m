Return-Path: <cygwin-patches-return-5502-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24186 invoked by alias); 1 Jun 2005 09:46:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24164 invoked by uid 22791); 1 Jun 2005 09:45:56 -0000
Received: from service.sh.cvut.cz (HELO service.sh.cvut.cz) (147.32.127.214)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 01 Jun 2005 09:45:56 +0000
Received: from localhost (localhost [127.0.0.1])
	by service.sh.cvut.cz (Postfix) with ESMTP id 93B6D1A33F4
	for <cygwin-patches@cygwin.com>; Wed,  1 Jun 2005 11:45:54 +0200 (CEST)
Received: from service.sh.cvut.cz ([127.0.0.1])
	by localhost (service [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04635-04 for <cygwin-patches@cygwin.com>;
	Wed, 1 Jun 2005 11:45:53 +0200 (CEST)
Received: from logout.sh.cvut.cz (logout.sh.cvut.cz [147.32.127.203])
	by service.sh.cvut.cz (Postfix) with ESMTP id 881DC1A33F1
	for <cygwin-patches@cygwin.com>; Wed,  1 Jun 2005 11:45:53 +0200 (CEST)
Received: from logout (logout [147.32.127.203])
	by logout.sh.cvut.cz (Postfix) with ESMTP id 3AE6F3C306
	for <cygwin-patches@cygwin.com>; Wed,  1 Jun 2005 11:45:54 +0200 (CEST)
Date: Wed, 01 Jun 2005 09:46:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Re: Probably unnecessary InterlockedCompareExchangePointer in
 List_remove in thread.h
In-Reply-To: <20050530183915.GB15421@trixie.casa.cgf.cx>
Message-ID: <20050601104028.J67887@logout.sh.cvut.cz>
References: <20050529165435.H81503@logout.sh.cvut.cz>
 <20050530105312.GA9933@calimero.vinschen.de> <20050530193427.C19887@logout.sh.cvut.cz>
 <20050530183330.GA15421@trixie.casa.cgf.cx> <20050530183915.GB15421@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q2/txt/msg00098.txt.bz2

I think that the InterlockedCompareExchangePointer had some meaning there. I
have been studying this problem a bit more and I think that I have found the
reason it should be present:

Suppose there are two threads. One is trying to insert a new node and the
second is trying to remove head, both using the same list. Now what if we have
this scenario:

1. List_remove executes up to the point where it has value of head->next
prepared to be stored to head (line 20) but has not done so yet.

2. List_insert executes the atomic compare and exchange of the
head with the new node making the new node into new head (line 8).

3. List_remove stores the value of head->next that it has computed in step 1 to
head variable (line 20).

4. At this point both the new head inserted by List_insert and the old head
have been lost because we have overwritten the head variable with pointer to
to the element that was at the beginning next to head.

The InterlockedCompareExchangePointer prevents this situation for the price of
double synchronization. The problem is that List_insert employs what is called
lock-free approach. It doesn't honor the lock in List_remove and changes state
behind Lock_remove's back even if it has the list locked.

After all the way it was before my patch seems to be the best because it allows
for concurency in List_insert.


     1  template <class list_node> inline void
     2  List_insert (list_node *&head, list_node *node)
     3  {
     4    if (!node)
     5      return;
     6    do
     7      node->next = head;
     8    while (InterlockedCompareExchangePointer (&head, node, node->next) !=
node->next);
     9  }
    10
    11  template <class list_node> inline void
    12  List_remove (fast_mutex &mx, list_node *&head, list_node const *node)
    13  {
    14    if (!node)
    15      return;
    16    mx.lock ();
    17    if (head)
    18      {
    19        if (head == node)
    20          head = head->next;
    21        else
    22          {
    23            list_node *cur = head;
    24
    25            while (cur->next && node != cur->next)
    26              cur = cur->next;
    27            if (node == cur->next)
    28              cur->next = cur->next->next;
    29          }
    30      }
    31    mx.unlock ();
    32  }



VH


On Mon, 30 May 2005, Christopher Faylor wrote:

> On Mon, May 30, 2005 at 02:33:30PM -0400, Christopher Faylor wrote:
> >I think this patch should be ok to apply.
>
> So I applied it.  I beefed up the ChangeLog entry a little more
> descriptive about the reason for the change (even though that may not be
> 100% GNU compliant).
>
> Thanks.
>
> cgf
>

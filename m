Return-Path: <cygwin-patches-return-2730-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21632 invoked by alias); 26 Jul 2002 13:43:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21618 invoked from network); 26 Jul 2002 13:43:21 -0000
Message-ID: <3D415128.373F4E59@ieee.org>
Date: Fri, 26 Jul 2002 06:43:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: setgroups
References: <3.0.5.32.20020726000410.00813de0@mail.attbi.com> <20020726105948.A30785@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00178.txt.bz2


Corinna Vinschen wrote:

> > Here is setgroups.
> 
> Why did you add a class cygsidarray while there's already a class
> cygsidlist?
> 
> I'm sorry but it would really be helpful if you could add a few
> words about what you did.  The patch is not that small and
> contains more than just a new function setgroups()...  E. g. what
> is the rational to divide get_group_sidlist into three functions?

The idea is that setgroups finds the group sids in /etc/group and stores 
them in a structure in cygheap->user. That structure must be cmalloc'ed,
hence the new class. The primary group sid is also stored there,
which requires minor changes in internal_getlogin and setegid.
setgroups returns an error if sids are not in /etc/group.

When seteuid is called, create_token checks if setgroups was called. 
+ If not, it does exactly as before and calls the former get_group_sidlist, 
which is broken into get_initgroups_sidlist and get_token_group_sidlist
for software reuse reasons (see below).
+ If setgroups has been called, create_token calls get_setgroups_sidlist,
which copies the group sids from the cygheap to the temporary cygsidlist
and which also calls get_token_group_sidlist (reuse software).

Sorry if this is too terse, I'd be happy to answer more questions.

Pierre

Return-Path: <cygwin-patches-return-3440-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31092 invoked by alias); 21 Jan 2003 16:45:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31049 invoked from network); 21 Jan 2003 16:45:50 -0000
Message-ID: <3E2D79A7.DCC9AF74@ieee.org>
Date: Tue, 21 Jan 2003 16:45:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Races in group/passwd code (was Re: etc_changed, passwd & group)
References: <3.0.5.32.20030117233612.007ed390@mail.attbi.com> <3.0.5.32.20030120215131.007f9740@h00207811519c.ne.client2.attbi.com> <20030121051325.GA4667@redhat.com> <20030121153538.GA24356@redhat.com> <3E2D6CF9.FF47B7F4@ieee.org> <20030121161115.GA13536@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00089.txt.bz2

Christopher Faylor wrote:

> You'd need a per-thread buffer to accomplish that.  I assume that
> is what you had in mind.

If you look at them, most internal_get{pw,gr} calls from outside
of passwd.cc and grp.cc only want the {u,g}id, the sid or the name,
but never the other fields. 
I wanted to avoid copying the entire line, at least in the first
two cases.

I was thinking of making the internal functions take a variable
number of arguments. The first would be as today, the second would 
be a control field specifying what is needed, and the others 
(typically only 1) would be pointers to {u,g}id, cygsid or
a name, in a well know order. Those fields would then be filled 
inside the internal_getXX routine.
The problem with "name" is that today we enforce no upperbound
on the length (but it would be easy to do).
I think name is only looked up in seteuid (outside of uinfo, 
where there is no multithreading anyway).

There are also internal cygwin routines outside of passwd.cc
and grp.cc (e.g. in security.cc) that scan the entire 
{passwd, group} file. I don't know how to avoid keeping a 
(reader) lock during the entire operation.
 
> I wonder how many inexplicable "cygwin hangs" issues this is
> responsible for.

Problems only happen when updating passwd/group while a program
is running. At least in case of the recent BSOD, users were
very good correlating the two events.

Pierre

Return-Path: <cygwin-patches-return-3432-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12267 invoked by alias); 21 Jan 2003 15:37:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12231 invoked from network); 21 Jan 2003 15:37:17 -0000
Message-ID: <3E2D6994.F6243D22@ieee.org>
Date: Tue, 21 Jan 2003 15:37:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: etc_changed, passwd & group
References: <3.0.5.32.20030117233612.007ed390@mail.attbi.com> <3.0.5.32.20030120215131.007f9740@h00207811519c.ne.client2.attbi.com> <20030121051325.GA4667@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00081.txt.bz2

Christopher Faylor wrote:

> Also, implying that there is a one-to-one correspondence between my
> ChangeLog entries and the ones for your patches is a little simplistic.

It would be, but I never compared them. I only remarked that this
became one of your largest recent projects (in terms of ChangeLog size). 

> Sorry, no.  I want to keep the input argument to etc::init.

That one keeps mystifying me.
It's like changing open to have "fh = open(fh, filename, flags)".
I have no problem with passing filename!

> If you are going to be modifying the isunintialized thing
> then why didn't you go all the way and get rid of the repeated
> code at the beginning of all of these functions?  Surely there
> is some way not to have to:
> 
>   if (pr.isuninitialized () || (check && pr.isinitializing ()))
>     read_etc_passwd ();

If I was writing the code from scratch I would have only 
pr.isinitializing (check). However these functions are inline and
the only effect of changing now (in many spots) would be aesthetic.
To the contrary, modifying the body of isinitializing brings you
real gains, both in logic (call init only once) and in efficiency 
(if it matters), while not changing the returned values.

You had no comments on my last observation, MS doesn't raise an event 
on mv and rm. I just looked up the MSDN site
<http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/base/findfirstchangenotification.asp>
I think we should add FILE_NOTIFY_CHANGE_FILE_NAME.

Pierre

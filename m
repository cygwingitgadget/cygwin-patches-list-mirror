Return-Path: <cygwin-patches-return-4266-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21929 invoked by alias); 30 Sep 2003 03:22:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21920 invoked from network); 30 Sep 2003 03:22:35 -0000
Message-Id: <3.0.5.32.20030929230848.00833740@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 30 Sep 2003 03:22:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Fixing the PROCESS_DUP_HANDLE security hole (part
  1).
In-Reply-To: <20030930031448.GA22866@redhat.com>
References: <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
 <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00282.txt.bz2

At 11:14 PM 9/29/2003 -0400, you wrote:
>On Mon, Sep 29, 2003 at 09:55:25PM -0400, Pierre A. Humblet wrote:
>>Here is a patch that allows to open master ttys without giving
>>full access to the process, at least for access to the ctty. 
>>
>>It works by snooping the ctty pipe handles and duplicating them
>>on the cygheap, for use by future opens in descendant processes.
>>
>>It passes all the tests I tried, but considering my lack of knowledge
>>about ttys, everything is possible.
>
>Does it pass doing an "echo > /dev/tty1" where /dev/tty1 is a tty in
>another command window?

Of course, but not (anymore) if the command is issued by a user that
has no access rights to /dev/tty1.

Pierre

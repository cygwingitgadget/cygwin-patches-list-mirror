Return-Path: <cygwin-patches-return-4265-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19045 invoked by alias); 30 Sep 2003 03:14:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19036 invoked from network); 30 Sep 2003 03:14:48 -0000
Date: Tue, 30 Sep 2003 03:14:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Fixing the PROCESS_DUP_HANDLE security hole (part 1).
Message-ID: <20030930031448.GA22866@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00281.txt.bz2

On Mon, Sep 29, 2003 at 09:55:25PM -0400, Pierre A. Humblet wrote:
>Here is a patch that allows to open master ttys without giving
>full access to the process, at least for access to the ctty. 
>
>It works by snooping the ctty pipe handles and duplicating them
>on the cygheap, for use by future opens in descendant processes.
>
>It passes all the tests I tried, but considering my lack of knowledge
>about ttys, everything is possible.

Does it pass doing an "echo > /dev/tty1" where /dev/tty1 is a tty in
another command window?

cgf

Return-Path: <cygwin-patches-return-4283-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19755 invoked by alias); 7 Oct 2003 02:18:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19739 invoked from network); 7 Oct 2003 02:18:59 -0000
Date: Tue, 07 Oct 2003 02:18:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: shared.cc debug info.
Message-ID: <20031007021858.GA10077@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20031006212612.008203b0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031006212612.008203b0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00002.txt.bz2

On Mon, Oct 06, 2003 at 09:26:12PM -0400, Pierre A. Humblet wrote:
>Here is a pretty simple patch..

Ok to include.

>BTW, are there more questions about "[Patch]: Fixing the PROCESS_DUP_HANDLE
>security  hole (part 1)." from last week?

Yes, actually.  I am still puzzling over all of the extra logic that you
pass in cygheap.  I don't understand the need for special handling of
children of the process that owns the controlling tty.

However, I haven't had time to look at this in any great detail since
I'm pursuing my own cygwin interests at the moment, when my real job
doesn't interfere.  Although in this case, I'm actually doing cygwin
work for Red Hat but it's not my real job, but there is still potential
revenue associated with it, but...

cgf

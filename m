Return-Path: <cygwin-patches-return-4492-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13090 invoked by alias); 9 Dec 2003 05:08:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13075 invoked from network); 9 Dec 2003 05:08:34 -0000
Date: Tue, 09 Dec 2003 05:08:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Fixing the PROCESS_DUP_HANDLE security hole (part 1).
Message-ID: <20031209050834.GA15178@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20031208221010.0082f7b0@incoming.verizon.net> <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net> <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net> <3.0.5.32.20031208221010.0082f7b0@incoming.verizon.net> <3.0.5.32.20031208224603.0082cc00@incoming.verizon.net> <20031209043601.GA14369@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209043601.GA14369@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00211.txt.bz2

On Mon, Dec 08, 2003 at 11:36:01PM -0500, Christopher Faylor wrote:
>I would have but the information that the fhandler contains the
>controlling tty is lost by the time dup is called.  Hmm.  I guess I
>could just check the io_handle.  I'll do that.

I did this but, in testing, found that there are still other problems
with setsid assuming that it can close the cygheap ctty when there may
still be open fds which wouldn't like that to happen.

I'll work on that tomorrow.

cgf

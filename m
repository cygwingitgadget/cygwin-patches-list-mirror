Return-Path: <cygwin-patches-return-4343-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27230 invoked by alias); 6 Nov 2003 15:32:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27210 invoked from network); 6 Nov 2003 15:32:43 -0000
Date: Thu, 06 Nov 2003 15:32:00 -0000
From: Christopher Faylor <cgf-no-personal-replies-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Fixing the PROCESS_DUP_HANDLE security hole (part 1).
Message-ID: <20031106153242.GA14828@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net> <3.0.5.32.20031105200201.00828100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20031105200201.00828100@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00062.txt.bz2

On Wed, Nov 05, 2003 at 08:02:01PM -0500, Pierre A. Humblet wrote:
>Ping? 
>
>This has been pending for a while. See also
><http://cygwin.com/ml/cygwin-patches/2003-q4/msg00003.html>

I haven't forgotten about it.  Unfortunately, in quick scans, the
implementation gives me heartburn.  That doesn't mean that this isn't
the correct way to do this, it just means that my initial gut feeling
is negative.

So, I haven't had much time to give this the attention it deserves and
either accept it or offer another alternative.  If it was in anything
other than tty code, it probably wouldn't have languished this long.

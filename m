Return-Path: <cygwin-patches-return-4547-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25374 invoked by alias); 1 Feb 2004 18:39:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25359 invoked from network); 1 Feb 2004 18:39:05 -0000
Date: Sun, 01 Feb 2004 18:39:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: ciresrv.parent
Message-ID: <20040201183904.GA23376@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040131141848.008138b0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040131141848.008138b0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00037.txt.bz2

On Sat, Jan 31, 2004 at 02:18:48PM -0500, Pierre A. Humblet wrote:
>Fortunately it is never used in the case of spawn: all handles are
>inherited, or the parent does the work (sockets). 

The one placed the handle is actually used is in
fhandler_socket::fixup_after_exec.  I'd like Corinna's confirmation
before this patch is checked in.

cgf

Return-Path: <cygwin-patches-return-5121-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1090 invoked by alias); 12 Nov 2004 04:33:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1079 invoked from network); 12 Nov 2004 04:33:15 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 12 Nov 2004 04:33:15 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 6ED781B3E5; Thu, 11 Nov 2004 23:33:22 -0500 (EST)
Date: Fri, 12 Nov 2004 04:33:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041112043322.GA21377@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00122.txt.bz2

On Thu, Nov 11, 2004 at 10:48:57PM -0500, Pierre A. Humblet wrote:
>Now that 1.5.12 is out, here is a patch to fix the PROCESS_DUP_HANDLE
>security hole.  It uses a new approach to reparenting: the parent
>duplicates the exec'ed process handle when signaled by the child.

Can you refresh my memory (a URL is fine) on "the PROCESS_DUP_HANDLE
security hole"?

I'm not 100% certain but I think if you cast back into the dim recesses
of cygwin's past, you might find that this is the way things used to be
done, to some degree.

cgf

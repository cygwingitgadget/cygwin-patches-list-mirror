Return-Path: <cygwin-patches-return-4554-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3910 invoked by alias); 3 Feb 2004 16:52:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3892 invoked from network); 3 Feb 2004 16:52:08 -0000
Date: Tue, 03 Feb 2004 16:52:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: heap_chunk_size
Message-ID: <20040203165208.GA15230@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040202202201.007e7e80@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040202202201.007e7e80@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00044.txt.bz2

On Mon, Feb 02, 2004 at 08:22:01PM -0500, Pierre A. Humblet wrote:
>Here is a no brainer patch that eliminates the use of "heap_chunk" in
>the cygwin shared.  That removes a source of DOS attack and it's
>another step towards the demise of the cygwin shared.

This isn't a no-brainer.  This value is stored in the shared memory to
avoid the runtime cost of registry lookups by every cygwin program.

cgf

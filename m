Return-Path: <cygwin-patches-return-4555-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6494 invoked by alias); 3 Feb 2004 17:26:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6477 invoked from network); 3 Feb 2004 17:26:27 -0000
Message-ID: <401FD9C0.D89112C2@phumblet.no-ip.org>
Date: Tue, 03 Feb 2004 17:26:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: heap_chunk_size
References: <3.0.5.32.20040202202201.007e7e80@incoming.verizon.net> <20040203165208.GA15230@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q1/txt/msg00045.txt.bz2



Christopher Faylor wrote:
> 
> On Mon, Feb 02, 2004 at 08:22:01PM -0500, Pierre A. Humblet wrote:
> >Here is a no brainer patch that eliminates the use of "heap_chunk" in
> >the cygwin shared.  That removes a source of DOS attack and it's
> >another step towards the demise of the cygwin shared.
> 
> This isn't a no-brainer.  This value is stored in the shared memory to
> avoid the runtime cost of registry lookups by every cygwin program.

A process only reads the registry when (!cygheap->user_heap.base),
i.e. when it starts from Windows. Previously it read the registry when it
was the first Cygwin process on the machine. There is a penalty, but it's 
small.
The chunk size could also be stored in the user shared (and read if it's
not in the cygheap). Actually that would be an even simpler patch, 
giving the same security. I'll send it tonight.

Pierre

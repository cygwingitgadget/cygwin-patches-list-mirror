Return-Path: <cygwin-patches-return-2533-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7333 invoked by alias); 28 Jun 2002 09:51:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7319 invoked from network); 28 Jun 2002 09:51:20 -0000
Date: Fri, 28 Jun 2002 03:57:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to pass file descriptors
Message-ID: <20020628115118.Z1188@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.30L.0206261539550.20345-600000@biohazard-cafe.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30L.0206261539550.20345-600000@biohazard-cafe.mit.edu>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00516.txt.bz2

On Wed, Jun 26, 2002 at 03:45:07PM -0400, David E Euresti wrote:
> Hello,
> 	I finally am able to send in the patch to pass file descriptors.
> There's still some work to be done like adding security and such, but
> otherwise it works.
> There are two new files cygserver_handle.cc and cygserver_handle.h  these
> go into src/winsup/cygwin

I have a problem with this patch.  First of all, it doesn't fit well
into current CVS since I've moved most of the socket I/O implementation
into fhandler_socket.cc a few days ago.

More problematic is the approach to use cygserver for this.  I've talked
to Chris about passing descriptors and we agree in that we want to try
under all circumstances to find a solution which doesn't need cygserver.
A stand-alone cygwin1.dll should allow that.  Since descriptor passing
only works on AF_UNIX sockets anyway and these are encapsulated inside
of Cygwin, we don't have to care for any backward compatibility.

So we discussed an approach which basically acts like this:

We could actually use a piece of shared mem, this is created by the
sending process and filled with it's own pid, the handles and possible
extra information (The stuff which you've packed into that structure,
binmode/textmode etc.).  Then it sends a datablock on the socket, giving
additionally the "name" of the shared memory.  Now it blocks, waiting
for some sort of "signal" given by the receiving process.  Signalling
could be accomplished using a named event object using the same name
as the shared mem object.

The receiving process extracts the name info, opens the shared mem
and reads the info.  Now it tries to duplicate the handles which
may or may not work.  If it works, it signals the originator that
everything's perfectly fine.

If it doesn't work, it fills it's own winpid into the shared mem
and signals "Hey, I'm lost here!".  Now it waits for a signal of
the sender process.  The sender gets the pid and tries by itself
to duplicate the handles.  If that works, it fills the handles into
the shared memory or it gives up.  Either way, it signals the result
to the receiver.  The receiver evaluates the signal, either creating
matching fhandlers or returning fd=-1 and signals the sender that
it's done.  Then it closes the shared mem.

The sender knows that we're done, closes the shared mem and returns.

The above approach depends on the PROCESS_DUP_HANDLE rights of the
involved processes unfortunately.  So, a slighty different way is,
the receiving process could duplicate it's own process handle for
the sender, giving the PROCESS_DUP_HANDLE permission, and return this
handle to the sender.  Then the sender always (mostly?) has the 
permission to create the handles for the receiver.

What do you think?

I'm actually very interested in getting that working so I'd appreciate
if we could work together on this.


Thanks in advance,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.

Return-Path: <cygwin-patches-return-2750-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31711 invoked by alias); 31 Jul 2002 00:28:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31697 invoked from network); 31 Jul 2002 00:28:51 -0000
Date: Tue, 30 Jul 2002 17:28:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Performance: fhandler_socket and ready_for_read()
Message-ID: <20020731002910.GD17985@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <07f001c2381e$43118070$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07f001c2381e$43118070$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00198.txt.bz2

On Wed, Jul 31, 2002 at 12:10:13AM +0100, Conrad Scott wrote:
>Attached is a socket patch that can make some programs by as much as 50
>times quicker.
>
>In looking for something else, it struck me that there doesn't seem to
>be any reason for the fhandler_base::ready_for_read() method when
>reading from sockets.  All that the method seems to be doing is
>checking for signals while waiting for data to arrive on the relevant
>fhandler object (eventually it calls peek_socket() which does a
>select() on the socket).  The fhandler_socket::read() method already
>handles signals happily (if the socket is blocking and winsock2 is
>available) since it uses an overlapped read and then blocks on the
>socket event and the signal_arrived event.
>
>Assuming that there is thus no need for this call to ready_to_read()
>for sockets (and please tell me if I'm wrong here), the following patch
>provides an stubbed fhandler_read::ready_for_read() that does nothing
>when that is valid.

If sockets are already testing for signals then ready_for_read is
redundant and even incorrect.

I think the actual way to fix this is to add a get_r_no_interrupt method
to fhandler_socket.  This avoids a call to ready_for_read.  This wasn't
previously possible since this wasn't a virtual method but now it is.

Unless you disagree, would you mind just adding a get_r_no_interrupt method
to fhandler_socket, using the same criteria as your ready_for_read stub?

Thanks for finding this, by the way.  A speed improvement in socket handling
is very welcome.  Sounds like it is time for a 1.3.13 release.

cgf

Return-Path: <cygwin-patches-return-3113-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9167 invoked by alias); 4 Nov 2002 04:29:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9124 invoked from network); 4 Nov 2002 04:28:59 -0000
Date: Sun, 03 Nov 2002 20:29:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: UNIX domain socket patch
Message-ID: <20021104043052.GB17407@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <03f001c23504$5be06890$6132bc3e@BABEL> <025701c235a1$058cb730$6132bc3e@BABEL> <20020729150716.X3921@cygbert.vinschen.de> <007a01c23721$31a7bc80$6132bc3e@BABEL> <002e01c23728$025a0a30$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002e01c23728$025a0a30$6132bc3e@BABEL>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00064.txt.bz2

How about this patch?  Did anyone ever look at it?

Corinna?  Egor?

cgf

On Mon, Jul 29, 2002 at 06:47:29PM +0100, Conrad Scott wrote:
>And one more time with the patch attached as text rather than
>binary.
>
>This thread really should teach me something, I just wish I knew
>what :-(
>
>// Conrad
>

>2002-07-27  Conrad Scott  <conrad.scott@dsl.pipex.com>
>
>	* fhandler.h
>	(fhandler_socket::connect_secret_initialized): New field.
>	(fhandler_socket::peer_sun_path): Ditto.
>	(fhandler_socket::set_peer_sun_path): New method.
>	(fhandler_socket::get_peer_sun_path): Ditto.
>	(fhandler_socket::set_connect_secret): Change return type to bool.
>	(fhandler_socket::get_connect_secret): Ditto.
>	(fhandler_socket::create_connect_secret): Ditto.
>	(fhandler_socket::check_peer_secret_event): Ditto.
>	(fhandler_socket::signal_secret_event): Remove method.
>	* fhandler_socket.cc (ENTROPY_SOURCE_NAME): Remove #define.
>	(get_inet_addr): Check that the UNIX domain sun_path refers to a
>	socket file.  Add the SOCKET_COOKIE string to the sscanf(3)
>	format.  Check the return value from sscanf(3) and set errno as
>	appropriate.  Add save_errno objects as appropriate.
>	(fhandler_socket::fhandler_socket): Initialize every field.
>	(fhandler_socket::~fhandler_socket): Call close_secret_event().
>	Free peer_sun_path if required.
>	(fhandler_socket::set_connect_secret): Change return type to bool.
>	Add asserts.  Use explicit destructor and free(3) rather than
>	delete.  Add tracing messages.  Set connect_secret_initialized as
>	appropriate.  Return true if the connect_secret has been
>	initialized.
>	(fhandler_socket::get_connect_secret): Add asserts.
>	(fhandler_socket::create_secret_event): Change return type to
>	bool.  Add asserts.  Add AF_LOCAL marker to tracing statements.
>	Change all tracing failure statements to syscall level.  Set errno
>	as appropriate.  Change the secret_event to be a semaphore.
>	(fhandler_socket::signal_secret_event): Remove method.
>	(fhandler_socket::close_secret_event): Wait for the secret event
>	(or an error) to be signalled before closing the event.
>	(fhandler_socket::check_peer_secret_event): Change return type to
>	bool.  Add asserts.  Add AF_LOCAL marker to tracing statements.
>	Set errno as appropriate.  Change all tracing failure statements
>	to syscall level.  Change to support new UNIX domain emulation
>	protocol.
>	(fhandler_socket::fixup_after_fork): Remove ineffective call to
>	fork_fixup.  Signal the secret_event to keep handle count and
>	signal count in sync.
>	(fhandler_socket::dup): Duplicate every field.  In particular,
>	explicitly duplicate the secret event handle and protect it.
>	(fhandler_socket::bind): Check that the requested address family
>	matches the socket's address family.  Change tracing messages to
>	use WSAGetLastError rather than errno.  For UNIX domain sockets,
>	create the secret event before creating the file system socket,
>	then immediately signal that event.
>	(fhandler_socket::connect): Remove the secret_check_failed and
>	in_progress flags.  Check that the requested address family
>	matches the socket's address family.  For the first connect on a
>	UNIX domain socket, check the that the server's secret event
>	exists; then bind the local socket and create its own secret
>	event.  Also set the peer sun path here.  Remove the old secret
>	event code.  Rewrite code that generates the errno for
>	non-blocking sockets to match SUSv3.  Change the code that sets
>	had_connect_or_listen likewise.
>	(fhandler_socket::accept): Remove the secret_check_failed and
>	in_progress flags.  Remove the old secret event code.  Check peer
>	secret event and do a hard reset on the accepted socket if it
>	fails.  Duplicate the peer sun path and the had_connect_or_listen
>	flag into the accepted fhandler.
>	(fhandler_socket::getsockname): Call ::getsockname() even for UNIX
>	domain sockets as an error check.
>	(fhandler_socket::getpeername): Add special case for UNIX domain
>	sockets as per the getsockname method.
>	(fhandler_socket::close): Close the secret event before, rather
>	than after, closing the underlying socket and return error status
>	as appropriate.
>	(fhandler_socket::set_sun_path): Add assert.  Free the previous
>	sun path as appropriate.
>	(fhandler_socket::set_peer_sun_path): New method.
>	* net.cc (cygwin_socket): Check for supported protocol families.

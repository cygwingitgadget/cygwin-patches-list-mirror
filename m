Return-Path: <cygwin-patches-return-2736-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9982 invoked by alias); 27 Jul 2002 00:25:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9963 invoked from network); 27 Jul 2002 00:25:00 -0000
Message-ID: <03f001c23504$5be06890$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: UNIX domain socket patch
Date: Fri, 26 Jul 2002 17:25:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_03ED_01C2350C.BD56D7A0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00184.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_03ED_01C2350C.BD56D7A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 6361

This is a rather long email, so I've made out like I was back in
ISO 9001 land and gone overboard with the "change request".  Enjoy
:-)

** Summary:

This is a patch for a race in cygwin's UNIX domain socket
authentication protocol.  It also fixes a couple of other minor
problems with cygwin's UNIX domain socket implementation.

This patch has been tested on both win2k and win98SE (but not on
winsock 1).  It has been tested with blocking and non-blocking
socket calls (and in the latter case both with polling for
connections and with select(2) calls).  It has also been tested
with a threaded client.

** Other fixes:

This patch also fixes:

 * getpeername(2) for UNIX domain sockets (currently this just
returns the information for the underlying INET socket).

 * with a non-blocking socket, a server couldn't poll a UNIX
domain socket by calling accept(2) repeatedly.

 * a socket could be created with one address family and then
connected/bound to a different one.

 * there was no checking of the UNIX domain socket file, so you
could simply create a standard file with the relevant data in it
and the code would not notice.


** Known issues in this patch:

One issue with the new protocol is that the client cannot close
its connection until the server has performed its half of the
protocol.  This can only be an issue in the following situation:

 * the client just writes to the connection (as a read would block
anyhow)

 * the server is *really* slow at accepting connections (or is
hung)

If the close is called before the client exits, it can be
interrupted (by a signal).  Otherwise, the solution is to kill the
server (or kill the client from the Windows Task Manager).

A second issue is that there is no code to handle multi-threading,
which could be a problem if a socket is shared between threads.
This was a problem in the previous version of the code as well.
I'll submit another patch to fix this.

** Problem with previous protocol:

The original authentication protocol relies on both client and
server creating a win32 event object with a "secret" name.  The
secret part of the name is a random key that is stored in the UNIX
domain socket file and is thus only accessible to whoever can read
that file.  Any process (client or server) trying to use the
underlying socket without knowledge of the secret key is prevented
from receiving connections.

The handshake is that on accept or connect, a process sets its own
secret event object and waits on the peer process's secret event
object.  The race is then as follows.  If two clients attempt to
connect to the same server, their two requests will be placed on
the server's connection queue and their connect requests will
succeed.  They will then both signal their own secret events and
wait on the server's secret event.  When the accept request
succeeds in the server with one or other of these two requests,
the server will signal its own secret event and wait on the
relevant peer process's secret event.  This wait in the server
will succeed immediately (since the clients signal their own
events as soon as the connect succeeds for them).  The problem is
that both the clients are waiting on the one server secret event
object, and it is possible for the "wrong" client to wake up.  At
this point, the client whose connection has been accepted is still
blocked on the server's secret event while the client whose
connection is still pending, carries on as if it had been
authenticated.  If the server now tries to read some data from the
client, it will block as the client itself is blocked.

In testing cygserver with UNIX domain sockets, I was getting such
blocks frequently.  At each block, there is a ten second delay (as
the protocol times out) and that client request fails.

There is also a problem with the protocol in that for non-blocking
connections, where the client calls connect(2) and then waits in
select(2) until the connection is signalled, it never performs its
half of the handshake and so could connect to unauthorized
servers.

** New protocol:

The new protocol is very similar to the original one, using secret
objects with the same names as before, except that now the objects
are semaphores rather than event objects and the processes do
authentication by checking for the existence of the semaphore
rather than by waiting on it.

In detail, both client and server create their semaphore before
attempting to connect.  In the client's case this implies that it
needs to explicitly bind(2) to a system-provided INET address as
the port number is part of the secret event name (this binding
would otherwise be done implicitly by the call to connect(2) so
this doesn't change the behaviour of the application).  In the
client, when the connect(2) call succeeds it merely needs to check
that the server's secret event exists: if so, it succeeds;
otherwise it resets the connection and fails.

The logic is fundamentally the same in the server (when the
accept(2) call succeeds, just check for the existence of the
client secret event) except for one annoying twist.  It is
possible for a client that doesn't read from the socket to connect
to a server, write some data and close the socket *before* the
server's accept(2) call returns that connection (i.e. the whole
thing happens with the client connection sitting on the server's
pending connection queue).  In this case, the server would reject
the connection since the client could have closed its secret event
too soon.  Thus for this one problem, the server does release the
client's semaphore (as a "I've seen your secret event" signal) and
the client waits on this signal in its close(2) code.

For simplicity in the code, when a secret event is duplicated (by
dup(2) or fork(2) for example) the secret event is also signalled
(in both the server and the client).  The server also signals its
secret event as soon as it creates it.  This means that in a
server, the release count on the semaphore equals the number of
handles there are to that socket (and thus to that event), while
in the client the release count is one lower than the handle count
and so it blocks in the last close, until the server signals it
too that is.

** Grovelling conclusion:

I think this patch is really groovy and I've just spent the last
week and a half sweating over it, so please apply it :-)

// Conrad


------=_NextPart_000_03ED_01C2350C.BD56D7A0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 4010

2002-07-27  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler.h
	(fhandler_socket::connect_secret_initialized): New field.
	(fhandler_socket::peer_sun_path): Ditto.
	(fhandler_socket::set_peer_sun_path): New method.
	(fhandler_socket::get_peer_sun_path): Ditto.
	(fhandler_socket::set_connect_secret): Change return type to bool.
	(fhandler_socket::get_connect_secret): Ditto.
	(fhandler_socket::create_connect_secret): Ditto.
	(fhandler_socket::check_peer_secret_event): Ditto.
	(fhandler_socket::signal_secret_event): Remove method.
	* fhandler_socket.cc (ENTROPY_SOURCE_NAME): Remove #define.
	(get_inet_addr): Check that the UNIX domain sun_path refers to a
	socket file.  Add the SOCKET_COOKIE string to the sscanf(3)
	format.  Check the return value from sscanf(3) and set errno as
	appropriate.  Add save_errno objects as appropriate.
	(fhandler_socket::fhandler_socket): Initialize every field.
	(fhandler_socket::~fhandler_socket): Call close_secret_event().
	Free peer_sun_path if required.
	(fhandler_socket::set_connect_secret): Change return type to bool.
	Add asserts.  Use explicit destructor and free(3) rather than
	delete.  Add tracing messages.  Set connect_secret_initialized as
	appropriate.  Return true if the connect_secret has been
	initialized.
	(fhandler_socket::get_connect_secret): Add asserts.
	(fhandler_socket::create_secret_event): Change return type to
	bool.  Add asserts.  Add AF_LOCAL marker to tracing statements.
	Change all tracing failure statements to syscall level.  Set errno
	as appropriate.  Change the secret_event to be a semaphore.
	(fhandler_socket::signal_secret_event): Remove method.
	(fhandler_socket::close_secret_event): Wait for the secret event
	(or an error) to be signalled before closing the event.
	(fhandler_socket::check_peer_secret_event): Change return type to
	bool.  Add asserts.  Add AF_LOCAL marker to tracing statements.
	Set errno as appropriate.  Change all tracing failure statements
	to syscall level.  Change to support new UNIX domain emulation
	protocol.
	(fhandler_socket::fixup_after_fork): Remove ineffective call to
	fork_fixup.  Signal the secret_event to keep handle count and
	signal count in sync.
	(fhandler_socket::dup): Duplicate every field.  In particular,
	explicitly duplicate the secret event handle and protect it.
	(fhandler_socket::bind): Check that the requested address family
	matches the socket's address family.  Change tracing messages to
	use WSAGetLastError rather than errno.  For UNIX domain sockets,
	create the secret event before creating the file system socket,
	then immediately signal that event.
	(fhandler_socket::connect): Remove the secret_check_failed and
	in_progress flags.  Check that the requested address family
	matches the socket's address family.  For the first connect on a
	UNIX domain socket, check the that the server's secret event
	exists; then bind the local socket and create its own secret
	event.  Also set the peer sun path here.  Remove the old secret
	event code.  Rewrite code that generates the errno for
	non-blocking sockets to match SUSv3.  Change the code that sets
	had_connect_or_listen likewise.
	(fhandler_socket::accept): Remove the secret_check_failed and
	in_progress flags.  Remove the old secret event code.  Check peer
	secret event and do a hard reset on the accepted socket if it
	fails.  Duplicate the peer sun path and the had_connect_or_listen
	flag into the accepted fhandler.
	(fhandler_socket::getsockname): Call ::getsockname() even for UNIX
	domain sockets as an error check.
	(fhandler_socket::getpeername): Add special case for UNIX domain
	sockets as per the getsockname method.
	(fhandler_socket::close): Close the secret event before, rather
	than after, closing the underlying socket and return error status
	as appropriate.
	(fhandler_socket::set_sun_path): Add assert.  Free the previous
	sun path as appropriate.
	(fhandler_socket::set_peer_sun_path): New method.
	* net.cc (cygwin_socket): Check for supported protocol families.

------=_NextPart_000_03ED_01C2350C.BD56D7A0
Content-Type: application/octet-stream;
	name="af_local.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="af_local.patch.bz2"
Content-length: 9943

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

------=_NextPart_000_03ED_01C2350C.BD56D7A0--


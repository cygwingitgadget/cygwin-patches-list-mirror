Return-Path: <cygwin-patches-return-2739-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9940 invoked by alias); 27 Jul 2002 19:06:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9924 invoked from network); 27 Jul 2002 19:06:24 -0000
Message-ID: <025701c235a1$058cb730$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <03f001c23504$5be06890$6132bc3e@BABEL>
Subject: Re: UNIX domain socket patch
Date: Sat, 27 Jul 2002 12:06:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0254_01C235A9.669E49F0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00187.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0254_01C235A9.669E49F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 247

I've just found a typo in the previous version of the patch I
sent, so I've attached a new one.  All that's involved is
suppressing (or not) a compiler warning (I obviously wasn't
watching the compiles too carefully at the end there).

// Conrad


------=_NextPart_000_0254_01C235A9.669E49F0
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

------=_NextPart_000_0254_01C235A9.669E49F0
Content-Type: application/octet-stream;
	name="af_local.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="af_local.patch.bz2"
Content-length: 9956

QlpoOTFBWSZTWS4rt8wAF6zfgH+xe///////3+7/////YCTfPA7zZss7u7uA
Hn3vqm7V00UqPs1aYt7vt157fcdb77h77a33cRT31s+d00KFPW3dWdrt7tNb
vfd7sPrT4XvdzRJ1q9gW7vbF2yfO5zWq1o1769x9n3PQzXmty9rYlq3vDERB
o0JkAIJ6GqntPUptkaU009E8UeKNqbUAAAZASmhNCECaJppMU2jTU8pptGTS
eoGTagMhoABk0ZAJTEURU/JJsp6hoBtQ/VPUaG1NAAAAABoAGgBJpJCKp/pq
p6bVG0R+qepp+qHpDTymQDIaAAaGgAADygiRKaJ6amQJ6o8TRQM9SZtKaeKe
ofqI0HqAAHpqaaBoARJCCAQGgkxopsjJonqmT1PSaaaDQepiNHpGjQNAeA6g
bgqVJEWREGBAJBGMEEYgvaB+iPfegkF59/ss5wkISJIRDAWwUlEBoVQVS2WI
7ojYqpCsiMggyIUoxIloloiNsZSwGMRRKrUSUQsWUMllIxlzEwclyLkVkFgM
waznPe99UzUjBUikDdgUQsm8rmZGGHKTd83OKf17OwwNPna2rVr8TvmtTRPo
WURBgi7n/FhMXdwm6PoRdN/et/EvZuKbRGJippNItTVtUyaq7WmkoVyENmTQ
RiwuRLRXHUSULHRctQiQKnkSN+ISX7rSyfmWp2bjl9lqJ2BODmkO3wxkWKCK
gt623XXXgWL1dNSY86ECt09OTRGah9IaNydJmSZIQS0oIDRH1/acpArDsz65
cJ+itdIqsOJ1oJ9lm6yW7mqAhQ2JOItaXikTmBLuSXhjvvus2E2N3Zv5aFUG
RUYxiIKKaakRb0ZtvmFpVdlNOAMmyTleTMtwyRFGIxGXx3ag1baDIxUmJpCF
VKJWuOn+z67wpnfOZbQZMaO7u4k4lCcnWbOW2tNWShNSCGv7nZoJda64+fjK
hKXa56du56/o/g0xp0/lucujpr+Gk0gWDrZIfGntLFBFhcCnGC2fCSiLUG4m
3n2zc01VeBtGo70IDQdQbotWKkjw4o23EhIa5jWdXgVwVk2cVQ914lgp/mtt
UnhWkPbVwmOmIj4W6+zs+pqVVT4oOkFeMULCqp7oAAMPCHb89KKTKyiNU9JM
wWNbaWKSpbVJUWKsiEQsraJWgxIhRMTeKGyENYO1BS0EKFMtByjUY0BQosYW
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
IpwoSBcV2+YA

------=_NextPart_000_0254_01C235A9.669E49F0--


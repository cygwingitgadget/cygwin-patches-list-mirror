Return-Path: <cygwin-patches-return-2605-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31035 invoked by alias); 5 Jul 2002 10:46:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31006 invoked from network); 5 Jul 2002 10:46:27 -0000
Message-ID: <008301c22411$7cfc7900$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <20020705030630.GA24255@redhat.com>
Subject: Re: printfs in cygserver?
Date: Fri, 05 Jul 2002 03:46:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0080_01C22419.DE3F06D0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00053.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0080_01C22419.DE3F06D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 816

"Christopher Faylor" <cgf@redhat.com> write:
> There seems to be a lot of of "printfs" in cygserver code that
is
> apparently linked into cygwin.  I specifically noticed it it
> cygserver_transport_pipes.cc and cygserver_transport_sockets.cc.
> Is this being corrected?  We don't use raw printf in cygwin
code.

I've fixed this on the cygwin_daemon branch.  In case it's
something you'd like fixed immediately, attached is a (slightly
updated) copy of a patch I previously submitted to Rob that, among
other things, changes the cygserver code to use the xxx_printf
calls from "strace.h".  I'd be happy for this to go into HEAD;
it's not a functionality patch, more of a brisk clean-up and
rub-down patch :-)

// Conrad

nb. The patch includes a new file "src/winsup/cygwin/woutsup.h"
that I've attached separately.


------=_NextPart_000_0080_01C22419.DE3F06D0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 17105

2002-06-21  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* cygserver.cc: The tests for a duplicate server instance are now
	the responsibility of the transport layer.
	(request_loop): Use new `recoverable' flag in call to
	`cygserver_transport::accept ()' and shutdown on an unrecoverable
	error.
	(main): Never call `cygserver_init ()'.  Fake `cygserver_running'
	just for sending a shutdown request.
	* cygserver_client.cc (client_request::send): Comment out
	message-size tracing statements as verbose.
	(client_request::handle): Ditto.
	(client_request_get_version::check_version): #ifdef as DLL-only.
	(check_cygserver_available): Ditto.
	(cygserver_init): Ditto.
	* include/cygwin/cygserver.h
	(client_request_get_version::check_version): #ifdef as DLL-only.
	(check_cygserver_available): Ditto.
	(cygserver_init): Ditto.
	* include/cygwin/cygserver_transport.h
	(transport_layer_base::impersonate_client): #ifdef as
	cygserver-only.
	(transport_layer_base::revert_to_self): Ditto.
	(transport_layer_base::listen): Ditto.
	(transport_layer_base::accept): Ditto.  Add a `recoverable' out
	flag for error handling.
	* include/cygwin/cygserver_transport_sockets.h: Ditto.
	* include/cygwin/cygserver_transport_pipes.h: Ditto.
	(transport_layer_pipes): Change type of the `pipe_name' field.
	Remove the `inited' field, as unnecessary.  Add new
	`is_accepted_endpoint' field.
	* include/cygwin/cygserver_transport.cc
	(transport_layer_base::impersonate_client): #ifdef as
	cygserver-only.
	(transport_layer_base::revert_to_self): Ditto.
	* include/cygwin/cygserver_transport_sockets.cc
	(transport_layer_sockets::listen): #ifdef as cygserver-only.
	(transport_layer_sockets::accept): #ifdef as cygserver-only.
	Analyse any errno from `accept ()' and set `recoverable' as
	appropriate.
	* cygserver_transport_pipes.cc: Add local #define of
	`FILE_FLAG_FIRST_PIPE_INSTANCE'.
	(pipe_instance_lock_once): New variable.
	(pipe_instance_lock): Ditto.
	(pipe_instance): Ditto.
	(initialise_pipe_instance_lock): New function.
	(transport_layer_pipes::transport_layer_pipes): Change
	initialization of `pipe_name'.  Initialize `is_accepted_endpoint'
	as appropriate.  Remove use of `inited'.
	(transport_layer_pipes::impersonate_client): #ifdef as
	cygserver-only.
	(transport_layer_pipes::revert_to_self): Ditto.
	(transport_layer_pipes::listen): Ditto.
	(transport_layer_pipes::accept): Ditto.  Keep track of how often
	many named pipes have been created, in the `pipe_instance'
	variable, and pass the `FILE_FLAG_FIRST_PIPE_INSTANCE' flag on the
	open of the first instance.  Analyse the error code from
	`CreateNamedPipe ()' and set the `recoverable' flag as
	appropriate.
	(transport_layer_pipes::close): Update the `pipe_instance' count.

2002-06-18  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* woutsup.h (cygserver_running): Add declaration.
	(api_fatal): Eliminate.
	* include/cygwin/cygserver.h
	(client_request_get_version::check_version): Change return type to
	bool.
	(check_cygserver_available): New function.
	(cygserver_init): Add check_version_too argument.
	* cygserver_client.cc (allow_daemon): Make a bool.
	(client_request_get_version::make_request): See errno on error.
	Remove special case for CYGSERVER_REQUEST_GET_VERSION; this is now
	handled in cygserver_init().
	(client_request_get_version::check_version): Use syscall_printf()
	instead of api_fatal(). Return true if cygserver version is
	compatible.
	(check_cygserver_available): New function; code moved here from
	cygserver_init().
	(cygserver_init): Move some code into check_cygserver_available().
	* cygserver.cc (__set_errno): Copy from debug.cc so that
	set_errno() can be used when __OUTSIDE_CYGWIN__.
	(main): Call cygserver_init() to set up cygserver_running and add
	checks against this to (try and) prevent multiple copies of
	cygserver running simultaneously.  Remember to delete all
	transport connections so that (one day) the transport classes can
	tidy up on cygserver shutdown.

2002-06-17  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* cygserver.cc (main): Adjust tracing output for a cleaner display
	when compiled without --enable-debugging.
	* threaded_queue.cc (threaded_queue::cleanup): Ditto.
	(queue_process_param::stop): Ditto.
	* include/cygwin/cygserver.h
	(client_request::make_request): Make non-virtual.
	(client_request::send): Make virtual and protected, not private.
	(client_request_attach_tty::send): New virtual method.
	* cygserver_client.cc: Use the `msglen()' accessor rather than
	`_header.msglen' throughout.
	(client_request_attach_tty::send): New method.
	(client_request::make_request): Remove the explicit close of
	`transport' as it is closed on deletion.

2002-06-17  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* include/cygwin/cygserver.h: Change the client_request classes to
	give greater encapsulation and to allow variable length requests
	and replies.
	(enum cygserver_request_code): Now client_request::request_code_t.
	(class request_header): Now client_request::header_t.  Make a
	union of the request_code and the error_code.  The `cb' field,
	which was the buffer length, is now the `size_t msglen' field.
	(struct request_get_version): Now
	client_request_get_version::request_get_version.
	(struct request_shutdown): Remove unused type.
	(struct request_attach_tty): Now
	client_request_attach_tty::request_attach_tty.
	(client_request::_buf): Make field const.
	(client_request::_buflen): New const private field.
	(client_request::request_code): New accessor.
	(client_request::error_code): Ditto.
	(client_request::msglen): Ditto.
	(client_request::handle_request): New static method.
	(client_request::make_request): New virtual method.
	(client_request::handle): New method.
	(client_request::send): Make private.
	(client_request_get_version::check_version): New method.
	(client_request_get_version::serve): Make private.
	(client_request_get_version::version): Ditto.
	(client_request_shutdown::serve): Ditto.
	(client_request_attach_tty::req): Ditto.
	(client_request_attach_tty::serve): Ditto.
	(client_request_attach_tty::from_master): Make method const.
	(client_request_attach_tty::from_master): Ditto.
	* cygserver_client.cc
	(client_request_get_version::client_request_get_version): Track
	changes to the client_request classes.
	(client_request_attach_tty::client_request_attach_tty): Ditto.
	(client_request_get_version::check_version): New method to
	encapsulate code from cygserver_init().
	(client_request_shutdown::client_request_shutdown): Move into
	"cygserver.cc".
	(client_request::send): Track changes to the client_request
	classes.  Add more error checking.
	(client_request::handle_request): New static method containing the
	first half of the old server_request::process() code.
	(client_request::make_request): New method to replace the old
	cygserver_request() function.
	(client_request::handle): New method containing the second half of
	the old server_request::process() code.
	(cygserver_init): Track changes to the client_request classes.  In
	particular, some code moved into the
	client_request_get_version::check_version() method.
	* cygserver.cc (client_request_attach_tty::serve): Track changes
	to the client_request classes.  In particular, only return a reply
	body if some handles are successfully duplicated for the client.
	And remove goto's.
	(client_request_get_version::serve): Track changes to the
	client_request classes.
	(client_request_shutdown::serve): Ditto.
	(class client_request_invalid): Dead, and so young too.
	(server_request::request_buffer): Remove unnecessary field.
	(client_request_shutdown::client_request_shutdown): Moved here
	from "cygserver_client.cc".
	(server_request::process): Implementation moved into the new
	client_request::handle_request() and client_request::handle()
	methods.
	* cygserver_shm.h (class client_request_shm): Put client- and
	server-specific interfaces inside #ifdef/#ifndef __INSIDE_CYGWIN__
	guards.
	(client_request_shm::serve): Make private.
	* cygserver_shm.cc
	(client_request_shm::client_request_shm): Track changes to the
	client_request classes.
	(client_request_shm::serve): Ditto
	* shm.cc (client_request_shm::client_request_shm): Ditto.  Use
	alloc_sd() rather than set_security_attribute() to get access to
	the SECURITY_DESCRIPTOR length, so that we can use it to set the
	request body length.
	(shmat): Track changes to the client_request classes. In
	particular, allocate client_request objects on the stack rather
	than on the heap, and use the client_request::make_request()
	method rather than the old cygserver_request() function.
	(shmdt): Ditto.
	(shmctl): Ditto.
	(shmget): Ditto.
	* fhandler_tty.cc (fhandler_tty_slave::cygserver_attach_tty): Ditto.

2002-06-17  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* include/cygwin/cygserver_transport.h
	(cygserver_transport::read): Change buffer type to void *.
	(cygserver_transport::write): Ditto.
	* include/cygwin/cygserver_transport_sockets.h
	(cygserver_transport_sockets::read): Ditto.
	(cygserver_transport_sockets::write): Ditto.
	* include/cygwin/cygserver_transport_pipes.h
	(cygserver_transport_pipes::read): Ditto.
	(cygserver_transport_pipes::write): Ditto.
	* cygserver_transport_sockets.cc
	(cygserver_transport_sockets::read): Ditto.
	(cygserver_transport_sockets::write): Ditto.
	* cygserver_transport_pipes.cc
	(cygserver_transport_pipes::read): Ditto. Set errno on error, to
	match behaviour of cygserver_transport_sockets class.
	(cygserver_transport_pipes::write): Ditto.

2002-06-16  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* cygserver.cc (version): New static variable.
	(server_request_queue::add_connection): Remove my gratuitous use
	of studly caps.
	(setup_privileges): Declare static.
	(handle_signal): Ditto.
	(longopts): Make a local variable of main().
	(opts): Ditto.
	(print_usage): New function.
	(print_version): Ditto (tip of the hat to Joshua Daniel Franklin
	for inspiration here).
	(main): More argument checking.  Add --help and --version options.

2002-06-16  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* include/cygwin/cygserver.h (client_request::serve): Make pure
	virtual.
	* cygserver.cc (client_request::serve): Remove definition of pure
	virtual method.
	(class client_request_invalid): New class.
	(server_request::process): Use new client_request_invalid
	class. And remove goto's.

2002-06-16  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* cygserver.cc (class server_request): Add virtual destructor.
	(server_request_queue::addConnection): New method to replace bad
	virtual add() method.
	(request_loop): Replace call to queue->add() with call to
	queue->addConnection().
	(server_request::server_request): Use field initialization.
	(server_request::~server_request): New virtual destructor.
	(server_request::process): Remove close and delete of
	transport_layer_base object. It is deleted by the server_request's
	own destructor and closed by its own destructor.
	* include/cygwin/cygserver.h
	(client_request::operator request_header): Remove unused method.
	* cygserver_client.cc: Ditto.
	* include/cygwin/cygserver_process.h
	(class cleanup_routine): Add virtual destructor.
	(cleanup_routine::cleanup): Make pure virtual.
	(class process_cache): Make destructor non-virtual.
	(process_cache::add): Ditto.
	* cygserver_process.cc
	(cleanup_routine::~cleanup_routine): New virtual destructor.
	* include/cygwin/cygserver_transport.h
	(class transport_layer_base): Add virtual destructor.
	* cygserver_transport.cc
	(transport_layer_base::~transport_layer_base): New virtual
	destructor.
	* include/cygwin/cygserver_transport_pipes.h
	(class transport_layer_pipes): Add virtual destructor.
	* cygserver_transport_pipes.cc
	(transport_layer_pipes::~transport_layer_pipes): New virtual
	destructor.
	(transport_layer_pipes::close): Null out handle after closing.
	* include/cygwin/cygserver_transport_sockets.h
	(class transport_layer_sockets): Add virtual destructor.
	* cygserver_transport_sockets.cc
	(transport_layer_sockets::~transport_layer_sockets): New virtual
	destructor.
	(transport_layer_sockets::close): Null out fd after closing.
	* threaded_queue.h (class queue_request): Add virtual destructor.
	(queue_request::process): Make pure virtual.
	* threaded_queue.cc (~queue_request): New virtual destructor.
	(queue_request::process): Remove definition of pure virtual
	method.

2002-06-16  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* include/cygwin/cygserver.h (client_request::send): Make
	non-virtual.
	(class client_request_attach_tty): Put client- and server-specific
	interfaces inside #ifdef/#ifndef __INSIDE_CYGWIN__ guards.
	* cygserver_client.cc: Ditto.
	(cygserver_init): Fix error handling.

2002-06-16  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* cygserver.cc: Throughout the code, check and correct level of
	the XXX_printf() functions used. Comment out several of the
	debug_printf() calls with "// verbose:".  Reformat and correct
	typos of some of the XXX_printf() formats.
	* cygserver_process.cc: Ditto.
	* cygserver_shm.cc: Ditto.
	* cygserver_transport_pipes.cc: Ditto.
	* cygserver_transport_sockets.cc: Ditto.
	* shm.cc (hi_ulong): New function to allow printing of a 64-bit
	key with current small_printf implementation.
	(lo_ulong): Ditto.
	(client_request_shm::client_request_shm): Use hi_ulong() and
	lo_ulong() in call to debug_printf().

2002-06-16  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* cygserver_shm.cc: Remove #define __INSIDE_CYGWIN__ from around
	"cygwin_shm.h" as it no longer contains any internal code.

2002-06-16  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* cygwin_shm.h (class _shmattach): Internal type moved to
	"cygserver_shm.h".
	(class shmnode): Ditto.
	(class shmid_ds): Ditto.
	* cygserver_shm.h: Remove obsolete #if 0 ... #endif block.
	(class shm_cleanup): Remove unused class.
	(struct _shmattach): Internal type copied from "cygwin_shm.h".
	(struct shmnode): Ditto.
	(struct int_shmid_ds): Ditto. Renamed to avoid name clash with
	public interface struct shmid_ds. Use the shmid_bs structure as a
	field.
	* cygserver_shm.cc: Remove obsolete #if 0 ... #endif block.
	(client_request_shm::serve): Update for redefinition of
	int_shmid_ds structure.
	* shm.cc (build_inprocess_shmds): Ditto.
	(fixup_shms_after_fork): Ditto.
	(shmctl): Ditto.
	(shmget): Ditto. Remove obsolete #if 0 ... #endif code.

2002-06-16  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* include/cygwin/cygserver_transport.h
	(transport_layer_base::transport_layer_base): Remove since it is
	now redundant.
	(transport_layer_base::listen): Make a pure virtual method.
	(transport_layer_base::accept): Ditto.
	(transport_layer_base::close): Ditto.
	(transport_layer_base::read): Ditto.
	(transport_layer_base::write): Ditto.
	(transport_layer_base::connect): Ditto.
	* cygserver_transport.cc
	(transport_layer_base::transport_layer_base): Remove since it is
	now redundant.
	(transport_layer_base::listen): Remove since it is now a pure
	virtual method.
	(transport_layer_base::accept): Ditto.
	(transport_layer_base::close): Ditto.
	(transport_layer_base::read): Ditto.
	(transport_layer_base::write): Ditto.
	(transport_layer_base::connect): Ditto.

2002-06-16  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* cygserver.cc (check_and_dup_handle): Only use security code if
	running on NT, i.e. if wincap.has_security().
	(client_request_attach_tty::serve): Add check for has_security().
	* cygserver_process.cc (process_cache::process): Use DWORD winpid
	throughout to avoid win32 vs. cygwin pid confusion.
	(process::process): Ditto.
	* cygserver_shm.cc (client_request_shm::serve): Only use security
	code if running on NT, i.e. if wincap.has_security().
	* cygserver_shm.h (client_request_shm::parameters.in): Replace the
	ambiguous pid field with cygpid and winpid fields.
	(client_request_shm::client_request_shm): Reduce to only two
	client-side constructors: one for SHM_CREATE, another for all the
	other requests.
	* shm.cc (client_request_shm::client_request_shm):
	Ditto. Initialize cygpid and winpid fields here. On NT initialize
	sd_buf here using set_security_attribute() to make use of the euid
	and egid.
	(shmat): Use new client_request_shm constructor.
	(shmdt): Ditto.
	(shmctl): Ditto.
	(shmget): Ditto. Remove security code, now performed in the
	relevant client_request_shm constructor.
	* include/cygwin/cygserver_process.h: (class cleanup_routine):
	Change winpid type to DWORD.
	(class process): Ditto.

2002-06-15  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* woutsup.h: New file.
	* cygserver.cc: Use "woutsup.h" and new XXX_printf macros.
	(getfunc): New function, copied verbatim from "strace.cc".
	(__cygserver__printf): New function.
	* cygserver_client.cc: Use "woutsup.h" and new XXX_printf macros.
	* cygserver_process.cc: Ditto.
	* cygserver_shm.cc: Ditto.
	* cygserver_transport.cc: Ditto.
	* cygserver_transport_pipes.cc: Ditto.
	* cygserver_transport_sockets.cc: Ditto.
	* threaded_queue.cc: Ditto.
	* shm.cc: Remove trailing \n from XXX_printf format strings.
	* Makefile.in: Remove special __OUTSIDE_CYGWIN__ case for
	cygserver_shm.cc.

------=_NextPart_000_0080_01C22419.DE3F06D0
Content-Type: application/octet-stream;
	name="cygwin_daemon.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="cygwin_daemon.patch.bz2"
Content-length: 31497

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
VVV//i7kinChIO4jOh4=

------=_NextPart_000_0080_01C22419.DE3F06D0
Content-Type: application/octet-stream;
	name="woutsup.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="woutsup.h"
Content-length: 2890

/* woutsup.h: for Cygwin code compiled outside the DLL (i.e. cygserver).=0A=
=0A=
   Copyright 2002 Red Hat, Inc.=0A=
=0A=
   This file is part of Cygwin.=0A=
=0A=
   This software is a copyrighted work licensed under the terms of the=0A=
   Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
   details. */=0A=
=0A=
#ifdef HAVE_CONFIG_H=0A=
# include "config.h"=0A=
#endif=0A=
=0A=
#ifdef __INSIDE_CYGWIN__=0A=
#error "woutsup.h is not for code being compiled inside the dll"=0A=
#endif=0A=
=0A=
#define WIN32_LEAN_AND_MEAN 1=0A=
#define _WINGDI_H=0A=
#define _WINUSER_H=0A=
#define _WINNLS_H=0A=
#define _WINVER_H=0A=
#define _WINNETWK_H=0A=
#define _WINSVC_H=0A=
#include <windows.h>=0A=
#include <wincrypt.h>=0A=
#include <lmcons.h>=0A=
#undef _WINGDI_H=0A=
#undef _WINUSER_H=0A=
#undef _WINNLS_H=0A=
#undef _WINVER_H=0A=
#undef _WINNETWK_H=0A=
#undef _WINSVC_H=0A=
=0A=
#include "wincap.h"=0A=
=0A=
/* The one function we use from winuser.h most of the time */=0A=
extern "C" DWORD WINAPI GetLastError (void);=0A=
=0A=
extern int cygserver_running;=0A=
=0A=
#if !defined(__STDC_VERSION__) || __STDC_VERSION__ >=3D 199900L=0A=
#define NEW_MACRO_VARARGS=0A=
#endif=0A=
=0A=
/*=0A=
 * A reproduction of the <sys/strace.h> macros.  This allows code that=0A=
 * runs both inside and outside the Cygwin DLL to use the same macros=0A=
 * for logging messages.=0A=
 */=0A=
=0A=
extern "C" void __cygserver__printf (const char *, const char *, ...);=0A=
=0A=
#ifdef NEW_MACRO_VARARGS=0A=
=0A=
#define system_printf(...)					\=0A=
  do								\=0A=
    {								\=0A=
      __cygserver__printf (__PRETTY_FUNCTION__, __VA_ARGS__);	\=0A=
    } while (false);=0A=
=0A=
#define __noop_printf(...) do {;} while (false)=0A=
=0A=
#else /* !NEW_MACRO_VARARGS */=0A=
=0A=
#define system_printf(args...)					\=0A=
  do								\=0A=
    {								\=0A=
      __cygserver__printf (__PRETTY_FUNCTION__, ## args);	\=0A=
    } while (false)=0A=
=0A=
#define __noop_printf(args...) do {;} while (false)=0A=
=0A=
#endif /* !NEW_MACRO_VARARGS */=0A=
=0A=
#ifdef DEBUGGING=0A=
#define debug_printf system_printf=0A=
#define paranoid_printf system_printf=0A=
#define select_printf system_printf=0A=
#define sigproc_printf system_printf=0A=
#define syscall_printf system_printf=0A=
#define termios_printf system_printf=0A=
#define wm_printf system_printf=0A=
#define minimal_printf system_printf=0A=
#define malloc_printf system_printf=0A=
#define thread_printf system_printf=0A=
#else=0A=
#define debug_printf __noop_printf=0A=
#define paranoid_printf __noop_printf=0A=
#define select_printf __noop_printf=0A=
#define sigproc_printf __noop_printf=0A=
#define syscall_printf __noop_printf=0A=
#define termios_printf __noop_printf=0A=
#define wm_printf __noop_printf=0A=
#define minimal_printf __noop_printf=0A=
#define malloc_printf __noop_printf=0A=
#define thread_printf __noop_printf=0A=
#endif=0A=

------=_NextPart_000_0080_01C22419.DE3F06D0--


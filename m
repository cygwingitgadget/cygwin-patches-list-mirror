Return-Path: <cygwin-patches-return-2484-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7599 invoked by alias); 21 Jun 2002 13:43:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7547 invoked from network); 21 Jun 2002 13:43:51 -0000
Message-ID: <077501c21929$e6e84350$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Cc: "Robert Collins" <robert.collins@syncretize.net>
Subject: Resubmission of cygwin_daemon patch.
Date: Fri, 21 Jun 2002 06:43:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0772_01C21932.46F00730"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00467.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0772_01C21932.46F00730
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 2008

Rob,

I've put together another patch from the cygwin_daemon branch,
excluding the ipcs(8) changes. In fact, this patch doesn't include any
changes to <sys/ipc.h> or <sys/shm.h>, so a couple of other bug fixes
and enhancements are also excluded, but since the overall patch
doesn't affect the shm code, this seems not unreasonable.

So, it contains the following list of changes, as you requested:

> * Conditionalize the security code so that cygserver works on non-NT
> platforms.
> * Add definitions of the strace XXX_printf macros to allow code to
use
> these whether it's compiled for the DLL or for the daemon.
> * Several minor C++ related changes: for example, making some
methods
> pure virtual, and adding virtual destructors throughout as required.
> * Add --version and --help options.
> * Add checking for an existing instance of the daemon to avoid
having
> multiple copies running.
> * Some more error checking throughout.

> * Refactor the client request classes for greater encapsulation and
to
> support variable length requests.

Two notes: I'm assuming that you wanted the client request changes in
the patch so that you could review them; I've also added a newer
version of the "checking for another running daemon" code that
improves on the previous one somewhat (once I found the lightly
documented flag you need to use on the first create of a named pipe to
get such checking).

I hope this is all appropriate. Note that I generated this code from a
plain "cvs diff" rather than from you cvsmkpatch, since I was
excluding some changes on that branch and couldn't see how to achieve
that and use your script. As a side-effect of this, I've had to
include the added file, "woutsup.h" separately, as it's not otherwise
included. (And I didn't want to risk a temporary "cvs add" in HEAD
since I'm only meant to be playing on the branch; obviously if you
wanted and it was okay I could do such a temporary add for this
purpose but it doesn't seem too important.)

Best wishes,

// Conrad


------=_NextPart_000_0772_01C21932.46F00730
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 17415

2002-06-21  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* Merge of previous patches for submission to HEAD without the
	changes to <sys/ipc.h> and <sys/shm.h>.
	* cygserver_shm.h: Include <sys/shm.h> with #undef
	__INSIDE_CYGWIN__, if necessary, to avoid picking up the old
	internal class definitions.
	* cygserver_shm.cc: Remove explicit include of <sys/shm.h> to
	allow the guarded include in "cygserver_shm.h" to be used.
	* shm.cc: Ditto.

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
	<sys/shm.h> as it no longer contains any internal code.

2002-06-16  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* cygserver_shm.h: Remove obsolete #if 0 ... #endif block.
	(class shm_cleanup): Remove unused class.
	(struct _shmattach): Internal type copied from <sys/shm.h>.
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

------=_NextPart_000_0772_01C21932.46F00730
Content-Type: application/octet-stream;
	name="cygwin_daemon.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="cygwin_daemon.patch.bz2"
Content-length: 31594

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
AEIFlkLJSkkPxoQYWfWXr4hsUiAyIwBhcLgJGSpYET9RQ5QqKojZbLGBayUE
aVYUZFjCqqLKQWiWCIJC20Qg0BSln6GjjVrGkltxbauZcwTCI2MpItqylYjG
ttVlQbYtKMlstRGsSqWWwGm71tUpOGhvE9d6lgcAgJ1nWXFSchDRgmjDIYGq
EMRRtCIUE0ip84ZQyQPxgI1ISYgttyYBWGtlNCdSfdCICMEILIwnfBXAwSEI
SHoJQHvi0hyuy0I4yxJRZuRDpl7UsSFZUYj393p9Pnx1fZX+nXzW7PdR6/P4
+FzBMoB8Dfmfzku+8gxxrlrLom2II/aEJEYB5GVbC4ZIUZCSpILKkBCECJUC
yL9R3FIwCIr7jiXuMKh/VFdkVuAFaXYfCFQ5QCuW2XdUn6QeqLiC8ohsiHwh
tIuJzMqFZKiihRADqvLIdSBgyR1QKWhNMhiKGIHw30DiKGZpcln0+DQrmeyh
Fkl3YBz9hQSFQDSE/Kk3pEtSMYEr86STowXrguUZEsm7fQCc4plBCGVHzuhb
inxwH2xAvDp0rWBeLEgPUQaiGRFA6QCrGhDgQf64cIgvtGKc4G7FLsiqboAb
4BCAFkRek1qhPflGO7y+oxj3kHXGJ9yr9n09KH5+Mq/hSpMvXjpmKNH9Sv30
np26amOk8KPO6eTTLrt6pF/DVsa/fLdjaEnNdn/1/U/dmP5ng48PGGlltJ2J
BJos3z/4vNJdvJ912ls4diaV8isus59mvyUpuX+yPbK0ZIHX9xfwW9N3zy6O
cE0IqY+fdF+cLhg5vJH7HVNT/J+H3+G9aj1tBLkjU/n6qzwzPt686zdEJDp/
r63Puyl419J+deknZGOn8N8NLZEevhBE17KGKju4U9Pllz7NYp50xu9Ts4jL
a+RM4IOyc7evypvGQg5ZEAmWNj+rh5UoEDdQ57VjdlMb6/cfybnXqRwXDlia
f4qfoRnwpAruMUby64bxqHpuw8nXBMyD/d+woQrvIZLyf6JORfn6Kd86bdT7
ug0EPMEGok3DWCy4rkiBGPgXFk8iqB7/uiSGEZtmrdkhPdcOpX6MV9PWd9dU
rPJS/Pv0tPzbRxV2B87SNkEZgKXL76ZFRutlvvn7QgQMgnL8afhDC+fSRK7E
2RMhD7kNqWxNETJ7dBjdIJMhNmJvpV8uG6+RlgNYzZBxD2Y7cOBs01T4i0w3
FnLX9lw9hpdzUxMFRec5YlkvNg7VDdNLZhLea3qoM7FyDzv50/VRSrQvm8xG
NcnMnHJfJ5UuGGmu3jc3ZtguFpF1s7zDXtjj01+jBitLcJaS6sIylk544TPO
5Mpkyd43arIpYJqidaPidKYjuevCOu9sSr8e3qz65lNttFLdkbZ6/XLpyNAu
GEWzlODV2g4A461m4SCTOIydoaPnICG7sYOdh8UF/R1QHps/O99J74/j/Hdp
VeeKN15RnT5MXn6M33ppHm4V79aLfr6td3ErOWZEPh3pIIXUyJAmhD+fKVre
KjOII7PNBSbs5wyUBUUkxC8UjxJYu0Ojz6j3qxVxwctYpdIkIxwzNUKRrIqH
DfbLD6VQzfJRl2vOHaaDCm09O6nllhh1P03K89t0UWAmoO7uPGLnw1nl3RBG
s3CnYauqDY4o++e1Sj2yu2Jqpes1uyZdptL835M3rh1SgjB+2XDWRMWXU+iF
0ekpzMDTWUd2Reon3T9FZ/KqeCcpXdJXnbaZPc7FFLrK99np6up8ffh7PdTH
j1Yg/vCdbJHhlnmD9nlBQREX8wIFiwZCncOmmAUlkcGTKFCyhcYheNIgK6pp
kxABkRgoIkFUGIrpxMYiCnqpDZhVBrWJ/NS8IFgxQ15vxb2oTkIENHl6mhii
yDzCh+4QHWBujWtFE3SRkBwRMEd3ttZQfqgmcVmyhNNToWu6ILnBMgghiDhi
j8Eyl2L/BQQEgRQT/tEoP3iEKlSFIAHkaEKEOw90oAMKI3CJT80G6YYAm3Zq
r8vpXuR1+T2B3m9fY79vhaoQfTK6nVqxBB24OUD0l7AYDe36JSAlwf/q8sur
9j/HO3xwZnZAkEOOvmiP4quPz5vBtjRZygNuH29I1Zv8m6WsH5Y9N+k63Vif
XMeRLryle9OuXxtb2qRn3cIxDEn2aE/s+jHGTbzk+2Fwn1dnY+81rVdktJNu
q9nnTvf6b9Swfbt13HWwfFRb/Ofmo7n1hQcPZKDzNyoZHWZNAgRlBpjX8n/m
f1B6zsfU8+VKYTz108+t4HfFqEjx1v1Demmsz7ILRdtm19MCGTxU3fUFQIiV
EseV6TOJg1o1LtjFcXZogp4nqO3rYyDsK9p97Npm3LoUPgZ7b7cFeWZ3lzgU
e32uOCLl31dixh8GaBiRjhvlTYV5GBy7oRrZ4Nbu1hrEycpWfTDsr+7O/Roj
W+/LZpoGpe558z1H7dbBV0YsjAEQG8g9JSTaUWpD92XvvMCAx3MsGkztcmRY
TOhxPAYbbpHVB67021xJ5jxgTBy7vpDmCQ2zDyY4pre+Z9h4k8xaet4blzw9
AbzmMcbaG1evE4gotTSY/dcOLEjGjypM7xTm/YhZXo3r/z9fyL/JVl/2X7VR
/V+c3K0pJnpT6usklzJcvdaWanWbzpl5B5rldPHZqcdW+q109m3Dqbrqqm3Q
b5N1hjuXZMuzW+VhNO96zWVWqjqpVaejj0cqPM4930PN3zb4PVasSvKU73Kk
RcoptVTelK0U63/gN+gbmPJB6+iTKIsPH/LJIQJ+xD6ivuHMAqLBlSWkpRCE
mGDpIdagO/ogdADQHpc5A1DCjAQ4cqVQ/JgKGMSNJ5vA0T5JujXSY35EhhMv
GJAiwklSNuCZqVFMk1l6K0tfSaZYy6UtIhsB8gpyzh9XTbhGSYdNWruEgduU
JRMks/EwTYHNq9bV3B79wHFOJyAoPRNIiGMFJZLfxoSlCOOopUtQukR+Wvv1
dOX7/QYM8z+Oe3b57yr7bOIsDCsu20UmR4069+Mdz3v8c7mLZd31W03mEZ9z
DebYqULH3WYKTHECarlOZDmE86z/T5jErlM6ZOOPDs2cQnRDADjKP8yBR4nl
/X2ij49O/8CaBuQ+CD4fMPBBWyR/PRTm/fVSpY8mVIZWZmXIZWDu8cd5iD6a
MDPlRguw9kmB/EjvoExAuIIktLp31jKu6Ld1KZd3Vsv4pMyyWSneWqiIvPnW
Ww+llyC8Z11Jve+uc1yl8OurtXXLzrRM6ZnCcOFVVXiJ+BhjyCbgSWzRA1ns
6Povew3OCvRtaTWGQi052l85oGbICtjmXUN2/jJdOhEibmGG5lqWxDOuqLoS
XEjC4oNjQaSwwsD+pkTXIxkaAKEMgCLhidi+xEEivURSRsniB2dfGSdFIWw9
OtA+pSXXZw+bEbI1li4F4yVOOG7ExdWpMAeEKJVmGsHimgymjpSVippWqG38
GuRhpsW2iLjbVlEUJiBuTdMNWP8eRO2NxCuUBHrOsIQIwJAkCIUPT1cvJfCZ
wB+sQhZENasQr7VQ4G8H8Pyn1jK2azRH7kw++MIb/sv+1KTkNWDGC6j6rYf0
qod0G+7/IsY0Pqj+mP19H19F8uGcs6GsVDvIueR91lQyXzCH2wQy/AgqYgRM
tDUwt0CM4swQ+/TDq1gxWV41nNf9fbQihBgv4Wq9UQ+3QNEt++K9RA5b+h6J
Il4u+NhDoAkgSKMzJZYsfjTnffjvny9j5SNFSOlMMpYI22+DgICAkSJFVVec
ETc2UpbKMj8CwPmaDfrm23v7zSdXntMtzVULYiWOnYggjVxZrXtmmaLkDKr3
NQtBTjfO6QXrfbzbt1Yb6ZpU47jadNEUBBgehkWYzcZb6unxGtghTzhrAwRW
SKyYrCn7OZzOapV3VZYTnji9zZjEqgBuIjdspnAYKXvOipVNwb5cWN6sXJVv
e7egevbW2/UxaQzWtD9fD6l3KLkhKdTItK8saYWoZmWSGNKW5GqGdAPtpk1L
bSGk25DGN2a6lwnK14lWLTo73JvakqYU2wpsU691fWL2N0rP3euzu80Qhj+R
BNX6NYO5D2kqogUQ5JSoTpFKjB7t43khokg3rGB42aAjNPveo2OmWFcJSlZJ
3iz1nvhYXeItZLc3IbCJ2ehu+Lq7bvVOpnnXi+Goxxw0yNt7JPYpBi79XhRx
mNA0avzI2UZvSNLXmIU7xpproakPaCDGWZ1zw7wfKrzc2ZlXXGVTd7jLrrvz
LbyR6SxyMdSuEUV3iRKZCeMCcTlbE3NJ5qWe0T0lFqSUeSqH2B2bALYm+SA2
gaa9zFuvR93u/T0311zHJ1mq26dHnI+YV31IXlSeczrnrvnB4rBUYjG0rK1z
Dt7HfZp3mkxu80W9+Tx129a7rzZrJOadaCsIslqmM9s9PGTx16LDO2NKWvNy
r6Ms89FljjeAKVvItMYJH6fp/Qvp957T3+d2kpH2xWf7vyPb9TUvdvOyiAf6
YnEj+klrqSIETQ1Q11/ZMD3KDL64vOZM/AmMHoP/u8PirGg5mUgEaj/9OAn5
m51+uhtG6ANevuyg560jdloMP5oaiJICURTdgGUiRJ5ia/Ig+Hb7PI9CYIKE
LePrEPZhD1Fy0dp0Qjxnx+Q6TvCn/gsPp+3nR0TiVUwfVLjq25GQmQsdNX0x
lt9DHGm9keKXAafVCe1kIKEJtAp4/1FIcjM/VYT4om1n208ZYPbEKgp98HZH
In37PdXh0cZAjqRemLLXz/6vy7Bvt/Iw5WR53lNRw1R61NATSkYOe2T7p3gr
fOsafpjfhpVisyynglbHMNBm6+nMDbsuHW48GtkMTYgUSNnIRkjFATRVN86Z
t9RyosHcEjJejrjIfiaye1Wc0hj18c8nRlfS3dOO2/X/C80Hz3mmvo81Z3OC
EhsVG14DnJyaZcv30kJrOOtqrKC29+KA+PBz6CT4E3bNWEzUESQBQQxAvmJ3
fPgsPhF1gc7x4JVuaD14qonhC/k42DbN0KnGJuj0z29dBjqoeEtEN0GQLy0H
hp7bPHDt8VGjnUmtrpjIOC8W0fRcmfzOUkYJrPUgSEmDgJEIeHiS3InAvF3Q
gOi55c1Cz1+mQc0MyBM3Rc1XHDCJBJf5CGMl+kufBpqtqujar45uzDne5JGb
uczgHErJj0pjou1ElqmmjBNTscxXWgKy03bp7/6XYuv7lw1cRlvhjx26Kkpr
z5uMkLVZRNG2Heqd2D64WG4q+Y8JePonK6Bp83HQ+zkbO3Pb6MWPl2U6TdBO
2HdB8JkRzyzt2wOqPKXuc/zSvfiF2u4RvsdPPOHW7P+8+vXR3xdNu00j1FCJ
pjTg3csJJNfTOOyrpdK3h+XOR5pWanXjz03/jHfW8OzY2ck7sepM3IFRb0aU
dqo5J/3038Dwm3WVorqSN7p8Utc4JrZOeYKt0USSOwVsHbtMgdm68OEBGDny
9Rn1SKJuG58UccDX5aenatl60G0d/y6eHEq2vl54MFhtcfx904w7YY5PJS7J
TnVblNcRPvlIv/E/k0PIioCDBEQ/RGKAsFgSB+9WWyBfzZBCNQvdyANXIQOK
8VmFKbsbW228kCFMYWCMC2CqjY9KYRhAUYuFhYzSYqENsIChKJpCgwIWMKiM
RBGAMGIxC6UaIMIDVFHI8/L2Tt+3NQf7RDUEO4yhC+J9PwfvLKkgIkCeByDk
+hhgxIqufx+y/5jgUVK0EPA7L8SEjr0V0fN8tv/CiPexRGlEclEdyewzufiP
b0Kv8kfnBKiH/xO4uXF/qRrMwfC/4H7h+kD8hEzDbhEsAf7HzbTf+kcx+lAD
BqY48bDuTIN7s150p5onMPG+ibpjYSEYRgtJ7DdzEYwhH+I5FfjPSQ9s/X/p
WIHLMXc/ekNrg89B0MTmDIDYCnMKR6wCiIO9IwKw9IkCI1BbH+tG837zeRDt
AKO0QuOREXBlMeuJTJUhR/e6BlaMtaNlVi21MGafOSM2KgioIqIuoAHeedYx
n8ofE9PInj6vvwwXq1/w1M0XduMzAs2DpqH5WHb7iz3GShwnV9yqxRFTkSGT
UH9MZyYHj4p5D4eWmSSsmTAspRxflcxicHqAR5JChXCAFzuQAv3Nte8czf15
hYJ1wZMTcQhVXHui4S6p03gHArmdPifoBt1j5nkd3m4no7Kt/vLHswNRhFTE
Ajl7yMqB6oyCVhVum2DmQp0rBpG7owBGLE27Zbg+kA7JJ7PpVBEYkhSkjT5D
kf4IL/gbTU7fZV2G02GRKFiG0dw1/ustLkjEix50fB1+AgXNOhROPBfDA2BD
PgKD0h0XQAzICFJuQDeAQUwomeZzjgYu55m/xCHdyHRDJ2oAaU7sBQb9TcUM
LDAQAhgxyQ8uz1+0BTwJ9aeQ1n5jmdhqiceykPRCi7Qv9iCSJpBqEIFm48h+
t4i/1hx5SFfTT2w6hmusIkie4Ci+XKSVxR3nlND3i6ePVmf1RFLaO00+8yNv
LtCxaLQT4CqPigEYyAnSQaIM4NDkRE5B4IfkQDno4QUOGTDLyahUDA8Ah8wc
veUKkqhqzZDuVHtXXSTZE8XmCqIQfFNh51ClnjCcyAFAHXR8hyPUVqRTVzOH
z3lD4mzMvYZG8DZhUekHyAY5AGFEdg8JGSRJEW0NBDkAav6jBxfkPM8evaQg
8yCuGyVvIWagDvX8BNwHQi+5/EQ/sWx87FhD8OAFAPuQ8UicEo9Rb5z0lgyG
kJyHVhUiKELKUgpGCEgHN8H7kB9w+ggtAFDaOahuPNlFELDMnqs81ohmarRv
OKCnJ9sfoT+/PqfIKJT0I94w/zzmPMOcETrHpsOupqBdwaugEEPq9l+hIftG
e/7QvOfSMUixVFQ8uzs1yGfGkAMjmuwmaGcCFUnghaWJYEB/nf+BLRwAu0i4
tr7U3geJJFiQkkOEqDIRkgLcRMZAQpGkSgoVTufiJMPGQjDwePDkh7DxbO0v
hC6bgMD4HMoaZeLsMOuQr6QOG/zbfoN6yqGVJJJJO0RPUO019RuHR2GiNice
gSjnGPXz9R+4h/qnZtHEkE+chsSEHqQ5HtofAgPlUsdOW/SkKr5I+IHlNMvT
ijNZaxJYZu2gGgZkIe1cI8U+f83yHx9R6VuuUsFlK9vHgHeonwcFPfgFwDyh
ij5CFiJncQ+NHtQsDaQVOgXTVcAHqAh1gvc7B0KE2bB3GuRFE5NO1EsojUAY
kQSMFDsPmi/ZE3eXQPMc4hqah8UyMBSyMIBS+B7LLeEg8RgBtPgR0RLnnL8v
k60qqGx6pkPUghFWohpQfWQSESFjQUEobUe5iMZCIwmMd/Rigc02GC8zkKeB
O6bS4YXPUsUYFM2KGbp1A9OvUZQT1iHmPF9IVr9foHD0CPnPWzyE3iYhkLlx
c13u8TEgnIlLpNCirIiQ0BuHBHaPgWgIcz04eXENgYnY8y50RDXEE3KMdn2J
SANbHXc1YszWQTbS7xNwLtQ+/YhRwBeXHchZEZdNEUJ1Lqh+TD7oHSLbG4ed
PQfmngGMef7wyLamA7E9IHPAikixh+SqeQElwUMHYh8gfA7QWe/a18BpKE2P
xnCfhDcIm4A5O+gQiINHJ68j0p3Zlk9YKPMjxES8g8xgfjooSvF2/ofAreRY
APW5uHDHl4M5dckYQNiIpiiA9xQLovY+rcfTyn9kGzfKYf2I/2JnrZE4/ayE
ipgd5B56fu/1/D2fp31wkQav8/ockv6dc90idz+tEFnfsWOUry+b/U1/sen9
oZzcTJmEgbCwZFXcLOTU00oZx2jTWbI5rmfmx3JGPbP0ftzpet++jQ8h4Ov0
zbvoOmAS2APoZgej0OqbPzbyMDEKOv5tWAfQOaH1JmvuutOYEQA3bFq465gF
DQ/RpsNhZzchsuqfSH0AG18JbxJCYWaF0hHdh2UA74g1sREYj+DKQ1vlHroP
Pk0aTKA2bSQcGsMFw2WUaItxzUMv2lZHFDB9ZZKELrSLRrNhJW0BqIQIgdEg
uJ1gD7kkCQgHQRPX8cr4T1AakIH7gPavtPtGL7lHtTaAhqbOb7vp9zaSEgWC
BeKaOLGIfqJ950Ah2eeB2BOjJFIQVYQGRBFQRRkIv7ROY3NslN/QmQ/zyDBA
HNpaW0AwGwE/28D/vM/+AZu/QdqJ+XODzOEuihoi0gsrCoxRBjNuFpg5a3KI
ME7WcZsDfO1kZFjxbXb/eGYkiBIy94amNB7DSJIJEFcBz4GBMJRmuoczYl8V
VREUYqoqMgxijBVAURYqKrrS9k5wNgHAbDBVQ/H64dpwOkk2cCSGmZAHNUwH
YyQmpYtixQdB+pSKgkSICIMYPXSWwpRjFiwFFYohEGtARJUUQZVNBKIp1/Bd
bwGi/W3NCPDVAqoSSAqqCqMGR7Czz6JsKde+6wYKSItJE8JugcVSjCIBStEB
KUGjEqVVrQlsoUS2yQSJAYhI4NFtXk2uB0U1E2JxwCGxQgnQ7o/hA7tg4HSK
w+7nJqQo5X6HCmQsEl6oOy7JwCBYrJKwv3wKEiYWW2Q2MCxEsQKL103N2Qm1
2DmCOHkIUkQwh28JJ2FhDtYpIaCEWh2u52qbnAzcWZnTN5CDBIAoM8cDYmWS
jX9q49+gch058DGF2P+tN6f0B4/yZbRHtIeEiSgIORPKwhRD+q6CzwOe/eAe
aCvaipEJEU34X0++fbw21RCvq3FPaqn7IuwiP3wWoC3Oo1lSNVTxdpRhQEhB
O8RkkQr0xPMynoEC8wKOAUnpSkfkSCRGEXpICQHBRCeX8T3pEI4F4AEUP8KT
y12lHE6YXlQnhnncfX3Xgio42SVCoZqOac6KVtLzh2YM4UD94FFAldwgf67S
ghjzJveIiZlmtsw5VH4jMOGx/ehSID014DyU0inuWXFR1hmbpCHrgSO9OIpS
CeiS6IT7RYAgyAIopIiCyQCRSQZBEhCMXmDMMjQRB6g1pwoVgip0qgWrzGEE
vEA7yBJft9j/KGZ9xCgzBpiuvVwUTUSIHlqoLvN/HVgER4Ec0nOQ4XGv2sIc
tpz3DLchErWbKpU6mWMh7Z2AhJ2sCUAUbCMRgG80MsjaipS8YL8LBD/NLla1
s+lBTnERsOpWQUkYBXYm09Kh2pcNeLUK1jtJ8RPf7KaBp7DjAuuo8pDQZE0s
gwonCTBnPRXOzqBgHj7JODgnAgWiNEgnAgZmmJjBiy1OrMKqGxRpfceBK88W
V6IRJG+2B58zOw/Gq4oHxKdU4id4nMMGE2gHOh1d5pw8TpDkIr4m4U8dTtjC
3WHO/Gk4ko4ALQRSLt76S8Bd40hXyfFmdmP+WX8DCIJDu5kFVBE6rWBhkkl3
GGqQOqbXchiJQOGlvb2zdCFJ1NHFDpCFKcDPkHgbjI9ZhCyMuu+m4NpgEvQD
8AxJu8GAYAoergvzmubgMdUqD75AJR8xITBxYQAWQH1CKhk7fwk4SCCIDuIQ
+jn3n4WQFlAnoBAw3vYY+CGMaCVgSkoEMlSylLIWckczYHI0gsgBeZRoBxeM
Naq8qmYIsQ0JmjW6U2aiEQrpHrnrBY5RsOQBWOw754Adw+8yOmbNyxALB4je
B27qGQtFR7lR/mRPImmYNEG9LuRTGiGETwEDfxyFEsJIRgESRYKxgCkSIEYb
Bhp5SICHUl91qDBCJWqDIT7Sd0nRPJSEBgSD3dN7VVSDkipFwuK+Xxr0TfWV
hI7FRm8etOQRxAoAgMIJBpIrCIpTVzZNZUCVSmaxezjSG+J2FUpeVinBaqwD
8qHcM94k/+qnWmQGfJEWBSMRA0JDv5ylV6DDRrlijGtsabGKoXFaNuDI5XLb
hkBiCJ2egpK0d7ittuxDS5pcnujB3KRqtTwBVO43Y3xgCMIoSCzpx745Y78J
6joGpEepw6BUfgicvh03obU2XVHIWBRddVTvpSFUpcMzKjndBzjd+O8whcSH
UxE9aQstKwiiJFCqdQiWYwCb7rKgYDwgUEH4FD1AhwDPOjmHu9OFDnA1WQjs
NhOAHpPLLxDMIxIwiJCERJHcsVdjGJCZobiNrHCfn7B+HxyVdgHrEN4VDIKF
tJCEizcRhU+VPehkUB8dUCg+Tfd82vZuG1EnJh1wt5sLFAYMUjBikYTVhqCR
B8wkpGCDBBIamhH/WWc1VVV2Wr3eMh4+C5gGMh9TKniaKRGsaURoLH7wopSi
KCUmtWSvrjv8MGFpU3EUksAkSXAobi0jkRjQ6GFhhwqXGru02GEg0F22TMiw
A9t5OMMGPKLKLhQULZqK0YVoLpMBtEIECxonKLCwxMVDRvSKVf7ahaGXQxpj
ERR6pUkftZFgcaBcYF7goBZAOcmZAImoxsGwsqRKCYh7wa6mh8iTNlJsOJLM
Bk0yCwFnJkqLQ4RIeIiPDVUBhawL05pKWizmGGNvBrAYM1t2WrMazshTKaOV
sQWKn0AqyYHInBNIbMvO6BltXEUOiGJFxuqRQOrs2BsSCCRRVOYc4yZoO5uW
NAHatkLDmFImQYEyTynceeQRA8BBSifOk+cXET4GU9Hoh1x7YpZqChAUICpB
F3xYQhFQJChCyByD4p8gIUtIsBZGIiwEikigDE80A5Qh4+EYKkFBjIjIMYmT
UOPLk/ygQ0dxl96VDbUsRWV053Dym5Hr5gKEVvv5qH6w8a2lSoV4WbkNFTKN
MAX+ohWo7LhUrZOoG2PzZFlUXsSAmGY9Kua8iyJhUhEkEwBtgHpDB3WeQ0AT
0mL8uG2BZniKm7YoVMSqITM8qU25FLroUuXngBeHE2pACjQ2/DxDZEfnJ7qM
ToulNcP7aamWT56SplXyAao2BIN8ng/SYGkDaOjR0tO+zhhsVrY4JpjXyn5z
ULXfp2VhVRAOqr0u2lHCh1qkAUc8LvC7YRJnQ/Vm0ullJC08aI0NslnFEijk
yEimvHCaNpCIbZSwjnSGy198l9lXBsIQIGQxvvN83VkuOWaKm9EUNw8cgqns
UMKMKBLSluEZBptGRQLfqxshXe5RbqjZQMVrW1iB5pqeTwA0HUFuu3Q7U6KQ
SUd15wL3tMGRsMfgo9bItzZr8r7Cp0hrqXQcMmruocII5cBr+TdoVo3qWmkH
ooB92Mzs1dWQiCj3FjUemEwpTOjDYqqbQyzFlvBzTEytFHSmarM5vmbtc9OZ
w53uTiQDchM+bN3xxobIxw0NNalmaoI1djLAe4W8Z3JsbhTSRe6bQPa+3iuC
1REGmmdVoS8GLFR7qOne+Ue0ykuGQ4e5aNBYe7qINafnuG3z0RJ3i9kWGZpb
I+RGOdWoYE2lGw8CQRYEa4PKtGxNpbx8cHlYEZXH3u2GrVDgIpGDg6amc61M
iKSgeUoC94tF3q5pkQNohIEVtfIVB11JWpTlUm2ySVN0RSt7Zhp3q3TY5uzG
sU0yccYZN6osUXrZU2dohTspwxFxKpN5lTe5NEJANWqUc0d+2/FL55gcJtg6
xkNeFWmgVMQEnFTgBXHMQ7uSJtBh2SB5cTeTxktj9pGU4xsPN4++XhW5WuZW
7HRlA3fCswtepnnmaMG02ei4NNA00hDWB6I60rK2iy+ZU11YHhNBtAcRIhwD
cbza6adUuUJJTSVB0G3ePEYhwgKb4NBECHB0BYRQqVAkSRQRh/VYVSiAFkgA
wDBIHKRLd5SBYAw/xLkoDhHl3BmJRsECy5dH/E4H/5IRikM057MaKA/EQiZw
wzOBAgZALBUOwRxFoE8y82mGrFseUoouk1ljO+zWL12BS71AtcLB5pRHyVA2
zcwxkPH1lgbSIhu8gPdQNJ5hmPYdlvQbUVAzwdcP5L2k1WiejOnh0kdJavNw
7KNuC6GiJzIG9vqWrsnGLzgfUQXrDfu3u5EDnSKJjQyF30GamaOCHv7kNDgb
Tg6OAXQTjHcvgBtNz+G8+R8qakGEC58bNOrQ2FQdSqEAgAdQbxo9IoWXuu4V
V5Z+9bsSOqyCBAi0kFoImCl7S5lc67NJg2gVNbnEAqEG2CkLUWhVGLuSGHER
gIXwD3cQeYCzMmFwBi73n8DwNicgwgZHcibOeHvUTyJEKSMJBPQdNhcE9u3K
HpajyJYiBskEAEo52nv8/z+HT0yfTbZnR+hNode834eh7gV9PZzF9KdaPfES
wooGl9PIdhRXcTelopJGD9SVxRpOXbNeIYaDM+nNtfsmapQer3V60QD001o0
rGYiAJ6YomgLQwiU7oOsj1RyEIkVSCYjJts1FmmZpcqSVSuF2KAQDSBgwqYQ
C0ChggFlolYWAjokR2ekgUibgdA0KovtyMsIaZKZKM/fACggh/ArgfTc7u4E
7wt5Le8VlGhYn2RPMHWH6QbaQ+UCJVKBTAT25h9cWCh2g0DtYzoWrIIFjkCD
AjMD3HLuLWItQAHjBrsVf1QEC4B7yiZIRLKQQF7aDuDjkySBIHdPNPKayK+N
I4oxp8sjxrQG+nc8IbTLWB1jLRmYgh2YKwGN5s9mQZxB+YGjweBwSvqQQkR3
xGRBqAIHMg80NIoAnfGttDUc15d8ZwWwEGHetUlp+QAk/GtCGQOCERNAGztT
gK46cRUaQ50Jix2qm5SiIMANGyIh17wQOfn2upzFg8NKSvn+OBMOwQoQvnYR
FIkRDkQNVNGDATY+kID9oePlYSB9gTaE9lKP52/oUTvAPXGKSQ7fMKoCgxIe
Pz5igggpJE9QGCrIisUUYAd6kXCMCzWXCCkkpErAlJFQEYJBJBBkwzDIRC0N
mhIFCFDUC/EcLEhUtfx6y1i1tGrgMVMpoGSM07EqWlA/OkOfBSSVkqov7IIT
2HmIHeoCgJEQPck/6JBZ6ZpHzQN+OtmD+coYyTmIceCLy/uMCFFJxEbJYbzU
P2ZFKvBIIeW+lg+myDIWDhFkFjjxKNQaVKHNQIKBjj3PUXQuRH+8T/qQNht3
b4Fq76+EykxZ/Eyqtn6j7c4DFFAIMHGcg38dTmw4HrO4wwVxnTda56nLAQDs
JAJAB2AhJjCAdaQhpEQRFFBSRkgOFAYYidyUtTgEaSvfoRuSH5Bdb9sdw0Uk
0pCyJObz0vL5aHlEMRk5uC7mK0vCdL8byaOiWchsGnEOtACjyHuVyFMB/E3G
RwZ8IQPKEIPQlcxo2UBM+ZSy9YtwQDoFyisHdFOghyhXCmoEn0MqILwSQP4l
DE5ME/HxceJN4YVLRKmyVAwCpfPuD6TMxmo7D0dYSC/v9hVlQzKegZGJKALG
UQILIChS1IwqNipAPFYuYgGiUDzLDV9cQ+6W7SC0jmIEWRCMQkEIEB+qKKSA
siyFZEjICrCLBAhh1n5u8tz6aZgxVYeB35KpbKrCcTDAertpwKJ+p/AP100A
qDFSIZ0QE5t5azWVWSHt6SivQ/xOaCdSvo5SjsnaSEJENI1ayl98B5brpswN
hqQ8jUDZBBiikGIRZFL2BBcCsVAYpgLoXq74ZfzSP5EMbPr2DY6IQWMSBAA3
8Vcs0TQiuhxhIFyo0Byfp9E2JUWH0fG21ERjqFhkE6wEKowZIYUgZkm5ADyO
xaRP9HvFd50gfA5FD8DG6pLKq7M0k/NYTcTc3QZmIlwYmwDhhIhve5ucN4qH
x9GQ0w2Mp5izk4xdMbrIYmDbJIHTApM0SK2FrrYx5hjkI3V04uUXvWJeDe9r
QuA0Jx4naROLfhI8XiAg9M56OaHKCG0PrTYAnQezwpkkKiM8JQxBYFVq0pUx
AvzpYGmNrTQ4IIJDERUGg4gDcuY5QLQ1gxRK0ZC5hcEuWTYAfDBkpARD65tL
KBtXviJ0qGbxF4HDujEeKnSk6Q/tRiMEaSA6CeKEDx9ioGwA1+HUBgSdCb7y
wwHZMAM9fWfI4g9A/A8OLfIZibOwckQSjCUPhZYTKugYCEkYq2QfhRQcWInQ
KEKANfOAiZP6RkZGRkDmOHSH8g6n8Eya2AZLkgnUSpMPXUV7495aHgQ9JDnE
PEao3wfcRwdhWREukDss9CqPoEEKlYeGGzQl9rH5/QbtGg4hE4lNJgwlGE+A
R5nF9QeghflPfJ5F2Bj8/n5u5CzUHziBmOwyTl66SWGEIwTJRofk+BpfDEou
6T9UTEkahQfDO2vhkWiP/tlThW5+HOSIMNigl8WnDMAyFHhlQfTIVAKE6p4A
+HjIBhEgkhCBBFgKCCIiNaRSKMUEICwBRX8JfhwfLCH3sgqCSSKEgcQ1A8TZ
3fmj6FANT0MRjN1FBBJFIQIsisYQCT1xaYyJCMljznF4mK2e3y+AbVDxPz6F
Jp+7IeQMUqIcijK5SsKaPZT6Iz1CUE8N2TgqWmibkaGiIZ2kYgWhlVid0wDY
hx2JSX3a7TjHJQ4AQWEUMRTsd8Xc2idRSlW2HuwvwsADVYAIbxTgLvO1wHyf
IjKK1AnACTSraMYleHLaC2K6oSVC/UNCygCIsQuuSFrqDndDu/Ny9Fy5G4Hl
hgyLpItT0EaWGZteq89+7m87C3ZCkgl87S7SmgoSJKDGiibxkTWmlMKMVoUX
yC0MCNENDLhAM8bAWYhqTXAyZzCFkEMEQiqRwnkG10VU3Dx6Yv7UFdLH4pCA
HNApalISKG4gBtAvHUmu3y1CWQEayiCUrSyQYJEBUGmMYSJlAtC+S0Uexjgk
YY8CjIHQIwYgsILIjJIJZIUcNmROdU09CMN7mGGKJxIdFygd20oANhtAJ4IH
r5FXwOv0e3Yb5RoVNstEy4GIXBzItWypE6ZGsEO05iO+Sc9hQuw0VM3eq5qm
SJxU/TAVS1j69ptNKuBYTY62d8PczyxqxT886QgGfCCRJDgFVCMI/wOFlswx
tCQYInhg7xLAzYoGwkO05AVrPGUfOTCF9Ty4gRDzKY+h6+LkczJ3QhISmBRF
LfA0POoeAIxy4CGHUNiF9R1vYXBC4ZgtCm8gRQPIAGtQVSJqZg7/ZkcjTw3d
1I9H0pllVEH6kuibpTEEYqKUrma4L2DMUEBNhIOkyGQmO8UGwpGoLChunsMK
UrYrNJtC0kmJlEph8ynOwMELbS7BCkIAGyLSCRBMgAKAClOBCLWxPl1udfWE
K0aB8tgNh80Q6i9UMHFVRFVVSIsYMYxVVEUX0A4Gcgop8I+6J8EXUJAeqTfM
taMcM0TmdNI98wjXPcwlneQEOseiECDOyRzpC5FZtIvwTTUSJkPYUVoXMCo1
SENQQLWPDUQwFnoZN4SkuG4wOihhw7BQiEZUQbCAanYnIgUoiUZkCS7QH8jw
johtJAiQD/PGRDhI9lLx4Ss7u68XkIt8HrGhDuCznDkU/d66b68ryqqhiGAw
UPmNRlKQKXYkVg22QtCCtaxawl1Vs2UlKAyGlcmQApAZ4gS6o/PhUugp7XcL
wlmXWiJiKlHPfSiUWK0v5soo0oUFENBVTQ7isIBZAsdFXTpkzEKLDAgmyWWR
ssKu4lLB3YYGGOIVDWQLp1aJkd2mGh1umCebKn+QpiKZwVaLUAwh7CvKVIFF
DCjOE4nW/nznhoRwsUowU2CTBUUy2oilWksZ2sK9KSyZooKLkjVH1xsjbcz8
3PNFscEdK0YhYQSLFYDCAg7aHAQ4i3nSsItXlViXimy5Bu9srUXzDEcGHCO6
4gaQDEUMEOJ0CWsGzg9W45FWJVVKajb6fJoaSEQYghNhtCdRPlgmgDXfwdQL
DXbZgkHQgBe1hxcQaWWIgQHHBoBj+ZoEQzI3TJ7ZIUQEQQNTggMNwI4jUWkV
WgKA0KGRVhFJyhTCROiAY6usDKy5xE5EWEssMfcn35CfnGWN8vDMbIHk73CY
JRKJZaI0VBS4zwB+hnwikHgK3rjBO8GEFFgQYiMiJFIQGIDGIoiMknoJSggR
3rDyLqOVw4C4ekA43QKSEXUzVwC6LKIhv1bbJclA5EP7BhKFFuC3DYo/KYaB
CQQg96HqPRCSRpsEhTcZAiQJBW7OQ7gfM3yCA6kPyMkCiCwkkJ4pAOKRYxJ1
omBJyXhYNBEHACGUUgjMRGlHKIWAsCVUooS3VmJgMYwcpKrCIUoWCAxJFgk1
rBcSsClUSWCFoUZCiDISlhJAYTEWwexJcLHSpFqCoBDpyyS6GiZtxLiN7ukH
S4+3JwFqGI+37vgw05glQaJ2lvOIFoU+mi0RzGIeqCW9ZlYD+X30GyGUc4Ks
YCg0WciW2BwohJNHZz9++U22gRviRIkHMot0G6w5KLsgnA7xhP3pE6Uen8iy
zJBlAotAPUMUgfoRRNvUg9f2AoADIsGEBPfEKkSKMQREWMFiEhaFZ9uYZJX9
BA8xOwDvQWCBGJ6zchu4B80Udh7RP0Ta/bDmncnYVUkSQEO9S2RikIMJzyxN
/DsTIDpx0VsYIJtzCyMRzjt87CPQlQIUIDIXxbIC1MLKgyWVWERbVBBFqJPk
8J/MmTS8WBwwWQJjJ0AOg6GS947A4RR24PeBAzQB4EUNQO6kAd8R5IfP+PgJ
nBDeJ2+zvA4AnEjAQMl8q1zsbg8DUoh3PcIEUqwgNmG/JrFkkhFNkGqPhaFZ
VVRVWbGYckNSJMYBiMBSJbCUKHGMEuqENu10TMFFVLTuLo3wTACSh7TygXfK
eG5AwdwUHT5EO2MIIAyjTUkTYc5xR3wcgSAjpHFOW75t+pahqH8QookD1mgU
GEuCX+wPRg5x6juKKA7IgnAgdzHHUWQJ79SqRZ3MVNyH3/R4JfepuTcjn1zm
6em7IrvUK1KqKOWWO/Xw+TqQgeyJ3TLI9sJUoOa3zFlP7Bgt7ZRGRSnXhojn
EQsMaJ/Dz4WCbImNSoU7NRUvdYwkAkYwgkEKHwysedKiIa6wsOtznAYBfj1Q
6j6/WOSe/LEpae6kSWQ5VGWVSHRphSnlP6XMKaaKKPfppxeRxXVBMEPh6Xed
JOQhtAi+sZGL3dWQwEFhr67ITEjJ7GycqKxKr95QLbU+5fiCz3An1I6FAkCJ
OSjA4e9xANoLohATCcJwIRrpzAPEc6HH+Eh4r4E3LjZX5hxfkyzDQzw9NUyb
gF1TlqyrGQiI4NUOhrLDW7qhyjSPqIHQdBxA2l3OCUkE5yWgZxovSHItiJcM
MpmWYRW0PoyZ/Ocsm5r5IpgsxJYA9E3B7FSeoCEHiUCO42RJPCohyJIASKok
+y3zA6JBCtpDp+zyuqp4sYiwEUZEO9FKKyelVSjAWiSuOOBbBQKyMtFUlEEt
qVVGCqKLLbCRYQUkPVERkhhxIhZ2WQownzP8WU+N0YXPmKYgB8qdTDIKKKR4
wNnxdptyAC96wKGIU6zmGzTzEzYcTp7TUuEIldNFQL70erOFcmFoMEDAQPdx
9Yhqb3wU9wHd3QQURWEGwGYO+QhInBgZzw4E2+/pIjuRUcoAom4ohDq6qZ58
AtvTtlJXu5c5O4DLcftTtJRCJIoyJGARGEiqz8gqUGlOCQgwwSFOYZAbC0sn
LiORGTIltVlAoxjq2AoMZARAQarApLZyywjgm+YOefiYlkFpKItaCQFZIqJS
0ZxSl5YHxYE5alFXbJUKLGDBkYzVKScJNRmDCBO4gNmFBYoqgFkSBBAJIiq1
Qa4EFsIg+h/fk3gbAiJ38/ZA7I1GDI+VCg9AIRHQ0NqVzEonMbWVdGZn+oda
TQGd93qGsld4IDW0J7T0k+MSM907I5hTJmgaiCgyDZYjBiNRBh4kCg9KfIAW
3+CvyrBSwvqkCHFeCOGrb94I3wTPoAQbhBiwuC5XEwzPwFBBgd0D1k+KefXs
70kEZUqVZooFPw/mMiFyONTi5BQ3Ya4KUZqAwPpTORqIXAUWaSaZjsYQT8lH
ut88pw2QgMew8jt0TuGbYUYFLRaiTu5cBo7O6hxAiedqwiMB47b3Odu4WmTL
mDybNLAUBm0nuVxgiySCwjEQNe1/DtMe0iHRmmpT/sEIhzy4GZgtMWYCGL6C
w0ZrCpNgqSI2P+hkVeE0hoOKG7jJCDS0lhndmVy37+Z3pcih0fBEmDilEVJB
9yOC57A8hgSyogd4GaHl+cV9ZA8RCCUxTRdxAHRTPWj7IwNQMopfAtQBiRQM
gVkUJFYQEZCE8UBM19gRdCKxYhFiEgjIwhCBIIEUgAPpNBO8H9MBE35HqNEF
A5tp1+Syvfrx5L1BZYragn3AKRRYRGRUXiEYQBW0BF99kJSMDOhWhiRpCG6q
VLCKRIsgChBIFF1AIeg0FHdug+apSep9F++F2cBMz4vC+hHeCC43xft0KLF6
KaIXQBL58Pu2e78T+u97L+QgJrZ31bkKbJAJaVGtgjJ4lrgtBRTlmya0srmL
HKGDSY2Tn1sorIGIcrg5iMW7N7yot1UQmG5nSspnj7J3e09ON9CDKt+PG9Wg
8s5nMC1kPQ0WsPA4jP8R+yc8msmjtlMlkEYZ4/QBvDGke4ZQkjzJwKUKY5QU
IlAfe+i5h4vvIZlF2twxKyFSmkDxx0Sdu8KNavhIQ+3x0xnGe40Hooxs8FlM
nluFsIfGQ+7Nnkb6y2iy167OlpaewKokm74GXTznIk896Lqo22lurcGiqloj
FBUQ58xgw8GSSapJNhuSBfRIf0EBkOfV0niei6FQXqGqyKqvf0qdiyfFRjG5
A6WvVGwX3FKPoGD7NAWhQ0CJgMSkgsOpYhSnLyntqSR8CY5BP3Wbo9YLRoB5
ODgkIHKSjeeRXxxlbweBqabbYdziJuWU8p1+Yp54yAk9gLAig1ACr6W3BZhx
fKQoMNzFGSNglCWVKBHI0z0CjmjInOBGJ5Q37tvE1ouyngB2aaInR7t+PXRR
ISqE1JsAHFYsoKjBiHsGIIPc0ioQRCB9yVAMd8sxPz8pmN3dqBwSKpqduf6g
879hvwVY0vctVFRozPFADr4GA7DtNRXS4tDPk9uYqK/bayFghKcvUFichxmB
aFA/Ty0Goz2oVjVdypmBwWxERDBqKKKKKLKWqoU6ctuH6PVmHUERJy+hkgzW
p0FFivVatYpFBYdLeTOoiWeFCjOSF9FkMk/Fw4cEVQTbVVFVYsVVXZ8bDkdq
Sp3VQqHyHVVhA7nfNh4p0y2bKSfLG1cPhpCHkKecQgMggFB9XtPQerzHE1eL
c31clrZUumqqR0IxWethKE4YTMsSPqaTQWshgMHphoJAJdKVA3h9oTTzYDm4
OsKJwx74H2MniG4yceS0CHdYB3AEDq9NbIbuSCD0CB8cIQPNEiEQUUEAiJBg
KBFWRUAggw1kOVED0G1e2Ca9Lsk3z5V60CrlIAfhSIzNQLfYWBhBQBjC2iCx
BpvDIZfPm+zUwGbKVWUVgiZRLi5hnS5wRvLkMIKZ0qJmRRDAj38didBVegnR
TRJAljwOoq0hyBrxV7DeHighkrzAF2HMieUXsyGjp0oHRPSJ3MU8ysU2KWjl
ngw5nKDElFy2kYHm7AtiQYQQw/fO+bicuAprIMQ0UpU+URPPLJcLNRGNtRkw
asFYqxEawvQfZIdXWIk/Kejs8b+7fRnTwlGQ0VQaEAp8sA68Q7kbD6IlXai5
ZB8ukHGTTCYqNOyqSXRgBz+NGlvaNwrREyuQpKzo682RoLZeCjGzUIK5FNvx
SIw+VD9V5IN2eWBwJSjoHBMCPo7Xg8mH1jbor1CmObIeplGjUSDG+RpmSJLQ
20WUcYGh+bUs16l7wOvIqYDUorCmEPZqGRLEMSkXLZUJNljhaudLJpWHA2a7
OzM64yEH2gZZ4uWki+BRAbqXFOiYVjKODIJpg6IjaCMhwB16Tg6NDIJQURFQ
UFQRXKNH7k6MRsYto2QpYLw0Hhmuuij1Qu72emWd0UfZevXvRrhUmXDKs4Qh
E2wKUGiZiaG7UaU2MhGMFrtE5pJNDidOebMppuvabxGBCDXSuTTqZWKC3Bk/
NOqTIK1qGM8IZ2MXVzT64RsWXHSgudCsbK0TlHeeDLMQMsY220RAxFtPpeKU
I7DGlp7Gxk1lUl2xB2GG8CqLs0Xga6ga29mi6ZGK6oqSzXaKYQUlIxRTg1gQ
ougvZlRdKtRBwCRAMIK7SnK5a0rYlqqGBoVKGK2VsHWUJkhhihGBIBvUOJsz
ExBQkkAGInzM80yUeEGEBLGtKZFDmmQwZGMZngHCQQ5ggcSTBJuRRiFiUEFh
QBPASqGmIKGItEUEqsKKPMDVHpNenh5eBBh8AOFBvIcNBFLwQz5krvQCD9v8
nvS59MQC+nDooeflP2+FrhFCmD3Exr8JOiluJdlJ2pukAikYsDrGA+oIAc6u
0BixFiBhB7UKsMHAqPB9IM40hXWSkXTKZdiBYVAKA8xokiQzhkCIb4KnOR6b
NCyGe00sn0QLxQ7oh+LJH0XQ353RLnIogRPXAsFeoshgHoyILAKQPLRfn9E8
Tjc+NVT5azqS4iXROrtgZoUD2iTriUjRDpi3j4G+MKFDRoSHn7NATAUE4LK8
UlY9LT5oUmssNQM0rqTcgllgMgjQJFEqP8fAp5H5/sqA1U0XBwn48Ih3co0f
R+7ahwIH0CNtLTFsD2wJJGRraegrpyaY9QdS9JOxOBxmWJgzTtYEMsR0lsnD
LV5gCJrg7h8Pt91LoUg3EhffIhmfYoxs+zdmo8jFmREkRI2YZeMWZCSSHaSX
okviR86+MEbMqGQlzAkETdYBYEMinBFPgW9I49DgN04U8skKhf0QvPgVcMEt
ZBFBJS7kCjvQVtQssCgNMJvQTP1KAQzHdZTaREQyE+0CuAch1QkgwhCKAwQY
DAYFPwB0BELbzys8H5oFEPUdQfiRWEUQo4lH925EDSX0z6KtHnmiofrMkVTg
EkI63ShAjIsQbbAVB9yiv4xGBFAeguczweLX4a0XddFJadRuccATLsT6TkHE
Qg/ifNCxWsItfnX/YB9xzIG7+QdQFw1H4LHuBheHaC+ha0VSPfvOJKiWOufs
LBwFD+OMljdaPfSAH8DN3iabjLxNISAfV6LcFKtIiF0/uFImeDZAORU8CiQk
fjqHd6J/AjxKfE3DGDxCIr7AQsmSBtuhrVKGD9Ahq8f0HhYh+qNM5uiTqWSS
T4fZb6rUyNihTwsJAMzZV478my2XIpylRKCED70iGAUG6ToSHVOywpIkV99s
7Aon23yfmuyRzeswcdlVVIKxkF2kfe17X6+YEEWIH19w0tDCINFERK0sAsNS
BrD9J2FCfnVnmVgqM5aAsQGGOIBzYCgGk9vkIXu3DIiwhGEIsWB+3PFq4GA0
ny9JSe/4gVhGKucDMvVyDnRT9MnQShT0AgGo6foQMPwA/WeAX07cFudVlZQ6
xdUOYQ7vMN1OCicAoQ7pCDmJsCo/oaZUKBu6VgjYIEWZgdIdW2gD3n6D5mft
G4f+qQoQvclPnGCsIIPg8PZCx0XQQ+uxI/Dn7mWwhqqtsTDaUvIQZYz8erAf
IYNQ2lpUGrUGYNtXW+RFjs4mSM3ROIvlLQw4LWC5NBjUkjHqKSqSWpKqu+Zo
YMgpClgEAPx6B01EV86qJ7SLJEYkQgqmhpkERTcjqbDcIO4iCHAQYHSLAAHb
7f6PcEHx90m4Q+bRDiKTA4ZE4ZOEA40KqsgrwAmSwglTQLCKAqiqCiy/OIjF
WKEURUEEBhlARSDgCP5MjpFyzuFWpikQb3DJhipLp/WkWAamDqRtgp01UDok
4ceBryyEyBjyVegzENpUS3ToOHbItziRe5ttH0UKkm2KxbfFbTaKLCsssqEc
RNhiWucltvzNnJ3X+S5P8YMkx27tN4Il605KIKqqv/8XckU4UJBvxp9i

------=_NextPart_000_0772_01C21932.46F00730
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

------=_NextPart_000_0772_01C21932.46F00730--


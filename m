Return-Path: <cygwin-patches-return-2460-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23529 invoked by alias); 18 Jun 2002 23:21:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23493 invoked from network); 18 Jun 2002 23:20:59 -0000
Message-ID: <018801c2171f$0a68f1b0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: cygserver patch
Date: Tue, 18 Jun 2002 16:21:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0185_01C21727.6BD4B260"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00443.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0185_01C21727.6BD4B260
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1943

I've been committing a sequence of patches for cygserver on the
cygwin_daemon branch over the last few days and I was thinking it was
about time to submit the current batch for consideration for the
mainline. I've attached a cumulative ChangeLog for the individual
patches and a bzip'ed patch file. (I've not appended the entire
ChangeLog here as it's rather long.) This patch is against the current
HEAD version, which I merged into the branch yesterday. Nicholas
Wourms has kindly downloaded the branch version and confirmed that it
works on a non-NT platform. I've also successfully run the ipctests
and has the server running continually while I've been developing. In
other words, I don't seem to have broken anything :-)

Which is all well and good, but what have I actually done? Summary:

* Conditionalize the security code so that cygserver works on non-NT
platforms.
* Refactor the client request classes for greater encapsulation and to
support variable length requests.
* Add new interfaces for the (eventual) implementation of ipcs(8).
* Add definitions of the strace XXX_printf macros to allow code to use
these whether it's compiled for the DLL or for the daemon.
* Several minor C++ related changes: for example, making some methods
pure virtual, and adding virtual destructors throughout as required.
* Add --version and --help options.
* Add checking for an existing instance of the daemon to avoid having
multiple copies running.
* Some more error checking throughout.

In other words, almost nothing shm related as it's not quite finished,
so I've not checked any of that into the branch as yet. This is all
just groundwork :-)

[One thing to note about this patch is that it includes a new file,
"woutsup.h". I only mention this in case anything special needs to be
done in cvs if/when the patch is committed.]

I hope this is all fine and that someone has a chance to look it over
sometime soon-ish.

Thanks.

// Conrad


------=_NextPart_000_0185_01C21727.6BD4B260
Content-Type: text/plain;
	name="cygserver.ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cygserver.ChangeLog.txt"
Content-length: 14646

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

	* include/sys/ipc.h (IPC_PRIVATE): Add cast to key_t.
	(IPC_INFO): New flag for ipcs(8).
	(IPC_RMID IPC_SET IPC_STAT): Renumber.
	* include/sys/shm.h (SHM_RDONLY SHM_RND): Renumber with distinct
	values [sic].
	(class _shmattach): Internal type moved to "cygserver_shm.h".
	(class shmnode): Ditto.
	(class shmid_ds): Ditto.
	(struct shmid_ds): Add spare fields.
	(struct shminfo): New type for IPC_INFO interface.
	* cygserver_shm.h: Remove obsolete #if 0 ... #endif block.
	(class shm_cleanup): Remove unused class.
	(struct _shmattach): Internal type moved from <sys/shm.h>.
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

------=_NextPart_000_0185_01C21727.6BD4B260
Content-Type: application/octet-stream;
	name="cygserver.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="cygserver.patch.bz2"
Content-length: 32339

QlpoOTFBWSZTWcDlVKEAX7DfgH3wf///////////////YIKc9419tsal13Z9
9jG28+568+s6D3dS+s86+LvofLfefQHcxxCAvHr65j2Z5tSPX2F7yerwa3vO
J3ea697vc0AyqjtugK6oAM9gGhl65d7nVthoPeve9zyHyeXva7TUuAZ91yj0
0pgee49HWVEMd63et777wnnPbrfd97u3GtDoHoBtX3vvnl33poaDffHe8kc1
m72coKiKvRtMqD3broL7293sh7KmgLfWuxmtbUrWR9zuzbWzM9d7ue8zTd9n
LZr0vp3beR9MAPNvpu+Oa51cr23vdV2e7FU77nVfW9sNWRsW3su2Y+9j6+VK
rqm+zO+3KO6HHaq7zffd2S+2xFitzndtmLsbrPfbnraO+x49npx6PdidtKdj
TT3Pj6633vkVttFSw2s2mvVSQrqDbbmrE29rncGgruO5rb3u88DoJTSBAAgE
0yaExDQEMhJ6YjU1HlMwk9TanqbFGIAJTQIIRAhqT0TT0qPyp7VPMo9T1T1P
UfqeqYn6k2Uek9TQaAZBoPQJGlFFCmUP1GjTRN6oaaGGhGCGQaA0AGACZNAA
k0kgk0CaEyYp5Ewp6niaBMTTU21EyPKAepkBpoAAIkiE0AE0Ag00g0aGpppo
09TJppghpTIzJPUBk0PUCJEQmgiYp5KeU80JpiAE9IxKeo9QHqDR6T1Aepka
AZHr6BDrBRQh7EISrGCwUIIhIpAERiSLAFJGIQFAhEkYBCKIECIiSIIEiBIo
CSCBBQZCkCE90feSWWRSVPjYtjhRiIqz4oiaX8R/2acLLS0vKAkskUYA2Fr+
5Kah9R5Az8sH1HGlOYwIDezDIRRZiWCDGIAiCUNCFzttiwxilBRDExiIUKxQ
abQsI3GgI+r2ezTczJKokH+f5VyIOIHTsWZmNkl4DA0MNIXWYGKqsBAw6ljn
QsI7QhiFGObbmXQqsWWXTZLirTPjBwMTGEhKYJVNIqRKDluBRcWjURCkoIoy
JhLDDBggxwzKLkUsirGkYkyCYUuLBoNKAiiTFVcmFphMywLbKGskuXCVDb10
54C+sBNFFP7BNdP6Mf19DJ/G+H+s/2xFNfd/ddGhN5uvoNunTGKTofpF9MPb
9cZlQWuoYlwiVkoMcY1C5bJbiUggM1kLYfZwWGhFkGTVWGRnX9X4xPstVERY
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
DA5VShA=

------=_NextPart_000_0185_01C21727.6BD4B260--


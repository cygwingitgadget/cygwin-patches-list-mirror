Return-Path: <cygwin-patches-return-2391-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1200 invoked by alias); 11 Jun 2002 15:33:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1144 invoked from network); 11 Jun 2002 15:33:56 -0000
Message-ID: <040f01c2115d$9c7c7cb0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <00a901c21152$f82c52c0$0200a8c0@lifelesswks>
Subject: Re: cygserver debug output patch
Date: Tue, 11 Jun 2002 08:33:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_040C_01C21165.FDE6B6C0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00374.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_040C_01C21165.FDE6B6C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 605

"Robert Collins" <robert.collins@syncretize.net> wrote:
> One nit: your changelog doesn't say *what* from
> cygserver_transport_pipes.cc you are moving to woutsup.h.

Sorry, that's a badly phrased change log entry: is the following any
clearer?

 * woutsup.h: New file for cygserver compilations outside the
 cygwin dll. Also collects the common debugging code from the
 various cygserver files.

 * cygserver.cc: Change to use "woutsup.h". Use new XXX_printf
 functions throughout.

If that's an improvement, I've attached a new ChangeLog entry with that
information.

Cheers for the moment,

// Conrad


------=_NextPart_000_040C_01C21165.FDE6B6C0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 1380

2002-06-10  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* woutsup.h: New file for cygserver compilations outside the
	cygwin dll. Also collects the common debugging code from the
	various cygserver files.
	* cygserver.cc: Change to use "woutsup.h". Use new XXX_printf
	functions throughout.
	* cygserver_client.cc: Ditto.
	* cygserver_process.cc: Ditto.
	(process_init): Initialise with PTHREAD_ONCE_INIT.
	* cygserver_shm.cc: Change to using "woutsup.h". Use new
	XXX_printf functions throughout.
	* cygserver_transport.cc: Ditto.
	(transport_layer_base::transport_layer_base): Removed (redundant).
	(transport_layer_base::listen): Now pure virtual.
	(transport_layer_base::accept): Ditto.
	(transport_layer_base::close): Ditto.
	(transport_layer_base::read): Ditto.
	(transport_layer_base::write): Ditto.
	(transport_layer_base::connect): Ditto.
	* cygserver_transport_pipes.cc: Change to using "woutsup.h". Use
	new XXX_printf functions throughout.
	* cygserver_transport_sockets.cc: Ditto.
	* threaded_queue.cc: Ditto.
	* include/cygwin/cygserver_transport.h
	(transport_layer_base::transport_layer_base): Removed (redundant).
	(transport_layer_base::listen): Now pure virtual.
	(transport_layer_base::accept): Ditto.
	(transport_layer_base::close): Ditto.
	(transport_layer_base::read): Ditto.
	(transport_layer_base::write): Ditto.
	(transport_layer_base::connect): Ditto.

------=_NextPart_000_040C_01C21165.FDE6B6C0--


Return-Path: <cygwin-patches-return-5701-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23854 invoked by alias); 5 Jan 2006 21:17:54 -0000
Received: (qmail 23844 invoked by uid 22791); 5 Jan 2006 21:17:54 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 05 Jan 2006 21:17:53 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 5C77D13C4A2; Thu,  5 Jan 2006 16:17:52 -0500 (EST)
Date: Thu, 05 Jan 2006 21:17:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: sigproc_init() handling CreateThread() failures
Message-ID: <20060105211752.GE26305@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1136494247.6371.16.camel@fulgurite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136494247.6371.16.camel@fulgurite>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00010.txt.bz2

On Thu, Jan 05, 2006 at 12:50:47PM -0800, Max Kaehn wrote:
>I notice that no_signals_available() tests my_sendsig using !.
>INVALID_HANDLE_VALUE is -1.  If no_signals_available() evaluates to
>true, that should prevent sig_send() from getting to the
>wait_for_sigthread() when there's no sigthread to wait for.  Here's the
>patch:

But, that is the whole point of setting my_sendsig to INVALID_HANDLE_VALUE.

>2006-01-05  Max Kaehn  <slothman@electric-cloud.com>
>
>	* sigproc.cc (no_signals_available):  test for my_sendsig ==
>	INVALID_HANDLE_VALUE.

This seems like it should work.  Does it have the same effect?

cgf

Index: sigproc.cc
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/sigproc.cc,v
retrieving revision 1.271
diff -u -p -r1.271 sigproc.cc
--- sigproc.cc	5 Jan 2006 16:26:22 -0000	1.271
+++ sigproc.cc	5 Jan 2006 21:16:49 -0000
@@ -39,7 +39,7 @@ details. */
 #define WSSC		  60000	// Wait for signal completion
 #define WPSP		  40000	// Wait for proc_subproc mutex
 
-#define no_signals_available(x) (!my_sendsig || ((x) && myself->exitcode & EXITCODE_SET) || &_my_tls == _sig_tls)
+#define no_signals_available(x) (!hwait_sig || ((x) && myself->exitcode & EXITCODE_SET) || &_my_tls == _sig_tls)
 
 #define NPROCS	256
 
@@ -61,6 +61,7 @@ HANDLE NO_COPY signal_arrived;		// Event
 
 HANDLE NO_COPY sigCONT;			// Used to "STOP" a process
 
+Static cygthread *hwait_sig;
 Static HANDLE wait_sig_inited;		// Control synchronization of
 					//  message queue startup
 
@@ -483,9 +484,8 @@ sigproc_init ()
    */
   sync_proc_subproc.init ("sync_proc_subproc");
 
-  my_sendsig = INVALID_HANDLE_VALUE;	// changed later
   sync_startup = NULL;
-  cygthread *hwait_sig = new cygthread (wait_sig, 0, cygself, "sig");
+  hwait_sig = new cygthread (wait_sig, 0, cygself, "sig");
   hwait_sig->zap_h ();
 
   global_sigs[SIGSTOP].sa_flags = SA_RESTART | SA_NODEFER;
@@ -1141,6 +1141,7 @@ wait_sig (VOID *)
 	    }
 	  break;
 	case __SIGEXIT:
+	  hwait_sig = NULL;
 	  sigproc_printf ("saw __SIGEXIT");
 	  break;	/* handle below */
 	default:
